/**
 * GUIDIA PLATFORM - CORE STORE & STATE MANAGEMENT
 * Chuyên biệt cho Du lịch Nội địa Việt Nam: Hướng Dẫn Viên (HDV) và Quản Trị Viên (Admin)
 * Đáp ứng đầy đủ 16 Use Case và các Luồng Ngoại Lệ ( -> ) theo tài liệu thiết kế hệ thống.
 */

const STORAGE_KEYS = {
  GUIDES: 'guidia_guides_v2',
  TRIPS: 'guidia_trips_v2',
  CERTIFICATES: 'guidia_certificates_v2',
  DISPUTES: 'guidia_disputes_v2',
  USERS: 'guidia_users_v2',
  MESSAGES: 'guidia_messages_v2',
  SETTINGS: 'guidia_settings_v2',
  CURRENT_GUIDE_ID: 'guidia_active_guide_id_v2',
  RECONCILIATIONS: 'guidia_reconciliations_v2'
};

// Dữ liệu khởi tạo chuẩn cho du lịch các danh thắng Việt Nam
const initialSeedData = {
  "settings": {
    "platformFeeRate": 0.1,
    "cancellationNoticeHours": 48,
    "autoPayoutHours": 24
  },
  "users": [],
  "guides": [],
  "trips": [],
  "certificates": [],
  "disputes": [],
  "transactions": [],
  "messages": []
};

class GuidiaStore {
  constructor() {
    this.init();
  }

  init() {
    // Luôn đồng bộ 100% dữ liệu thực tế từ CSDL SQL Server QL_Du_Lich_v2
    this.syncWithDatabase();
  }

  // Gửi thao tác cập nhật dữ liệu 2 chiều trực tiếp tới SQL Server (QL_Du_Lich)
  async syncDatabaseAction(action, params = {}) {
    try {
      const body = new URLSearchParams();
      body.append('action', action);
      for (const k in params) {
        if (params[k] !== undefined && params[k] !== null) {
          body.append(k, params[k]);
        }
      }
      const basePath = (typeof window !== 'undefined' && window.location && window.location.pathname && window.location.pathname.startsWith('/HTTMDT')) 
        ? '/HTTMDT/api/data/action' 
        : 'api/data/action';
      const res = await fetch(basePath, {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
        body: body.toString()
      });
      if (res.ok) {
        const data = await res.json();
        console.log(`[SQL Server 2-way Synced] action=${action}:`, data);
        return data;
      }
    } catch (e) {
      console.warn(`[SQL Server Sync Warning] action=${action}:`, e);
    }
    return null;
  }

  // Tải toàn bộ dữ liệu thực tế từ SQL Server vào bộ nhớ giao diện
  async syncWithDatabase() {
    try {
      const basePath = (typeof window !== 'undefined' && window.location && window.location.pathname && window.location.pathname.startsWith('/HTTMDT')) 
        ? '/HTTMDT/api/data/bootstrap' 
        : 'api/data/bootstrap';
      const res = await fetch(basePath);
      if (res.ok) {
        const data = await res.json();
        if (data && data.success) {
          if (Array.isArray(data.users) && data.users.length > 0) {
            localStorage.setItem(STORAGE_KEYS.USERS, JSON.stringify(data.users));
          }
          if (Array.isArray(data.guides) && data.guides.length > 0) {
            localStorage.setItem(STORAGE_KEYS.GUIDES, JSON.stringify(data.guides));
            const certs = data.guides.map(g => ({
              id: 'cert_' + g.id,
              guideId: g.id,
              guideName: g.name,
              guideEmail: g.email,
              guidePhone: g.phone,
              certType: g.certType || 'Thẻ Hướng Dẫn Viên Du Lịch Quốc Tế',
              certNumber: g.certNumber || ('VN-HDV-' + g.id),
              issuedBy: 'Sở Du Lịch ' + (g.city || 'Hà Nội'),
              expiryDate: '2028-12-31',
              documentUrl: g.certImage || 'img/the-hdv-1.jpg',
              status: g.certStatus || 'approved',
              submittedAt: g.createdAt || '2026-11-06 20:00:00',
              note: 'Hồ sơ thẻ hành nghề được cấp bởi Cục/Sở Du Lịch Việt Nam.'
            }));
            localStorage.setItem(STORAGE_KEYS.CERTIFICATES, JSON.stringify(certs));
          }
          if (Array.isArray(data.trips) && data.trips.length > 0) {
            const reviewsList = Array.isArray(data.reviews) ? data.reviews : [];
            const formattedTrips = data.trips.map(t => {
              const gCount = t.guests || t.groupSize || t.number_of_guests || 2;
              let rev = t.review || null;
              if (!rev && reviewsList.length > 0) {
                const foundRev = reviewsList.find(r => 
                  (t.dbBookingId && String(r.bookingId) === String(t.dbBookingId)) || 
                  (t.bookingId && String(r.bookingId) === String(t.bookingId)) ||
                  String(r.tripId) === String(t.id) || 
                  (t.bookingCode && String(r.tripId) === String(t.bookingCode))
                );
                if (foundRev) {
                  rev = {
                    reviewId: foundRev.reviewId || foundRev.id,
                    stars: foundRev.stars || foundRev.rating || 5,
                    comment: foundRev.comment,
                    imageUrl: (foundRev.imageUrl && !foundRev.imageUrl.includes('anh-danh-gia.jpg')) ? foundRev.imageUrl : '',
                    reply: foundRev.reply || null,
                    createdAt: foundRev.createdAt,
                    repliedAt: foundRev.repliedAt
                  };
                }
              }
              return {
                ...t,
                review: rev,
                startDate: t.startDate || '2026-11-20',
                startTime: t.startTime || '08:00',
                endDate: t.endDate || t.startDate || '2026-11-20',
                endTime: t.endTime || '17:30',
                guests: gCount,
                groupSize: gCount,
                number_of_guests: gCount,
                duration: t.duration || '1 ngày',
                isDisputed: Boolean(t.isDisputed || t.status === 'disputed' || t.dbStatus === 'DISPUTED')
              };
            });
            localStorage.setItem(STORAGE_KEYS.TRIPS, JSON.stringify(formattedTrips));
          }
          if (Array.isArray(data.reviews) && data.reviews.length > 0) {
            localStorage.setItem('guidia_reviews_v2', JSON.stringify(data.reviews));
          }
          if (Array.isArray(data.disputes) && data.disputes.length > 0) {
            localStorage.setItem(STORAGE_KEYS.DISPUTES, JSON.stringify(data.disputes));
          }
          if (Array.isArray(data.transactions) && data.transactions.length > 0) {
            const formattedTxns = data.transactions.map(t => {
              const code = t.tripId || t.bookingCode || ('#' + (t.bookingId || t.dbBookingId || ''));
              const typeStr = (t.type || '').toUpperCase();
              let title = t.title || t.description;
              if (!title) {
                if (typeStr === 'ESCROW_HOLD' || typeStr === 'ESCROW') {
                  title = `Tạm giữ ký quỹ Escrow bảo vệ quyền lợi du khách cho chuyến đi ${code}`;
                } else if (typeStr === 'SETTLE' || typeStr === 'PAYOUT') {
                  title = `Tất toán 90% thù lao chuyến đi ${code} cho Hướng Dẫn Viên`;
                } else if (typeStr === 'PLATFORM_FEE' || typeStr === 'FEE') {
                  title = `Khấu trừ 10% phí hoa hồng vận hành sàn từ chuyến đi ${code}`;
                } else if (typeStr === 'REFUND') {
                  title = `Hoàn tiền 100% tạm giữ cho du khách chuyến đi ${code}`;
                } else {
                  title = `Giao dịch chuyến đi ${code}`;
                }
              }
              return {
                ...t,
                id: t.id || t.transactionCode || ('TXN-' + (t.transactionId || t.dbTransactionId || Date.now())),
                tripId: t.tripId || t.bookingCode || code,
                type: t.type,
                title: title,
                amount: Number(t.amount) || 0,
                gatewayRef: t.gatewayRef || t.gateway || t.paymentGateway || 'VNPAY',
                status: t.status || t.reconciliationStatus || 'MATCHED'
              };
            });
            localStorage.setItem('guidia_transactions_v2', JSON.stringify(formattedTxns));
          }
          if (data.financialSummary) {
            localStorage.setItem('guidia_financial_summary_v2', JSON.stringify(data.financialSummary));
          }
          if (Array.isArray(data.messages)) {
            let localMsgs = [];
            try {
              localMsgs = JSON.parse(localStorage.getItem(STORAGE_KEYS.MESSAGES) || '[]');
            } catch (err) {
              localMsgs = [];
            }
            const readMap = new Map();
            localMsgs.forEach(m => {
              if (m.isRead || m.status === 'seen') {
                if (m.id) readMap.set(String(m.id), true);
                if (m.senderId && m.receiverId && m.timestamp) {
                  readMap.set(`${m.senderId}_${m.receiverId}_${m.timestamp}`, true);
                }
              }
            });

            const dbMsgIds = new Set(data.messages.map(m => String(m.id)));
            const dbMsgSigs = new Set(data.messages.map(m => `${m.senderId}_${m.receiverId}_${(m.text || m.content || '').trim()}`));

            const mergedMessages = data.messages.map(m => {
              const byId = m.id && readMap.has(String(m.id));
              const bySig = m.senderId && m.receiverId && m.timestamp && readMap.has(`${m.senderId}_${m.receiverId}_${m.timestamp}`);
              const isRead = Boolean(m.isRead || byId || bySig);
              return {
                ...m,
                isRead: isRead,
                status: isRead ? 'seen' : (m.status || 'delivered')
              };
            });

            // Giữ lại các tin nhắn vừa được gửi cục bộ chưa kịp ghi nhận trong đợt bootstrap này
            const localPending = localMsgs.filter(m => {
              if (!m) return false;
              if (m.id && dbMsgIds.has(String(m.id))) return false;
              const sig = `${m.senderId}_${m.receiverId}_${(m.text || m.content || '').trim()}`;
              if (dbMsgSigs.has(sig)) return false;
              return true;
            });

            const finalMessages = [...mergedMessages, ...localPending];
            const oldJson = localStorage.getItem(STORAGE_KEYS.MESSAGES);
            const newJson = JSON.stringify(finalMessages);
            if (oldJson !== newJson) {
              localStorage.setItem(STORAGE_KEYS.MESSAGES, newJson);
              if (typeof window !== 'undefined') {
                window.dispatchEvent(new CustomEvent('guidia_messages_synced', { detail: finalMessages }));
              }
            }
          }
          console.log('✅ Đã đồng bộ 100% dữ liệu thực tế từ SQL Server (QL_Du_Lich) vào Web!');
          return true;
        }
      }
    } catch (e) {
      console.warn('Chưa thể kết nối tự động tới SQL Server API:', e);
    }
    return false;
  }

  // Getters
  getGuides() {
    let guides = JSON.parse(localStorage.getItem(STORAGE_KEYS.GUIDES) || '[]');
    if (!guides || guides.length === 0) {
      const users = this.getUsers ? this.getUsers() : (initialSeedData.users || []);
      guides = users.filter(u => u.role === 'guide');
      if (guides.length > 0) localStorage.setItem(STORAGE_KEYS.GUIDES, JSON.stringify(guides));
    }

    // TÍNH TOÁN TRUNG BÌNH ĐÁNH GIÁ THỰC TẾ TRONG CSDL (Reviews / Đánh_Giá)
    let reviews = [];
    try {
      reviews = JSON.parse(localStorage.getItem('guidia_reviews_v2') || '[]');
    } catch(e) {}
    let trips = [];
    try {
      trips = JSON.parse(localStorage.getItem(STORAGE_KEYS.TRIPS) || '[]');
    } catch(e) {}

    return guides.map(g => {
      // Tìm các đánh giá thực tế của HDV này
      const guideReviews = reviews.filter(r => String(r.guideId) === String(g.id) || (r.guideName && g.name && r.guideName.trim().toLowerCase() === g.name.trim().toLowerCase()));
      
      let realRating = 5.0;
      let realCount = guideReviews.length;

      if (guideReviews.length > 0) {
        const sum = guideReviews.reduce((acc, r) => acc + (parseFloat(r.stars || r.rating) || 5.0), 0);
        realRating = parseFloat((sum / guideReviews.length).toFixed(1));
      } else if (g.avgRating && parseFloat(g.avgRating) > 0) {
        realRating = parseFloat(parseFloat(g.avgRating).toFixed(1));
        realCount = g.reviewCount || 0;
      } else if (g.rating && parseFloat(g.rating) > 0 && g.reviewCount !== undefined) {
        realRating = parseFloat(parseFloat(g.rating).toFixed(1));
        realCount = g.reviewCount;
      }

      const guideTrips = trips.filter(t => String(t.guideId) === String(g.id));
      const compTrips = guideTrips.filter(t => t.status === 'finished_paid' || t.status === 'COMPLETED' || t.dbStatus === 'COMPLETED' || t.status === 'finished').length;

      return {
        ...g,
        rating: realRating,
        avgRating: realRating,
        reviewCount: realCount,
        reviewsCount: realCount,
        completedTrips: compTrips > 0 ? compTrips : (g.completedCount || g.completedTrips || guideTrips.length || 0),
        reviewsList: guideReviews
      };
    });
  }

  getReviews() {
    return JSON.parse(localStorage.getItem('guidia_reviews_v2') || '[]');
  }

  // Tiêu chí HDV đã duyệt & hoàn tất hồ sơ (Không hiển thị người chờ duyệt thẻ hoặc chưa xong hồ sơ)
  isGuideApproved(guide) {
    if (!guide) return false;
    // 1. Tài khoản không được ở trạng thái khóa / đình chỉ / chờ duyệt
    const status = String(guide.status || guide.dbStatus || '').toLowerCase();
    if (status === 'suspended' || status === 'locked' || status === 'bi_khoa' || status === 'pending_approval' || status === 'cho_duyet') {
      return false;
    }

    // 2. Thẻ hành nghề / hồ sơ phải hoàn tất và được duyệt chính thức (approved)
    const certSt = String(guide.certStatus || guide.dbCertStatus || guide.approval_status || '').toLowerCase();
    if (certSt === 'pending' || certSt === 'cho_duyet' || certSt === 'rejected' || certSt === 'tu_choi') {
      return false;
    }

    // Phải là approved / da_duyet
    return certSt === 'approved' || certSt === 'da_duyet';
  }

  // Danh sách Hướng dẫn viên đã được Ban Quản Trị phê duyệt thẻ và đang hoạt động hợp lệ
  getApprovedGuides() {
    return this.getGuides().filter(g => this.isGuideApproved(g));
  }

  // Lấy 01 Địa danh du lịch được khách hàng đi nhiều nhất (Top 1 theo yêu cầu vang lai.md)
  getTopDestination() {
    const trips = this.getTrips ? this.getTrips() : [];
    const locationCounts = {};
    trips.forEach(t => {
      const loc = t.location || t.city || '';
      if (!loc) return;
      let key = 'Hội An, Quảng Nam';
      if (loc.toLowerCase().includes('hội an') || loc.toLowerCase().includes('hoi an')) key = 'Hội An, Quảng Nam';
      else if (loc.toLowerCase().includes('hà nội') || loc.toLowerCase().includes('ha noi')) key = 'Hà Nội';
      else if (loc.toLowerCase().includes('sapa') || loc.toLowerCase().includes('sa pa')) key = 'Sapa, Lào Cai';
      else if (loc.toLowerCase().includes('hồ chí minh') || loc.toLowerCase().includes('sài gòn') || loc.toLowerCase().includes('hcm')) key = 'TP. Hồ Chí Minh';
      else if (loc.toLowerCase().includes('huế') || loc.toLowerCase().includes('hue')) key = 'Cố Đô Huế';
      else if (loc.toLowerCase().includes('đà nẵng') || loc.toLowerCase().includes('da nang')) key = 'Đà Nẵng';
      else key = loc;

      locationCounts[key] = (locationCounts[key] || 0) + 1;
    });

    let topName = 'Hội An, Quảng Nam';
    let maxTrips = 0;
    for (const [name, count] of Object.entries(locationCounts)) {
      if (count > maxTrips) {
        maxTrips = count;
        topName = name;
      }
    }

    const destMeta = {
      'Hội An, Quảng Nam': {
        name: 'Hội An, Quảng Nam',
        keyword: 'Hội An',
        tripsCount: Math.max(maxTrips, 85),
        image: 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?auto=format&fit=crop&w=1200&q=80',
        description: 'Đô thị cổ nghìn năm với những dãy phố vàng rêu phong bên dòng sông Hoài thơ mộng, lễ hội đèn lồng lung linh huyền ảo và nền ẩm thực Phố Hội trứ danh được bảo tồn nguyên vẹn qua nhiều thế hệ.'
      },
      'Cố Đô Huế': {
        name: 'Cố Đô Huế',
        keyword: 'Huế',
        tripsCount: Math.max(maxTrips, 85),
        image: 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?auto=format&fit=crop&w=1400&q=80',
        description: 'Điểm đến du lịch hàng đầu được đông đảo du khách tinh tế yêu thích và đánh giá 5 sao trọn vẹn.'
      },
      'Đà Nẵng': {
        name: 'Thành Phố Đà Nẵng',
        keyword: 'Đà Nẵng',
        tripsCount: Math.max(maxTrips, 78),
        image: 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?auto=format&fit=crop&w=1200&q=80',
        description: 'Thành phố đáng sống bậc nhất với bán đảo Sơn Trà tuyệt mỹ, bãi biển Mỹ Khê cát trắng mịn và Cầu Vàng Bà Nà Hills trứ danh vươn tầm quốc tế.'
      },
      'Hà Nội': {
        name: 'Thủ Đô Hà Nội',
        keyword: 'Hà Nội',
        tripsCount: Math.max(maxTrips, 72),
        image: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=1200&q=80',
        description: 'Trái tim ngàn năm văn hiến với 36 phố phường cổ kính, nét ẩm thực tinh tế Michelin Selected và câu chuyện lịch sử Thăng Long hào hùng.'
      },
      'Sapa, Lào Cai': {
        name: 'Sapa, Lào Cai',
        keyword: 'Sapa',
        tripsCount: Math.max(maxTrips, 64),
        image: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=1200&q=80',
        description: 'Đại ngàn Tây Bắc hùng vĩ, ruộng bậc thang kỳ vĩ giữa biển mây và bản sắc văn hóa các dân tộc Dao Đỏ, H\'Mông mộc mạc nguyên bản.'
      },
      'TP. Hồ Chí Minh': {
        name: 'TP. Hồ Chí Minh',
        keyword: 'Hồ Chí Minh',
        tripsCount: Math.max(maxTrips, 68),
        image: 'https://images.unsplash.com/photo-1583417319070-4a69db38a482?auto=format&fit=crop&w=1200&q=80',
        description: 'Đô thị phồn hoa năng động giao thoa giữa nét kiến trúc Pháp thuộc cổ điển và nhịp sống hiện đại bậc nhất phương Nam.'
      }
    };

    return destMeta[topName] || {
      name: topName,
      keyword: topName.split(',')[0],
      tripsCount: Math.max(maxTrips, 85),
      image: 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?auto=format&fit=crop&w=1400&q=80',
      description: 'Điểm đến du lịch hàng đầu được đông đảo du khách tinh tế yêu thích và đánh giá 5 sao trọn vẹn.'
    };
  }

  // Lấy Top 3 đến 5 HDV có nhiều chuyến đi nhất & đánh giá cao nhất (ORDER BY SoChuyenDi DESC, DiemTrungBinh DESC)
  getTopGuides(limit = 4) {
    const approved = this.getApprovedGuides();
    const trips = this.getTrips ? this.getTrips() : [];

    const enhanced = approved.map(g => {
      const gTrips = trips.filter(t => String(t.guideId) === String(g.id));
      const compTrips = gTrips.filter(t => t.status === 'completed' || t.status === 'finished_paid' || t.dbStatus === 'COMPLETED').length;
      const completedTrips = compTrips > 0 ? compTrips : (g.completedCount || g.completedTrips || gTrips.length || 0);
      const rating = parseFloat(g.rating || g.avgRating || 5.0);
      return {
        ...g,
        completedTrips,
        rating
      };
    });

    // ORDER BY SoChuyenDi DESC, DiemTrungBinh DESC
    enhanced.sort((a, b) => {
      if (b.completedTrips !== a.completedTrips) {
        return b.completedTrips - a.completedTrips;
      }
      return b.rating - a.rating;
    });

    return enhanced.slice(0, limit);
  }
  getTrips() {
    this.processAutoTimers();
    let raw = JSON.parse(localStorage.getItem(STORAGE_KEYS.TRIPS) || '[]');
    if (!raw || raw.length === 0) {
      raw = initialSeedData.trips || [];
      if (raw.length > 0) localStorage.setItem(STORAGE_KEYS.TRIPS, JSON.stringify(raw));
    }
    const disputes = this.getDisputes();
    return raw.map(t => {
      const gCount = t.guests || t.groupSize || t.number_of_guests || 2;
      const relDispute = disputes.find(d => 
        String(d.tripId) === String(t.id) || 
        (t.dbBookingId && String(d.bookingId) === String(t.dbBookingId)) ||
        (d.bookingCode && d.bookingCode === t.id)
      );

      let status = t.status;
      if (t.dbStatus === 'ĐÃ_XÁC_NHẬN' || t.dbStatus === 'CONFIRMED' || t.status === 'CONFIRMED') status = 'confirmed_upcoming';
      else if (t.dbStatus === 'ĐÃ_HOÀN_THÀNH' || t.dbStatus === 'COMPLETED' || t.status === 'COMPLETED') status = 'finished_paid';
      else if (t.dbStatus === 'ĐÃ_HỦY' || t.dbStatus === 'CANCELLED' || t.status === 'CANCELLED') status = 'cancelled_refunded';
      else if (t.dbStatus === 'ĐANG_KHIẾU_NẠI' || t.dbStatus === 'DISPUTED' || t.status === 'DISPUTED' || t.isDisputed) status = 'disputed';
      else if (t.dbStatus === 'CHỜ_XÁC_NHẬN' || t.dbStatus === 'PENDING' || t.status === 'PENDING') status = 'pending_guide';
      let paymentStatus = t.paymentStatus;
      let isDisputed = Boolean(t.isDisputed || status === 'disputed' || t.dbStatus === 'DISPUTED' || t.dbStatus === 'ĐANG_KHIẾU_NẠI');
      let cancelReason = t.cancelReason;

      if (relDispute) {
        const hasDecision = (relDispute.adminDecision && relDispute.adminDecision.trim().length > 0) || (relDispute.adminNote && relDispute.adminNote.trim().length > 0);
        const isResolved = (
          relDispute.status === 'resolved_refund' || 
          relDispute.status === 'rejected_to_guide' || 
          relDispute.status === 'resolved' || 
          relDispute.dbStatus === 'APPROVED_REFUND' || 
          relDispute.dbStatus === 'REJECTED' || 
          hasDecision
        );
        if (isResolved) {
          isDisputed = false; // Khiếu nại đã xử lý xong, không còn cờ đang tranh chấp
          if (relDispute.status === 'resolved_refund' || relDispute.dbStatus === 'APPROVED_REFUND') {
            status = 'cancelled_refunded';
            paymentStatus = 'refunded_to_customer';
            cancelReason = cancelReason || ('Khiếu nại được duyệt hoàn tiền: ' + (relDispute.adminDecision || 'Đã đối chiếu và hoàn tiền 100% cho du khách.'));
          } else {
            status = 'finished_paid';
            paymentStatus = 'paid_to_guide';
          }
        }
      }

      return {
        ...t,
        status,
        paymentStatus,
        isDisputed,
        cancelReason,
        startDate: t.startDate || '2026-11-20',
        startTime: t.startTime || '08:00',
        endDate: t.endDate || t.startDate || '2026-11-20',
        endTime: t.endTime || '17:30',
        guests: gCount,
        groupSize: gCount,
        number_of_guests: gCount,
        duration: t.duration || '1 ngày'
      };
    });
  }
  getCertificates() {
    let certs = JSON.parse(localStorage.getItem(STORAGE_KEYS.CERTIFICATES) || '[]');
    if (!certs || certs.length === 0) {
      certs = initialSeedData.certificates || [];
      if (certs.length > 0) localStorage.setItem(STORAGE_KEYS.CERTIFICATES, JSON.stringify(certs));
    }
    return certs;
  }
  getDisputes() {
    let disputes = JSON.parse(localStorage.getItem(STORAGE_KEYS.DISPUTES) || '[]');
    if (!disputes || disputes.length === 0) {
      disputes = initialSeedData.disputes || [];
      if (disputes.length > 0) localStorage.setItem(STORAGE_KEYS.DISPUTES, JSON.stringify(disputes));
    }
    return disputes;
  }
  getUsers() {
    return JSON.parse(localStorage.getItem(STORAGE_KEYS.USERS) || '[]');
  }

  parseMessageTime(msg) {
    if (!msg) return 0;
    if (typeof msg.createdAt === 'number' && !isNaN(msg.createdAt) && msg.createdAt > 0) {
      return msg.createdAt;
    }
    const raw = msg.createdAt || msg.timestamp;
    if (typeof raw === 'number' && !isNaN(raw) && raw > 0) {
      return raw;
    }
    if (typeof raw === 'string') {
      const trimmed = raw.trim();

      // Format ISO: YYYY-MM-DD HH:mm:ss hoặc YYYY-MM-DDTHH:mm:ss
      const isoMatch = trimmed.match(/^(\d{4})[-/](\d{1,2})[-/](\d{1,2})(?:[T\s](\d{1,2}):(\d{1,2}):?(\d{0,2}))?/);
      if (isoMatch) {
        const y = parseInt(isoMatch[1], 10);
        const m = parseInt(isoMatch[2], 10) - 1;
        const d = parseInt(isoMatch[3], 10);
        const hh = parseInt(isoMatch[4] || 0, 10);
        const mm = parseInt(isoMatch[5] || 0, 10);
        const ss = parseInt(isoMatch[6] || 0, 10);
        const dateObj = new Date(y, m, d, hh, mm, ss);
        if (!isNaN(dateObj.getTime())) return dateObj.getTime();
      }

      // Format vi-VN: HH:mm:ss DD/MM/YYYY hoặc HH:mm:ss, DD/MM/YYYY
      const viMatch1 = trimmed.match(/^(\d{1,2}):(\d{1,2})(?::(\d{1,2}))?(?:,\s*|\s+)(\d{1,2})\/(\d{1,2})\/(\d{4})/);
      if (viMatch1) {
        const hh = parseInt(viMatch1[1], 10);
        const mm = parseInt(viMatch1[2], 10);
        const ss = parseInt(viMatch1[3] || 0, 10);
        const d = parseInt(viMatch1[4], 10);
        const m = parseInt(viMatch1[5], 10) - 1;
        const y = parseInt(viMatch1[6], 10);
        const dateObj = new Date(y, m, d, hh, mm, ss);
        if (!isNaN(dateObj.getTime())) return dateObj.getTime();
      }

      // Format DD/MM/YYYY HH:mm:ss hoặc DD/MM/YYYY, HH:mm:ss
      const viMatch2 = trimmed.match(/^(\d{1,2})\/(\d{1,2})\/(\d{4})(?:,\s*|\s+)(\d{1,2}):(\d{1,2})(?::(\d{1,2}))?/);
      if (viMatch2) {
        const d = parseInt(viMatch2[1], 10);
        const m = parseInt(viMatch2[2], 10) - 1;
        const y = parseInt(viMatch2[3], 10);
        const hh = parseInt(viMatch2[4], 10);
        const mm = parseInt(viMatch2[5], 10);
        const ss = parseInt(viMatch2[6] || 0, 10);
        const dateObj = new Date(y, m, d, hh, mm, ss);
        if (!isNaN(dateObj.getTime())) return dateObj.getTime();
      }

      const parsed = Date.parse(trimmed);
      if (!isNaN(parsed)) return parsed;
    }

    // Fallback: nếu id dạng msg_1794062333000
    if (msg.id && typeof msg.id === 'string') {
      const match = msg.id.match(/^msg_(\d{10,14})$/);
      if (match) {
        return parseInt(match[1], 10);
      }
      const numMatch = msg.id.match(/\d+/);
      if (numMatch) {
        return parseInt(numMatch[0], 10);
      }
    }

    return 0;
  }

  getMessages() {
    let msgs = [];
    try {
      msgs = JSON.parse(localStorage.getItem(STORAGE_KEYS.MESSAGES) || '[]');
    } catch (e) {
      msgs = [];
    }
    let needsResave = false;
    msgs = msgs.map(m => {
      let changed = false;
      if (!m.text && m.content) {
        m.text = m.content;
        changed = true;
      }
      if (!m.content && m.text) {
        m.content = m.text;
        changed = true;
      }
      // Tự động chuẩn hóa timestamp nếu trước đó lưu dạng vi-VN (e.g. "21:08:44 7/11/2026")
      if (typeof m.timestamp === 'string') {
        const viMatch = m.timestamp.trim().match(/^(\d{1,2}):(\d{1,2})(?::(\d{1,2}))?(?:,\s*|\s+)(\d{1,2})\/(\d{1,2})\/(\d{4})/);
        if (viMatch) {
          const hh = String(viMatch[1]).padStart(2, '0');
          const mm = String(viMatch[2]).padStart(2, '0');
          const ss = String(viMatch[3] || '0').padStart(2, '0');
          const dd = String(viMatch[4]).padStart(2, '0');
          const MM = String(viMatch[5]).padStart(2, '0');
          const yyyy = viMatch[6];
          m.timestamp = `${yyyy}-${MM}-${dd} ${hh}:${mm}:${ss}`;
          m.time = `${hh}:${mm}`;
          m.createdAt = new Date(parseInt(yyyy, 10), parseInt(MM, 10) - 1, parseInt(dd, 10), parseInt(hh, 10), parseInt(mm, 10), parseInt(ss, 10)).getTime();
          changed = true;
        }
      }
      if (!m.createdAt) {
        m.createdAt = this.parseMessageTime(m);
        changed = true;
      }
      if (!m.time && m.timestamp) {
        const tMatch = String(m.timestamp).match(/(\d{1,2}):(\d{2})/);
        if (tMatch) m.time = tMatch[0];
      }
      if (changed) needsResave = true;
      return m;
    });

    if (needsResave) {
      try {
        localStorage.setItem(STORAGE_KEYS.MESSAGES, JSON.stringify(msgs));
      } catch (e) {
        console.warn('Cannot resave normalized messages:', e);
      }
    }
    return msgs;
  }

  getSettings() { return JSON.parse(localStorage.getItem(STORAGE_KEYS.SETTINGS) || '{}'); }
  getTransactions() {
    let raw = [];
    try {
      raw = JSON.parse(localStorage.getItem('guidia_transactions_v2') || '[]');
    } catch (e) {
      raw = [];
    }
    return raw.map(t => {
      const code = t.tripId || t.bookingCode || ('#' + (t.bookingId || t.dbBookingId || ''));
      const typeStr = (t.type || '').toUpperCase();
      let title = t.title || t.description;
      if (!title) {
        if (typeStr === 'ESCROW_HOLD' || typeStr === 'ESCROW') {
          title = `Tạm giữ ký quỹ Escrow bảo vệ quyền lợi du khách cho chuyến đi ${code}`;
        } else if (typeStr === 'SETTLE' || typeStr === 'PAYOUT') {
          title = `Tất toán 90% thù lao chuyến đi ${code} cho Hướng Dẫn Viên`;
        } else if (typeStr === 'PLATFORM_FEE' || typeStr === 'FEE') {
          title = `Khấu trừ 10% phí hoa hồng vận hành sàn từ chuyến đi ${code}`;
        } else if (typeStr === 'REFUND') {
          title = `Hoàn tiền 100% tạm giữ cho du khách chuyến đi ${code}`;
        } else {
          title = `Giao dịch chuyến đi ${code}`;
        }
      }
      return {
        ...t,
        id: t.id || t.transactionCode || ('TXN-' + (t.transactionId || t.dbTransactionId || Date.now())),
        tripId: t.tripId || t.bookingCode || code,
        type: t.type,
        title: title,
        amount: Number(t.amount) || 0,
        gatewayRef: t.gatewayRef || t.gateway || t.paymentGateway || 'VNPAY',
        status: t.status || t.reconciliationStatus || 'MATCHED'
      };
    });
  }
  getActiveGuideId() { return localStorage.getItem(STORAGE_KEYS.CURRENT_GUIDE_ID) || '2'; }

  // Set active guide (để demo nhanh giữa HDV hoạt động bình thường, HDV chờ duyệt, HDV bị khóa)
  setActiveGuideId(guideId) {
    localStorage.setItem(STORAGE_KEYS.CURRENT_GUIDE_ID, guideId);
  }

  getActiveGuide() {
    const id = this.getActiveGuideId();
    return this.getGuides().find(g => String(g.id) === String(id)) || this.getGuides()[0];
  }

  // ==========================================
  // XÁC THỰC VÀ ĐĂNG KÝ (Authentication & Registration)
  // ==========================================
  login(identifier, password, requiredRole = null) {
    const users = this.getUsers();
    const cleanId = (identifier || '').trim().toLowerCase();
    const cleanPhone = (identifier || '').replace(/\D/g, '');
    const user = users.find(u => 
      (u.email && u.email.toLowerCase() === cleanId) || 
      (u.phone && cleanPhone && u.phone.replace(/\D/g, '') === cleanPhone)
    );

    
    if (!user) {
      return { success: false, code: 'A1_INVALID_CREDENTIALS', message: 'Thông tin không đúng' };
    }

    // Kiểm tra mật khẩu (hỗ trợ password gốc hoặc default demo 123456 / admin123 / password123)
    const validPassword = user.password === password || 
                          (user.role === 'admin' && (password === 'admin123' || password === 'adminpassword')) ||
                          password === '123456' || password === 'password123';
    if (!validPassword) {
      return { success: false, code: 'A1_INVALID_CREDENTIALS', message: 'Thông tin không đúng' };
    }

    
    if (user.status === 'suspended') {
      return { 
        success: false, 
        code: 'A2_LOCKED', 
        message: 'Tài khoản đã bị khóa do vi phạm. Vui lòng liên hệ bộ phận hỗ trợ' 
      };
    }

    
    // Tự động phân quyền và lưu session đăng nhập
    sessionStorage.setItem('guidia_current_user', JSON.stringify(user));
    localStorage.setItem('guidia_current_user', JSON.stringify(user));
    if (user.role === 'guide') {
      this.setActiveGuideId(user.id);
      localStorage.setItem('guidia_current_guide_id_v2', user.id);
    } else if (user.role === 'customer') {
      localStorage.setItem('guidia_current_customer_id_v2', user.id);
    }

    const isHtmlEnv = typeof window !== 'undefined' && window.location.pathname.endsWith('.html');
    const ext = isHtmlEnv ? '.html' : '.jsp';
    let redirectUrl = 'customer' + ext;
    const pendingRedirect = typeof sessionStorage !== 'undefined' ? sessionStorage.getItem('customer_pending_redirect') : null;
    if (pendingRedirect) {
      sessionStorage.removeItem('customer_pending_redirect');
      redirectUrl = pendingRedirect;
    }
    if (user.role === 'guide') redirectUrl = 'guide' + ext;
    if (user.role === 'admin') redirectUrl = 'admin' + ext;

    return { 
      success: true, 
      user, 
      role: user.role,
      redirectUrl,
      message: `Đăng nhập thành công! Chào mừng ${user.name}.` 
    };
  }

  
  verifyResetPasswordInfo({ name, phone, email, extraInfo }) {
    const users = this.getUsers();
    const cName = (name || '').trim().toLowerCase();
    const cPhone = (phone || '').replace(/\D/g, '');
    const cEmail = (email || '').trim().toLowerCase();
    const cExtra = (extraInfo || '').trim().toLowerCase();

    if (!cName || !cPhone || !cEmail || !cExtra) {
      return { success: false, message: 'Vui lòng điền đầy đủ họ tên, số điện thoại, email và thông tin phụ!' };
    }

    const user = users.find(u => {
      const matchName = u.name && u.name.trim().toLowerCase() === cName;
      const matchPhone = u.phone && u.phone.replace(/\D/g, '') === cPhone;
      const matchEmail = u.email && u.email.trim().toLowerCase() === cEmail;
      
      const uExtra = (u.extraInfo || '').trim().toLowerCase();
      const matchExtra = uExtra && (uExtra.includes(cExtra) || cExtra.includes(uExtra));
      return matchName && matchPhone && matchEmail && matchExtra;
    });

    if (!user) {
      // Thông tin không chính xác (A4.1)
      return { 
        success: false, 
        code: 'A4_1_VERIFY_FAILED', 
        message: 'Lỗi xác minh' 
      };
    }

    // Thông tin chính xác -> Cho phép nhập mật khẩu mới
    return {
      success: true,
      code: 'A4_2_VERIFIED',
      userId: user.id,
      user: { id: user.id, name: user.name, email: user.email },
      message: 'Xác minh thông tin chính xác! Vui lòng nhập mật khẩu mới.'
    };
  }

  // .2: Cập nhật mật khẩu mới
  resetPassword(userId, newPassword) {
    if (!newPassword || newPassword.length < 6) {
      return { success: false, message: 'Mật khẩu mới phải có tối thiểu 6 ký tự!' };
    }
    const users = this.getUsers();
    const user = users.find(u => String(u.id) === String(userId));
    if (!user) {
      return { success: false, message: 'Không tìm thấy tài khoản người dùng!' };
    }
    user.password = newPassword;
    localStorage.setItem(STORAGE_KEYS.USERS, JSON.stringify(users));

    // Đồng bộ đổi mật khẩu vào SQL Server
    this.syncDatabaseAction('reset_password', {
      userId: user.id,
      newPassword: newPassword
    });

    return {
      success: true,
      message: 'Hệ thống đã xác nhận và cập nhật mật khẩu mới thành công! Vui lòng đăng nhập lại.'
    };
  }

  registerCustomer({ name, phone, email, password, extraInfo }) {
    if (!name || !phone || !email || !password || !extraInfo) {
      return { success: false, message: 'Vui lòng điền đầy đủ các thông tin bắt buộc và thông tin phụ!' };
    }
    if (password.length < 6) {
      return { success: false, message: 'Mật khẩu phải có tối thiểu 6 ký tự!' };
    }
    const cleanPhone = phone.replace(/\D/g, '');
    const users = this.getUsers();
    
    
    if (users.some(u => u.email && u.email.toLowerCase() === email.trim().toLowerCase())) {
      return { success: false, code: 'A2_DUPLICATE_EMAIL', message: 'Dữ liệu không hợp lệ hoặc trùng: Email này đã được đăng ký!' };
    }
    if (users.some(u => u.phone && u.phone.replace(/\D/g, '') === cleanPhone)) {
      return { success: false, code: 'A2_DUPLICATE_PHONE', message: 'Dữ liệu không hợp lệ hoặc trùng: Số điện thoại này đã được sử dụng!' };
    }

    const newUser = {
      id: 'usr_' + Date.now().toString(36),
      name: name.trim(),
      role: 'customer',
      email: email.trim().toLowerCase(),
      phone: phone.trim(),
      password: password,
      extraInfo: extraInfo.trim(),
      cancelCount: 0,
      status: 'active',
      avatar: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150',
      createdAt: new Date().toLocaleString('vi-VN')
    };

    users.push(newUser);
    localStorage.setItem(STORAGE_KEYS.USERS, JSON.stringify(users));
    sessionStorage.setItem('guidia_current_user', JSON.stringify(newUser));

    // Đồng bộ đăng ký du khách mới vào SQL Server
    this.syncDatabaseAction('register', {
      name: newUser.name,
      phone: newUser.phone,
      email: newUser.email,
      password: newUser.password,
      role: 'CUSTOMER',
      extraInfo: newUser.extraInfo
    });

    const ext = (typeof window !== 'undefined' && window.location.pathname.endsWith('.html')) ? '.html' : '.jsp';
    return { 
      success: true, 
      user: newUser, 
      redirectUrl: 'customer' + ext,
      message: 'Hệ thống đã kích hoạt tài khoản và thông báo đăng ký thành công!' 
    };
  }

  registerGuide({ name, phone, email, password, extraInfo, city, certType, certNumber, certImage, specialties }) {
    if (!name || !phone || !email || !password || !certNumber || !extraInfo) {
      return { success: false, message: 'Vui lòng điền đầy đủ họ tên, liên hệ, số thẻ HDV, mật khẩu và thông tin phụ!' };
    }
    if (password.length < 6) {
      return { success: false, message: 'Mật khẩu phải có tối thiểu 6 ký tự!' };
    }
    const cleanPhone = phone.replace(/\D/g, '');
    const users = this.getUsers();
    
    
    if (users.some(u => u.email && u.email.toLowerCase() === email.trim().toLowerCase())) {
      return { success: false, code: 'A2_DUPLICATE_EMAIL', message: 'Dữ liệu không hợp lệ hoặc trùng: Email này đã được đăng ký!' };
    }
    if (users.some(u => u.phone && u.phone.replace(/\D/g, '') === cleanPhone)) {
      return { success: false, code: 'A2_DUPLICATE_PHONE', message: 'Dữ liệu không hợp lệ hoặc trùng: Số điện thoại này đã được sử dụng!' };
    }

    const newGuideId = 'guide_' + Date.now().toString(36);
    const newUser = {
      id: newGuideId,
      name: name.trim(),
      role: 'guide',
      email: email.trim().toLowerCase(),
      phone: phone.trim(),
      password: password,
      extraInfo: extraInfo.trim(),
      status: 'pending_approval', // Hồ sơ chuyển sang "Chờ duyệt" để QTV xét duyệt
      violationCount: 0,
      avatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
      createdAt: new Date().toLocaleString('vi-VN')
    };

    const newGuideProfile = {
      id: newGuideId,
      name: name.trim(),
      city: city || 'Hà Nội',
      region: 'north',
      phone: phone.trim(),
      rating: 5.0,
      reviewCount: 0,
      hourlyPrice: 350000,
      dailyPrice: 1200000,
      experienceYears: 'Mới gia nhập',
      certType: certType || 'Thẻ Hướng Dẫn Viên Du Lịch Nội Địa',
      certNumber: certNumber.trim(),
      certStatus: 'pending',
      issuedBy: 'Sở Du Lịch Địa Phương',
      certImage: certImage || 'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=600',
      bio: `Hướng dẫn viên bản địa chuyên tuyến ${city || 'Việt Nam'}. Nhiệt huyết, tận tâm và am hiểu văn hóa địa phương.`,
      specialties: specialties || `Tuyến tour ${city || 'Việt Nam'} - Sở thích: ${extraInfo.trim()}`,
      languages: 'Tiếng Việt',
      blockedDates: [],
      violationCount: 0,
      balance: { escrow: 0, available: 0 }
    };

    const newCert = {
      id: 'CERT-' + Date.now().toString().slice(-4),
      guideId: newGuideId,
      guideName: name.trim(),
      certNumber: certNumber.trim(),
      certType: certType || 'Thẻ Hướng Dẫn Viên Du Lịch Nội Địa',
      issuedBy: 'Sở Du Lịch Địa Phương',
      status: 'pending',
      image: certImage || 'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=600',
      submittedAt: new Date().toLocaleString('vi-VN')
    };

    users.push(newUser);
    localStorage.setItem(STORAGE_KEYS.USERS, JSON.stringify(users));

    const guides = this.getGuides();
    guides.push(newGuideProfile);
    localStorage.setItem(STORAGE_KEYS.GUIDES, JSON.stringify(guides));

    // Đồng bộ đăng ký Hướng dẫn viên mới vào SQL Server (Hồ sơ ở trạng thái Chờ duyệt)
    this.syncDatabaseAction('register', {
      name: newUser.name,
      phone: newUser.phone,
      email: newUser.email,
      password: newUser.password,
      role: 'GUIDE',
      extraInfo: newUser.extraInfo,
      city: newGuideProfile.city,
      certType: newGuideProfile.certType,
      certNumber: newGuideProfile.certNumber,
      certImage: newGuideProfile.certImage
    });

    const certs = this.getCertificates();
    certs.unshift(newCert);
    localStorage.setItem(STORAGE_KEYS.CERTIFICATES, JSON.stringify(certs));

    return { 
      success: true, 
      user: newUser, 
      isGuidePending: true,
      message: 'Đăng ký thành công! Hồ sơ hướng dẫn viên đã chuyển sang "Chờ duyệt" để QTV xét duyệt.' 
    };
  }

  getCurrentUser() {
    const raw = sessionStorage.getItem('guidia_current_user');
    if (!raw) return null;
    try {
      return JSON.parse(raw);
    } catch (e) {
      return null;
    }
  }

  logout() {
    sessionStorage.removeItem('guidia_current_user');
    const ext = (typeof window !== 'undefined' && window.location.pathname.endsWith('.html')) ? '.html' : '.jsp';
    return { success: true, redirectUrl: 'login' + ext };
  }

  // ==========================================
  // HỆ THỐNG CƠ SỞ DỮ LIỆU QUAN HỆ MÔ PHỎNG (15 BẢNG SQL SERVER)
  // Cho phép hệ thống hoạt động hoàn toàn độc lập mà không cần server bên ngoài,
  // đồng thời phản ánh chính xác cấu trúc 15 bảng T-SQL trong database_sqlserver.sql
  // ==========================================
  getSqlTables() {
    const users = this.getUsers();
    const guides = this.getGuides();
    const trips = this.getTrips();
    const certs = this.getCertificates();
    const disputes = this.getDisputes();
    const txns = this.getTransactions();
    const msgs = this.getMessages();

    return {
      NguoiDung: users.map(u => ({
        maNguoiDung: u.id,
        hoTen: u.name,
        email: u.email,
        soDienThoai: u.phone,
        trangThai: u.status === 'active' ? 'HoatDong' : (u.status === 'suspended' ? 'BiKhoa' : 'ChoDuyet')
      })),
      KhachDuLich: users.filter(u => u.role === 'customer').map(u => ({
        maKhach: u.id,
        hoTen: u.name,
        soChuyenDaDi: trips.filter(t => String(t.customerId) === String(u.id) && t.status === 'finished_paid').length,
        soChuyenSapDi: trips.filter(t => String(t.customerId) === String(u.id) && t.status === 'confirmed_upcoming').length
      })),
      HuongDanVien: guides.map(g => ({
        maHuongDanVien: g.id,
        hoTen: g.name,
        khuVuc: g.city,
        kinhNghiem: g.experienceYears,
        soSaoTB: g.rating
      })),
      QuanTriVien: users.filter(u => u.role === 'admin').map(u => ({
        maQuanTriVien: u.id,
        hoTen: u.name,
        quyenHan: 'ToanQuyenQuanTri'
      })),
      HoSoHuongDanVien: certs.map(c => ({
        maHoSo: c.id,
        maHuongDanVien: c.guideId,
        soTheHanhNghe: c.certNumber,
        donViCapThe: c.issuedBy,
        ngayCap: c.issueDate,
        ngayHetHan: c.expiryDate,
        trangThaiXacMinh: c.status === 'approved' ? 'DaDuyet' : (c.status === 'pending' ? 'ChoXacMinh' : 'TuChoi'),
        lyDoTuChoi: c.rejectReason || null
      })),
      ChuyenDi: trips.map(t => ({
        maChuyenDi: 'TOUR_' + t.id,
        maHuongDanVien: t.guideId,
        tenChuyenDi: t.location,
        diaDiem: t.location.split('(')[0].trim(),
        trangThai: 'HoatDong',
        giaTien: t.totalAmount
      })),
      YeuCauDatLich: trips.map(t => ({
        maYeuCau: t.id,
        maKhach: t.customerId,
        maHuongDanVien: t.guideId,
        maChuyenDi: 'TOUR_' + t.id,
        ngayBatDau: t.startDate,
        ngayKetThuc: t.startDate,
        soNguoi: t.guests,
        tongTien: t.totalAmount,
        trangThai: t.status === 'confirmed_upcoming' ? 'DaXacNhan' : (t.status === 'finished_paid' ? 'HoanThanh' : (t.status === 'cancelled_refunded' ? 'DaHuy' : 'ChoXacNhan')),
        lyDoHuy: t.cancelReason || t.rejectReason || null
      })),
      LichLamViec: guides.flatMap(g => (g.blockedDates || []).map((date, idx) => ({
        maLich: `LICH_${g.id}_${idx + 1}`,
        maHuongDanVien: g.id,
        ngayLamViec: date,
        gioBatDau: '08:00:00',
        gioKetThuc: '17:00:00',
        trangThai: 'Ban'
      }))),
      TinNhan: msgs.map(m => ({
        maTinNhan: m.id,
        maHuongDanVien: m.senderId.startsWith('guide') ? m.senderId : m.receiverId,
        maKhach: m.senderId.startsWith('usr') ? m.senderId : m.receiverId,
        noiDung: m.text,
        thoiGianGui: m.timestamp,
        trangThai: m.status === 'seen' ? 'DaDoc' : 'ChuaDoc'
      })),
      GiaoDich: txns.map(tx => ({
        maGiaoDich: tx.id,
        maYeuCau: tx.tripId,
        soTien: tx.amount,
        thoiGian: tx.timestamp,
        phuongThucThanhToan: tx.gatewayRef.split('_')[0],
        trangThai: tx.internalStatus === 'completed' ? 'DaGiaiNgan' : 'TamGiuEscrow',
        phiSan: Math.round(tx.amount * 0.1),
        tienHDVNhan: Math.round(tx.amount * 0.9)
      })),
      XacNhanKetThuc: trips.map(t => ({
        maXacNhan: 'XN_' + t.id,
        maYeuCau: t.id,
        thoiGianKhachXacNhan: t.customerCompleted ? t.guideCompletedAt : null,
        thoiGianHDVXacNhan: t.guideCompleted ? t.guideCompletedAt : null,
        trangThai: t.status === 'finished_paid' ? 'DaHoanTat' : 'ChoXacNhan'
      })),
      DanhGia: trips.filter(t => t.review).map((t, idx) => ({
        maDanhGia: 'REV_' + (idx + 1),
        maKhach: t.customerId,
        maHuongDanVien: t.guideId,
        maChuyenDi: 'TOUR_' + t.id,
        soSao: t.review.stars,
        noiDung: t.review.comment,
        ngayDanhGia: t.review.createdAt,
        phanHoi: t.review.reply || null
      })),
      KhieuNai: disputes.map(d => ({
        maKhieuNai: d.id,
        maKhach: 'usr_thao',
        maQuanTriVien: 'usr_admin',
        noiDung: d.reason,
        thoiGianGui: d.createdAt,
        trangThai: d.status === 'pending' ? 'ChoXuLy' : (d.status === 'resolved_refund' ? 'DaGiaiQuyet' : 'BacBo'),
        ketQuaXuLy: d.adminDecision || null,
        soTienHoan: d.status === 'resolved_refund' ? d.amount : 0
      })),
      BangChungKhieuNai: disputes.map(d => ({
        maBangChung: 'BC_' + d.id,
        maKhieuNai: d.id,
        loaiTep: 'HinhAnh',
        duongDanTep: d.evidenceUrl || d.evidenceText,
        thoiGianTaiLen: d.createdAt
      })),
      BaoCaoThongKe: [
        {
          maBaoCao: 'BC_TONG_HOP_T11',
          maQuanTriVien: 'usr_admin',
          loaiBaoCao: 'BaoCaoTongHopToanSan',
          ngayTao: '2026-11-02',
          noiDung: 'Báo cáo tổng hợp số liệu doanh thu, tỷ lệ hủy, ký quỹ Escrow và phân bổ giao dịch tháng 11/2026.'
        }
      ]
    };
  }

  // ==========================================
  // USE CASE 03: ĐĂNG NHẬP / XÁC THỰC TRẠNG THÁI TÀI KHOẢN
  // ==========================================
  authenticateUser(emailOrPhone, password) {
    const users = this.getUsers();
    const user = users.find(u => (u.email === emailOrPhone || u.phone === emailOrPhone));
    
    
    if (!user || user.password !== password) {
      return { 
        success: false, 
        errorCode: '', 
        message: 'Thông tin đăng nhập không đúng! Vui lòng kiểm tra lại email/SĐT và mật khẩu.' 
      };
    }

    
    if (user.status === 'suspended') {
      return { 
        success: false, 
        errorCode: '', 
        message: `Tài khoản đã bị khóa do vi phạm: "${user.banReason || 'Vi phạm điều khoản'}". Vui lòng liên hệ bộ phận hỗ trợ.` 
      };
    }

    
    if (user.role === 'guide') {
      const guides = this.getGuides();
      const guide = guides.find(g => String(g.id) === String(user.id));
      if (user.status === 'pending_approval' || (guide && guide.certStatus === 'pending')) {
        return { 
          success: false, 
          errorCode: '', 
          message: 'Hồ sơ hướng dẫn viên đang chờ duyệt. Quản trị viên đang thẩm định thẻ hành nghề của bạn!' 
        };
      }
    }

    return { success: true, user };
  }

  // ==========================================
  // USE CASE 04: QUẢN LÝ THÔNG TIN CÁ NHÂN (HDV)
  // ==========================================
  updateGuideProfile(guideId, data, isImportantChange = false) {
    const users = this.getUsers();
    const user = users.find(u => String(u.id) === String(guideId));
    const guides = this.getGuides();
    const guide = guides.find(g => String(g.id) === String(guideId));

    if (!user || !guide) {
      return { success: false, message: 'Không tìm thấy hồ sơ hướng dẫn viên' };
    }

    
    if (!data.name || data.name.trim().length < 2) {
      return { success: false, errorCode: '', message: 'Dữ liệu không hợp lệ: Họ tên phải có ít nhất 2 ký tự.' };
    }
    if (!data.phone || !/^(0|\+84)[3|5|7|8|9][0-9]{8}$/.test(data.phone.replace(/\s+/g, ''))) {
      return { success: false, errorCode: '', message: 'Dữ liệu không hợp lệ: Số điện thoại không đúng chuẩn di động Việt Nam.' };
    }

    
    if (data.newPassword) {
      if (!data.oldPassword || data.oldPassword !== user.password) {
        return { success: false, errorCode: '', message: 'Đổi mật khẩu thất bại: Mật khẩu cũ không chính xác!' };
      }
      if (data.newPassword.length < 6) {
        return { success: false, errorCode: '', message: 'Mật khẩu mới phải có tối thiểu 6 ký tự.' };
      }
      user.password = data.newPassword;
    }

    // Cập nhật thông tin thông thường
    user.name = data.name.trim();
    user.phone = data.phone.trim();
    guide.name = user.name;
    guide.phone = user.phone;
    if (data.city) guide.city = data.city;
    if (data.hourlyPrice) guide.hourlyPrice = parseInt(data.hourlyPrice) || guide.hourlyPrice;
    if (data.dailyPrice) guide.dailyPrice = parseInt(data.dailyPrice) || guide.dailyPrice;
    if (data.bio) guide.bio = data.bio;
    if (data.specialties) guide.specialties = data.specialties;
    if (data.languages) guide.languages = data.languages;
    if (data.avatar) {
      user.avatar = data.avatar;
      guide.avatar = data.avatar;
    }

    
    if (isImportantChange) {
      guide.certStatus = 'pending';
      user.status = 'pending_approval';
      if (data.certType) guide.certType = data.certType;
      if (data.certNumber) guide.certNumber = data.certNumber;
      if (data.issuedBy) guide.issuedBy = data.issuedBy;
      if (data.certImage) guide.certImage = data.certImage;

      const certs = this.getCertificates();
      certs.unshift({
        id: 'cert_' + Date.now(),
        guideId: guide.id,
        guideName: guide.name,
        city: guide.city,
        certType: guide.certType,
        certNumber: guide.certNumber,
        issuedBy: guide.issuedBy || 'Sở Du Lịch',
        issueDate: new Date().toISOString().split('T')[0],
        expiryDate: '2029-12-31',
        documentUrl: guide.certImage || 'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=600',
        status: 'pending',
        submittedAt: new Date().toLocaleString('vi-VN'),
        note: 'HDV cập nhật lại thẻ hành nghề du lịch Việt Nam mới. Yêu cầu thẩm định lại.'
      });
      localStorage.setItem(STORAGE_KEYS.CERTIFICATES, JSON.stringify(certs));
    }

    localStorage.setItem(STORAGE_KEYS.USERS, JSON.stringify(users));
    localStorage.setItem(STORAGE_KEYS.GUIDES, JSON.stringify(guides));

    // Đồng bộ trực tiếp thay đổi thông tin cá nhân của HDV vào SQL Server
    this.syncDatabaseAction('update_profile', {
      userId: guideId,
      name: user.name,
      phone: user.phone,
      avatar: user.avatar,
      bio: guide.bio,
      city: guide.city,
      hourlyPrice: guide.hourlyPrice,
      dailyPrice: guide.dailyPrice,
      languages: guide.languages,
      bankName: guide.bankName,
      bankAccount: guide.bankAccount,
      bankOwner: guide.bankOwner,
      certNumber: guide.certNumber,
      certImage: guide.certImage,
      password: data.newPassword || ''
    });

    if (isImportantChange) {
      return {
        success: true,
        isPendingApproval: true,
        message: 'Đã lưu thông tin! Vì bạn đã thay đổi Thẻ hành nghề du lịch, hồ sơ của bạn đã chuyển sang trạng thái "Chờ duyệt" để Quản trị viên thẩm tra lại.'
      };
    }

    return { success: true, message: 'Cập nhật thông tin cá nhân và hồ sơ thành công!' };
  }

  // ==========================================
  // USE CASE 05: NHẮN TIN TRAO ĐỔI (LIVE CHAT)
  // ==========================================
  getConversation(userA, userB) {
    const all = this.getMessages();
    const strA = String(userA);
    const strB = String(userB);
    return all.filter(m => 
      (String(m.senderId) === strA && String(m.receiverId) === strB) ||
      (String(m.senderId) === strB && String(m.receiverId) === strA)
    ).sort((a, b) => this.parseMessageTime(a) - this.parseMessageTime(b));
  }

  sendMessage(senderId, receiverId, text, imageUrl = null) {
    const users = this.getUsers();
    const receiver = users.find(u => String(u.id) === String(receiverId));

    if (receiver && receiver.status === 'suspended') {
      return { 
        success: false, 
        errorCode: '', 
        message: 'Không thể gửi tin nhắn: Tài khoản của đối phương đã bị tạm ngưng hoặc khóa!' 
      };
    }

    if (!text && !imageUrl) {
      return { success: false, message: 'Nội dung tin nhắn không được để trống.' };
    }

    const sender = users.find(u => String(u.id) === String(senderId));
    const messages = this.getMessages();
    const now = new Date();
    const pad = n => String(n).padStart(2, '0');
    const isoTimestamp = `${now.getFullYear()}-${pad(now.getMonth() + 1)}-${pad(now.getDate())} ${pad(now.getHours())}:${pad(now.getMinutes())}:${pad(now.getSeconds())}`;
    const displayTime = `${pad(now.getHours())}:${pad(now.getMinutes())}`;

    const cleanSenderId = (typeof senderId === 'string' && senderId.includes('_')) ? (parseInt(senderId.replace(/\D+/g, '')) || 2) : (parseInt(senderId) || 2);
    const cleanReceiverId = (typeof receiverId === 'string' && receiverId.includes('_')) ? (parseInt(receiverId.replace(/\D+/g, '')) || 17) : (parseInt(receiverId) || 17);

    const newMsg = {
      id: 'msg_' + Date.now(),
      senderId: cleanSenderId,
      senderName: sender ? sender.name : 'Người dùng',
      receiverId: cleanReceiverId,
      text: text || '',
      content: text || '',
      imageUrl: imageUrl || null,
      timestamp: isoTimestamp,
      createdAt: now.getTime(),
      time: displayTime,
      status: 'delivered', // đã gửi, sẽ chuyển thành 'seen' khi đọc
      isRead: false
    };

    messages.push(newMsg);
    localStorage.setItem(STORAGE_KEYS.MESSAGES, JSON.stringify(messages));
    if (typeof window !== 'undefined') {
      window.dispatchEvent(new CustomEvent('guidia_messages_synced', { detail: messages }));
    }

    // Đồng bộ trực tiếp vào SQL Server QL_Du_Lich bảng Messages
    this.syncDatabaseAction('send_message', {
      senderId: cleanSenderId,
      receiverId: cleanReceiverId,
      content: text || '',
      imageUrl: imageUrl || ''
    }).then(() => {
      // Gọi lại sync ngầm sau 400ms để nhận id từ DB
      setTimeout(() => this.syncWithDatabase(), 400);
    });

    return { success: true, message: newMsg };
  }

  markMessagesAsRead(receiverId, senderId) {
    const messages = this.getMessages();
    let hasUpdated = false;
    messages.forEach(m => {
      const matchReceiver = String(m.receiverId) === String(receiverId);
      const matchSender = !senderId || String(m.senderId) === String(senderId);
      if (matchReceiver && matchSender) {
        if (!m.isRead || m.status !== 'seen') {
          m.isRead = true;
          m.status = 'seen';
          hasUpdated = true;
        }
      }
    });

    if (hasUpdated) {
      localStorage.setItem(STORAGE_KEYS.MESSAGES, JSON.stringify(messages));
      if (typeof window !== 'undefined') {
        window.dispatchEvent(new CustomEvent('guidia_messages_synced', { detail: messages }));
      }
      const cleanReceiverId = (typeof receiverId === 'string' && receiverId.includes('_')) ? (parseInt(receiverId.replace(/\D+/g, '')) || 17) : (parseInt(receiverId) || 17);
      const cleanSenderId = senderId ? ((typeof senderId === 'string' && senderId.includes('_')) ? (parseInt(senderId.replace(/\D+/g, '')) || 2) : (parseInt(senderId) || 2)) : 0;
      this.syncDatabaseAction('mark_read', {
        receiverId: cleanReceiverId,
        senderId: cleanSenderId
      });
    }
    return hasUpdated;
  }

  // ==========================================
  // TẠO ĐƠN ĐẶT TOUR & ĐỒNG BỘ SQL SERVER
  // ==========================================
  createTripBooking({ guideId, guideName, customerId, customerName, customerPhone, location, startDate, startTime, endDate, endTime, duration, guests, totalAmount, notes }) {
    const trips = this.getTrips();
    const cleanGuideId = guideId || 2;
    const cleanCustId = customerId || 17;
    const price = totalAmount || 1500000;
    const fee = Math.round(price * 0.10);
    const payout = price - fee;
    const sDate = startDate || new Date().toISOString().slice(0, 10);
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const bookDate = new Date(sDate);
    bookDate.setHours(0, 0, 0, 0);
    const diffDays = Math.round((bookDate.getTime() - today.getTime()) / (1000 * 3600 * 24));
    if (diffDays < 2) {
      return {
        success: false,
        message: 'Khách hàng phải đặt lịch chuyến đi trước ít nhất 2 ngày kể từ ngày đặt lịch!'
      };
    }
    const sTime = startTime || '08:00';
    const eDate = endDate || sDate;
    const eTime = endTime || '17:30';
    const gCount = parseInt(guests) || 2;

    const newTrip = {
      id: 'TRIP-' + (trips.length + 101),
      bookingCode: 'TRIP-' + (trips.length + 101),
      guideId: cleanGuideId,
      guideName: guideName || 'Hướng Dẫn Viên',
      customerId: cleanCustId,
      customerName: customerName || 'Du Khách',
      customerPhone: customerPhone || '0980000001',
      location: location || 'Hà Nội',
      startDate: sDate,
      startTime: sTime,
      endDate: eDate,
      endTime: eTime,
      duration: duration || '1 ngày',
      guests: gCount,
      groupSize: gCount,
      number_of_guests: gCount,
      totalAmount: price,
      platformFee: fee,
      guidePayout: payout,
      escrowAmount: price,
      notes: notes || '',
      status: 'pending_guide_confirm',
      dbStatus: 'PENDING',
      paymentStatus: 'escrow_held',
      guideConfirmed: false,
      customerConfirmed: false,
      createdAt: new Date().toISOString().replace('T', ' ').slice(0, 19),
      createdAtMs: Date.now(),
      expireAtMs: Date.now() + 24 * 3600 * 1000,
      expireAtStr: new Date(Date.now() + 24 * 3600 * 1000).toLocaleString('vi-VN')
    };

    trips.unshift(newTrip);
    localStorage.setItem(STORAGE_KEYS.TRIPS, JSON.stringify(trips));

    // Đồng bộ trực tiếp vào SQL Server QL_Du_Lich
    this.syncDatabaseAction('create_booking', {
      customerId: cleanCustId,
      guideId: cleanGuideId,
      destination: location || 'Hà Nội',
      startDate: sDate,
      startTime: sTime,
      endDate: eDate,
      endTime: eTime,
      guests: gCount,
      totalPrice: price,
      note: notes || ''
    });

    return { success: true, trip: newTrip };
  }

  updateGuideBankAccount(guideId, { bankName, bankAccount, bankOwner }) {
    const guides = this.getGuides();
    const guide = guides.find(g => String(g.id) === String(guideId));
    if (!guide) return { success: false, message: 'Không tìm thấy hướng dẫn viên' };

    guide.bankName = bankName || '';
    guide.bankAccount = bankAccount || '';
    guide.bankOwner = bankOwner || guide.name || '';
    localStorage.setItem(STORAGE_KEYS.GUIDES, JSON.stringify(guides));

    const users = this.getUsers();
    const user = users.find(u => String(u.id) === String(guideId));
    if (user) {
      user.bankName = guide.bankName;
      user.bankAccount = guide.bankAccount;
      user.bankOwner = guide.bankOwner;
      localStorage.setItem(STORAGE_KEYS.USERS, JSON.stringify(users));
    }

    // Đồng bộ trực tiếp vào SQL Server QL_Du_Lich
    this.syncDatabaseAction('update_bank', {
      guideId: parseInt(guideId) || 2,
      bankName: guide.bankName,
      bankAccount: guide.bankAccount,
      bankOwner: guide.bankOwner
    });

    return { success: true, message: 'Đã cập nhật thông tin tài khoản ngân hàng thành công!' };
  }

  // ==========================================
  // USE CASE 06: QUẢN LÝ YÊU CẦU ĐẶT LỊCH (HDV)
  // ==========================================
  respondToBookingRequest(tripId, accept = true, rejectReason = '') {
    const trips = this.getTrips();
    const trip = trips.find(t => t.id === tripId);
    if (!trip) return { success: false, message: 'Không tìm thấy yêu cầu chuyến đi' };

    const guides = this.getGuides();
    const guide = guides.find(g => String(g.id) === String(trip.guideId));

    if (accept) {
      // Yêu cầu bắt buộc: Trước khi nhận khách phải điền thông tin tài khoản ngân hàng ở trang thông tin cá nhân
      if (!guide || !guide.bankAccount || !guide.bankAccount.trim() || !guide.bankName || !guide.bankName.trim()) {
        return {
          success: false,
          requireBank: true,
          message: 'Vui lòng Cung cấp thông tin tài khoản ngân hàng'
        };
      }

      if (guide && guide.blockedDates && guide.blockedDates.includes(trip.startDate)) {
        trip.status = 'cancelled_refunded';
        trip.paymentStatus = 'refunded_to_customer';
        trip.rejectReason = 'Lịch ngày này đã trùng lặp. Hệ thống hủy đơn và hoàn tiền cho du khách';
        localStorage.setItem(STORAGE_KEYS.TRIPS, JSON.stringify(trips));
        return {
          success: false,
          errorCode: '',
          message: 'Lịch ngày này đã trùng! Hệ thống đã hủy giao dịch và hoàn 100% tiền tạm giữ cho du khách.'
        };
      }

      // Chuyển đơn sang "Đã xác nhận", khóa thời gian đó trong lịch HDV
      trip.status = 'confirmed_upcoming';
      trip.dbStatus = 'ĐÃ_XÁC_NHẬN';
      trip.acceptedAt = new Date().toLocaleString('vi-VN');

      if (guide) {
        guide.blockedDates = guide.blockedDates || [];
        guide.blockedDates = guide.blockedDates.filter(d => d !== trip.startDate);
        localStorage.setItem(STORAGE_KEYS.GUIDES, JSON.stringify(guides));
      }

      localStorage.setItem(STORAGE_KEYS.TRIPS, JSON.stringify(trips));

      // Đồng bộ xác nhận tour vào SQL Server (Bookings & GuideSchedules)
      this.syncDatabaseAction('accept_trip', {
        tripId: trip.dbBookingId || trip.dbTripId || trip.id,
        bookingId: trip.dbBookingId || trip.dbTripId || trip.id,
        guideId: trip.guideId || 2
      });

      // 10. Thông báo cho KDL (Tự động gửi tin nhắn xác nhận tour từ HDV tới Du khách)
      try {
        const notifyContent = `Chào bạn! Tôi đã chấp nhận yêu cầu đặt tour ${trip.id} (${trip.location}) khởi hành lúc ${trip.startTime || '08:00'} ngày ${trip.startDate}. Chuyến đi của bạn đã được chuyển sang trạng thái ĐÃ XÁC NHẬN. Rất hân hạnh đồng hành cùng bạn!`;
        this.sendMessage(trip.guideId, trip.customerId, notifyContent);
      } catch (e) {
        console.warn('Lỗi gửi tin nhắn thông báo cho khách:', e);
      }

      return {
        success: true,
        message: 'Đã chấp nhận đơn đặt lịch ' + trip.id + '! Chuyến đi đã chuyển sang Quản Lý Chuyến Đi, đã khóa lịch dẫn đoàn và gửi thông báo xác nhận tới Du khách.'
      };
    } else {
      
      if (!rejectReason || !rejectReason.trim()) {
        return {
          success: false,
          errorCode: '',
          message: 'Bắt buộc phải nhập lý do khi từ chối yêu cầu đặt lịch của du khách!'
        };
      }

      trip.status = 'cancelled_refunded';
      trip.paymentStatus = 'refunded_to_customer';
      trip.rejectReason = rejectReason.trim();
      trip.cancelledAt = new Date().toLocaleString('vi-VN');

      // Ghi nhận hoàn tiền trong giao dịch
      const txns = this.getTransactions();
      txns.unshift({
        id: 'TXN-REFUND-' + Date.now(),
        tripId: trip.id,
        type: 'refund',
        title: `Hoàn tiền đặt tour ${trip.id} do HDV từ chối (${rejectReason.trim()})`,
        amount: trip.totalAmount,
        gatewayRef: 'MOCK_REFUND_' + Math.floor(100000 + Math.random() * 900000),
        gatewayStatus: 'success',
        internalStatus: 'completed',
        matched: true,
        timestamp: new Date().toLocaleString('vi-VN')
      });
      localStorage.setItem('guidia_transactions_v2', JSON.stringify(txns));

      localStorage.setItem(STORAGE_KEYS.TRIPS, JSON.stringify(trips));

      // Đồng bộ từ chối tour vào SQL Server
      this.syncDatabaseAction('cancel_trip', {
        tripId: trip.dbBookingId || trip.dbTripId || trip.id,
        bookingId: trip.dbBookingId || trip.dbTripId || trip.id,
        reason: rejectReason.trim(),
        userId: trip.guideId || 2,
        role: 'guide'
      });

      return {
        success: true,
        message: 'Đã từ chối đơn đặt lịch. Tiền cọc đã được cập nhật hoàn lại trên hệ thống và SQL Server.'
      };
    }
  }

  
  // Quét và tự động xử lý các mốc thời gian quá hạn thực tế (24h/48h)
  processAutoTimers() {
    let raw = JSON.parse(localStorage.getItem(STORAGE_KEYS.TRIPS) || '[]');
    if (!raw || raw.length === 0) return { modified: false, expiredBookings: 0, autoPayouts: 0 };
    let modified = false;
    let expiredBookings = 0;
    let autoPayouts = 0;
    const now = Date.now();

    raw.forEach(trip => {
      // 1. UC06 Luồng phụ A5: Quá hạn 24h HDV không phản hồi -> Tự động hủy & hoàn 100% tiền tạm giữ
      if (trip.status === 'pending_guide' || trip.status === 'pending_guide_confirm' || trip.status === 'pending') {
        let expireAt = trip.expireAtMs;
        if (!expireAt && trip.createdAt) {
          const createdParsed = Date.parse(trip.createdAt.replace(' ', 'T'));
          if (!isNaN(createdParsed)) {
            expireAt = createdParsed + 24 * 3600 * 1000;
            trip.expireAtMs = expireAt;
            modified = true;
          }
        }
        if (expireAt && now >= expireAt) {
          trip.status = 'cancelled_refunded';
          trip.paymentStatus = 'refunded_to_customer';
          trip.rejectReason = 'Hệ thống tự động hủy đơn do HDV không phản hồi trong vòng 24h (Luồng phụ A5 - UC06)';
          trip.cancelledAt = new Date().toLocaleString('vi-VN');
          trip.autoExpired = true;
          modified = true;
          expiredBookings++;

          try {
            const txns = JSON.parse(localStorage.getItem('guidia_transactions_v2') || '[]');
            txns.unshift({
              id: 'TXN-REFUND-' + Date.now() + '-' + Math.floor(Math.random() * 1000),
              tripId: trip.id,
              type: 'refund',
              title: `Tự động hoàn 100% tiền tạm giữ đơn ${trip.id} do quá hạn 24h HDV không phản hồi (A5 - UC06)`,
              amount: trip.totalAmount || trip.escrowAmount || 0,
              gatewayRef: 'AUTO_REFUND_' + Math.floor(100000 + Math.random() * 900000),
              gatewayStatus: 'success',
              internalStatus: 'completed',
              matched: true,
              timestamp: new Date().toLocaleString('vi-VN')
            });
            localStorage.setItem('guidia_transactions_v2', JSON.stringify(txns));
          } catch (e) { }
        }
      }

      // 2. UC07 Luồng phụ A3: KDL không xác nhận sau 1 ngày (24h) kể từ khi HDV xác nhận -> Tự động tất toán cho HDV
      if (trip.status === 'completed_pending_payout') {
        let deadline = trip.autoReleaseDeadlineMs;
        if (!deadline && trip.guideCompletedAt) {
          const completedParsed = Date.parse(trip.guideCompletedAt.replace(' ', 'T'));
          if (!isNaN(completedParsed)) {
            deadline = completedParsed + 24 * 3600 * 1000;
            trip.autoReleaseDeadlineMs = deadline;
            modified = true;
          }
        }
        if (deadline && now >= deadline) {
          trip.status = 'finished_paid';
          trip.paymentStatus = 'paid_to_guide';
          trip.autoReleased = true;
          trip.completedAt = new Date().toLocaleString('vi-VN');
          modified = true;
          autoPayouts++;

          try {
            const guides = JSON.parse(localStorage.getItem(STORAGE_KEYS.GUIDES) || '[]');
            const guide = guides.find(g => String(g.id) === String(trip.guideId));
            if (guide) {
              guide.balance = guide.balance || { available: 0, escrow: 0, totalEarned: 0 };
              const payout = trip.guidePayout || Math.round((trip.totalAmount || 0) * 0.9);
              guide.balance.escrow = Math.max(0, (guide.balance.escrow || 0) - (trip.totalAmount || 0));
              guide.balance.available = (guide.balance.available || 0) + payout;
              guide.balance.totalEarned = (guide.balance.totalEarned || 0) + payout;
              localStorage.setItem(STORAGE_KEYS.GUIDES, JSON.stringify(guides));
            }
          } catch (e) { }

          try {
            const txns = JSON.parse(localStorage.getItem('guidia_transactions_v2') || '[]');
            txns.unshift({
              id: 'TXN-PAYOUT-' + Date.now() + '-' + Math.floor(Math.random() * 1000),
              tripId: trip.id,
              type: 'payout',
              title: `Tự động tất toán thù lao ${trip.id} cho HDV sau 24h khách không khiếu nại (A3 - UC07)`,
              amount: trip.guidePayout || Math.round((trip.totalAmount || 0) * 0.9),
              gatewayRef: 'AUTO_PAYOUT_' + Math.floor(100000 + Math.random() * 900000),
              gatewayStatus: 'success',
              internalStatus: 'completed',
              matched: true,
              timestamp: new Date().toLocaleString('vi-VN')
            });
            localStorage.setItem('guidia_transactions_v2', JSON.stringify(txns));
          } catch (e) { }
        }
      }
    });

    if (modified) {
      localStorage.setItem(STORAGE_KEYS.TRIPS, JSON.stringify(raw));
    }
    return { modified, expiredBookings, autoPayouts };
  }

  // Giả lập tua nhanh thời gian (giờ) để kiểm thử ngay lập tức không cần chờ 2 ngày
  simulateFastForward(hours = 24) {
    const raw = JSON.parse(localStorage.getItem(STORAGE_KEYS.TRIPS) || '[]');
    const msToSubtract = hours * 3600 * 1000;
    raw.forEach(t => {
      if (t.createdAtMs) t.createdAtMs -= msToSubtract;
      if (t.expireAtMs) t.expireAtMs -= msToSubtract;
      if (t.guideCompletedAtMs) t.guideCompletedAtMs -= msToSubtract;
      if (t.autoReleaseDeadlineMs) t.autoReleaseDeadlineMs -= msToSubtract;
    });
    localStorage.setItem(STORAGE_KEYS.TRIPS, JSON.stringify(raw));
    return this.processAutoTimers();
  }

  autoExpireBookingRequest(tripId) {
    const trips = this.getTrips();
    const trip = trips.find(t => t.id === tripId);
    if (!trip || (trip.status !== 'pending_guide' && trip.status !== 'pending_guide_confirm' && trip.status !== 'pending')) {
      return { success: false, message: 'Đơn không ở trạng thái chờ duyệt' };
    }

    trip.status = 'cancelled_refunded';
    trip.paymentStatus = 'refunded_to_customer';
    trip.rejectReason = 'Hết thời hạn 24h quy định: HDV không phản hồi (Luồng phụ A5 - UC06)';
    trip.cancelledAt = new Date().toLocaleString('vi-VN');

    // Ghi nhận giao dịch hoàn tiền
    const txns = this.getTransactions();
    txns.unshift({
      id: 'TXN-REFUND-' + Date.now(),
      tripId: trip.id,
      type: 'refund',
      title: `Hoàn 100% tiền tạm giữ đơn ${trip.id} do quá hạn 24h HDV không phản hồi`,
      amount: trip.totalAmount,
      gatewayRef: 'AUTO_REFUND_' + Math.floor(100000 + Math.random() * 900000),
      gatewayStatus: 'success',
      internalStatus: 'completed',
      matched: true,
      timestamp: new Date().toLocaleString('vi-VN')
    });
    localStorage.setItem('guidia_transactions_v2', JSON.stringify(txns));
    localStorage.setItem(STORAGE_KEYS.TRIPS, JSON.stringify(trips));
    return {
      success: true,
      message: 'Hệ thống đã tự động hủy đơn do quá hạn 24h và hoàn 100% tiền tạm giữ cho khách hàng.'
    };
  }

  // Luồng phụ A3 - UC07: Tự động tất toán sau 1 ngày nếu KDL không xác nhận
  autoReleasePayout(tripId) {
    const trips = this.getTrips();
    const trip = trips.find(t => t.id === tripId);
    if (!trip || trip.status !== 'completed_pending_payout') {
      return { success: false, message: 'Chuyến đi không ở trạng thái chờ tất toán' };
    }
    this.payoutTrip(trip);
    localStorage.setItem(STORAGE_KEYS.TRIPS, JSON.stringify(trips));
    return {
      success: true,
      message: 'Hệ thống đã tự động tất toán thù lao cho HDV sau 1 ngày (khấu trừ 10% phí sàn) theo Luồng phụ A3 - UC07!'
    };
  }

  // ==========================================
  // USE CASE 07: QUẢN LÝ CHUYẾN ĐI (HDV & KHÁCH)
  // ==========================================
  // Bắt đầu chuyến đi (Chuyển sang trạng thái ĐANG ĐI theo đặc tả UC07)
  startTripTour(tripId) {
    const trips = this.getTrips();
    const trip = trips.find(t => t.id === tripId || String(t.dbBookingId) === String(tripId));
    if (!trip) return { success: false, message: 'Không tìm thấy chuyến đi' };

    trip.isOngoing = true;
    trip.status = 'ongoing';
    trip.startedAt = new Date().toLocaleString('vi-VN');
    localStorage.setItem(STORAGE_KEYS.TRIPS, JSON.stringify(trips));
    localStorage.setItem('guidia_trips_v2', JSON.stringify(trips));

    return {
      success: true,
      message: `Chuyến đi ${trip.id} đã chính thức bắt đầu! Chuyến đi hiện ở trạng thái ĐANG ĐI.`
    };
  }

  guideConfirmComplete(tripId) {
    const trips = this.getTrips();
    const trip = trips.find(t => t.id === tripId);
    if (!trip) return { success: false, message: 'Không tìm thấy chuyến đi' };

    const todayStr = new Date().toISOString().split('T')[0];
    const sDate = String(trip.startDate || '').substring(0, 10).trim();
    if (sDate && sDate > todayStr) {
      return {
        success: false,
        message: 'Chuyến đi chưa diễn ra! Ngày khởi hành là ' + trip.startDate + ' (hôm nay là ' + todayStr.split('-').reverse().join('/') + '). Không thể xác nhận kết thúc tour chưa bắt đầu.'
      };
    }

    trip.guideCompleted = true;
    trip.guideCompletedAt = new Date().toLocaleString('vi-VN');
    const nowMs = Date.now();
    trip.guideCompletedAtMs = nowMs;
    
    if (trip.customerCompleted) {
      this.payoutTrip(trip);
      localStorage.setItem(STORAGE_KEYS.TRIPS, JSON.stringify(trips));
      return {
        success: true,
        message: 'Cả hai bên đã xác nhận hoàn tất tour! Tiền đã được tất toán và chuyển khoản trực tiếp vào STK Ngân hàng của bạn sau khi giữ 10% phí sàn.'
      };
    } else {
      trip.status = 'completed_pending_payout';
      const deadlineMs = nowMs + 24 * 3600 * 1000;
      trip.autoReleaseDeadlineMs = deadlineMs;
      trip.autoReleaseDeadline = new Date(deadlineMs).toLocaleString('vi-VN');
      localStorage.setItem(STORAGE_KEYS.TRIPS, JSON.stringify(trips));
      return {
        success: true,
        message: 'Bạn đã xác nhận kết thúc chuyến đi! Quy định sàn: Sau 1 ngày (24h), nếu khách không khiếu nại, hệ thống sẽ tự động chuyển khoản thù lao trực tiếp vào STK Ngân hàng cho bạn.'
      };
    }
  }

  // Tất toán giải ngân thực nhận cho HDV
  payoutTrip(trip) {
    if (!trip) return;
    trip.status = 'finished_paid';
    trip.paymentStatus = 'paid_to_guide';

    try {
      const guides = this.getGuides();
      const guide = guides.find(g => String(g.id) === String(trip.guideId));
      if (guide) {
        if (!guide.balance) {
          guide.balance = { available: 0, escrow: 0, pending: 0 };
        }
        const totalAmt = Number(trip.totalAmount || trip.totalPrice || 0);
        const payoutAmt = Number(trip.guidePayout || trip.guideReceivedAmount || Math.round(totalAmt * 0.9));
        guide.balance.escrow = Math.max(0, (guide.balance.escrow || 0) - totalAmt);
        guide.balance.available = (guide.balance.available || 0) + payoutAmt;
        localStorage.setItem(STORAGE_KEYS.GUIDES, JSON.stringify(guides));
      }
    } catch (e) {
      console.warn("payoutTrip guide balance update warning:", e);
    }

    try {
      // Ghi nhận giao dịch
      const txns = this.getTransactions();
      const totalAmt = Number(trip.totalAmount || trip.totalPrice || 0);
      const payoutAmt = Number(trip.guidePayout || trip.guideReceivedAmount || Math.round(totalAmt * 0.9));
      const feeAmt = Number(trip.platformFee || Math.round(totalAmt * 0.1));
      const tripCode = trip.id || trip.bookingCode || ('TRIP-' + (trip.dbBookingId || ''));
      const guideName = trip.guideName || '';

      txns.unshift({
        id: 'TXN-PAYOUT-' + Date.now(),
        tripId: tripCode,
        type: 'payout',
        title: `Tất toán 90% thù lao tour ${tripCode} chuyển thẳng STK Vietcombank của HDV ${guideName}`,
        amount: payoutAmt,
        gatewayRef: 'VNPAY_TR_' + Math.floor(100000 + Math.random() * 900000),
        gatewayStatus: 'success',
        internalStatus: 'completed',
        matched: true,
        timestamp: new Date().toLocaleString('vi-VN')
      });
      txns.unshift({
        id: 'TXN-FEE-' + Date.now(),
        tripId: tripCode,
        type: 'fee',
        title: `Khấu trừ 10% phí vận hành sàn tour ${tripCode}`,
        amount: feeAmt,
        gatewayRef: 'SYSTEM_FEE_' + Math.floor(10000 + Math.random() * 90000),
        gatewayStatus: 'success',
        internalStatus: 'completed',
        matched: true,
        timestamp: new Date().toLocaleString('vi-VN')
      });
      localStorage.setItem('guidia_transactions_v2', JSON.stringify(txns));
    } catch (e) {
      console.warn("payoutTrip txn update warning:", e);
    }

    // Cập nhật hoàn thành tour và giải ngân tất toán vào SQL Server
    this.syncDatabaseAction('complete_trip', {
      tripId: trip.dbBookingId || trip.dbTripId || trip.id,
      bookingId: trip.dbBookingId || trip.dbTripId || trip.id
    });
  }

  // Hủy chuyến đi ( & )
  cancelTrip(tripId, cancelledByRole = 'guide', reason = '') {
    const trips = this.getTrips();
    const trip = trips.find(t => t.id === tripId || String(t.dbBookingId) === String(tripId));
    if (!trip) return { success: false, message: 'Không tìm thấy chuyến đi' };

    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const tourDate = new Date(trip.startDate);
    tourDate.setHours(0, 0, 0, 0);
    const diffDays = Math.round((tourDate.getTime() - today.getTime()) / (1000 * 3600 * 24));

    if (diffDays >= 2) {
      trip.status = 'cancelled_refunded';
      trip.paymentStatus = 'refunded_to_customer';
      trip.cancelReason = reason || 'Hủy chuyến theo yêu cầu';
      trip.cancelledBy = cancelledByRole;
      trip.cancelledAt = new Date().toLocaleString('vi-VN');

      // Mở lại ngày trong lịch HDV
      const guides = this.getGuides();
      const guide = guides.find(g => String(g.id) === String(trip.guideId));
      if (guide && guide.blockedDates) {
        guide.blockedDates = guide.blockedDates.filter(d => d !== trip.startDate);
        localStorage.setItem(STORAGE_KEYS.GUIDES, JSON.stringify(guides));
      }

      // Ghi nhận số lần hủy để xét vi phạm
      if (cancelledByRole === 'guide') {
        guide.violationCount = (guide.violationCount || 0) + 1;
        localStorage.setItem(STORAGE_KEYS.GUIDES, JSON.stringify(guides));
      } else {
        const users = this.getUsers();
        const user = users.find(u => String(u.id) === String(trip.customerId));
        if (user) {
          user.cancelCount = (user.cancelCount || 0) + 1;
          localStorage.setItem(STORAGE_KEYS.USERS, JSON.stringify(users));
        }
      }

      localStorage.setItem(STORAGE_KEYS.TRIPS, JSON.stringify(trips));

      // Đồng bộ thao tác Hủy Chuyến trực tiếp vào SQL Server
      this.syncDatabaseAction('cancel_trip', {
        tripId: trip.dbBookingId || trip.dbTripId || trip.id,
        bookingId: trip.dbBookingId || trip.dbTripId || trip.id,
        reason: reason || 'Hủy chuyến theo yêu cầu',
        userId: trip.customerId || 1,
        role: cancelledByRole
      });

      return {
        success: true,
        message: 'Hủy chuyến thành công trước ngày xuất phát 2 ngày. Sàn đã hoàn 100% tiền tạm giữ cho du khách và cập nhật CSDL SQL Server!'
      };
    } else {
      
      return {
        success: false,
        errorCode: '',
        message: 'Không thể hủy chuyến trong vòng 2 ngày (48 giờ) trước ngày xuất phát! Nếu có sự cố bất khả kháng, vui lòng sử dụng tính năng "Gửi Khiếu Nại" để Quản trị viên xử lý.'
      };
    }
  }

  // ==========================================
  // USE CASE 08: ĐÁNH GIÁ DỊCH VỤ (KDL)
  // ==========================================
  submitCustomerReview(tripId, stars, comment, imageUrl) {
    let raw = JSON.parse(localStorage.getItem(STORAGE_KEYS.TRIPS) || '[]');
    let trip = raw.find(t => String(t.id) === String(tripId) || String(t.bookingCode) === String(tripId) || (t.dbBookingId && String(t.dbBookingId) === String(tripId)));
    if (!trip) {
      const trips = this.getTrips();
      trip = trips.find(t => String(t.id) === String(tripId) || String(t.bookingCode) === String(tripId));
      if (!trip) return { success: false, message: 'Không tìm thấy chuyến đi để đánh giá' };
      raw = trips;
    }

    const cleanStars = Math.max(1, Math.min(5, parseInt(stars) || 5));
    const cleanImageUrl = (imageUrl && imageUrl !== 'img/anh-danh-gia.jpg') ? imageUrl.trim() : '';
    trip.review = {
      stars: cleanStars,
      comment: (comment || '').trim() || 'Dịch vụ rất tốt, hướng dẫn viên nhiệt tình!',
      imageUrl: cleanImageUrl,
      createdAt: new Date().toLocaleString('vi-VN'),
      date: new Date().toISOString().slice(0, 10)
    };

    try {
      localStorage.setItem(STORAGE_KEYS.TRIPS, JSON.stringify(raw));
      localStorage.setItem('guidia_trips_v2', JSON.stringify(raw));
    } catch (e) {
      console.warn('LocalStorage Quota Warning:', e);
    }

    // Đồng bộ trực tiếp đánh giá vào CSDL SQL Server QL_Du_Lich (UC08)
    this.syncDatabaseAction('submit_review', {
      bookingId: trip.dbBookingId || trip.id,
      tripId: trip.dbBookingId || trip.id,
      customerId: trip.customerId || 1,
      guideId: trip.guideId || 2,
      stars: cleanStars,
      comment: trip.review.comment,
      imageUrl: cleanImageUrl
    });

    // Cập nhật điểm đánh giá trung bình của HDV
    try {
      const guides = this.getGuides();
      const guide = guides.find(g => String(g.id) === String(trip.guideId));
      if (guide) {
        const guideReviewedTrips = raw.filter(t => String(t.guideId) === String(guide.id) && t.review);
        const totalScore = guideReviewedTrips.reduce((acc, curr) => acc + (curr.review.stars || 5), 0);
        guide.rating = guideReviewedTrips.length > 0 ? (totalScore / guideReviewedTrips.length).toFixed(1) : guide.rating;
        guide.reviewCount = guideReviewedTrips.length;
        localStorage.setItem(STORAGE_KEYS.GUIDES, JSON.stringify(guides));
        localStorage.setItem('guidia_guides_v2', JSON.stringify(guides));
      }
    } catch (e) { }

    return {
      success: true,
      message: 'Đã gửi đánh giá thành công! Dữ liệu đã được lưu trực tiếp vào CSDL SQL Server.'
    };
  }

  // ==========================================
  // USE CASE 09: PHẢN HỒI ĐÁNH GIÁ (HDV)
  // ==========================================
  replyReview(tripId, replyText) {
    if (!replyText || !replyText.trim()) {
      return { success: false, errorCode: '', message: 'Nội dung phản hồi không được để trống!' };
    }

    const cleanTripId = String(tripId || '').trim();
    const trips = this.getTrips();
    const trip = trips.find(t => 
      String(t.id).trim() === cleanTripId || 
      (t.dbBookingId && String(t.dbBookingId).trim() === cleanTripId) ||
      (t.bookingCode && String(t.bookingCode).trim() === cleanTripId) ||
      (t.bookingId && String(t.bookingId).trim() === cleanTripId)
    );
    if (!trip || !trip.review) return { success: false, message: 'Không tìm thấy đánh giá của khách' };

    trip.review.reply = replyText.trim();
    trip.review.repliedAt = new Date().toLocaleString('vi-VN');
    localStorage.setItem(STORAGE_KEYS.TRIPS, JSON.stringify(trips));
    localStorage.setItem('guidia_trips_v2', JSON.stringify(trips));

    // Đồng bộ vào mảng guidia_reviews_v2 nếu có
    try {
      let reviews = JSON.parse(localStorage.getItem('guidia_reviews_v2') || '[]');
      let rev = reviews.find(r => 
        (trip.dbBookingId && String(r.bookingId) === String(trip.dbBookingId)) ||
        (trip.id && String(r.tripId) === String(trip.id)) ||
        (trip.bookingCode && String(r.tripId) === String(trip.bookingCode))
      );
      if (rev) {
        rev.reply = replyText.trim();
        rev.repliedAt = trip.review.repliedAt;
        localStorage.setItem('guidia_reviews_v2', JSON.stringify(reviews));
      }
    } catch (e) {}

    // Đồng bộ phản hồi công khai của HDV vào CSDL SQL Server QL_Du_Lich (UC09)
    this.syncDatabaseAction('reply_review', {
      bookingId: trip.dbBookingId || trip.bookingId || trip.id,
      tripId: trip.bookingCode || trip.id,
      reviewId: (trip.review && (trip.review.reviewId || trip.review.id)) || 0,
      reply: replyText.trim()
    });

    return {
      success: true,
      message: 'Đã lưu và hiển thị phản hồi công khai vào CSDL SQL Server.'
    };
  }

  // ==========================================
  // USE CASE 10: KHIẾU NẠI (HDV / KDL & QTV)
  // ==========================================
  submitDispute(data) {
    
    if (!data.evidenceText && !data.evidenceUrl) {
      return {
        success: false,
        errorCode: '',
        message: 'Bắt buộc phải đính kèm bằng chứng (hình ảnh, video hoặc dẫn chứng tin nhắn) khi gửi khiếu nại!'
      };
    }

    const trips = this.getTrips();
    const trip = trips.find(t => t.id === data.tripId || String(t.dbBookingId) === String(data.tripId));
    if (trip) {
      trip.isDisputed = true;
      localStorage.setItem(STORAGE_KEYS.TRIPS, JSON.stringify(trips));
      localStorage.setItem('guidia_trips_v2', JSON.stringify(trips));
    }

    const disputes = this.getDisputes();
    const newDispute = {
      id: 'DISPUTE-VN' + Math.floor(100 + Math.random() * 900),
      tripId: data.tripId,
      bookingId: trip ? (trip.dbBookingId || trip.id) : data.tripId,
      complainantRole: data.role || 'guide',
      complainantName: data.complainantName,
      complainantPhone: data.complainantPhone || '0905123456',
      defendantName: data.defendantName,
      tourLocation: data.tourLocation || (trip ? trip.location : 'Việt Nam'),
      amount: data.amount || (trip ? trip.totalAmount : 1500000),
      reason: data.reason,
      evidenceUrl: data.evidenceUrl || '',
      evidenceText: data.evidenceText,
      status: 'pending', // Chờ xử lý
      adminDecision: null,
      createdAt: new Date().toLocaleString('vi-VN')
    };

    try {
      localStorage.setItem(STORAGE_KEYS.DISPUTES, JSON.stringify(disputes));
      localStorage.setItem('guidia_disputes_v2', JSON.stringify(disputes));
    } catch (e) {
      console.warn('LocalStorage Quota Warning:', e);
    }

    // Đồng bộ trực tiếp khiếu nại vào CSDL SQL Server QL_Du_Lich (UC10)
    this.syncDatabaseAction('create_dispute', {
      disputeCode: newDispute.id,
      bookingId: trip ? (trip.dbBookingId || trip.id) : data.tripId,
      tripId: trip ? (trip.dbBookingId || trip.id) : data.tripId,
      customerId: data.customerId || (trip ? trip.customerId : 1),
      guideId: data.guideId || (trip ? trip.guideId : 2),
      disputeType: data.reason ? data.reason.split(':')[0] : 'Sự cố dịch vụ',
      reason: data.reason || data.evidenceText,
      evidenceUrl: data.evidenceUrl || '',
      amount: newDispute.amount
    });

    return {
      success: true,
      message: 'Khiếu nại đã gửi thành công & lưu vào CSDL SQL Server. Sàn đã TẠM DỪNG TẤT TOÁN TIỀN của chuyến đi để QTV thẩm định.'
    };
  }

  // QTV Phán quyết khiếu nại (Admin)
  resolveDispute(disputeId, decision, reason = '') {
    const disputes = this.getDisputes();
    const dispute = disputes.find(d => 
      d.id === disputeId || 
      String(d.dbDisputeId) === String(disputeId) || 
      d.disputeCode === disputeId ||
      String(d.id) === String(disputeId)
    );
    if (!dispute) return { success: false, message: 'Không tìm thấy khiếu nại' };

    const trips = this.getTrips();
    const trip = trips.find(t => 
      t.id === dispute.tripId || 
      String(t.id) === String(dispute.tripId) || 
      String(t.dbBookingId) === String(dispute.bookingId) || 
      (t.bookingCode && t.bookingCode === dispute.tripId) ||
      (dispute.bookingId && String(t.id) === String(dispute.bookingId)) ||
      (dispute.tripId && String(t.dbBookingId) === String(dispute.tripId))
    );

    if (decision === 'accept_refund') {
      dispute.status = 'resolved_refund';
      dispute.adminDecision = `Chấp nhận khiếu nại. Hoàn toàn bộ số tiền cho Khách du lịch. Lý do: "${reason || 'HDV vi phạm cam kết lộ trình'}"`;
      if (trip) {
        trip.paymentStatus = 'refunded_to_customer';
        trip.status = 'cancelled_refunded';
        trip.isDisputed = false;
      }
      try {
        const guides = this.getGuides();
        const guide = guides.find(g => (g.name && dispute.defendantName && g.name.includes(dispute.defendantName)) || (trip && String(g.id) === String(trip.guideId)) || String(g.id) === String(dispute.reportedUserId));
        if (guide) {
          guide.violationCount = (guide.violationCount || 0) + 1;
          if (guide.violationCount > 3) {
            guide.status = 'suspended';
            const users = this.getUsers();
            const u = users.find(x => String(x.id) === String(guide.id));
            if (u) u.status = 'suspended';
            localStorage.setItem(STORAGE_KEYS.USERS, JSON.stringify(users));
          }
          localStorage.setItem(STORAGE_KEYS.GUIDES, JSON.stringify(guides));
        }
      } catch (err) {
        console.warn('Error updating guide violations:', err);
      }
    } else if (decision === 'reject') {
      dispute.status = 'resolved_release';
      dispute.adminDecision = `Bác bỏ khiếu nại. Tiến hành tất toán thù lao cho Hướng dẫn viên. Lý do: "${reason || 'Bằng chứng không đủ căn cứ, HDV thực hiện đúng cam kết'}"`;
      if (trip) {
        trip.isDisputed = false;
        try {
          this.payoutTrip(trip);
        } catch (err) {
          console.warn('Error in payoutTrip:', err);
        }
      }
    } else if (decision === 'need_more_info') {
      dispute.status = 'need_more_info';
      dispute.adminDecision = `Yêu cầu bổ sung chứng cứ: "${reason || 'Cần cung cấp thêm video hoặc biên bản xác nhận tại điểm đến'}"`;
    }

    dispute.resolvedAt = new Date().toLocaleString('vi-VN');
    localStorage.setItem(STORAGE_KEYS.DISPUTES, JSON.stringify(disputes));
    localStorage.setItem('guidia_disputes_v2', JSON.stringify(disputes));
    localStorage.setItem(STORAGE_KEYS.TRIPS, JSON.stringify(trips));
    localStorage.setItem('guidia_trips_v2', JSON.stringify(trips));

    // Đồng bộ phán quyết khiếu nại trực tiếp vào SQL Server
    const decisionCode = decision === 'accept_refund' ? 'DUYET' : (decision === 'reject' ? 'TU_CHOI' : 'YEU_CAU_BO_SUNG');
    this.syncDatabaseAction('resolve_dispute', {
      disputeId: dispute.dbDisputeId || dispute.id,
      decision: decisionCode,
      ruling: reason || dispute.adminDecision,
      adminId: 1
    });

    return { success: true, message: `Đã cập nhật phán quyết xử lý khiếu nại vào SQL Server: ${dispute.adminDecision}` };
  }

  // Khách du lịch gửi bổ sung bằng chứng theo yêu cầu của Quản trị viên
  supplementDispute(disputeId, evidenceText, evidenceUrl = '') {
    const disputes = this.getDisputes();
    const d = disputes.find(item => item.id === disputeId || String(item.dbDisputeId) === String(disputeId) || item.disputeCode === disputeId);
    if (d) {
      const nowStr = new Date().toLocaleString('vi-VN');
      d.evidenceText = (d.evidenceText || d.reason || '') + ` | [Bổ sung ngày ${nowStr}]: ${evidenceText}`;
      d.reason = d.evidenceText;
      if (evidenceUrl && evidenceUrl.trim()) d.evidenceUrl = evidenceUrl.trim();
      d.status = 'pending';
      d.adminDecision = 'Đã nhận bằng chứng bổ sung từ Khách du lịch. Đang chờ thẩm định lại.';
      localStorage.setItem(STORAGE_KEYS.DISPUTES, JSON.stringify(disputes));
      localStorage.setItem('guidia_disputes_v2', JSON.stringify(disputes));
    }

    const realId = d ? (d.dbDisputeId || d.id) : disputeId;
    this.syncDatabaseAction('supplement_dispute', {
      disputeId: realId,
      evidenceText: evidenceText,
      evidenceUrl: (evidenceUrl && evidenceUrl.trim()) ? evidenceUrl.trim() : (d ? (d.evidenceUrl || '') : '')
    });

    return {
      success: true,
      message: 'Đã gửi bổ sung bằng chứng thành công! Hồ sơ đã được chuyển lại về trạng thái "Chờ xử lý" cho Admin.'
    };
  }

  // ==========================================
  // USE CASE 11: QUẢN LÝ LỊCH LÀM VIỆC (HDV)
  // ==========================================
  updateSchedule(guideId, dateStr, setBlocked = true) {
    const guides = this.getGuides();
    const guide = guides.find(g => String(g.id) === String(guideId));
    if (!guide) return { success: false, message: 'Không tìm thấy HDV' };

    const trips = this.getTrips();

    
    const confirmedTrip = trips.find(t => String(t.guideId) === String(guideId) && t.startDate === dateStr && t.status === 'confirmed_upcoming');
    if (confirmedTrip && setBlocked) {
      return {
        success: false,
        errorCode: '',
        message: `Ngày ${dateStr} đã có chuyến đi ĐÃ XÁC NHẬN (${confirmedTrip.id}). Hệ thống không cho phép đánh dấu bận! Vui lòng dùng tính năng "Hủy chuyến" nếu không thể dẫn tour.`
      };
    }

    
    const pendingTrip = trips.find(t => String(t.guideId) === String(guideId) && t.startDate === dateStr && t.status === 'pending_guide');
    if (pendingTrip && setBlocked) {
      return {
        success: false,
        errorCode: '',
        message: `Ngày ${dateStr} đang có yêu cầu đặt tour chờ bạn xác nhận (${pendingTrip.id}). Vui lòng chấp nhận hoặc từ chối yêu cầu này trước khi đổi lịch!`
      };
    }

    guide.blockedDates = guide.blockedDates || [];
    if (setBlocked) {
      if (!guide.blockedDates.includes(dateStr)) {
        guide.blockedDates.push(dateStr);
      }
    } else {
      guide.blockedDates = guide.blockedDates.filter(d => d !== dateStr);
    }

    localStorage.setItem(STORAGE_KEYS.GUIDES, JSON.stringify(guides));

    // Đồng bộ trực tiếp vào SQL Server QL_Du_Lich (GuideSchedules)
    this.syncDatabaseAction('update_schedule', {
      guideId: guideId,
      workDate: dateStr,
      status: setBlocked ? 'BUSY' : 'AVAILABLE'
    });

    return {
      success: true,
      isBlocked: setBlocked,
      message: setBlocked
        ? `Đã đánh dấu ngày ${dateStr} là NGÀY BẬN. Khách du lịch sẽ không thể đặt lịch vào ngày này.`
        : `Đã mở lại lịch rảnh nhận khách ngày ${dateStr}.`
    };
  }

  // ==========================================
  // USE CASE 12: QUẢN LÝ DOANH THU (HDV)
  // ==========================================
  getRevenueSummary(guideId, filterOptions = {}) {
    const allTrips = this.getTrips();
    let trips = allTrips.filter(t => String(t.guideId) === String(guideId));
    const guide = this.getGuides().find(g => String(g.id) === String(guideId));
    const targetYear = filterOptions.year || '2026';

    // 1. Tính toán số liệu thực tế 12 tháng từ CSDL cho HDV này
    const monthlyStats = [];
    for (let m = 1; m <= 12; m++) {
      monthlyStats.push({
        month: m,
        monthLabel: `Thg ${m}`,
        totalGMV: 0,
        platformFee: 0,
        guidePayout: 0,
        tripsCount: 0
      });
    }

    const yearTrips = trips.filter(t => t.startDate && t.startDate.startsWith(targetYear + '-'));
    yearTrips.forEach(t => {
      if (t.startDate) {
        const parts = t.startDate.split('-');
        if (parts.length >= 2) {
          const m = parseInt(parts[1], 10);
          if (m >= 1 && m <= 12) {
            const fee = t.platformFee || Math.round((t.totalAmount || 0) * 0.1);
            const payout = t.guidePayout || Math.round((t.totalAmount || 0) * 0.9);
            // Không tính các chuyến hủy hoàn tiền cho khách
            if (t.status !== 'cancelled_refunded' && t.paymentStatus !== 'refunded_to_customer') {
              monthlyStats[m - 1].totalGMV += (t.totalAmount || 0);
              monthlyStats[m - 1].platformFee += fee;
              monthlyStats[m - 1].guidePayout += payout;
              monthlyStats[m - 1].tripsCount++;
            }
          }
        }
      }
    });

    // 2. Lọc danh sách chuyến đi theo kỳ (Tháng, Quý hoặc Tất cả)
    if (filterOptions.period && filterOptions.period !== 'all') {
      const p = String(filterOptions.period);
      if (p === '2026-11' || p === '11') {
        trips = trips.filter(t => t.startDate && t.startDate.includes('-11-'));
      } else if (p === '2026-10' || p === '10') {
        trips = trips.filter(t => t.startDate && t.startDate.includes('-10-'));
      } else if (p === '2026-12' || p === '12') {
        trips = trips.filter(t => t.startDate && t.startDate.includes('-12-'));
      } else if (p === '2026-q4') {
        trips = trips.filter(t => t.startDate && (t.startDate.includes('-10-') || t.startDate.includes('-11-') || t.startDate.includes('-12-')));
      } else if (/^\d+$/.test(p)) {
        const mNum = parseInt(p, 10);
        const mStr = mNum < 10 ? '0' + mNum : String(mNum);
        trips = trips.filter(t => t.startDate && t.startDate.includes(`-${mStr}-`));
      } else {
        trips = trips.filter(t => t.startDate && t.startDate.startsWith(p));
      }
    }

    // 3. Lọc theo trạng thái dòng tiền
    if (filterOptions.status && filterOptions.status !== 'all') {
      if (filterOptions.status === 'paid_to_guide') {
        trips = trips.filter(t => (t.paymentStatus === 'paid_to_guide' || t.status === 'finished_paid') && !t.isDisputed);
      } else if (filterOptions.status === 'escrow_held') {
        trips = trips.filter(t => (t.paymentStatus === 'escrow_held' || ['confirmed_upcoming', 'pending_guide', 'completed_pending_payout'].includes(t.status)) && !t.isDisputed);
      } else if (filterOptions.status === 'disputed') {
        trips = trips.filter(t => Boolean(t.isDisputed || t.status === 'disputed' || t.dbStatus === 'DISPUTED'));
      }
    }

    let totalGMV = 0;
    let totalPlatformFee = 0;
    let totalRealReceived = 0;
    let escrowHolding = 0;

    trips.forEach(t => {
      const fee = t.platformFee || Math.round((t.totalAmount || 0) * 0.1);
      const payout = t.guidePayout || Math.round((t.totalAmount || 0) * 0.9);

      if (t.isDisputed || t.status === 'disputed' || t.dbStatus === 'DISPUTED') {
        escrowHolding += (t.totalAmount || 0);
      } else if (t.status === 'finished_paid' || t.paymentStatus === 'paid_to_guide' || t.status === 'completed') {
        totalGMV += (t.totalAmount || 0);
        totalPlatformFee += fee;
        totalRealReceived += payout;
      } else if (['confirmed_upcoming', 'completed_pending_payout', 'pending_guide'].includes(t.status) || t.paymentStatus === 'escrow_held') {
        escrowHolding += (t.totalAmount || 0);
        totalGMV += (t.totalAmount || 0);
        totalPlatformFee += fee;
      }
    });

    return {
      totalGMV,
      totalPlatformFee,
      totalRealReceived,
      escrowHolding,
      availableBalance: totalRealReceived,
      trips,
      monthlyStats,
      targetYear
    };
  }

  // ==========================================
  // USE CASE 13: QUẢN LÝ TÀI KHOẢN NGƯỜI DÙNG (ADMIN)
  // ==========================================
  approveGuideCertificate(certId) {
    const certs = this.getCertificates();
    const cert = certs.find(c => c.id === certId);
    if (!cert) return { success: false, message: 'Không tìm thấy hồ sơ chứng chỉ' };

    cert.status = 'approved';
    cert.approvedAt = new Date().toLocaleString('vi-VN');

    const guides = this.getGuides();
    const guide = guides.find(g => g.id === cert.guideId);
    if (guide) {
      guide.certStatus = 'approved';
      localStorage.setItem(STORAGE_KEYS.GUIDES, JSON.stringify(guides));
    }

    const users = this.getUsers();
    const user = users.find(u => u.id === cert.guideId);
    if (user) {
      user.status = 'active';
      localStorage.setItem(STORAGE_KEYS.USERS, JSON.stringify(users));
    }

    localStorage.setItem(STORAGE_KEYS.CERTIFICATES, JSON.stringify(certs));

    // Cập nhật 2 chiều vào SQL Server
    this.syncDatabaseAction('approve_cert', { certId: cert.dbCertId || cert.id, status: 'DA_DUYET', reason: 'Duyệt hồ sơ thẻ HDV' });

    return { success: true, message: `Đã phê duyệt thẻ hành nghề của HDV ${cert.guideName}. Dữ liệu đã được cập nhật vào SQL Server!` };
  }

  rejectGuideCertificate(certId, reason = '') {
    if (!reason || !reason.trim()) {
      return { success: false, errorCode: '', message: 'Bắt buộc phải nhập lý do từ chối hồ sơ thẻ HDV!' };
    }

    const certs = this.getCertificates();
    const cert = certs.find(c => c.id === certId);
    if (!cert) return { success: false, message: 'Không tìm thấy hồ sơ' };

    cert.status = 'rejected';
    cert.rejectReason = reason.trim();
    cert.rejectedAt = new Date().toLocaleString('vi-VN');

    const guides = this.getGuides();
    const guide = guides.find(g => g.id === cert.guideId);
    if (guide) {
      guide.certStatus = 'rejected';
      localStorage.setItem(STORAGE_KEYS.GUIDES, JSON.stringify(guides));
    }

    localStorage.setItem(STORAGE_KEYS.CERTIFICATES, JSON.stringify(certs));

    // Cập nhật 2 chiều vào SQL Server
    this.syncDatabaseAction('approve_cert', { certId: cert.dbCertId || cert.id, status: 'TU_CHOI', reason: reason.trim() });

    return { success: true, message: `Đã từ chối hồ sơ. Thông báo và lý do "${reason.trim()}" đã được ghi vào SQL Server!` };
  }

  // Khóa tài khoản người dùng / HDV kèm lý do
  banUser(userId, reason = '') {
    if (!reason || !reason.trim()) {
      return { success: false, message: 'Bắt buộc phải nhập lý do khi khóa tài khoản!' };
    }

    const users = this.getUsers();
    const user = users.find(u => String(u.id) === String(userId));
    if (!user) return { success: false, message: 'Không tìm thấy người dùng' };

    const trips = this.getTrips();
    const activeTrips = trips.filter(t => 
      (String(t.guideId) === String(userId) || String(t.customerId) === String(userId)) && 
      ['confirmed_upcoming', 'pending_guide', 'ongoing'].includes(t.status)
    );

    user.status = 'suspended';
    user.banReason = reason.trim();
    user.bannedAt = new Date().toLocaleString('vi-VN');
    localStorage.setItem(STORAGE_KEYS.USERS, JSON.stringify(users));

    let warningMsg = '';
    if (activeTrips.length > 0) {
      activeTrips.forEach(t => {
        t.status = 'cancelled_refunded';
        t.paymentStatus = 'refunded_to_customer';
        t.cancelReason = `Tài khoản ${user.name} bị khóa bởi Quản trị viên: ${reason.trim()}`;
      });
      localStorage.setItem(STORAGE_KEYS.TRIPS, JSON.stringify(trips));
      warningMsg = ` (Đã tự động hủy và hoàn tiền 100% cho ${activeTrips.length} chuyến đi chưa hoàn thành của tài khoản này theo quy định)`;
    }

    // Cập nhật 2 chiều trực tiếp vào SQL Server
    this.syncDatabaseAction('toggle_lock', { userId: user.id, status: 'BI_KHOA', reason: reason.trim() });

    return {
      success: true,
      hasActiveTrips: activeTrips.length > 0,
      activeTripsCount: activeTrips.length,
      message: `Đã khóa tài khoản "${user.name}" trong SQL Server. Lý do: ${reason.trim()}${warningMsg}`
    };
  }

  unbanUser(userId) {
    const users = this.getUsers();
    const user = users.find(u => String(u.id) === String(userId));
    if (!user) return { success: false, message: 'Không tìm thấy người dùng' };

    user.status = 'active';
    user.banReason = null;
    localStorage.setItem(STORAGE_KEYS.USERS, JSON.stringify(users));

    // Cập nhật 2 chiều trực tiếp vào SQL Server
    this.syncDatabaseAction('toggle_lock', { userId: user.id, status: 'HOAT_DONG', reason: 'Mở khóa tài khoản' });

    return { success: true, message: `Đã mở khóa tài khoản "${user.name}" trong SQL Server. Người dùng có thể đăng nhập bình thường.` };
  }

  // Lấy chi tiết hồ sơ tài khoản (hồ sơ, thẻ HDV, lịch sử chuyến, vi phạm & hủy)
  getUserDetails(userId) {
    const users = this.getUsers();
    const user = users.find(u => String(u.id) === String(userId));
    if (!user) return null;

    const isGuide = user.role === 'guide';
    const guide = isGuide ? this.getGuides().find(g => g.id === userId) : null;
    const cert = isGuide ? this.getCertificates().find(c => String(c.guideId) === String(userId)) : null;
    const allTrips = this.getTrips();
    const userTrips = allTrips.filter(t => isGuide ? String(t.guideId) === String(userId) : String(t.customerId) === String(userId));

    const completedTrips = userTrips.filter(t => t.status === 'finished_paid').length;
    const cancelledTrips = userTrips.filter(t => t.status === 'cancelled_refunded').length;
    const activeTrips = userTrips.filter(t => ['confirmed_upcoming', 'pending_guide', 'completed_pending_payout'].includes(t.status));
    const cancelCount = user.cancelCount !== undefined ? user.cancelCount : cancelledTrips;
    const violationCount = (guide && guide.violationCount) || user.violationCount || 0;
    const isViolationExceeded = cancelCount >= 3 || violationCount >= 2;

    return {
      user,
      isGuide,
      guide,
      cert,
      userTrips,
      completedTrips,
      cancelledTrips,
      activeTrips,
      cancelCount,
      violationCount,
      isViolationExceeded
    };
  }

  // ==========================================
  // USE CASE 01 & 15: BÁO CÁO DOANH THU SÀN (LỌC THEO THÁNG & NĂM)
  // ==========================================
  getAdminReportSummary({ month = 'all', year = '2026', region = 'all', startDate, endDate, metric = 'all', errorSimulation = false } = {}) {
    if (errorSimulation) {
      return {
        success: false,
        errorCode: 'A3',
        message: 'Đã xảy ra lỗi gián đoạn khi kết nối máy chủ tổng hợp dữ liệu báo cáo. Vui lòng thử lại!'
      };
    }

    let allTrips = this.getTrips();

    // 1. Lọc theo khu vực (Toàn quốc / Miền Bắc / Miền Trung / Miền Nam)
    let regionTrips = allTrips;
    if (region && region !== 'all') {
      const regionKeywords = {
        north: ['Hà Nội', 'Ninh Bình', 'Sa Pa', 'Hạ Long', 'Tây Bắc', 'Thăng Long'],
        central: ['Hội An', 'Đà Nẵng', 'Huế', 'Mỹ Sơn', 'Quảng Nam', 'Sông Hoài'],
        south: ['Sài Gòn', 'TP.HCM', 'Miền Tây', 'Phú Quốc', 'Cần Thơ']
      };
      const kwList = regionKeywords[region] || [];
      regionTrips = allTrips.filter(t => kwList.some(kw => t.location && t.location.includes(kw)));
    }

    // 2. Lọc theo Năm
    let yearTrips = regionTrips;
    if (year && year !== 'all') {
      const targetYearStr = String(year);
      yearTrips = regionTrips.filter(t => {
        if (!t.startDate) return false;
        return t.startDate.startsWith(targetYearStr + '-');
      });
    }

    // 3. Thống kê dữ liệu 12 Tháng phục vụ vẽ biểu đồ theo Tháng/Năm
    const monthlyStats = [];
    for (let m = 1; m <= 12; m++) {
      monthlyStats.push({
        month: m,
        monthLabel: `Tháng ${m}`,
        totalGMV: 0,
        platformFee: 0,
        tripsCount: 0
      });
    }

    yearTrips.forEach(t => {
      if (t.startDate) {
        const parts = t.startDate.split('-');
        if (parts.length >= 2) {
          const m = parseInt(parts[1], 10);
          if (m >= 1 && m <= 12) {
            const fee = t.platformFee || Math.round((t.totalAmount || 0) * 0.1);
            if (t.status !== 'cancelled_refunded' && t.paymentStatus !== 'refunded_to_customer') {
              monthlyStats[m - 1].totalGMV += (t.totalAmount || 0);
              monthlyStats[m - 1].platformFee += fee;
              monthlyStats[m - 1].tripsCount++;
            }
          }
        }
      }
    });

    // 4. Lọc theo Tháng cụ thể
    let filteredTrips = yearTrips;
    if (month && month !== 'all') {
      const targetMonth = parseInt(month, 10);
      filteredTrips = yearTrips.filter(t => {
        if (!t.startDate) return false;
        const parts = t.startDate.split('-');
        if (parts.length >= 2) {
          return parseInt(parts[1], 10) === targetMonth;
        }
        return false;
      });
    }

    // Tương thích ngược nếu có truyền startDate/endDate
    if (startDate) {
      filteredTrips = filteredTrips.filter(t => t.startDate >= startDate);
    }
    if (endDate) {
      filteredTrips = filteredTrips.filter(t => t.startDate <= endDate);
    }

    let totalGMV = 0;
    let totalPlatformFee = 0;
    let totalGuidePaid = 0;
    let totalEscrowHeld = 0;

    filteredTrips.forEach(t => {
      const fee = t.platformFee || Math.round((t.totalAmount || 0) * 0.1);
      const payout = t.guidePayout || Math.round((t.totalAmount || 0) * 0.9);

      if (t.status !== 'cancelled_refunded' && t.paymentStatus !== 'refunded_to_customer') {
        totalGMV += (t.totalAmount || 0);
      }
      if (t.paymentStatus === 'paid_to_guide' || t.status === 'finished_paid' || t.status === 'completed') {
        totalPlatformFee += fee;
        totalGuidePaid += payout;
      } else if (t.status !== 'cancelled_refunded' && t.paymentStatus !== 'refunded_to_customer') {
        totalEscrowHeld += (t.totalAmount || 0);
        totalPlatformFee += fee;
      }
    });

    // 5. Thống kê Số Người Dùng, Số Chuyến Đi, Số Chuyến Hủy, Khiếu Nại
    const allUsers = this.getUsers().filter(u => u.role !== 'admin');
    const customersCount = allUsers.filter(u => u.role === 'customer').length;
    const guidesCount = allUsers.filter(u => u.role === 'guide').length;
    const totalUsers = allUsers.length > 0 ? allUsers.length : 46;

    const cancelledTrips = filteredTrips.filter(t => 
      t.status === 'cancelled' || 
      t.status === 'cancelled_refunded' || 
      t.paymentStatus === 'refunded_to_customer' ||
      t.dbStatus === 'CANCELLED'
    ).length;

    const allDisputes = this.getDisputes();
    const tripIdsSet = new Set(filteredTrips.map(t => String(t.id)));
    const filteredDisputes = allDisputes.filter(d => tripIdsSet.has(String(d.tripId)));
    const tripDisputeCount = filteredTrips.filter(t => Boolean(t.isDisputed || t.status === 'disputed' || t.dbStatus === 'DISPUTED')).length;
    const disputesCount = Math.max(filteredDisputes.length, tripDisputeCount);

    return {
      success: true,
      emptyData: filteredTrips.length === 0,
      totalGMV,
      totalPlatformFee,
      totalGuidePaid,
      totalEscrowHeld,
      totalTrips: filteredTrips.length,
      totalUsers,
      customersCount,
      guidesCount,
      cancelledTrips,
      disputesCount,
      totalDisputes: allDisputes.length,
      trips: filteredTrips,
      monthlyStats,
      selectedMonth: month,
      selectedYear: year,
      selectedRegion: region
    };
  }

  // ==========================================
  // USE CASE 14: QUẢN LÝ GIAO DỊCH & ĐỐI SOÁT CỔNG THANH TOÁN (ADMIN)
  // ==========================================
  performReconciliation() {
    const txns = this.getTransactions();
    let matchedCount = 0;
    let mismatchCount = 0;

    // Giả lập đối soát dữ liệu cổng thanh toán (VNPAY / Momo / Ngân hàng)
    txns.forEach(t => {
      if (t.gatewayStatus === 'pending_recon' || !t.matched) {
        mismatchCount++;
      } else {
        matchedCount++;
      }
    });

    const reconResult = {
      timestamp: new Date().toLocaleString('vi-VN'),
      matchedCount,
      mismatchCount,
      totalCount: txns.length,
      details: txns
    };

    localStorage.setItem(STORAGE_KEYS.RECONCILIATIONS, JSON.stringify(reconResult));
    return {
      success: true,
      matchedCount,
      mismatchCount,
      reconResult,
      message: `Đối soát thành công! Khớp: ${matchedCount} giao dịch, Lệch cần xử lý: ${mismatchCount} giao dịch.`
    };
  }

  // Xử lý giao dịch lệch (Khớp lại / Gửi lại lệnh)
  resolveMismatchTransaction(txnId, action = 'force_match') {
    const txns = this.getTransactions();
    const txn = txns.find(t => t.id === txnId);
    if (!txn) return { success: false, message: 'Không tìm thấy giao dịch' };

    txn.matched = true;
    txn.gatewayStatus = 'success';
    txn.internalStatus = 'completed';
    txn.reconciledAt = new Date().toLocaleString('vi-VN');
    txn.reconciledBy = 'Admin Root';

    localStorage.setItem('guidia_transactions_v2', JSON.stringify(txns));
    return { success: true, message: `Đã xử lý xong giao dịch ${txnId}! Trạng thái hiện tại: Đã khớp 100%.` };
  }

  // ==========================================
  // MÔ PHỎNG TÁC NHÂN NGOÀI (Simulation Helper)
  // ==========================================
  simulateNewBookingFromCustomer(guideId, location, price = 1500000) {
    const trips = this.getTrips();
    const guide = this.getGuides().find(g => String(g.id) === String(guideId)) || this.getGuides()[0];
    const newId = 'TRIP-VN' + (100 + trips.length + 1);

    const newTrip = {
      id: newId,
      guideId: guide.id,
      guideName: guide.name,
      customerId: 'usr_minh',
      customerName: 'Nguyễn Văn Minh (Khách du lịch)',
      customerPhone: '0912345678',
      location: location || 'Hà Nội - Phố Cổ & Di Sản Thăng Long',
      startDate: '2026-11-20',
      duration: 'Buổi chiều (4 giờ)',
      guests: 2,
      totalAmount: price,
      platformFee: Math.round(price * 0.1),
      guidePayout: Math.round(price * 0.9),
      status: 'pending_guide',
      paymentStatus: 'escrow_held',
      guideCompleted: false,
      customerCompleted: false,
      isDisputed: false,
      notes: 'Khách du lịch mô phỏng: Muốn tìm hiểu sâu văn hóa ẩm thực truyền thống.',
      createdAt: new Date().toLocaleString('vi-VN')
    };

    trips.unshift(newTrip);
    localStorage.setItem(STORAGE_KEYS.TRIPS, JSON.stringify(trips));
    return { success: true, trip: newTrip };
  }

  resetToDefault() {
    localStorage.clear();
    this.init();
    return { success: true, message: 'Đã khôi phục dữ liệu mẫu hệ thống ban đầu.' };
  }
}

// Khởi tạo instance toàn cục
window.guidiaStore = new GuidiaStore();
