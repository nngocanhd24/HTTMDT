<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
  <!DOCTYPE html>
  <html lang="vi">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Guidia - Không Gian Làm Việc Hướng Dẫn Viên Du Lịch Việt Nam</title>

    <!-- Google Fonts & Lucide Icons -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
      href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Cormorant+Garamond:wght@600;700&display=swap"
      rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
    <script>
      function switchGuideTab(targetTabId) {
        if (window.activateGuideTab) {
          window.activateGuideTab(targetTabId, true);
        } else {
          const link = document.querySelector(`.sidebar-nav .nav-link-item[data-tab="${targetTabId}"]`);
          if (link) link.click();
        }
      }
    </script>

    <link rel="stylesheet" href="css/style.css">

  </head>

  <body class="portal-body">



    <!-- Sidebar -->
    <aside class="portal-sidebar">
      <a href="guide.jsp#requests"
        onclick="if(window.switchGuideTab){event.preventDefault();switchGuideTab('tab-requests');window.location.hash='requests';}"
        class="sidebar-brand gui-1" title="Về Yêu Cầu Đặt Lịch">
        <div class="logo-icon gui-2">
          <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none"
            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="10" />
            <polygon points="16.24 7.76 14.12 14.12 7.76 16.24 9.88 9.88 16.24 7.76" />
          </svg>
        </div>
        <div class="logo-text">
          <span class="logo-title gui-3">Guidia</span>
        </div>
        <span class="portal-badge">HDV Chuyên Nghiệp</span>
      </a>

      <nav class="sidebar-nav">
        <!-- 1. Yêu cầu đặt lịch -->
        <a href="#requests" class="nav-link-item active" data-tab="tab-requests">
          <i data-lucide="bell"></i>
          <span>Yêu Cầu Đặt Lịch</span>
          <span class="tab-badge-pill" id="badgePendingCount">0</span>
        </a>

        <!-- 2. Quản lý chuyến đi -->
        <a href="#trips" class="nav-link-item" data-tab="tab-trips">
          <i data-lucide="map-pin"></i>
          <span>Chuyến Đi Của Tôi</span>
        </a>

        <!-- 3. Quản lý lịch làm việc -->
        <a href="#schedule" class="nav-link-item" data-tab="tab-schedule">
          <i data-lucide="calendar"></i>
          <span>Lịch Làm Việc</span>
        </a>

        <!-- 4. Quản lý doanh thu -->
        <a href="#revenue" class="nav-link-item" data-tab="tab-revenue">
          <i data-lucide="wallet"></i>
          <span>Doanh Thu</span>
        </a>

        <!-- 5. Nhắn tin trao đổi -->
        <a href="#chat" class="nav-link-item" data-tab="tab-chat">
          <i data-lucide="message-square"></i>
          <span>Nhắn Tin & Tư Vấn</span>
          <span class="tab-badge-pill" id="badgeGuideChatUnread" style="display:none;">0</span>
        </a>

        <!-- 6. Phản hồi đánh giá -->
        <a href="#reviews" class="nav-link-item" data-tab="tab-reviews">
          <i data-lucide="star"></i>
          <span>Đánh Giá Của Khách</span>
        </a>

        <!-- 7. Khiếu nại -->
        <a href="#disputes" class="nav-link-item" data-tab="tab-disputes">
          <i data-lucide="shield-alert"></i>
          <span>Khiếu Nại & Hỗ Trợ</span>
        </a>

        <!-- 8. Thông tin cá nhân -->
        <a href="#profile" class="nav-link-item" data-tab="tab-profile">
          <i data-lucide="user-check"></i>
          <span>Thông Tin Cá Nhân</span>
        </a>
      </nav>

      <div class="sidebar-footer">
        <div class="user-mini-card">
          <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150" alt="Guide Avatar"
            id="guideAvatarMini">
          <div class="user-mini-info">
            <div class="u-name" id="guideNameMini">Hướng Dẫn Viên</div>
            <div class="u-role" id="guideRoleMini">HDV Bản Địa</div>
          </div>
        </div>
        <!-- Nút Đăng Xuất chuyển về thanh dọc bên trái -->
        <button type="button" onclick="handleGuideLogout()" class="sidebar-logout-btn" title="Đăng Xuất Khỏi Hệ Thống">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none"
            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" />
            <polyline points="16 17 21 12 16 7" />
            <line x1="21" y1="12" x2="9" y2="12" />
          </svg>
          <span>Đăng Xuất</span>
        </button>
      </div>
    </aside>

    <!-- Main Content -->
    <main class="portal-main">

      <header class="portal-topbar">
        <div class="topbar-left gui-8">
          <button type="button"
            onclick="if (window.history.length > 1) { window.history.back(); } else { window.location.href = 'guide.jsp'; }"
            class="btn-portal-back" title="Quay lại">
            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none"
              stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
              <path d="m12 19-7-7 7-7" />
              <path d="M19 12H5" />
            </svg>
          </button>

          <!-- Logo Guidia đồng bộ -->
          <a href="guide.jsp#requests"
            onclick="if(window.switchGuideTab){event.preventDefault();switchGuideTab('tab-requests');window.location.hash='requests';}"
            class="brand-logo portal-header-brand" title="Về Yêu Cầu Đặt Lịch">
            <div class="logo-icon">
              <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none"
                stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <circle cx="12" cy="12" r="10" />
                <polygon points="16.24 7.76 14.12 14.12 7.76 16.24 9.88 9.88 16.24 7.76" />
              </svg>
            </div>
            <div class="logo-text">
              <span class="logo-title">Guidia</span>
              <span class="logo-sub">Private Local Guides</span>
            </div>
          </a>

          <!-- Tiêu đề trang / phân hệ -->
          <div class="portal-header-title-box">
            <h1 id="guidePageTitle">Yêu Cầu Đặt Lịch Tour Mới</h1>
          </div>
        </div>
        <div class="topbar-right">
          <div class="gui-9" style="display:flex; align-items:center; gap:12px;">
            <select id="guideAccountSwitcher" style="display:none;" onchange="switchGuideAccount(this.value)"
              title="Chuyển đổi tài khoản HDV"></select>

            <div class="gui-13">
              <img id="guideHeaderAvatar" src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=120"
                class="gui-14">
              <div class="gui-15">
                <div class="gui-16" id="guideHeaderName">HDV</div>
                <div class="gui-17" id="guideHeaderEmail">hdv@guidia.com</div>
              </div>
            </div>
          </div>
        </div>
      </header>


      <div class="portal-content">

        <!-- BANNER CẢNH BÁO TRẠNG THÁI TÀI KHOẢN (NẾU CHỜ DUYỆT HOẶC BỊ KHÓA) -->
        <div id="accountStatusAlertBox" class="gui-20"></div>

        <!-- ========================================================================= -->
        <!-- TAB 1: YÊU CẦU ĐẶT LỊCH -->
        <!-- ========================================================================= -->
        <section class="tab-content-panel active" id="tab-requests">
          <div class="card-table-wrapper">
            <div class="card-table-header">
              <div>
                <h3>Yêu Cầu Đặt Tour Đang Chờ Duyệt</h3>
                <p class="gui-21">
                  Du khách đã thanh toán toàn bộ chi phí. Tiền đang được <strong>Cổng thanh toán tạm giữ ký quỹ
                    (Escrow)</strong> an toàn.
                </p>
              </div>
            </div>

            <div id="bookingRequestsContainer" class="gui-22">
              <!-- Render danh sách yêu cầu -->
            </div>
          </div>
        </section>

        <!-- ========================================================================= -->
        <!-- TAB 2: QUẢN LÝ CHUYẾN ĐI -->
        <!-- ========================================================================= -->
        <section class="tab-content-panel" id="tab-trips">
          <div class="card-table-wrapper">
            <div class="card-table-header">
              <div>
                <h3>Danh Sách Chuyến Đi Tại Việt Nam</h3>
                <p class="gui-23">
                  Theo dõi tiến trình, xác nhận kết thúc để tất toán thù lao hoặc hủy tour theo quy định 48h.
                </p>
              </div>
              <!-- Bộ lọc 4 trạng thái chuyến đi chuẩn đặc tả UC07: Sắp đi, Đang đi, Đã đi, Đã hủy -->
              <div class="gui-24">
                <button class="btn-sm-action trip-filter-btn active" data-filter="all"
                  onclick="filterTripsTab('all')">Tất Cả</button>
                <button class="btn-sm-action trip-filter-btn" data-filter="upcoming"
                  onclick="filterTripsTab('upcoming')">Sắp Đi</button>
                <button class="btn-sm-action trip-filter-btn" data-filter="ongoing"
                  onclick="filterTripsTab('ongoing')">Đang Đi</button>
                <button class="btn-sm-action trip-filter-btn" data-filter="completed"
                  onclick="filterTripsTab('completed')">Đã Đi</button>
                <button class="btn-sm-action trip-filter-btn" data-filter="cancelled"
                  onclick="filterTripsTab('cancelled')">Đã Hủy</button>
              </div>
            </div>

            <div id="tripsListContainer" class="gui-22">
              <!-- Render danh sách chuyến đi -->
            </div>
          </div>
        </section>

        <!-- ========================================================================= -->
        <!-- TAB 3: LỊCH LÀM VIỆC  -->
        <!-- ========================================================================= -->
        <section class="tab-content-panel" id="tab-schedule">
          <div class="calendar-container">

            <!-- THỐNG KÊ SỐ NGÀY LỊCH LÀM VIỆC TRONG THÁNG (BƯỚC 2) -->
            <div class="schedule-summary-cards"
              style="display:grid; grid-template-columns:repeat(auto-fit, minmax(200px, 1fr)); gap:12px; margin-bottom:16px;">
              <div style="background:#eff6ff; border:1px solid #bfdbfe; border-radius:10px; padding:12px 16px;">
                <div
                  style="font-size:0.8rem; color:#1e40af; font-weight:700; display:flex; align-items:center; gap:6px;">
                  <i data-lucide="check-circle-2" style="width:16px;height:16px;color:#2563eb;"></i> Có Lịch Dẫn Đoàn
                </div>
                <div style="font-size:1.6rem; font-weight:800; color:#1e3a8a; margin-top:4px;" id="statConfirmedDays">0
                  ngày</div>
                <div style="font-size:0.75rem; color:#3b82f6;">Chuyến đã xác nhận trong tháng</div>
              </div>

              <div style="background:#fefce8; border:1px solid #fef08a; border-radius:10px; padding:12px 16px;">
                <div
                  style="font-size:0.8rem; color:#854d0e; font-weight:700; display:flex; align-items:center; gap:6px;">
                  <i data-lucide="clock" style="width:16px;height:16px;color:#ca8a04;"></i> Chờ Xác Nhận
                </div>
                <div style="font-size:1.6rem; font-weight:800; color:#713f12; margin-top:4px;" id="statPendingDays">0
                  ngày</div>
                <div style="font-size:0.75rem; color:#a16207;">Yêu cầu cần HDV phản hồi</div>
              </div>

              <div style="background:#f1f5f9; border:1px solid #cbd5e1; border-radius:10px; padding:12px 16px;">
                <div
                  style="font-size:0.8rem; color:#475569; font-weight:700; display:flex; align-items:center; gap:6px;">
                  <i data-lucide="lock" style="width:16px;height:16px;color:#64748b;"></i> Đã Khóa Bận
                </div>
                <div style="font-size:1.6rem; font-weight:800; color:#334155; margin-top:4px;" id="statBlockedDays">0
                  ngày</div>
                <div style="font-size:0.75rem; color:#64748b;">HDV chủ động không nhận khách</div>
              </div>

              <div style="background:#f0fdf4; border:1px solid #bbf7d0; border-radius:10px; padding:12px 16px;">
                <div
                  style="font-size:0.8rem; color:#166534; font-weight:700; display:flex; align-items:center; gap:6px;">
                  <i data-lucide="calendar-check" style="width:16px;height:16px;color:#16a34a;"></i> Mở Lịch Rảnh
                </div>
                <div style="font-size:1.6rem; font-weight:800; color:#14532d; margin-top:4px;" id="statAvailableDays">0
                  ngày</div>
                <div style="font-size:0.75rem; color:#15803d;">Sẵn sàng nhận tour du khách</div>
              </div>
            </div>

            <div class="calendar-header gui-25"
              style="display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:12px;">
              <div>
                <h3 id="scheduleCalendarHeading" class="gui-26">Lịch Làm Việc Tháng 11/2026</h3>
                <p class="gui-27" id="scheduleCalendarSub">
                  Phân biệt thời gian có chuyến đã xác nhận, chờ xác nhận, thời gian bận và thời gian rảnh.
                </p>
              </div>

              <!-- BỘ LỌC THÁNG & NĂM + NÚT CHỈNH SỬA (BƯỚC 3) -->
              <div class="gui-28" style="display:flex; align-items:center; flex-wrap:wrap; gap:8px;">
                <button type="button" class="btn-outline gui-29" onclick="changeScheduleMonth(-1)" title="Tháng trước">
                  <i data-lucide="chevron-left" class="icon-xs"></i>
                </button>

                <div class="gui-30" style="display:flex; align-items:center; gap:4px;">
                  <label class="gui-31">Tháng:</label>
                  <select id="scheduleMonthSelect" class="form-input gui-32" onchange="onScheduleFilterChange()">
                    <option value="1">Tháng 1</option>
                    <option value="2">Tháng 2</option>
                    <option value="3">Tháng 3</option>
                    <option value="4">Tháng 4</option>
                    <option value="5">Tháng 5</option>
                    <option value="6">Tháng 6</option>
                    <option value="7">Tháng 7</option>
                    <option value="8">Tháng 8</option>
                    <option value="9">Tháng 9</option>
                    <option value="10">Tháng 10</option>
                    <option value="11" selected>Tháng 11</option>
                    <option value="12">Tháng 12</option>
                  </select>
                </div>

                <div class="gui-30" style="display:flex; align-items:center; gap:4px;">
                  <label class="gui-31">Năm:</label>
                  <select id="scheduleYearSelect" class="form-input gui-33" onchange="onScheduleFilterChange()">
                    <option value="2024">2024</option>
                    <option value="2025">2025</option>
                    <option value="2026" selected>2026</option>
                    <option value="2027">2027</option>
                    <option value="2028">2028</option>
                  </select>
                </div>

                <button type="button" class="btn-outline gui-29" onclick="changeScheduleMonth(1)" title="Tháng sau">
                  <i data-lucide="chevron-right" class="icon-xs"></i>
                </button>

                <button type="button" class="btn-outline gui-34" onclick="resetScheduleToToday()"
                  title="Về tháng hiện tại">
                  <i data-lucide="calendar" class="icon-xs"></i> Hiện Tại
                </button>

                <!-- NÚT CHỈNH SỬA -->
                <button type="button" class="btn-primary" id="btnStartEditSchedule" onclick="startScheduleEdit()"
                  style="display:inline-flex; align-items:center; gap:6px; font-weight:700;">
                  <i data-lucide="edit-3" class="icon-xs"></i> Chỉnh Sửa
                </button>
              </div>
            </div>

            <!-- THANH CÔNG CỤ CHỈNH SỬA LỊCH (HIỂN THỊ KHI Ở CHẾ ĐỘ CHỈNH SỬA) -->
            <div id="scheduleEditToolbar"
              style="display:none; background:#fffbeb; border:1.5px solid #f59e0b; border-radius:10px; padding:14px 18px; margin-bottom:16px;">
              <div style="display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:12px;">
                <div>
                  <strong style="color:#b45309; font-size:0.95rem; display:flex; align-items:center; gap:6px;">
                    <i data-lucide="calendar-check" style="width:18px;height:18px;"></i> Chế Độ Chỉnh Sửa Lịch Làm Việc
                  </strong>
                  <p style="margin:4px 0 0; font-size:0.82rem; color:#78350f;">
                    Nhấp vào các ngày trên bảng lịch để thay đổi lịch làm việc. Nhấn <strong>"Lưu Lịch Làm
                      Việc"</strong> để cập nhật hoặc <strong>"Hủy Thao Tác"</strong> để thoát.
                  </p>
                </div>

                <div style="display:flex; align-items:center; gap:10px; flex-wrap:wrap;">
                  <button type="button" class="btn-primary" onclick="saveScheduleEdit()"
                    style="background:#059669; border-color:#059669; font-weight:700; display:flex; align-items:center; gap:6px;">
                    <i data-lucide="save" class="icon-xs"></i> Lưu
                  </button>

                  <button type="button" class="btn-outline" onclick="cancelScheduleEdit()"
                    style="color:#b91c1c; border-color:#fca5a5; font-weight:600; display:flex; align-items:center; gap:6px;"
                    title="Thoát chế độ sửa, lịch giữ nguyên">
                    <i data-lucide="x" class="icon-xs"></i> Hủy Thao Tác
                  </button>
                </div>
              </div>

              <!-- Dòng hiển thị các ngày đang chọn -->
              <div id="scheduleSelectedListBar"
                style="margin-top:10px; padding-top:8px; border-top:1px dashed #fcd34d; font-size:0.82rem; color:#92400e; display:flex; align-items:center; justify-content:space-between; flex-wrap:wrap; gap:8px;">
                <span>
                  <i data-lucide="check-square"
                    style="width:14px;height:14px;display:inline-block;vertical-align:middle;"></i>
                  Đang thay đổi: <strong id="selectedScheduleCount">0</strong> ngày.
                  <span id="selectedScheduleDatesList" style="margin-left:6px; color:#451a03; font-style:italic;">(Hãy
                    nhấp vào các ô ngày trên lịch để đổi trạng thái)</span>
                </span>
                <button type="button"
                  style="background:transparent; border:none; color:#b91c1c; font-size:0.75rem; text-decoration:underline; cursor:pointer;"
                  onclick="clearScheduleSelectedDates()">
                  Hoàn tác thay đổi
                </button>
              </div>
            </div>

            <!-- Chú thích màu sắc lịch làm việc -->
            <div class="calendar-legend">
              <div class="legend-item">
                <div class="legend-color gui-35"></div>
                <span>Đã có chuyến xác nhận (Đã xác nhận chuyến)</span>
              </div>
              <div class="legend-item">
                <div class="legend-color gui-36"></div>
                <span>Đang có yêu cầu chờ xác nhận</span>
              </div>
              <div class="legend-item">
                <div class="legend-color gui-37"></div>
                <span>Thời gian bận (HDV đánh dấu bận)</span>
              </div>
              <div class="legend-item">
                <div class="legend-color gui-38"></div>
                <span>Thời gian rảnh (Sẵn sàng nhận tour)</span>
              </div>
            </div>

            <div class="calendar-grid" id="guideCalendarGrid">
              <!-- Render calendar grid -->
            </div>
          </div>
        </section>

        <!-- ========================================================================= -->
        <!-- TAB 4: QUẢN LÝ DOANH THU  -->
        <!-- ========================================================================= -->
        <section class="tab-content-panel" id="tab-revenue">

          <!-- BỘ LỌC VÀ CÔNG CỤ THEO DÕI DOANH THU  -->
          <div class="gui-39">
            <div class="gui-40">
              <div class="gui-41">
                <span class="gui-42">
                  <i data-lucide="filter" class="icon-xs gui-43"></i> Khoảng thời gian:
                </span>
                <select id="revFilterPeriod" class="form-control gui-44" onchange="applyRevenueFilters()">
                  <option value="all" selected>Tất cả thời gian (2026)</option>
                  <option value="1">Tháng 1</option>
                  <option value="2">Tháng 2</option>
                  <option value="3">Tháng 3</option>
                  <option value="4">Tháng 4</option>
                  <option value="5">Tháng 5</option>
                  <option value="6">Tháng 6</option>
                  <option value="7">Tháng 7</option>
                  <option value="8">Tháng 8</option>
                  <option value="9">Tháng 9</option>
                  <option value="10">Tháng 10</option>
                  <option value="11">Tháng 11</option>
                  <option value="12">Tháng 12</option>
                </select>
              </div>

              <div class="gui-41">
                <span class="gui-42">
                  <i data-lucide="layers" class="icon-xs gui-43"></i> Trạng thái dòng tiền:
                </span>
                <select id="revFilterStatus" class="form-control gui-45" onchange="applyRevenueFilters()">
                  <option value="all">Tất cả trạng thái</option>
                  <option value="paid_to_guide">Đã thanh toán cho HDV</option>
                  <option value="escrow_held">Đang tạm giữ Escrow</option>
                  <option value="disputed">Đang được giữ do khiếu nại </option>
                </select>
              </div>
            </div>

            <div class="gui-41">
              <button class="btn-outline gui-46" onclick="resetRevenueFilter()">
                <i data-lucide="rotate-ccw" class="icon-xs"></i> Đặt Lại Bộ Lọc
              </button>
            </div>
          </div>


          <div id="revErrorState" class="gui-47">
            <div class="gui-48">
              <i data-lucide="alert-triangle"></i>
            </div>
            <h4 class="gui-49">Không tải được dữ liệu doanh thu </h4>
            <p class="gui-50">
              Hệ thống gián đoạn kết nối máy chủ dữ liệu hoặc không đồng bộ được lịch sử giao dịch. Vui lòng bấm thử lại
              để hệ thống tải lại số liệu.
            </p>
            <button class="btn-primary gui-51" onclick="retryRevenueLoad()">
              <i data-lucide="refresh-cw"></i> Thử Lại
            </button>
          </div>

          <!-- KHU VỰC NỘI DUNG DOANH THU CHÍNH -->
          <div id="revMainContent">
            <!-- 4 thẻ thống kê số liệu tài chính  -->
            <div class="stats-row" id="revStatsRow">
              <div class="stat-card">
                <div class="stat-info">
                  <span class="stat-lbl">Tổng Doanh Thu Tour</span>
                  <div class="stat-val" id="revTotalGMV">0₫</div>
                  <span class="stat-sub">Tổng giá trị tour đã hoàn thành</span>
                </div>
                <div class="stat-icon-wrap icon-emerald"><i data-lucide="trending-up"></i></div>
              </div>

              <div class="stat-card">
                <div class="stat-info">
                  <span class="stat-lbl">Phí Sàn Khấu Trừ</span>
                  <div class="stat-val gui-52" id="revTotalFee">0₫</div>
                  <span class="stat-sub">Phí duy trì và bảo hiểm sàn</span>
                </div>
                <div class="stat-icon-wrap icon-purple"><i data-lucide="percent"></i></div>
              </div>

              <div class="stat-card">
                <div class="stat-info">
                  <span class="stat-lbl">Đã Thanh Toán Cho HDV</span>
                  <div class="stat-val gui-43" id="revAvailableBalance">0₫</div>
                  <span class="stat-sub">Khoản thực nhận đã thanh toán thành công</span>
                </div>
                <div class="stat-icon-wrap icon-emerald"><i data-lucide="check-circle"></i></div>
              </div>

              <div class="stat-card">
                <div class="stat-info">
                  <span class="stat-lbl">Đang Ký Quỹ Escrow (Tạm Giữ)</span>
                  <div class="stat-val gui-53" id="revEscrowHolding">0₫</div>
                  <span class="stat-sub">Bảo đảm cho các tour sắp đi & đang xử lý</span>
                </div>
                <div class="stat-icon-wrap icon-amber"><i data-lucide="shield-alert"></i></div>
              </div>
            </div>

            <!-- Thông tin tài khoản ngân hàng của HDV nhận tất toán -->
            <div class="gui-54">
              <div class="gui-55">
                <div class="gui-56">
                  <i data-lucide="landmark"></i>
                </div>
                <div>
                  <div class="gui-57">
                    ⚡ Thông Tin Tài Khoản
                  </div>
                  <div id="revGuideBankBox" class="gui-58">
                    Đang tải thông tin tài khoản ngân hàng...
                  </div>
                </div>
              </div>
              <div class="gui-59">
                <i data-lucide="shield-check" class="icon-xs gui-43"></i>
                Hệ thống thanh toán tự động thù lao vào tài khoản ngân hàng sau khi tour hoàn thành.
              </div>
            </div>

            <!-- Biểu đồ doanh thu 12 tháng chuyên nghiệp kết nối dữ liệu thực tế SQL Server -->
            <div class="card-table-wrapper gui-60" id="revChartContainer">
              <div class="gui-61">
                <div>
                  <h3 class="gui-62" id="revChartTitle">Biểu Đồ Doanh Thu Thực Nhận 12 Tháng (Năm 2026)</h3>
                  <p class="gui-63" id="revChartSubtitle">
                    Tổng hợp thu nhập thực nhận hàng tháng sau khi khấu trừ phí nền tảng. Nhấp vào cột tháng để lọc chi
                    tiết.
                  </p>
                </div>
                <!-- Chú thích 3 trạng thái duy nhất theo đúng yêu cầu -->
                <div class="gui-64">
                  <span class="gui-65">
                    <span class="gui-66"></span>
                    Tháng Có Doanh Thu
                  </span>
                  <span class="gui-65">
                    <span class="gui-67"></span>
                    Tháng Đang Chọn
                  </span>
                  <span class="gui-65">
                    <span class="gui-68"></span>
                    Chưa Có Doanh Thu
                  </span>
                </div>
              </div>

              <div class="monthly-revenue-grid gui-69" id="revMonthlyGrid">
                <!-- Render động 12 tháng từ dữ liệu SQL Server -->
              </div>

              <div class="gui-70">
                <span class="gui-71">💡 Mẹo: Bấm trực tiếp vào cột của bất kỳ tháng nào để xem danh sách chuyến đi chi
                  tiết của tháng đó.</span>
              </div>
            </div>


            <div id="revEmptyState" class="gui-72">
              <div class="gui-73">
                <i data-lucide="receipt"></i>
              </div>
              <h4 class="gui-74">Chưa có dữ liệu doanh thu </h4>
              <p class="gui-75">
                Hệ thống chưa ghi nhận bất kỳ giao dịch hoặc doanh thu nào trong khoảng thời gian / bộ lọc đã chọn.
              </p>
              <button class="btn-primary gui-76" onclick="resetRevenueFilter()">
                <i data-lucide="rotate-ccw"></i> Xem Lại Tất Cả Dữ Liệu
              </button>
            </div>

            <!-- Bảng chi tiết doanh thu từng tour  -->
            <div class="card-table-wrapper" id="revTableContainer">
              <div class="card-table-header gui-77">
                <h3>Chi Tiết Các Khoản Thu & Tất Toán Từ Chuyến Đi</h3>
                <span class="gui-78">
                  <i data-lucide="check" class="icon-xs gui-79"></i> Bấm "Xem Chi Tiết" để bóc tách phí sàn & thực nhận
                </span>
              </div>
              <table class="custom-table">
                <thead>
                  <tr>
                    <th>Mã Tour</th>
                    <th>Điểm Đến Tại Việt Nam</th>
                    <th>Du Khách</th>
                    <th>Ngày Khởi Hành</th>
                    <th>Tổng Tiền</th>
                    <th>Phí Sàn</th>
                    <th>Thực Nhận</th>
                    <th>Trạng Thái Dòng Tiền</th>
                    <th class="gui-80">Thao Tác</th>
                  </tr>
                </thead>
                <tbody id="revTableBody">
                  <!-- Render dynamically -->
                </tbody>
              </table>
            </div>
          </div>
        </section>

        <!-- ========================================================================= -->
        <!-- TAB 5: NHẮN TIN TRAO ĐỔI  -->
        <!-- ========================================================================= -->
        <section class="tab-content-panel" id="tab-chat">
          <div class="chat-layout">
            <!-- Cột danh sách hội thoại -->
            <div class="chat-sidebar-list">
              <div class="gui-81">
                Hội Thoại Với Khách Hàng
              </div>
              <div id="chatConversationList">
                <!-- Render dynamically -->
              </div>
            </div>

            <!-- Khu vực khung chat chính -->
            <div class="chat-main-area">
              <div class="chat-header">
                <div class="gui-8">
                  <div class="gui-82" id="chatPartnerAvatar">
                    KH
                  </div>
                  <div>
                    <h4 class="gui-83" id="chatPartnerName">Nguyễn Văn Minh</h4>
                    <span class="gui-84" id="chatPartnerStatusBadge">
                      <span class="gui-85"></span> Đang trực tuyến
                    </span>
                  </div>
                </div>
                <div class="gui-86">
                  Tour: <strong id="chatPartnerTour">Hội An & Làng Gốm Thanh Hà</strong>
                </div>
              </div>

              <!-- Cảnh báo khi tài khoản đối phương bị khóa  -->
              <div id="chatSuspendedNotice" class="gui-87">
                <i data-lucide="slash" class="gui-88"></i>
                <span><strong>Tài khoản bị khóa:</strong> Khách hàng này đang bị khóa do vi phạm. Hệ thống không cho
                  phép gửi tin nhắn mới .</span>
              </div>

              <!-- Danh sách bong bóng chat -->
              <div class="chat-messages-container" id="chatMessagesContainer">
                <!-- Render bubbles -->
              </div>

              <!-- Thanh nhập tin nhắn -->
              <form class="chat-input-bar" id="chatInputBar" onsubmit="handleSendGuideChatMessage(event)">
                <button type="button" class="btn-ghost" onclick="openChatImageModal()" title="Chọn ảnh gửi cho khách">
                  <i data-lucide="image"></i>
                </button>
                <input type="text" id="chatInputText" class="form-control gui-89"
                  placeholder="Nhập tin nhắn trao đổi với du khách...">
                <button type="submit" class="btn-primary gui-90" id="btnSendChatMessage">
                  <i data-lucide="send"></i> Gửi
                </button>
              </form>
            </div>
          </div>
        </section>

        <!-- ========================================================================= -->
        <!-- TAB 6: PHẢN HỒI ĐÁNH GIÁ -->
        <!-- ========================================================================= -->
        <section class="tab-content-panel" id="tab-reviews">
          <div class="card-table-wrapper">
            <div class="card-table-header">
              <div>
                <h3>Đánh Giá Của Khách Hàng & Phản Hồi</h3>
                <p class="gui-23">
                  Hệ thống <strong>ưu tiên hiển thị các đánh giá mới chưa có phản hồi</strong> lên đầu để bạn dễ dàng
                  chăm sóc khách.
                </p>
              </div>
            </div>

            <div id="reviewsListContainer" class="gui-22">
              <!-- Render danh sách đánh giá -->
            </div>
          </div>
        </section>

        <!-- ========================================================================= -->
        <!-- TAB 7: KHIẾU NẠI & HỖ TRỢ -->
        <!-- ========================================================================= -->
        <section class="tab-content-panel" id="tab-disputes">
          <div class="card-table-wrapper gui-91">
            <h3 class="gui-92">Gửi Khiếu Nại Chuyến Đi Lên Ban Quản Trị</h3>
            <p class="gui-93">
              Khi phát sinh sự cố (khách không đến điểm hẹn, vi phạm văn hóa, hủy đơn cận giờ...), HDV có thể gửi khiếu
              nại kèm <strong>bằng chứng bắt buộc</strong>. Sàn sẽ lập tức <strong>tạm dừng giải ngân</strong> để phân
              xử.
            </p>

            <form onsubmit="handleGuideSubmitDispute(event)" class="gui-94">
              <div class="form-group">
                <label class="form-label">Chọn Chuyến Đi Phát Sinh Sự Cố <span class="gui-95">*</span></label>
                <select id="disputeTripSelect" class="form-control" required>
                  <!-- Render trips -->
                </select>
              </div>

              <div class="form-group">
                <label class="form-label">Loại Sự Cố Du Lịch</label>
                <select id="disputeReasonType" class="form-control">
                  <option value="Khách vắng mặt không lý do tại điểm hẹn">Khách vắng mặt không lý do tại điểm hẹn
                  </option>
                  <option value="Khách yêu cầu đi thêm tuyến ngoài thỏa thuận không trả phí">Khách yêu cầu đi thêm tuyến
                    ngoài thỏa thuận không trả phí</option>
                  <option value="Hành vi vi phạm quy định tại khu di tích / di sản">Hành vi vi phạm quy định tại khu di
                    tích / di sản</option>
                  <option value="Khác">Khác</option>
                </select>
              </div>

              <div class="form-group gui-96">
                <label class="form-label">Mô Tả Chi Tiết Vụ Việc</label>
                <textarea id="disputeDescription" class="form-control" rows="3"
                  placeholder="Mô tả cụ thể thời gian, địa điểm và quá trình diễn biến sự việc..." required></textarea>
              </div>

              <div class="form-group gui-96">
                <label class="form-label">Bằng Chứng Bắt Buộc (Ảnh chụp màn hình, ảnh định vị, video hoặc đoạn chat)
                  <span class="gui-95">*</span></label>
                <input type="text" id="disputeEvidenceText" class="form-control"
                  placeholder="Dẫn chứng tin nhắn cuộc gọi hoặc biên bản tại điểm đến..." required>

                <div class="gui-97">
                  <label class="gui-98">
                    <i data-lucide="upload" class="icon-xs gui-79"></i> Tải Lên Tệp Ảnh Bằng Chứng (Từ máy tính):
                  </label>
                  <input type="file" id="disputeEvidenceFile" accept="image/*" class="form-control gui-99"
                    onchange="previewDisputeEvidence(event)">
                  <input type="hidden" id="disputeEvidenceUrl"
                    value="https://images.unsplash.com/photo-1584438784894-089d6a62b8fa?w=600">
                </div>

                <!-- Live Image Preview Box -->
                <div id="disputeEvidencePreviewWrap" class="gui-100">
                  <img id="disputeEvidencePreviewImg"
                    src="https://images.unsplash.com/photo-1584438784894-089d6a62b8fa?w=600" alt="Bằng chứng sự cố"
                    class="gui-101">
                  <div class="gui-102">
                    <strong class="gui-103">Ảnh Bằng Chứng Được Đính Kèm</strong>
                    <span>Bấm "Chọn tệp" ở trên để tải trực tiếp ảnh từ máy tính. Ảnh sẽ hiển thị ngay tại đây để bạn
                      kiểm tra trước khi gửi lên Ban Quản Trị.</span>
                  </div>
                </div>
              </div>

              <div class="gui-104">
                <button type="submit" class="btn-primary gui-105">
                  <i data-lucide="send"></i> Gửi Khiếu Nại Lên Ban Quản Trị
                </button>
              </div>
            </form>
          </div>

          <!-- Danh sách khiếu nại đã gửi hoặc liên quan -->
          <div class="card-table-wrapper">
            <div class="card-table-header">
              <h3>Danh Sách Khiếu Nại</h3>
            </div>
            <div id="disputesListContainer" class="gui-22">
              <!-- Render dynamically -->
            </div>
          </div>
        </section>

        <!-- ========================================================================= -->
        <!-- TAB 8: THÔNG TIN CÁ NHÂN -->
        <!-- ========================================================================= -->
        <section class="tab-content-panel" id="tab-profile">
          <div class="card-table-wrapper gui-106">
            <div class="gui-107">
              <div>
                <h3 class="gui-108">Thông Tin Cá Nhân & Thẻ Hướng Dẫn Viên</h3>
                <p class="gui-21">
                  Cập nhật thông tin dẫn tour tại các điểm du lịch Việt Nam. Nếu thay đổi <strong>Thẻ hành
                    nghề</strong>, hồ sơ sẽ chuyển sang <strong>Chờ Quản trị viên duyệt lại</strong>.
                </p>
              </div>
              <div id="certStatusTagProfile">
                <!-- Render status badge -->
              </div>
            </div>

            <form onsubmit="handleGuideSaveProfile(event)" class="gui-109">
              <!-- Ảnh đại diện HDV -->
              <div class="form-group gui-96"
                style="display:flex; align-items:center; gap:20px; background:#f8fafc; padding:16px; border-radius:12px; border:1px solid #e2e8f0; margin-bottom:16px;">
                <div style="position:relative;">
                  <img id="profGuideAvatarPreview"
                    src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150" alt="Ảnh đại diện"
                    style="width:84px; height:84px; border-radius:50%; object-fit:cover; border:3px solid var(--mint-500); box-shadow:0 3px 8px rgba(0,0,0,0.12);">
                </div>
                <div style="flex:1;">
                  <label class="form-label" style="font-weight:700; margin-bottom:4px;">Ảnh Đại Diện Hướng Dẫn
                    Viên</label>
                  <input type="text" id="profGuideAvatar" class="form-control"
                    placeholder="Đường dẫn ảnh đại diện (URL)..."
                    oninput="document.getElementById('profGuideAvatarPreview').src = this.value || 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150'" disabled>
                  <div style="font-size:0.75rem; color:#64748b; margin-top:4px;">Ảnh sẽ hiển thị trên hồ sơ để du khách
                    và ban quản trị nhận diện bạn.</div>
                </div>
              </div>

              <div class="form-group">
                <label class="form-label">Họ và Tên HDV <span class="gui-95">*</span></label>
                <input type="text" id="profGuideName" class="form-control" required disabled>
              </div>

              <div class="form-group">
                <label class="form-label">Số Điện Thoại Liên Hệ <span class="gui-95">*</span></label>
                <input type="text" id="profGuidePhone" class="form-control" required disabled>
              </div>

              <div class="form-group">
                <label class="form-label">Khu Vực Tuyến Điểm Dẫn Tour Tại Việt Nam</label>
                <input type="text" id="profGuideCity" class="form-control"
                  placeholder="VD: Phố Cổ Hội An & Mỹ Sơn, Quảng Nam" required disabled>
              </div>

              <div class="form-group">
                <label class="form-label">Giá Dẫn Tour Theo Giờ / Ngày (VNĐ)</label>
                <div class="gui-110">
                  <input type="number" id="profGuideHourlyPrice" class="form-control"
                    placeholder="Theo giờ (VD: 450000)" disabled>
                  <input type="number" id="profGuideDailyPrice" class="form-control"
                    placeholder="Theo ngày (VD: 1500000)" disabled>
                </div>
              </div>

              <div class="form-group gui-96">
                <label class="form-label">Chuyên Môn & Điểm Đến Thế Mạnh</label>
                <input type="text" id="profGuideSpecialties" class="form-control"
                  placeholder="VD: Lịch sử phố cổ, Văn hóa Champa, Thám hiểm Hang động Tràng An..." disabled>
              </div>

              <div class="form-group gui-96">
                <label class="form-label">Ngoại Ngữ Thuyết Minh</label>
                <input type="text" id="profGuideLanguages" class="form-control"
                  placeholder="VD: Tiếng Việt (Bản ngữ), Tiếng Anh (IELTS 7.5), Tiếng Pháp (B2)..." disabled>
              </div>

              <div class="form-group gui-96">
                <label class="form-label">Giới Thiệu Bản Thân & Kinh Nghiệm Nghề Nghiệp</label>
                <textarea id="profGuideBio" class="form-control" rows="3" disabled></textarea>
              </div>

              <!-- KHỐI THẺ HÀNH NGHỀ -->
              <div class="gui-111">
                <h4 class="gui-112">
                  <i data-lucide="file-badge" class="icon-sm gui-52"></i>
                  Thông Tin Thẻ Hướng Dẫn Viên Du Lịch Việt Nam
                </h4>
                <p class="gui-113">
                  Lưu ý: Việc sửa đổi các trường dưới đây sẽ yêu cầu Quản trị viên thẩm định lại trước khi bạn có thể
                  tiếp tục nhận tour mới.
                </p>

                <div class="gui-114">
                  <div class="form-group">
                    <label class="form-label">Loại Thẻ HDV</label>
                    <select id="profGuideCertType" class="form-control" disabled>
                      <option value="Thẻ Hướng Dẫn Viên Du Lịch Quốc Tế Tại Việt Nam">Thẻ Hướng Dẫn Viên Du Lịch Quốc Tế
                        Tại Việt Nam</option>
                      <option value="Thẻ Hướng Dẫn Viên Du Lịch Nội Địa">Thẻ Hướng Dẫn Viên Du Lịch Nội Địa</option>
                    </select>
                  </div>

                  <div class="form-group">
                    <label class="form-label">Số Hiệu Thẻ HDV</label>
                    <input type="text" id="profGuideCertNumber" class="form-control" placeholder="VD: VN-HDVND-10492" disabled>
                  </div>

                  <div class="form-group">
                    <label class="form-label">Cơ Quan Cấp Thẻ (Sở Du Lịch Tỉnh/Thành)</label>
                    <input type="text" id="profGuideIssuedBy" class="form-control"
                      placeholder="VD: Sở Du Lịch Tỉnh Quảng Nam" disabled>
                  </div>

                  <div class="form-group gui-96">
                    <label class="form-label">Tải Lên Ảnh Thẻ Hành Nghề Hướng Dẫn Viên Du Lịch <span
                        class="gui-95">*</span></label>
                    <input type="file" id="profGuideCertFileInput" accept="image/*" class="form-control gui-99"
                      onchange="previewGuideCertFile(event)" disabled>
                    <input type="hidden" id="profGuideCertImage" value="">

                    <!-- Live Card Photo Preview -->
                    <div id="profGuideCertPreviewWrap" class="gui-115">
                      <img id="profGuideCertPreviewImg"
                        src="https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=600"
                        alt="Ảnh thẻ hành nghề HDV" class="gui-116">
                      <div>
                        <div class="gui-117">
                          <i data-lucide="image" class="icon-xs gui-52"></i> Hình Ảnh Thẻ Hành Nghề Thực Tế
                        </div>
                        <p class="gui-118">
                          Ảnh chụp rõ mặt trước thẻ hành nghề du lịch nội địa hoặc quốc tế (phôi thẻ do Tổng cục Du lịch
                          / Sở Du Lịch cấp). Khi bạn chọn tệp ảnh mới từ máy tính, hình ảnh sẽ lập tức hiển thị xem
                          trước tại đây thay vì chỉ có đường dẫn link.
                        </p>
                        <span class="gui-119">
                          ✓ Hỗ trợ định dạng: JPG, PNG, WEBP
                        </span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <!-- KHỐI TÀI KHOẢN NGÂN HÀNG NHẬN DOANH THU (BẮT BUỘC ĐỂ NHẬN KHÁCH) -->
              <div class="gui-120">
                <h4 class="gui-121">
                  <i data-lucide="landmark" class="icon-sm gui-43"></i>
                  Thông Tin Tài Khoản Ngân Hàng Nhận Doanh Thu <span class="gui-95">*</span>
                </h4>
                <p class="gui-122">
                  <strong>Lưu ý bắt buộc:</strong> Hướng dẫn viên phải thiết lập tài khoản ngân hàng chính chủ để hệ
                  thống tự động thanh toán thù lao sau khi tour kết thúc. Nếu chưa điền thông tin này, bạn sẽ
                  <strong>không thể xác nhận nhận tour mới</strong> khi có du khách đặt lịch.
                </p>

                <div class="gui-123">
                  <div class="form-group">
                    <label class="form-label">Tên Ngân Hàng <span class="gui-95">*</span></label>
                    <input type="text" id="profGuideBankName" class="form-control"
                      placeholder="VD: Vietcombank, MB Bank, BIDV..." required disabled>
                  </div>
                  <div class="form-group">
                    <label class="form-label">Số Tài Khoản (STK) <span class="gui-95">*</span></label>
                    <input type="text" id="profGuideBankAccount" class="form-control" placeholder="VD: 0071000889988"
                      required disabled>
                  </div>
                  <div class="form-group">
                    <label class="form-label">Tên Chủ Tài Khoản <span class="gui-95">*</span></label>
                    <input type="text" id="profGuideBankOwner" class="form-control"
                      placeholder="VD: NGUYEN VAN A (Viết hoa)" required disabled>
                  </div>
                </div>
              </div>

              <!-- Đổi Mật Khẩu -->
              <div class="gui-124">
                <h4 class="gui-125">Đổi Mật Khẩu Đăng Nhập</h4>
                <div class="gui-114">
                  <div class="form-group">
                    <label class="form-label">Mật Khẩu Hiện Tại</label>
                    <input type="password" id="profOldPassword" class="form-control" placeholder="Nhập mật khẩu cũ" disabled>
                  </div>
                  <div class="form-group">
                    <label class="form-label">Mật Khẩu Mới</label>
                    <input type="password" id="profNewPassword" class="form-control"
                      placeholder="Nhập mật khẩu mới (tối thiểu 6 ký tự)" disabled>
                  </div>
                </div>
              </div>

              <!-- Nút Hành Động Chỉnh Sửa Hồ Sơ HDV (Trước khi bấm Chỉnh sửa thì không sửa được, bấm Chỉnh sửa mới hiện Lưu và Hủy) -->
              <div id="guideProfileInitialActions" class="gui-126">
                <button type="button" id="btnGuideEditProfile" class="btn-primary" onclick="enableGuideProfileEdit()">
                  <i data-lucide="edit-3"></i> Chỉnh Sửa
                </button>
              </div>

              <div id="guideProfileEditActions" class="gui-126" style="display: none;">
                <button type="button" class="btn-outline" onclick="cancelGuideProfileEdit()">
                  <i data-lucide="x"></i> Hủy Chỉnh Sửa
                </button>
                <button type="submit" class="btn-primary">
                  <i data-lucide="save"></i> Lưu Thay Đổi Hồ Sơ
                </button>
              </div>
            </form>
          </div>
        </section>

      </div>
    </main>

    <!-- MODAL TỪ CHỐI YÊU CẦU ĐẶT LỊCH -->
    <div id="rejectBookingModal" class="gui-127">
      <div class="gui-128">
        <h3 class="gui-129">
          <i data-lucide="alert-octagon"></i> Từ Chối Yêu Cầu Đặt Lịch
        </h3>
        <p class="gui-130">
          Hệ thống sẽ tự động <strong>hoàn tiền 100%</strong> cho du khách qua Cổng thanh toán. Bạn bắt buộc phải cung
          cấp lý do từ chối để thông báo cho khách.
        </p>
        <input type="hidden" id="rejectTripId">
        <div class="form-group">
          <label class="form-label">Lý do từ chối <span class="gui-95">*</span></label>
          <textarea id="rejectReasonText" class="form-control" rows="3"
            placeholder="VD: Đã kín lịch đột xuất, lịch trình không phù hợp điều kiện thời tiết..."></textarea>
        </div>
        <div class="gui-131">
          <button class="btn-outline" onclick="closeRejectModal()">Hủy Thao Tác</button>
          <button class="btn-primary gui-105" onclick="confirmRejectBooking()">
            Xác Nhận Từ Chối & Hoàn Tiền
          </button>
        </div>
      </div>
    </div>

    <!-- MODAL CHỈNH SỬA PHẢN HỒI ĐÁNH GIÁ  -->
    <div id="editReplyModal" class="gui-127">
      <div class="gui-132">
        <div class="gui-133">
          <h3 class="gui-134">
            <i data-lucide="message-square-quote" class="gui-43"></i>
            Chỉnh Sửa Phản Hồi Đánh Giá
          </h3>
          <button type="button" class="btn-ghost gui-135" onclick="closeEditReplyModal()">
            <i data-lucide="x" class="gui-136"></i>
          </button>
        </div>
        <p class="gui-137">
          Cập nhật lại nội dung phản hồi gửi đến du khách. Câu trả lời lịch thiệp sẽ giúp củng cố mức độ tin cậy và
          chuyên nghiệp của bạn.
        </p>
        <input type="hidden" id="editReplyTripId">
        <div class="form-group gui-138">
          <label class="form-label">Nội dung phản hồi của HDV <span class="gui-139">*</span></label>
          <textarea id="editReplyContentText" class="form-control gui-140" rows="4"
            placeholder="Nhập câu trả lời phản hồi khách du lịch..."></textarea>
        </div>
        <div class="gui-141">
          <button type="button" class="btn-outline" onclick="closeEditReplyModal()">Hủy</button>
          <button type="button" class="btn-primary" onclick="confirmSaveEditReply()">
            <i data-lucide="check" class="gui-142"></i> Lưu Phản Hồi
          </button>
        </div>
      </div>
    </div>

    <!-- MODAL CHỌN ẢNH GỬI TIN NHẮN (TẢI TỪ THIẾT BỊ HOẶC CHỌN ẢNH ĐIỂM ĐẾN) -->
    <div id="chatImageModal" class="gui-127">
      <div class="gui-143">
        <div class="gui-133">
          <h3 class="gui-134">
            <i data-lucide="image" class="gui-43"></i>
            Gửi Hình Ảnh Trong Tin Nhắn
          </h3>
          <button type="button" class="btn-ghost gui-135" onclick="closeChatImageModal()">
            <i data-lucide="x" class="gui-136"></i>
          </button>
        </div>

        <!-- Lựa chọn 1: Tải ảnh từ máy tính / điện thoại -->
        <div class="gui-144" onclick="document.getElementById('chatImageFileInput').click()"
          onmouseover="this.style.borderColor='#059669'" onmouseout="this.style.borderColor='#cbd5e1'">
          <i data-lucide="upload-cloud" class="gui-145"></i>
          <div class="gui-146">Bấm để chọn ảnh từ máy tính hoặc điện thoại</div>
          <div class="gui-147">Hỗ trợ ảnh JPG, PNG, WEBP rõ nét</div>
          <input type="file" id="chatImageFileInput" accept="image/*" class="gui-20"
            onchange="handleChatImageFileChange(this)">
          <div id="chatUploadPreviewBox" class="gui-148">
            <img id="chatUploadPreviewImg" src="" class="gui-149">
            <span class="gui-150">✓ Đã sẵn sàng gửi ảnh này</span>
          </div>
        </div>

        <!-- Lựa chọn 2: Chọn nhanh ảnh danh lam thắng cảnh Việt Nam -->
        <div>
          <label class="form-label gui-151">
            Hoặc chọn nhanh ảnh danh thắng Việt Nam:
          </label>
          <div class="gui-152" id="presetChatImagesGrid">
            <div class="preset-img-item gui-153"
              onclick="selectPresetChatImage('https://images.unsplash.com/photo-1528127269322-539801943592?w=600', 'Hạ Long - Vịnh Di Sản', this)">
              <img src="https://images.unsplash.com/photo-1528127269322-539801943592?w=300" class="gui-154">
              <span class="gui-155">Vịnh Hạ Long</span>
            </div>
            <div class="preset-img-item gui-153"
              onclick="selectPresetChatImage('https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=600', 'Hội An - Phố Cổ Đèn Lồng', this)">
              <img src="https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?w=300" class="gui-154">
              <span class="gui-155">Phố Cổ Hội An</span>
            </div>
            <div class="preset-img-item gui-153"
              onclick="selectPresetChatImage('https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=600', 'Ninh Bình - Tràng An Non Nước', this)">
              <img src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=300" class="gui-154">
              <span class="gui-155">Tràng An</span>
            </div>
            <div class="preset-img-item gui-153"
              onclick="selectPresetChatImage('https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=600', 'Hà Nội - Tháp Rùa Hồ Gươm', this)">
              <img src="https://images.unsplash.com/photo-1583417319070-4a69db38a482?w=300" class="gui-154">
              <span class="gui-155">Hồ Gươm</span>
            </div>
            <div class="preset-img-item gui-153"
              onclick="selectPresetChatImage('https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=600', 'Sa Pa - Mây Núi Fansipan', this)">
              <img src="https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=300" class="gui-154">
              <span class="gui-155">Sa Pa</span>
            </div>
            <div class="preset-img-item gui-153"
              onclick="selectPresetChatImage('https://images.unsplash.com/photo-1578632767115-351597cf2477?w=600', 'Huế - Cố Đô Cung Đình', this)">
              <img src="https://images.unsplash.com/photo-1578632767115-351597cf2477?w=300" class="gui-154">
              <span class="gui-155">Cố Đô Huế</span>
            </div>
          </div>
        </div>

        <div class="gui-156">
          <button type="button" class="btn-outline" onclick="closeChatImageModal()">Đóng</button>
          <button type="button" class="btn-primary gui-157" id="btnConfirmSendChatImg" onclick="confirmSendChatImage()"
            disabled>
            <i data-lucide="send"></i> Gửi Ảnh Vào Tin Nhắn
          </button>
        </div>
      </div>
    </div>

    <!-- MODAL HỦY CHUYẾN ĐI (KHUNG NHẬP LÝ DO HỦY CHUYẾN) -->
    <div id="cancelTripByGuideModal" class="gui-127">
      <div class="gui-158">
        <div class="gui-133">
          <h3 class="gui-159">
            <i data-lucide="alert-octagon"></i>
            Hủy Chuyến Đi Của Khách Hàng
          </h3>
          <button type="button" class="btn-ghost gui-135" onclick="closeCancelTripModal()">
            <i data-lucide="x" class="gui-136"></i>
          </button>
        </div>

        <div class="gui-160">
          <strong>⚠️ Lưu ý quy định hủy tour của Guidia:</strong><br>
          • Nếu hủy <strong>trước 48 giờ</strong> so với giờ khởi hành: Hệ thống tự động hoàn tiền 100% cho du khách và
          mở lại lịch rảnh cho bạn.<br>
          • Nếu hủy <strong>trong vòng 48 giờ</strong>: Bị chặn hủy trên hệ thống do vi phạm cam kết dịch vụ .
        </div>

        <input type="hidden" id="cancelTripIdInput">

        <div id="cancelTripSummaryCard" class="gui-161">
          <!-- Thông tin tóm tắt chuyến -->
        </div>

        <div class="form-group gui-162">
          <label class="form-label gui-163">
            <span>Lý do bạn muốn hủy chuyến đi này <span class="gui-139">*</span></span>
            <span class="gui-164">Bắt buộc nhập</span>
          </label>
          <textarea id="cancelTripReasonInput" class="form-control gui-140" rows="3"
            placeholder="Nhập lý do chi tiết (VD: Gặp sự cố sức khỏe đột xuất, thời tiết mưa bão nguy hiểm, phương tiện hỏng hóc...)"></textarea>
        </div>

        <div class="gui-141">
          <button type="button" class="btn-outline" onclick="closeCancelTripModal()">Hủy Bỏ</button>
          <button type="button" class="btn-primary gui-105" onclick="confirmCancelTripByGuide()">
            <i data-lucide="x-circle"></i> Xác Nhận Hủy Chuyến
          </button>
        </div>
      </div>
    </div>

    <!-- MODAL XEM CHI TIẾT KHOẢN THU CHUYẾN ĐI  -->
    <div id="tripRevenueDetailModal" class="gui-127">
      <div class="gui-165">
        <div class="gui-166">
          <div>
            <span class="gui-167">Bóc Tách Doanh Thu Chuyến Đi </span>
            <h3 class="gui-168">
              <i data-lucide="receipt" class="gui-43"></i>
              Mã Chuyến: <span id="revDetailTripCode" class="gui-43">TRIP-VN101</span>
            </h3>
          </div>
          <button type="button" class="btn-ghost gui-135" onclick="closeTripRevenueDetailModal()">
            <i data-lucide="x" class="gui-136"></i>
          </button>
        </div>

        <!-- Khung thông tin tour tóm tắt -->
        <div class="gui-169">
          <div class="gui-170" id="revDetailLocation">Điểm đến</div>
          <div class="gui-171">
            <div>Du khách: <strong id="revDetailCustomer" class="gui-172">Nguyễn Văn Minh</strong></div>
            <div>Ngày khởi hành: <strong id="revDetailDate" class="gui-172">2026-11-15</strong></div>
            <div>Số lượng: <span id="revDetailGuests">2 khách</span></div>
            <div>Thời lượng: <span id="revDetailDuration">4 giờ</span></div>
          </div>
        </div>

        <!-- Bóc tách chi tiết: Tiền chuyến, Phí sàn, Thực nhận -->
        <div class="gui-173">
          <div class="gui-174">
            Bóc Tách Chi Tiết Dòng Tiền
          </div>

          <div class="gui-175">
            <span class="gui-176">1. Tiền chuyến (Khách thanh toán):</span>
            <strong class="gui-177" id="revDetailTotalAmount">0₫</strong>
          </div>

          <div class="gui-175">
            <span class="gui-176">2. Phí nền tảng Guidia (Khấu trừ):</span>
            <strong class="gui-178" id="revDetailPlatformFee">- 0₫</strong>
          </div>

          <div class="gui-179">
            <span class="gui-180">3. HDV thực nhận:</span>
            <strong class="gui-181" id="revDetailGuidePayout">0₫</strong>
          </div>
        </div>

        <!-- TRẠNG THÁI DÒNG TIỀN (BAO GỒM NGOẠI LỆ  NẾU ĐANG BỊ KHIẾU NẠI) -->
        <div id="revDetailCashflowStatusBox" class="gui-182">
          <!-- Sẽ được fill động bởi JavaScript: Đang được giữ do khiếu nại  / Đã chuyển thẳng STK / Đang tạm giữ Escrow -->
        </div>

        <div class="gui-183">
          <button type="button" class="btn-primary" onclick="closeTripRevenueDetailModal()">
            <i data-lucide="check"></i> Đã Hiểu
          </button>
        </div>
      </div>
    </div>

    <!-- Toast Notification -->
    <div class="toast-notification" id="toastNotification">
      <i data-lucide="check-circle" class="toast-icon"></i>
      <span id="toastMessage">Thông báo thành công</span>
    </div>

    <!-- Scripts -->
    <script src="js/store.js?v=<%= System.currentTimeMillis() %>"></script>
    <script>
      /**
       * GUIDIA - Guide Portal Controller Logic
       * Chuyên biệt cho Hướng Dẫn Viên Du Lịch Nội Địa Việt Nam
       * Đáp ứng đầy đủ 8 Use Case của HDV và các Luồng Ngoại Lệ 
       */

      let currentGuideId = 'guide_yen';
      let currentChatPartnerId = 'usr_minh';
      let activeTripFilter = 'all';

      // Helper chuẩn hóa kiểm tra trạng thái và ngày tour cho toàn bộ trang HDV (UC06, UC07, UC11)
      function isGuideTripConfirmed(t) {
        if (!t) return false;
        const st = (t.status || t.dbStatus || '').toLowerCase().trim();
        return st === 'confirmed' || st === 'confirmed_upcoming' || st === 'đã_xác_nhận' || st === 'đã xác nhận' || st === 'ongoing' || st === 'in_progress' || st === 'đang_đi' || st === 'finished_paid' || st === 'completed' || st === 'đã_hoàn_thành' || st === 'đã hoàn thành';
      }

      function isGuideTripPending(t) {
        if (!t) return false;
        const st = (t.status || t.dbStatus || '').toLowerCase().trim();
        return st === 'pending' || st === 'pending_guide' || st === 'pending_guide_confirm' || st === 'chờ_xác_nhận' || st === 'chờ xác nhận';
      }

      function doesGuideTripCoverDate(t, dateStr) {
        if (!t || !t.startDate) return false;
        const sDate = String(t.startDate).substring(0, 10).trim();
        const eDate = String(t.endDate || t.startDate).substring(0, 10).trim();
        return (sDate <= dateStr && eDate >= dateStr);
      }

      // Vòng lặp đếm ngược thời gian thực trên giao diện HDV
      let guideLiveCountdownInterval = null;
      function startLiveCountdownLoop() {
        if (guideLiveCountdownInterval) clearInterval(guideLiveCountdownInterval);
        guideLiveCountdownInterval = setInterval(() => {
          const now = Date.now();
          const timerEls = document.querySelectorAll('.live-countdown-timer[data-expire-ms]');
          let needReRender = false;

          timerEls.forEach(el => {
            const expireMs = parseInt(el.getAttribute('data-expire-ms'), 10);
            if (isNaN(expireMs)) return;

            const remaining = expireMs - now;
            if (remaining > 0) {
              const totalSec = Math.floor(remaining / 1000);
              const hrs = Math.floor(totalSec / 3600);
              const mins = Math.floor((totalSec % 3600) / 60);
              const secs = totalSec % 60;
              el.textContent = `${String(hrs).padStart(2, '0')}:${String(mins).padStart(2, '0')}:${String(secs).padStart(2, '0')}`;
            } else {
              el.textContent = '00:00:00 (Đã hết hạn 24h)';
              el.style.color = '#dc2626';
              needReRender = true;
            }
          });

          if (needReRender && window.guidiaStore) {
            const res = window.guidiaStore.processAutoTimers();
            if (res && res.modified) {
              renderRequestsTab();
              renderTripsTab();
            }
          }
        }, 1000);
      }

      function handleFastForward24Hours() {
        if (!confirm('Kiểm thử: Bạn có muốn giả lập tua nhanh thời gian thêm 24 giờ để kiểm tra tính năng tự động hủy đơn do quá hạn phản hồi không?')) return;
        if (window.guidiaStore && window.guidiaStore.simulateFastForward) {
          const res = window.guidiaStore.simulateFastForward(24);
          alert(`Đã tua nhanh 24h! Đã xử lý ${res.expiredBookings || 0} đơn quá hạn và ${res.autoPayouts || 0} lượt tất toán tự động.`);
          renderRequestsTab();
          renderTripsTab();
        }
      }

      function initGuideApp() {
        const allGuides = window.guidiaStore ? window.guidiaStore.getGuides() : [];

        // 1. Luôn ưu tiên tài khoản HDV đang đăng nhập trong Session
        let loggedInGuideId = null;
        const currentUserJson = sessionStorage.getItem('guidia_current_user') || localStorage.getItem('guidia_current_user');
        if (currentUserJson) {
          try {
            const loggedInUser = JSON.parse(currentUserJson);
            if (loggedInUser && loggedInUser.id && (loggedInUser.role === 'guide' || loggedInUser.vaiTro === 'HUONG_DAN_VIEN')) {
              loggedInGuideId = parseInt(loggedInUser.id) || loggedInUser.id;
            }
          } catch (e) { }
        }

        if (loggedInGuideId) {
          currentGuideId = loggedInGuideId;
        } else {
          const savedGuideId = localStorage.getItem('guidia_current_guide_id_v2');
          if (savedGuideId) {
            currentGuideId = parseInt(savedGuideId) || savedGuideId;
          } else {
            currentGuideId = (window.guidiaStore && window.guidiaStore.getActiveGuideId()) || (allGuides.length > 0 ? allGuides[0].id : 2);
          }
        }

        localStorage.setItem('guidia_current_guide_id_v2', currentGuideId);
        if (window.guidiaStore && window.guidiaStore.setActiveGuideId) {
          window.guidiaStore.setActiveGuideId(currentGuideId);
        }

        // Khởi tạo tab và hiển thị dữ liệu ngay lập tức
        setupPortalTabs();
        populateGuideSwitcher(allGuides);
        checkCurrentGuideAccountStatus();
        renderAllGuidePortal();
        startLiveCountdownLoop();

        if (window.lucide) {
          window.lucide.createIcons();
        }

        // Tự động đồng bộ CSDL SQL Server ở chế độ ngầm (Background)
        if (window.guidiaStore && window.guidiaStore.syncWithDatabase) {
          window.guidiaStore.syncWithDatabase().then(() => {
            const updatedGuides = window.guidiaStore.getGuides();
            populateGuideSwitcher(updatedGuides);
            checkCurrentGuideAccountStatus();
            renderAllGuidePortal();
            if (window.lucide) window.lucide.createIcons();
          }).catch(err => {
            console.warn('Lỗi đồng bộ dữ liệu SQL Server:', err);
          });
        }
      }

      if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initGuideApp);
      } else {
        initGuideApp();
      }

      // ĐỒNG BỘ TIN NHẮN REALTIME GIỮA CÁC TAB & ĐỊNH KỲ TỪ CSDL SQL SERVER
      window.addEventListener('storage', function (e) {
        if (e.key === 'guidia_messages_v2' || e.key === 'guidia_trips_v2') {
          renderChatTab();
          renderActiveChatMessages();
          updateGuideBadges();
        }
      });

      window.addEventListener('guidia_messages_synced', function () {
        renderChatTab();
        renderActiveChatMessages();
        updateGuideBadges();
      });

      // Định kỳ 3s đồng bộ CSDL SQL Server để nhận tin nhắn mới theo thời gian thực
      setInterval(async function () {
        if (window.guidiaStore && window.guidiaStore.syncWithDatabase) {
          await window.guidiaStore.syncWithDatabase();
        }
      }, 3000);

      function updateGuideBadges() {
        const store = window.guidiaStore;
        if (!store) return;
        const messages = store.getMessages ? store.getMessages() : [];
        const unreadMsg = messages.filter(m => String(m.receiverId) === String(currentGuideId) && !m.isRead);
        const bChat = document.getElementById('badgeGuideChatUnread');
        if (bChat) {
          bChat.textContent = unreadMsg.length;
          bChat.style.display = unreadMsg.length > 0 ? 'inline-block' : 'none';
        }
      }

      function openChatWithCustomer(customerId) {
        currentChatPartnerId = parseInt(customerId) || customerId;
        const chatNav = document.querySelector('a[data-tab="tab-chat"]');
        if (chatNav) {
          chatNav.click();
        } else {
          document.querySelectorAll('.tab-content-panel').forEach(p => p.classList.remove('active'));
          const cp = document.getElementById('tab-chat');
          if (cp) cp.classList.add('active');
        }
        renderChatTab();
        renderActiveChatMessages();
      }

      // Đổ dữ liệu 15 HDV từ CSDL vào dropdown
      function populateGuideSwitcher(guides) {
        const switcher = document.getElementById('guideAccountSwitcher');
        if (!switcher || !guides || guides.length === 0) return;
        switcher.innerHTML = guides.map(g => {
          const isSelected = String(g.id) === String(currentGuideId) ? 'selected' : '';
          const statusLabel = g.status === 'suspended' ? ' [Bị khóa]' : (g.certStatus === 'approved' ? ' [Đã duyệt]' : ' [Chờ duyệt]');
          return `<option value="${g.id}" ${isSelected}>#${g.id} - ${g.name}${statusLabel}</option>`;
        }).join('');
      }

      // Chuyển đổi giữa các tài khoản HDV để xem dữ liệu từng người
      function switchGuideAccount(newGuideId) {
        currentGuideId = parseInt(newGuideId) || newGuideId;
        localStorage.setItem('guidia_current_guide_id_v2', currentGuideId);
        window.guidiaStore.setActiveGuideId(currentGuideId);
        const guide = window.guidiaStore.getGuides().find(g => String(g.id) === String(currentGuideId));
        if (guide) {
          sessionStorage.setItem('guidia_current_user', JSON.stringify({
            id: guide.id,
            name: guide.name,
            email: guide.email,
            phone: guide.phone,
            role: 'guide',
            avatar: guide.avatar,
            status: guide.status === 'suspended' ? 'suspended' : 'active'
          }));
        }

        checkCurrentGuideAccountStatus();
        renderAllGuidePortal();
        showToast(`Đã chuyển sang tài khoản HDV: ${getGuideDisplayName(currentGuideId)} (Dữ liệu CSDL SQL Server)`);
      }



      function getGuideDisplayName(id) {
        const g = window.guidiaStore.getGuides().find(item => String(item.id) === String(id));
        return g ? g.name : id;
      }



      // Kiểm tra và hiển thị thông tin tài khoản HDV hiện tại
      function checkCurrentGuideAccountStatus() {
        const store = window.guidiaStore;
        const allGuides = store.getGuides();
        let sessionUser = null;
        try {
          const s = sessionStorage.getItem('guidia_current_user') || localStorage.getItem('guidia_current_user');
          if (s) sessionUser = JSON.parse(s);
        } catch (e) { }

        const guide = allGuides.find(g => String(g.id) === String(currentGuideId)) || sessionUser || allGuides[0];
        const user = store.getUsers().find(u => String(u.id) === String(currentGuideId)) || guide;

        const alertBox = document.getElementById('accountStatusAlertBox');
        const badge = document.getElementById('currentGuideStatusBadge');
        const miniName = document.getElementById('guideNameMini');
        const miniRole = document.getElementById('guideRoleMini');
        const miniAvatar = document.getElementById('guideAvatarMini');
        const headerName = document.getElementById('guideHeaderName');
        const headerEmail = document.getElementById('guideHeaderEmail');
        const headerAvatar = document.getElementById('guideHeaderAvatar');

        if (guide) {
          if (miniName) miniName.textContent = guide.name;
          if (miniRole) miniRole.textContent = `${guide.certStatus === 'approved' ? 'HDV Đã Duyệt' : 'HDV Chờ Duyệt'}

 • ${guide.city || 'Việt Nam'}

`;
          if (miniAvatar) miniAvatar.src = guide.avatar || 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150';

          if (headerName) headerName.textContent = guide.name;
          if (headerEmail) headerEmail.textContent = guide.email || 'hdv@guidia.com';
          if (headerAvatar) headerAvatar.src = guide.avatar || 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=120';
        }



        if (miniName && guide) miniName.textContent = guide.name;
        if (miniRole && guide) miniRole.textContent = `${guide.certType ? guide.certType.replace('Thẻ Hướng Dẫn Viên Du Lịch ', '') : 'HDV'}

 • ${guide.city}

`;
        if (miniAvatar && user) miniAvatar.src = user.avatar;

        if (!alertBox || !guide) return;

        // Tài khoản bị khóa do vi phạm
        if (user && user.status === 'suspended') {
          alertBox.style.display = 'block';
          alertBox.className = 'account-status-banner suspended';
          alertBox.innerHTML = `
      <i data-lucide="shield-alert" class="gui-184"></i>
      <div>
        <strong>Tài khoản Hướng Dẫn Viên đang bị TẠM KHÓA</strong>
        <p class="gui-185">Lý do: "${user.banReason || 'Vi phạm tiêu chuẩn hoạt động'}

". Bạn hiện bị tạm ngưng nhận yêu cầu đặt tour mới và không thể giải ngân.</p>
      </div>
    `;
          if (badge) {
            badge.className = 'badge-tag-status status-suspended';
            badge.innerHTML = `<i data-lucide="slash" class="icon-xs"></i> Bị Tạm Khóa`;
          }


        }


        // Tài khoản HDV chưa được duyệt hồ sơ
        else if (guide.certStatus === 'pending' || (user && user.status === 'pending_approval')) {
          alertBox.style.display = 'block';
          alertBox.className = 'account-status-banner pending';
          alertBox.innerHTML = `
      <i data-lucide="clock" class="gui-186"></i>
      <div>
        <strong>Hồ sơ thẻ hành nghề đang CHỜ QUẢN TRỊ VIÊN DUYỆT</strong>
        <p class="gui-185">Thẻ hành nghề du lịch của bạn đang được Ban Quản trị đối chiếu thẩm định. Sau khi được phê duyệt, bạn sẽ nhận được thông báo và bắt đầu nhận tour.</p>
      </div>
    `;
          if (badge) {
            badge.className = 'badge-tag-status status-pending';
            badge.innerHTML = `<i data-lucide="clock" class="icon-xs"></i> Chờ Phê Duyệt`;
          }


        }

        else {
          alertBox.style.display = 'none';
          if (badge) {
            badge.className = 'badge-tag-status status-active';
            badge.innerHTML = `<i data-lucide="check-circle" class="icon-xs"></i> Đang Hoạt Động`;
          }


        }



        if (window.lucide) window.lucide.createIcons();
      }







      // Thiết lập chuyển Tab
      function setupPortalTabs() {
        const navLinks = document.querySelectorAll('.sidebar-nav .nav-link-item');
        const panels = document.querySelectorAll('.tab-content-panel');
        const pageTitle = document.getElementById('guidePageTitle') || document.getElementById('pageTitle');

        const titles = {
          'tab-requests': 'Quản Lý Yêu Cầu Đặt Lịch',
          'tab-trips': 'Chuyến Đi Của Tôi',
          'tab-schedule': 'Lịch Làm Việc & Nhận Khách',
          'tab-revenue': 'Quản Lý Doanh Thu & Thu Nhập',
          'tab-chat': 'Nhắn Tin & Tư Vấn Du Khách',
          'tab-reviews': 'Đánh Giá & Nhận Xét Của Khách',
          'tab-disputes': 'Xử Lý Khiếu Nại & Hỗ Trợ',
          'tab-profile': 'Thông Tin Cá Nhân & Chứng Chỉ'
        };

        const hashToTab = {
          '#requests': 'tab-requests',
          '#tab-requests': 'tab-requests',
          '#trips': 'tab-trips',
          '#tab-trips': 'tab-trips',
          '#schedule': 'tab-schedule',
          '#tab-schedule': 'tab-schedule',
          '#revenue': 'tab-revenue',
          '#tab-revenue': 'tab-revenue',
          '#chat': 'tab-chat',
          '#tab-chat': 'tab-chat',
          '#reviews': 'tab-reviews',
          '#tab-reviews': 'tab-reviews',
          '#disputes': 'tab-disputes',
          '#tab-disputes': 'tab-disputes',
          '#profile': 'tab-profile',
          '#tab-profile': 'tab-profile'
        };

        const tabToHash = {
          'tab-requests': '#requests',
          'tab-trips': '#trips',
          'tab-schedule': '#schedule',
          'tab-revenue': '#revenue',
          'tab-chat': '#chat',
          'tab-reviews': '#reviews',
          'tab-disputes': '#disputes',
          'tab-profile': '#profile'
        };

        function activateGuideTab(targetId, updateHash = true) {
          if (!targetId) targetId = 'tab-requests';
          navLinks.forEach(l => {
            if (l.getAttribute('data-tab') === targetId) {
              l.classList.add('active');
            } else {
              l.classList.remove('active');
            }
          });

          panels.forEach(p => {
            if (p.id === targetId) {
              p.classList.add('active');
            } else {
              p.classList.remove('active');
            }
          });

          // Đồng bộ trạng thái active trên thanh header nav
          document.querySelectorAll('.portal-header-nav .nav-item').forEach(hi => {
            if (hi.getAttribute('data-tab') === targetId) {
              hi.classList.add('active');
            } else {
              hi.classList.remove('active');
            }
          });

          if (pageTitle && titles[targetId]) {
            pageTitle.textContent = titles[targetId];
          }

          if (updateHash && tabToHash[targetId] && window.location.hash !== tabToHash[targetId]) {
            try {
              history.pushState(null, '', tabToHash[targetId]);
            } catch (e) {
              window.location.hash = tabToHash[targetId];
            }
          }

          try {
            if (targetId === 'tab-requests') renderRequestsTab();
            if (targetId === 'tab-trips') renderTripsTab();
            if (targetId === 'tab-schedule') renderScheduleCalendar();
            if (targetId === 'tab-revenue') renderRevenueTab();
            if (targetId === 'tab-chat') renderChatTab();
            if (targetId === 'tab-reviews') renderReviewsTab();
            if (targetId === 'tab-disputes') renderDisputesTab();
            if (targetId === 'tab-profile') renderProfileTab();
          } catch (err) {
            console.error('Lỗi khi render tab ' + targetId, err);
          }

          if (window.lucide) window.lucide.createIcons();
        }

        window.activateGuideTab = activateGuideTab;

        navLinks.forEach(link => {
          link.addEventListener('click', (e) => {
            e.preventDefault();
            const targetId = link.getAttribute('data-tab');
            activateGuideTab(targetId, true);
          });
        });

        // Lắng nghe sự kiện đổi URL hash
        window.addEventListener('hashchange', () => {
          const hash = window.location.hash;
          if (hash && hashToTab[hash]) {
            activateGuideTab(hashToTab[hash], false);
          }
        });

        // Tự động kích hoạt tab ban đầu theo URL hash nếu có
        const initialHash = window.location.hash;
        if (initialHash && hashToTab[initialHash]) {
          activateGuideTab(hashToTab[initialHash], false);
        }
      }



      function renderAllGuidePortal() {
        renderRequestsTab();
        renderTripsTab();
        renderScheduleCalendar();
        renderRevenueTab();
        renderChatTab();
        renderReviewsTab();
        renderDisputesTab();
        renderProfileTab();
        updateGuideBadges();
      }



      // =========================================================================
      // 1. QUẢN LÝ YÊU CẦU ĐẶT LỊCH 
      // =========================================================================
      function renderRequestsTab() {
        const store = window.guidiaStore;
        const trips = store.getTrips().filter(t => String(t.guideId) === String(currentGuideId));
        const pendingRequests = trips.filter(t => isGuideTripPending(t));

        const badge = document.getElementById('badgePendingCount');
        if (badge) {
          badge.textContent = pendingRequests.length;
          badge.style.display = pendingRequests.length > 0 ? 'inline-block' : 'none';
        }

        const container = document.getElementById('bookingRequestsContainer');
        if (!container) return;

        if (pendingRequests.length === 0) {
          container.innerHTML = `
      <div class="gui-187">
        <i data-lucide="check-circle-2" class="gui-188"></i>
        <h4 class="gui-189">Hiện không có yêu cầu nào đang chờ xử lý</h4>
        <p class="gui-190">Bạn đã phản hồi toàn bộ các yêu cầu thuê tour từ du khách!</p>
      </div>
    `;
        } else {
          container.innerHTML = pendingRequests.map(trip => {
            const expireMs = trip.expireAtMs || (trip.createdAt ? new Date(trip.createdAt).getTime() + 86400000 : Date.now() + 86400000);
            const payout = trip.guidePayout || Math.round((trip.totalAmount || 0) * 0.9);
            return `
      <div class="gui-191">
        <div class="gui-192">
          <div>
            <div class="gui-193">
              <span class="escrow-pill"><i data-lucide="shield-check" class="icon-xs"></i> Đã Ký Quỹ Escrow: ${(trip.totalAmount || 0).toLocaleString('vi-VN')}₫</span>
              <strong class="gui-194">Mã Đơn: ${trip.id}</strong>
            </div>
            <p class="gui-195">
              Khách du lịch: <strong>${trip.customerName || 'Du khách'}</strong> (SĐT: <strong>${trip.customerPhone || '0912345678'}</strong>)
            </p>
            <p class="gui-196">
              📍 Lộ trình tại Việt Nam: ${trip.location || 'Việt Nam'}
            </p>
            <p class="gui-197">
              🛫 <strong>Khởi hành:</strong> ${trip.startTime || '08:00'} ngày ${trip.startDate || 'Hôm nay'}
              &nbsp;•&nbsp; 🏁 <strong>Kết thúc:</strong> ${trip.endTime || '17:30'} ngày ${trip.endDate || trip.startDate || 'Hôm nay'}
              &nbsp;•&nbsp; 👥 <strong>Số lượng:</strong> <strong>${trip.guests || trip.groupSize || trip.number_of_guests || 2} khách</strong>
            </p>
          </div>

          <div class="gui-15">
            <div class="gui-199">Thù lao thực nhận (sau khi trừ phí sàn):</div>
            <div class="gui-200">
              ${payout.toLocaleString('vi-VN')}₫
            </div>
            
            <div class="action-btn-group gui-201">
              <span class="gui-202">
                <i data-lucide="timer" class="icon-xs"></i> Tự động từ chối & hoàn tiền sau 24h nếu không phản hồi
              </span>

              <button class="btn-sm-action" style="color:#0284c7; border-color:#bae6fd; background:#f0f9ff;" onclick="openChatWithCustomer('${trip.customerId}')" title="Nhắn tin với du khách">
                <i data-lucide="message-square"></i> Nhắn Tin
              </button>

              <button class="btn-sm-action btn-approve" onclick="handleAcceptBookingRequest('${trip.id}')" title="Khóa thời gian trong lịch và xác nhận tour">
                <i data-lucide="check"></i> Chấp Nhận 
              </button>
              
              <button class="btn-sm-action btn-reject" onclick="openRejectModal('${trip.id}')" title="Từ chối và hoàn 100% tiền tạm giữ cho khách">
                <i data-lucide="x"></i> Từ Chối 
              </button>
            </div>
          </div>
        </div>
      </div>
    `;
          }).join('');
        }

        if (window.lucide) window.lucide.createIcons();
      }



      function handleAcceptBookingRequest(tripId) {
        const store = window.guidiaStore;
        const trip = store.getTrips().find(t => t.id === tripId);
        const guideId = trip ? trip.guideId : currentGuideId;
        const guide = store.getGuides().find(g => String(g.id) === String(guideId));
        const cert = store.getCertificates().find(c => String(c.guideId) === String(guideId));
        const certStatus = (cert && cert.status) || (guide && guide.certStatus);

        // Khi HDV đang sửa thẻ và ở trạng thái Chờ duyệt thì không thể nhận thêm chuyến đi mới
        if (certStatus === 'pending') {
          showToast('Thẻ Hướng Dẫn Viên của bạn đang trong trạng thái Chờ Quản trị viên duyệt lại nên tạm thời không thể nhận thêm chuyến đi mới. Các chuyến đi hiện có vẫn tiếp tục đi bình thường!', 'warning');
          return;
        }

        // Kiểm tra tài khoản ngân hàng của HDV trước khi nhận tour
        if (!guide || !guide.bankAccount || !guide.bankAccount.trim() || !guide.bankName || !guide.bankName.trim()) {
          showToast('Vui lòng Cung cấp thông tin tài khoản ngân hàng', 'warning');
          const profileTabBtn = document.querySelector('[data-tab="tab-profile"]');
          if (profileTabBtn) profileTabBtn.click();
          setTimeout(() => {
            const bankInput = document.getElementById('profGuideBankName');
            if (bankInput) {
              bankInput.focus();
              bankInput.scrollIntoView({ behavior: 'smooth', block: 'center' }

              );
            }


          }

            , 200);
          return;
        }



        const res = store.respondToBookingRequest(tripId, true);
        if (res.success) {
          showToast(res.message, 'success');
          renderRequestsTab();
          renderTripsTab();
          renderScheduleCalendar();
          renderRevenueTab();

          // UC06 Bước 10: Tự động chuyển ngay sang tab "Quản Lý Chuyến Đi" và làm nổi bật chuyến đi vừa xác nhận
          setTimeout(() => {
            const tripsTabBtn = document.querySelector('.sidebar-nav .nav-link-item[data-tab="tab-trips"]');
            if (tripsTabBtn) {
              tripsTabBtn.click();
              setTimeout(() => {
                const tripCard = document.querySelector(`[data-trip-id="${tripId}"]`) || document.getElementById(`guide-trip-${tripId}`);
                if (tripCard) {
                  tripCard.scrollIntoView({ behavior: 'smooth', block: 'center' });
                  tripCard.style.outline = '3px solid #10b981';
                  tripCard.style.boxShadow = '0 0 15px rgba(16, 185, 129, 0.4)';
                  tripCard.style.borderRadius = '12px';
                  tripCard.style.transition = 'all 0.4s ease';
                  setTimeout(() => {
                    tripCard.style.outline = '';
                    tripCard.style.boxShadow = '';
                  }, 4000);
                }
              }, 300);
            }
          }, 250);
        }

        else {
          showToast(res.message, res.requireBank ? 'warning' : 'error');
          if (res.requireBank) {
            const profileTabBtn = document.querySelector('[data-tab="tab-profile"]');
            if (profileTabBtn) profileTabBtn.click();
            setTimeout(() => {
              const bankInput = document.getElementById('profGuideBankName');
              if (bankInput) {
                bankInput.focus();
                bankInput.scrollIntoView({ behavior: 'smooth', block: 'center' }

                );
              }


            }

              , 200);
          }


        }


      }



      function openRejectModal(tripId) {
        const modal = document.getElementById('rejectBookingModal');
        const inputId = document.getElementById('rejectTripId');
        const reasonText = document.getElementById('rejectReasonText');
        if (modal && inputId) {
          inputId.value = tripId;
          if (reasonText) reasonText.value = '';
          modal.style.display = 'flex';
        }


      }



      function closeRejectModal() {
        const modal = document.getElementById('rejectBookingModal');
        if (modal) modal.style.display = 'none';
      }



      function confirmRejectBooking() {
        const tripId = document.getElementById('rejectTripId').value;
        const reason = document.getElementById('rejectReasonText').value;

        if (!reason || !reason.trim()) {
          showToast('Vui lòng nhập lý do từ chối !', 'error');
          return;
        }



        const res = window.guidiaStore.respondToBookingRequest(tripId, false, reason);
        if (res.success) {
          closeRejectModal();
          showToast(res.message, 'success');
          renderRequestsTab();
          renderTripsTab();
          renderRevenueTab();
        }

        else {
          showToast(res.message, 'error');
        }


      }



      function handleAutoExpireRequest(tripId) {
        const res = window.guidiaStore.autoExpireBookingRequest(tripId);
        if (res.success) {
          showToast(res.message);
          renderRequestsTab();
          renderTripsTab();
          renderRevenueTab();
        }


      }



      // =========================================================================
      // 2. QUẢN LÝ CHUYẾN ĐI TẠI VIỆT NAM (UC07: Sắp đi, Đang đi, Đã đi, Đã hủy)
      // =========================================================================
      function getTripCategory(trip) {
        const normStatus = (trip.status || trip.dbStatus || '').toLowerCase().trim();
        // 1. Đã Hủy
        if (normStatus === 'cancelled_refunded' || normStatus === 'cancelled' || normStatus === 'đã_hủy' || normStatus === 'đã hủy' || normStatus === 'rejected') {
          return 'cancelled';
        }
        // 2. Đã Đi (Hoàn thành)
        if (normStatus === 'finished_paid' || normStatus === 'completed' || normStatus === 'finished' || normStatus === 'đã_hoàn_thành' || normStatus === 'đã hoàn thành' || trip.paymentStatus === 'paid_to_guide') {
          return 'completed';
        }
        // 3. Đang Đi:
        const todayStr = new Date().toISOString().split('T')[0];
        const sDate = String(trip.startDate || '').substring(0, 10).trim();
        const isTourDateReached = Boolean(sDate && sDate <= todayStr);
        const isOngoing = trip.isOngoing || normStatus === 'ongoing' || normStatus === 'in_progress' || normStatus === 'đang_đi' || normStatus === 'đang đi' || normStatus === 'completed_pending_payout' || Boolean(trip.guideCompleted || trip.customerCompleted) || ((normStatus === 'confirmed_upcoming' || normStatus === 'confirmed' || normStatus === 'đã_xác_nhận') && isTourDateReached);
        if (isOngoing) {
          return 'ongoing';
        }
        // 4. Sắp Đi
        return 'upcoming';
      }

      function handleGuideStartTrip(tripId) {
        const res = window.guidiaStore.startTripTour(tripId);
        if (res.success) {
          showToast(res.message, 'success');
          renderTripsTab();
        } else {
          showToast(res.message, 'error');
        }
      }

      function filterTripsTab(filter) {
        activeTripFilter = filter;
        document.querySelectorAll('.trip-filter-btn').forEach(btn => {
          btn.classList.toggle('active', btn.getAttribute('data-filter') === filter);
        });
        renderTripsTab();
      }

      function renderTripsTab() {
        const store = window.guidiaStore;
        // ĐẶC TẢ UC07: Chỉ hiển thị các chuyến đi đã được HDV xác nhận trở đi
        let trips = store.getTrips().filter(t =>
          String(t.guideId) === String(currentGuideId) &&
          !isGuideTripPending(t)
        );

        if (activeTripFilter !== 'all') {
          trips = trips.filter(t => {
            const cat = getTripCategory(t);
            if (activeTripFilter === 'upcoming') return cat === 'upcoming';
            if (activeTripFilter === 'ongoing') return cat === 'ongoing';
            if (activeTripFilter === 'completed') return cat === 'completed';
            if (activeTripFilter === 'cancelled') return cat === 'cancelled';
            return t.status === activeTripFilter || cat === activeTripFilter;
          });
        }

        const container = document.getElementById('tripsListContainer');
        if (!container) return;

        if (trips.length === 0) {
          container.innerHTML = `
      <div class="gui-203">
        Không có chuyến đi nào trong danh mục này.
      </div>
    `;
          return;
        }

        const disputes = store.getDisputes();
        const todayStr = new Date().toISOString().split('T')[0];

        container.innerHTML = trips.map(trip => {
          const relDispute = disputes.find(d =>
            String(d.tripId) === String(trip.id) ||
            (trip.dbBookingId && String(d.bookingId) === String(trip.dbBookingId)) ||
            (d.bookingCode && d.bookingCode === trip.id)
          );

          // Đồng bộ chặt chẽ với tình trạng khiếu nại
          let isDisputeResolved = false;
          let isDisputeRefund = false;
          if (relDispute) {
            const hasDecision = (relDispute.adminDecision && relDispute.adminDecision.trim().length > 0) || (relDispute.adminNote && relDispute.adminNote.trim().length > 0);
            isDisputeResolved = (
              relDispute.status === 'resolved_refund' ||
              relDispute.status === 'rejected_to_guide' ||
              relDispute.status === 'resolved' ||
              relDispute.dbStatus === 'APPROVED_REFUND' ||
              relDispute.dbStatus === 'REJECTED' ||
              hasDecision
            );
            isDisputeRefund = (relDispute.status === 'resolved_refund' || relDispute.dbStatus === 'APPROVED_REFUND');
          }

          const isOngoingDispute = Boolean(trip.isDisputed && !isDisputeResolved);
          const category = getTripCategory(trip);

          // Badge trạng thái chuẩn 4 trạng thái UC07
          let statusBadgeHtml = '';
          if (isOngoingDispute) {
            statusBadgeHtml = '<span class="status-badge gui-216"><i data-lucide="shield-alert" class="icon-xs"></i> Đang Có Khiếu Nại</span>';
          } else if (isDisputeResolved) {
            statusBadgeHtml = isDisputeRefund
              ? '<span class="status-badge badge-cancelled gui-204"><i data-lucide="rotate-ccw" class="icon-xs"></i> Đã Hủy & Hoàn Tiền 100% (Khiếu Nại Đã Giải Quyết)</span>'
              : '<span class="status-badge badge-paid gui-205"><i data-lucide="check" class="icon-xs"></i> Đã Đi & Tất Toán (Khiếu Nại Đã Bác Bỏ)</span>';
          } else if (category === 'cancelled') {
            statusBadgeHtml = '<span class="status-badge badge-cancelled" style="background:#fee2e2; color:#b91c1c; border:1px solid #fca5a5; font-weight:700;"><i data-lucide="x-circle" class="icon-xs"></i> Đã Hủy</span>';
          } else if (category === 'completed') {
            statusBadgeHtml = '<span class="status-badge badge-paid" style="background:#dcfce7; color:#15803d; border:1px solid #86efac; font-weight:700;"><i data-lucide="check-check" class="icon-xs"></i> Đã Đi (Hoàn Thành & Tất Toán)</span>';
          } else if (category === 'ongoing') {
            statusBadgeHtml = '<span class="status-badge badge-ongoing" style="background:#e0f2fe; color:#0369a1; border:1px solid #7dd3fc; font-weight:700;"><i data-lucide="compass" class="icon-xs"></i> Đang Đi</span>';
          } else {
            statusBadgeHtml = '<span class="status-badge badge-upcoming" style="background:#fef3c7; color:#92400e; border:1px solid #fcd34d; font-weight:700;"><i data-lucide="calendar" class="icon-xs"></i> Sắp Đi</span>';
          }

          const guestCount = trip.guests || trip.groupSize || trip.number_of_guests || 2;
          const displayCancelReason = trip.cancelReason || (isDisputeResolved && isDisputeRefund ? 'Khiếu nại được giải quyết: Hoàn tiền 100% cho du khách' : '');

          // Dòng thông báo tiến trình cho mục Đang Đi
          let ongoingNoticeHtml = '';
          if (category === 'ongoing') {
            if (trip.guideCompleted && !trip.customerCompleted) {
              ongoingNoticeHtml = `
          <div style="margin:6px 0; font-size:0.8rem; background:#eff6ff; color:#1d4ed8; border:1px solid #bfdbfe; padding:4px 10px; border-radius:6px; font-weight:600; display:inline-flex; align-items:center; gap:6px;">
            <i data-lucide="clock" class="icon-xs"></i> Đang đi: Bạn đã xác nhận kết thúc (Đang chờ Khách du lịch xác nhận hoặc tự động tất toán sau 24h)
          </div>
        `;
            } else if (!trip.guideCompleted && trip.customerCompleted) {
              ongoingNoticeHtml = `
          <div style="margin:6px 0; font-size:0.8rem; background:#fef3c7; color:#92400e; border:1px solid #fcd34d; padding:4px 10px; border-radius:6px; font-weight:600; display:inline-flex; align-items:center; gap:6px;">
            <i data-lucide="bell" class="icon-xs"></i> Đang đi: Khách du lịch đã xác nhận kết thúc! Vui lòng chọn "Xác Nhận Kết Thúc Chuyến Đi" bên dưới để nhận tất toán thù lao.
          </div>
        `;
            } else {
              ongoingNoticeHtml = `
          <div style="margin:6px 0; font-size:0.8rem; background:#f0fdf4; color:#166534; border:1px solid #86efac; padding:4px 10px; border-radius:6px; font-weight:600; display:inline-flex; align-items:center; gap:6px;">
            <i data-lucide="compass" class="icon-xs"></i> Tour đang diễn ra theo lịch trình. Khi kết thúc hãy bấm "Xác Nhận Kết Thúc Chuyến Đi".
          </div>
        `;
            }
          } else if (category === 'upcoming') {
            ongoingNoticeHtml = `
        <div style="margin:6px 0; font-size:0.8rem; color:#475569; display:inline-flex; align-items:center; gap:6px;">
          <i data-lucide="calendar" class="icon-xs" style="color:#0284c7;"></i> Chuyến đi sắp khởi hành lúc ${trip.startTime || '08:00'} ngày ${trip.startDate}. (Chưa diễn ra — Nút xác nhận kết thúc chỉ mở khi đến hoặc sau ngày đi).
        </div>
      `;
          }

          // Các nút hành động chuẩn theo từng trạng thái
          let actionButtonsHtml = '';
          if (category === 'upcoming') {
            actionButtonsHtml = `
        <span style="font-size:0.8rem; background:#f1f5f9; color:#475569; border:1px solid #cbd5e1; padding:4px 10px; border-radius:6px; font-weight:600; display:inline-flex; align-items:center; gap:5px;">
          <i data-lucide="calendar-clock" class="icon-xs" style="color:#0284c7;"></i> Chưa đến ngày đi (${trip.startDate})
        </span>
        <button class="btn-sm-action" style="color:#0284c7; border-color:#bae6fd; background:#f0f9ff;" onclick="openChatWithCustomer('${trip.customerId}')" title="Nhắn tin với du khách">
          <i data-lucide="message-square" class="icon-xs"></i> Nhắn Tin
        </button>
        <button class="btn-sm-action btn-reject" onclick="openCancelTripModal('${trip.id}')" title="Hủy tour (Khung nhập lý do & Tuân thủ quy định trước 48h)">
          <i data-lucide="x-circle"></i> Hủy Chuyến
        </button>
        <button class="btn-sm-action btn-neutral" onclick="quickDisputeTrip('${trip.id}')" title="Gửi khiếu nại nếu phát sinh sự cố">
          <i data-lucide="alert-triangle"></i> Khiếu Nại Sự Cố
        </button>
      `;
          } else if (category === 'ongoing') {
            if (!trip.guideCompleted) {
              actionButtonsHtml = `
          <button class="btn-sm-action" style="color:#0284c7; border-color:#bae6fd; background:#f0f9ff;" onclick="openChatWithCustomer('${trip.customerId}')" title="Nhắn tin với du khách">
            <i data-lucide="message-square" class="icon-xs"></i> Nhắn Tin
          </button>
          <button class="btn-sm-action btn-approve" style="background:#059669; color:#ffffff; font-weight:700;" onclick="handleGuideCompleteTrip('${trip.id}')" title="Xác nhận tour đã hoàn thành theo lịch trình">
            <i data-lucide="check-check"></i> Xác Nhận Kết Thúc Chuyến Đi
          </button>
          <button class="btn-sm-action btn-neutral" onclick="quickDisputeTrip('${trip.id}')" title="Gửi khiếu nại nếu có sự cố">
            <i data-lucide="alert-triangle"></i> Khiếu Nại Sự Cố
          </button>
        `;
            } else {
              actionButtonsHtml = `
          <button class="btn-sm-action" style="color:#0284c7; border-color:#bae6fd; background:#f0f9ff;" onclick="openChatWithCustomer('${trip.customerId}')" title="Nhắn tin với du khách">
            <i data-lucide="message-square" class="icon-xs"></i> Nhắn Tin
          </button>
          <span style="font-size:0.8rem; background:#eff6ff; color:#1d4ed8; border:1px solid #bfdbfe; padding:4px 10px; border-radius:6px; font-weight:700; display:inline-flex; align-items:center; gap:4px;">
            <i data-lucide="check" class="icon-xs"></i> Bạn đã xác nhận kết thúc
          </span>
          <button class="btn-sm-action" style="font-size:0.75rem; background:#f8fafc; border:1px solid #cbd5e1; color:#475569;" onclick="window.guidiaStore.simulateFastForward(24); renderTripsTab(); renderRevenueTab();" title="Giả lập sau 1 ngày KDL không xác nhận để tự động tất toán">
            <i data-lucide="fast-forward" class="icon-xs"></i> Tua Nhanh 24h (Tự Động Tất Toán)
          </button>
          <button class="btn-sm-action btn-neutral" onclick="quickDisputeTrip('${trip.id}')" title="Gửi khiếu nại nếu có sự cố">
            <i data-lucide="alert-triangle"></i> Khiếu Nại Sự Cố
          </button>
        `;
            }
          } else if (category === 'completed') {
            actionButtonsHtml = `
        <button class="btn-sm-action" style="color:#0284c7; border-color:#bae6fd; background:#f0f9ff;" onclick="openChatWithCustomer('${trip.customerId}')" title="Nhắn tin với du khách">
          <i data-lucide="message-square" class="icon-xs"></i> Nhắn Tin
        </button>
        <span style="font-size:0.82rem; color:#15803d; font-weight:700; display:inline-flex; align-items:center; gap:4px;">
          <i data-lucide="check-check" class="icon-xs"></i> Đã hoàn thành & tất toán thù lao
        </span>
        <button class="btn-sm-action" onclick="switchGuideTab('tab-reviews')" title="Xem đánh giá của khách">
          <i data-lucide="star" class="icon-xs"></i> Xem Đánh Giá
        </button>
      `;
          } else {
            actionButtonsHtml = `
        <span style="font-size:0.82rem; color:#b91c1c; display:inline-flex; align-items:center; gap:4px;">
          <i data-lucide="x" class="icon-xs"></i> Đã hủy tour & hoàn 100% tiền tạm giữ cho khách
        </span>
      `;
          }

          return `
      <div class="gui-206" data-trip-id="${trip.id}" id="guide-trip-${trip.id}">
        <div class="gui-192">
          <div>
            <div class="gui-207">
              <strong class="gui-208">${trip.id}</strong>
              ${statusBadgeHtml}
              ${isOngoingDispute ? '<span class="dispute-held-tag gui-209"><i data-lucide="shield-alert" class="icon-xs"></i> Tiền đang giữ do khiếu nại</span>' : ''}
              ${isDisputeResolved && isDisputeRefund ? '<span class="status-badge gui-210"><i data-lucide="check-circle" class="icon-xs"></i> Đã hoàn tiền cho khách</span>' : ''}
            </div>

            ${ongoingNoticeHtml}

            <p class="gui-195">
              Khách du lịch: <strong>${trip.customerName || 'Du khách'}</strong> • SĐT: <strong>${trip.customerPhone || '0980000001'}</strong>
            </p>
            <p class="gui-196">
              📍 Lộ trình: ${trip.location}
            </p>
            <p class="gui-197">
              🛫 <strong>Khởi hành:</strong> ${trip.startTime || '08:00'} ngày ${trip.startDate}
              &nbsp;•&nbsp; 🏁 <strong>Kết thúc:</strong> ${trip.endTime || '17:30'} ngày ${trip.endDate || trip.startDate}
              &nbsp;•&nbsp; 👥 <strong>Quy mô:</strong> <strong>${guestCount} khách</strong>
            </p>
            ${displayCancelReason ? `<p class="gui-212">Lý do hủy: ${displayCancelReason}</p>` : ''}
          </div>

          <div class="gui-15">
            <div class="gui-199">Tổng thu / Thực nhận:</div>
            <div class="gui-213">
              ${(trip.totalAmount || 0).toLocaleString('vi-VN')}₫ <span class="gui-214">(Thực nhận: ${(trip.guidePayout || Math.round((trip.totalAmount || 0) * 0.9)).toLocaleString('vi-VN')}₫)</span>
            </div>

            <div class="action-btn-group gui-201">
              ${actionButtonsHtml}
            </div>
          </div>
        </div>
      </div>
    `;
        }).join('');

        if (window.lucide) window.lucide.createIcons();
      }



      function getTripStatusInfo(status, paymentStatus, isDisputed) {
        const normStatus = (status || '').toLowerCase();
        if (isDisputed || normStatus === 'disputed' || normStatus === 'disputed_frozen') {
          return { badgeHtml: '<span class="status-badge gui-216"><i data-lucide="alert-triangle" class="icon-xs"></i> Đang Có Khiếu Nại</span>' }

            ;
        }


        if (normStatus === 'finished_paid' || paymentStatus === 'paid_to_guide' || normStatus === 'completed') {
          return { badgeHtml: '<span class="status-badge badge-paid"><i data-lucide="check" class="icon-xs"></i> Đã Hoàn Thành & Tất Toán</span>' }

            ;
        }


        if (normStatus === 'completed_pending_payout') {
          return { badgeHtml: '<span class="status-badge badge-pending-payout"><i data-lucide="hourglass" class="icon-xs"></i> Chờ 24h Tự Động Tất Toán </span>' }

            ;
        }


        if (normStatus === 'confirmed_upcoming' || normStatus === 'confirmed') {
          return { badgeHtml: '<span class="status-badge badge-upcoming"><i data-lucide="calendar" class="icon-xs"></i> Đã Xác Nhận (Ký Quỹ Escrow)</span>' }

            ;
        }


        if (normStatus === 'pending_guide' || normStatus === 'pending_guide_confirm' || normStatus === 'pending') {
          return { badgeHtml: '<span class="status-badge badge-pending-guide"><i data-lucide="bell" class="icon-xs"></i> Chờ Bạn Xác Nhận</span>' }

            ;
        }


        if (normStatus === 'cancelled_refunded' || normStatus === 'cancelled') {
          return { badgeHtml: '<span class="status-badge badge-cancelled"><i data-lucide="x" class="icon-xs"></i> Đã Hủy & Hoàn Tiền 100%</span>' }

            ;
        }


        return { badgeHtml: `<span class="status-badge badge-upcoming"><i data-lucide="calendar" class="icon-xs"></i> Sắp Khởi Hành</span>` }

          ;
      }



      function handleGuideCompleteTrip(tripId) {
        const store = window.guidiaStore;
        const trip = store.getTrips().find(t => t.id === tripId);
        if (trip) {
          const todayStr = new Date().toISOString().split('T')[0];
          const sDate = String(trip.startDate || '').substring(0, 10).trim();
          if (sDate && sDate > todayStr) {
            showToast('Chuyến đi chưa diễn ra! Ngày khởi hành là ' + trip.startDate + ' (hôm nay mới là ' + todayStr.split('-').reverse().join('/') + '). Bạn chỉ có thể xác nhận kết thúc sau khi chuyến đi đã bắt đầu!', 'warning');
            return;
          }
        }

        const res = window.guidiaStore.guideConfirmComplete(tripId);
        showToast(res.message, res.success ? 'success' : 'error');
        renderTripsTab();
        renderRevenueTab();
      }



      function openCancelTripModal(tripId) {
        const store = window.guidiaStore;
        const trip = store.getTrips().find(t => t.id === tripId);
        if (!trip) {
          showToast('Không tìm thấy thông tin chuyến đi!', 'error');
          return;
        }

        // Ràng buộc quy định hủy chuyến: phải trước ít nhất 2 ngày
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        const tourDate = new Date(trip.startDate);
        tourDate.setHours(0, 0, 0, 0);
        const diffDays = Math.round((tourDate.getTime() - today.getTime()) / (1000 * 3600 * 24));
        if (diffDays < 2) {
          showToast('Chính sách hủy tour: Hướng dẫn viên chỉ có thể hủy chuyến trước ngày khởi hành tối thiểu 2 ngày! Hiện không thể hủy chuyến này.', 'error');
          return;
        }



        const modal = document.getElementById('cancelTripByGuideModal');
        const inputId = document.getElementById('cancelTripIdInput');
        const inputReason = document.getElementById('cancelTripReasonInput');
        const summaryBox = document.getElementById('cancelTripSummaryCard');

        if (inputId) inputId.value = trip.id;
        if (inputReason) {
          inputReason.value = '';
          setTimeout(() => inputReason.focus(), 150);
        }


        if (summaryBox) {
          summaryBox.innerHTML = `
      <div class="gui-219">Chuyến đi: ${trip.id}

 - ${trip.location}

</div>
      <div class="gui-220">
        Khách hàng: <strong>${trip.customerName}

</strong> (${trip.customerPhone || 'N/A'}

) • Ngày đi: <strong>${trip.startDate}

</strong> • Giá trị: <strong>${trip.totalAmount.toLocaleString('vi-VN')}

₫</strong>
      </div>
    `;
        }


        if (modal) {
          modal.style.display = 'flex';
          if (window.lucide) window.lucide.createIcons();
        }


      }



      function closeCancelTripModal() {
        const modal = document.getElementById('cancelTripByGuideModal');
        if (modal) modal.style.display = 'none';
      }



      function confirmCancelTripByGuide() {
        const tripId = document.getElementById('cancelTripIdInput')?.value;
        const reason = document.getElementById('cancelTripReasonInput')?.value?.trim();

        if (!tripId) {
          showToast('Lỗi: Không xác định được mã chuyến!', 'error');
          return;
        }


        if (!reason) {
          showToast('Vui lòng nhập lý do bạn muốn hủy chuyến đi này!', 'error');
          document.getElementById('cancelTripReasonInput')?.focus();
          return;
        }



        const res = window.guidiaStore.cancelTrip(tripId, 'guide', reason);
        if (res.success) {
          closeCancelTripModal();
          showToast(res.message, 'success');
          renderTripsTab();
          renderScheduleCalendar();
          renderRevenueTab();
        }

        else {

          showToast(`${res.message}

`, 'error');
        }


      }



      function handleGuideCancelTrip(tripId) {
        openCancelTripModal(tripId);
      }



      function quickDisputeTrip(tripId) {
        const link = document.querySelector('a[data-tab="tab-disputes"]');
        if (link) link.click();
        const select = document.getElementById('disputeTripSelect');
        if (select) select.value = tripId;
      }



      // =========================================================================
      // 3. QUẢN LÝ LỊCH LÀM VIỆC 
      // =========================================================================
      let currentScheduleMonth = 11;
      let currentScheduleYear = 2026;

      function onScheduleFilterChange() {
        const mSelect = document.getElementById('scheduleMonthSelect');
        const ySelect = document.getElementById('scheduleYearSelect');
        if (mSelect) currentScheduleMonth = parseInt(mSelect.value) || 11;
        if (ySelect) currentScheduleYear = parseInt(ySelect.value) || 2026;
        renderScheduleCalendar();
      }



      function changeScheduleMonth(delta) {
        currentScheduleMonth += delta;
        if (currentScheduleMonth > 12) {
          currentScheduleMonth = 1;
          currentScheduleYear++;
        }

        else if (currentScheduleMonth < 1) {
          currentScheduleMonth = 12;
          currentScheduleYear--;
        }


        const mSelect = document.getElementById('scheduleMonthSelect');
        const ySelect = document.getElementById('scheduleYearSelect');
        if (mSelect) mSelect.value = currentScheduleMonth;
        if (ySelect) ySelect.value = currentScheduleYear;
        renderScheduleCalendar();
      }



      function resetScheduleToToday() {
        const now = new Date();
        currentScheduleMonth = now.getMonth() + 1;
        currentScheduleYear = now.getFullYear();
        const mSelect = document.getElementById('scheduleMonthSelect');
        const ySelect = document.getElementById('scheduleYearSelect');
        if (mSelect) mSelect.value = currentScheduleMonth;
        if (ySelect) ySelect.value = currentScheduleYear;
        renderScheduleCalendar();
      }



      // =========================================================================
      // 3. QUẢN LÝ LỊCH LÀM VIỆC & NHẬN KHÁCH (USE CASE QUẢN LÝ LỊCH LÀM VIỆC HDV)
      // =========================================================================
      let isScheduleEditMode = false;
      let pendingBlockedDates = []; // Danh sách ngày bận tạm thời trong chế độ sửa
      let originalBlockedDates = []; // Danh sách ngày bận ban đầu để hoàn tác khi bấm Hủy
      let selectedScheduleDates = []; // Mảng các ngày 'YYYY-MM-DD' đã thay đổi trong phiên sửa này

      // Helper chuẩn hóa kiểm tra trạng thái và ngày tour cho Lịch làm việc (UC11 & UC06)
      function isGuideTripConfirmed(t) {
        if (!t) return false;
        const st = (t.status || t.dbStatus || '').toLowerCase().trim();
        return st === 'confirmed' || st === 'confirmed_upcoming' || st === 'đã_xác_nhận' || st === 'đã xác nhận' || st === 'ongoing' || st === 'in_progress' || st === 'đang_đi' || st === 'finished_paid' || st === 'completed' || st === 'đã_hoàn_thành' || st === 'đã hoàn thành';
      }

      function isGuideTripPending(t) {
        if (!t) return false;
        const st = (t.status || t.dbStatus || '').toLowerCase().trim();
        return st === 'pending' || st === 'pending_guide' || st === 'pending_guide_confirm' || st === 'chờ_xác_nhận' || st === 'chờ xác nhận';
      }

      function doesGuideTripCoverDate(t, dateStr) {
        if (!t || !t.startDate) return false;
        const sDate = String(t.startDate).substring(0, 10).trim();
        const eDate = String(t.endDate || t.startDate).substring(0, 10).trim();
        return (sDate <= dateStr && eDate >= dateStr);
      }

      function renderScheduleCalendar() {
        const grid = document.getElementById('guideCalendarGrid');
        if (!grid) return;

        const heading = document.getElementById('scheduleCalendarHeading');
        if (heading) {
          heading.textContent = 'Lịch Làm Việc Tháng ' + currentScheduleMonth + '/' + currentScheduleYear;
        }

        const mSelect = document.getElementById('scheduleMonthSelect');
        const ySelect = document.getElementById('scheduleYearSelect');
        if (mSelect && parseInt(mSelect.value) !== currentScheduleMonth) mSelect.value = currentScheduleMonth;
        if (ySelect && parseInt(ySelect.value) !== currentScheduleYear) ySelect.value = currentScheduleYear;

        const store = window.guidiaStore;
        const guide = store.getGuides().find(g => String(g.id) === String(currentGuideId)) || store.getGuides()[0];
        const trips = store.getTrips().filter(t => String(t.guideId) === String(currentGuideId));
        const blockedDates = isScheduleEditMode ? pendingBlockedDates : ((guide && guide.blockedDates) || []);

        const totalDays = new Date(currentScheduleYear, currentScheduleMonth, 0).getDate();
        const monthStr = currentScheduleMonth < 10 ? '0' + currentScheduleMonth : '' + currentScheduleMonth;

        // Tính toán thống kê chính xác số ngày trong tháng (bước 2)
        let confirmedDaysCount = 0;
        let pendingDaysCount = 0;
        let blockedDaysCount = 0;
        let availableDaysCount = 0;

        for (let d = 1; d <= totalDays; d++) {
          const dayStr = d < 10 ? '0' + d : '' + d;
          const dateStr = currentScheduleYear + '-' + monthStr + '-' + dayStr;

          const conf = trips.find(t => doesGuideTripCoverDate(t, dateStr) && isGuideTripConfirmed(t));
          const pend = trips.find(t => doesGuideTripCoverDate(t, dateStr) && isGuideTripPending(t));
          const isBlk = blockedDates.includes(dateStr);

          if (conf) confirmedDaysCount++;
          else if (pend) pendingDaysCount++;
          else if (isBlk) blockedDaysCount++;
          else availableDaysCount++;
        }

        // Cập nhật các thẻ thống kê tổng quan
        const elStatConf = document.getElementById('statConfirmedDays');
        const elStatPend = document.getElementById('statPendingDays');
        const elStatBlk = document.getElementById('statBlockedDays');
        const elStatAvail = document.getElementById('statAvailableDays');
        if (elStatConf) elStatConf.textContent = confirmedDaysCount + ' ngày';
        if (elStatPend) elStatPend.textContent = pendingDaysCount + ' ngày';
        if (elStatBlk) elStatBlk.textContent = blockedDaysCount + ' ngày';
        if (elStatAvail) elStatAvail.textContent = availableDaysCount + ' ngày';

        // Điều khiển hiển thị Toolbar Chỉnh sửa lịch (Bước 3 & 4)
        const editToolbar = document.getElementById('scheduleEditToolbar');
        const btnStartEdit = document.getElementById('btnStartEditSchedule');
        const subHeading = document.getElementById('scheduleCalendarSub');

        if (isScheduleEditMode) {
          if (editToolbar) editToolbar.style.display = 'block';
          if (btnStartEdit) btnStartEdit.style.display = 'none';
          if (subHeading) subHeading.textContent = 'Đang ở chế độ chỉnh sửa: Nhấp vào các ô ngày trên lịch để đổi trạng thái BẬN / RẢNH, sau đó nhấn "Lưu Lịch Làm Việc".';

          const selCountEl = document.getElementById('selectedScheduleCount');
          const selListEl = document.getElementById('selectedScheduleDatesList');
          if (selCountEl) selCountEl.textContent = selectedScheduleDates.length;
          if (selListEl) {
            selListEl.textContent = selectedScheduleDates.length > 0
              ? ('Đã thay đổi: ' + selectedScheduleDates.sort().join(', '))
              : '(Chạm vào các ô ngày trên bảng lịch để đổi trạng thái BẬN / RẢNH)';
          }
        } else {
          if (editToolbar) editToolbar.style.display = 'none';
          if (btnStartEdit) btnStartEdit.style.display = 'inline-flex';
          if (subHeading) subHeading.textContent = 'Phân biệt thời gian có chuyến đã xác nhận, chờ xác nhận, thời gian bận và thời gian rảnh. Bấm "Chỉnh Sửa " để thay đổi.';
        }

        // Render lưới lịch tháng
        const weekdays = ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'];
        let html = weekdays.map(day => '<div class="calendar-day-header">' + day + '</div>').join('');

        const firstDayOfWeek = new Date(currentScheduleYear, currentScheduleMonth - 1, 1).getDay();
        for (let b = 0; b < firstDayOfWeek; b++) {
          html += '<div class="calendar-day-cell gui-221" style="background:#f8fafc; border-color:#f1f5f9; cursor:default;"></div>';
        }

        for (let d = 1; d <= totalDays; d++) {
          const dayStr = d < 10 ? '0' + d : '' + d;
          const dateStr = currentScheduleYear + '-' + monthStr + '-' + dayStr;

          const confirmedTrip = trips.find(t => doesGuideTripCoverDate(t, dateStr) && isGuideTripConfirmed(t));
          const pendingTrip = trips.find(t => doesGuideTripCoverDate(t, dateStr) && isGuideTripPending(t));

          const isBlocked = blockedDates.includes(dateStr);
          const isSelectedInEdit = isScheduleEditMode && selectedScheduleDates.includes(dateStr);

          let cellClass = '';
          let tagHtml = '';
          let tooltipTitle = dateStr;

          if (confirmedTrip) {
            cellClass = 'status-confirmed';
            tagHtml = '<span class="day-tag tag-confirmed" style="background:#dbeafe; color:#1e40af; border:1px solid #93c5fd;"><i data-lucide="check-circle-2" class="icon-xs"></i> Có Chuyến: ' + confirmedTrip.id + '</span>'
              + '<div style="font-size:0.7rem; color:#1e3a8a; margin-top:2px; font-weight:600; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" title="' + (confirmedTrip.location || '') + '">' + (confirmedTrip.location ? (confirmedTrip.location.substring(0, 18) + '...') : 'Tour đã xác nhận') + '</div>';
            tooltipTitle = 'Ngày ' + dateStr + ': Đã có chuyến xác nhận (' + confirmedTrip.id + ' - ' + (confirmedTrip.location || '') + ')';
          } else if (pendingTrip) {
            cellClass = 'status-pending';
            tagHtml = '<span class="day-tag tag-pending" style="background:#fef3c7; color:#92400e; border:1px solid #fcd34d;"><i data-lucide="clock" class="icon-xs"></i> Chờ Xác Nhận</span>'
              + '<div style="font-size:0.68rem; color:#78350f; margin-top:2px;">' + pendingTrip.id + ' (' + (pendingTrip.customerName || 'Khách') + ')</div>';
            tooltipTitle = 'Ngày ' + dateStr + ': Đang có yêu cầu đặt tour chờ duyệt (' + pendingTrip.id + ')';
          } else if (isBlocked) {
            cellClass = 'status-blocked';
            tagHtml = '<span class="day-tag tag-blocked" style="background:#f1f5f9; color:#475569; border:1px solid #cbd5e1;"><i data-lucide="lock" class="icon-xs"></i> Đã Khóa Bận</span>';
            tooltipTitle = 'Ngày ' + dateStr + ': Đã đánh dấu bận (không nhận khách)';
          } else {
            tagHtml = '<span class="day-tag tag-available" style="background:#f0fdf4; color:#166534; border:1px solid #86efac;"><i data-lucide="check" class="icon-xs"></i> Mở Lịch</span>';
            tooltipTitle = 'Ngày ' + dateStr + ': Thời gian rảnh (Sẵn sàng nhận tour)';
          }

          let editBorder = '';
          let editBadge = '';
          if (isScheduleEditMode) {
            if (isSelectedInEdit) {
              editBorder = 'border:2.5px solid #d97706 !important; box-shadow:0 0 0 2px rgba(217, 119, 6, 0.25) !important; background:' + (isBlocked ? '#fff7ed' : '#f0fdf4') + ' !important; cursor:pointer;';
              editBadge = '<div style="margin-top:3px; font-size:0.68rem; font-weight:800; color:' + (isBlocked ? '#b45309' : '#15803d') + '; background:' + (isBlocked ? '#fef3c7' : '#dcfce7') + '; border:1px solid ' + (isBlocked ? '#fde68a' : '#bbf7d0') + '; border-radius:4px; padding:1px 4px; text-align:center;">'
                + (isBlocked ? '⚡ Đã chuyển BẬN' : '✨ Đã chuyển RẢNH') + '</div>';
            } else {
              editBorder = 'cursor:pointer;';
            }
          }

          html += '<div class="calendar-day-cell ' + cellClass + '" style="' + editBorder + '" onclick="handleCalendarDateClick(\'' + dateStr + '\')" title="' + tooltipTitle + '">'
            + '<span class="day-number gui-222" style="font-size:0.95rem; font-weight:700;">' + d + '</span>'
            + tagHtml
            + editBadge
            + '</div>';
        }

        grid.innerHTML = html;
        if (window.lucide) window.lucide.createIcons();
      }

      // BƯỚC 3: HDV CHỌN "CHỈNH SỬA" VÀ CẬP NHẬT LẠI LỊCH LÀM VIỆC
      function startScheduleEdit() {
        const store = window.guidiaStore;
        const guide = store.getGuides().find(g => String(g.id) === String(currentGuideId)) || store.getGuides()[0];
        isScheduleEditMode = true;
        originalBlockedDates = [...((guide && guide.blockedDates) || [])];
        pendingBlockedDates = [...originalBlockedDates];
        selectedScheduleDates = [];
        renderScheduleCalendar();
        showToast('Đã bật chế độ Chỉnh sửa lịch. Hãy chạm vào các ô ngày trên lịch để đổi trạng thái BẬN / RẢNH, sau đó nhấn "Lưu Lịch Làm Việc"!', 'info');
      }

      function clearScheduleSelectedDates() {
        pendingBlockedDates = [...originalBlockedDates];
        selectedScheduleDates = [];
        renderScheduleCalendar();
        showToast('Đã hoàn tác các thay đổi chưa lưu trong phiên này.', 'info');
      }

      // Xử lý khi nhấp vào ô ngày trên lịch
      function handleCalendarDateClick(dateStr) {
        const store = window.guidiaStore;
        const guide = store.getGuides().find(g => String(g.id) === String(currentGuideId)) || store.getGuides()[0];
        const trips = store.getTrips().filter(t => String(t.guideId) === String(currentGuideId));

        if (isScheduleEditMode) {
          // 1. Kiểm tra ngày có chuyến xác nhận
          const confirmed = trips.find(t => doesGuideTripCoverDate(t, dateStr) && isGuideTripConfirmed(t));
          if (confirmed) {
            showToast('Ngày ' + dateStr + ' đã có chuyến đi ĐÃ XÁC NHẬN (' + confirmed.id + '). Không thể thay đổi lịch!', 'warning');
            return;
          }

          // 2. Kiểm tra ngày có yêu cầu chờ xác nhận
          const pending = trips.find(t => doesGuideTripCoverDate(t, dateStr) && isGuideTripPending(t));
          if (pending) {
            showToast('Ngày ' + dateStr + ' đang có yêu cầu chờ xác nhận (' + pending.id + '). Vui lòng xử lý yêu cầu trước tại mục Yêu Cầu Đặt Lịch!', 'warning');
            return;
          }

          // 3. Đảo trạng thái ngày (BẬN <-> RẢNH)
          const isCurrentlyBlocked = pendingBlockedDates.includes(dateStr);
          if (isCurrentlyBlocked) {
            pendingBlockedDates = pendingBlockedDates.filter(d => d !== dateStr);
            showToast('Ngày ' + dateStr + ': Đã đổi sang RẢNH (Nhấn "Lưu" để cập nhật vào CSDL)', 'info');
          } else {
            pendingBlockedDates.push(dateStr);
            showToast('Ngày ' + dateStr + ': Đã đổi sang BẬN (Nhấn "Lưu" để cập nhật vào CSDL)', 'info');
          }

          if (!selectedScheduleDates.includes(dateStr)) {
            selectedScheduleDates.push(dateStr);
          }
          renderScheduleCalendar();
          return;
        }

        // Khi không ở chế độ sửa: Cho phép HDV xem chi tiết tour hoặc yêu cầu tương ứng
        const confirmed = trips.find(t => doesGuideTripCoverDate(t, dateStr) && isGuideTripConfirmed(t));
        if (confirmed) {
          const tripsTabBtn = document.querySelector('[data-tab="tab-trips"]');
          if (tripsTabBtn) tripsTabBtn.click();
          showToast('Chuyển sang Chuyến Đi Của Tôi: Chi tiết chuyến ' + confirmed.id, 'info');
          return;
        }

        const pending = trips.find(t => doesGuideTripCoverDate(t, dateStr) && isGuideTripPending(t));
        if (pending) {
          const reqTabBtn = document.querySelector('[data-tab="tab-requests"]');
          if (reqTabBtn) reqTabBtn.click();
          showToast('Chuyển sang Yêu Cầu Đặt Lịch: Phản hồi yêu cầu ' + pending.id, 'info');
          return;
        }

        showToast('Ngày ' + dateStr + '. Bấm "Chỉnh Sửa" ở góc trên để đánh dấu bận / rảnh.', 'info');
      }

      // HDV NHẤN "LƯU" - LƯU VÀO CSDL SQL SERVER VÀ CẬP NHẬT GIAO DIỆN
      function saveScheduleEdit() {
        const store = window.guidiaStore;
        const guide = store.getGuides().find(g => String(g.id) === String(currentGuideId)) || store.getGuides()[0];

        if (!selectedScheduleDates || selectedScheduleDates.length === 0) {
          isScheduleEditMode = false;
          renderScheduleCalendar();
          showToast('Lịch làm việc không có thay đổi nào mới. Đã đóng chế độ chỉnh sửa.', 'info');
          return;
        }

        // 1. Áp dụng toàn bộ lịch mới vào Store & LocalStorage
        if (guide) {
          guide.blockedDates = [...pendingBlockedDates];
          const allGuides = store.getGuides();
          localStorage.setItem('guidia_guides_v2', JSON.stringify(allGuides));
        }

        // 2. Đồng bộ từng ngày đã thay đổi vào CSDL SQL Server (GuideSchedules)
        const count = selectedScheduleDates.length;
        for (const dStr of selectedScheduleDates) {
          const isNowBlocked = pendingBlockedDates.includes(dStr);
          store.updateSchedule(currentGuideId, dStr, isNowBlocked);
        }

        isScheduleEditMode = false;
        selectedScheduleDates = [];
        originalBlockedDates = [...pendingBlockedDates];
        renderScheduleCalendar();
        showToast('Đã lưu lịch làm việc thành công vào CSDL SQL Server (' + count + ' ngày đã cập nhật)!', 'success');
      }

      // HỦY THAO TÁC: LỊCH GIỮ NGUYÊN
      function cancelScheduleEdit() {
        isScheduleEditMode = false;
        pendingBlockedDates = [...originalBlockedDates];
        selectedScheduleDates = [];
        renderScheduleCalendar();
        showToast('Đã hủy thao tác. Lịch làm việc được giữ nguyên không đổi!', 'info');
      }

      // =========================================================================
      // 4. QUẢN LÝ DOANH THU 
      // =========================================================================
      let isRevenueLoadError = false;

      function renderRevenueTab() {

        const errorState = document.getElementById('revErrorState');
        const mainContent = document.getElementById('revMainContent');
        const emptyState = document.getElementById('revEmptyState');
        const tableContainer = document.getElementById('revTableContainer');


        if (isRevenueLoadError) {
          if (errorState) errorState.style.display = 'block';
          if (mainContent) mainContent.style.display = 'none';
          if (window.lucide) window.lucide.createIcons();
          return;
        }

        else {
          if (errorState) errorState.style.display = 'none';
          if (mainContent) mainContent.style.display = 'block';
        }




        const filterPeriod = document.getElementById('revFilterPeriod')?.value || 'all';
        const filterStatus = document.getElementById('revFilterStatus')?.value || 'all';


        const store = window.guidiaStore;
        const summary = store.getRevenueSummary(currentGuideId, {
          period: filterPeriod !== 'all' ? filterPeriod : undefined,
          status: filterStatus !== 'all' ? filterStatus : undefined
        }

        );


        const elGMV = document.getElementById('revTotalGMV');
        const elFee = document.getElementById('revTotalFee');
        const elAvailable = document.getElementById('revAvailableBalance');
        const elEscrow = document.getElementById('revEscrowHolding');

        if (elGMV) elGMV.textContent = (summary.totalGMV || 0).toLocaleString('vi-VN') + '₫';
        if (elFee) elFee.textContent = (summary.totalPlatformFee || 0).toLocaleString('vi-VN') + '₫';
        if (elAvailable) elAvailable.textContent = (summary.availableBalance || 0).toLocaleString('vi-VN') + '₫';
        if (elEscrow) elEscrow.textContent = (summary.escrowHolding || 0).toLocaleString('vi-VN') + '₫';

        // Cập nhật thông tin tài khoản ngân hàng hiển thị ở Quản lý doanh thu
        const curGuide = store.getGuides().find(g => String(g.id) === String(currentGuideId));
        const revBankBox = document.getElementById('revGuideBankBox');
        if (revBankBox) {
          if (curGuide && curGuide.bankAccount && curGuide.bankName) {
            revBankBox.innerHTML = `Ngân hàng: <span class="gui-223">${curGuide.bankName}</span> &bull; Số TK: <span class="gui-223">${curGuide.bankAccount}</span> &bull; Chủ TK: <span class="gui-223">${curGuide.bankOwner || curGuide.name}</span>`;
          } else {
            revBankBox.innerHTML = `<span class="gui-224"><i data-lucide="alert-circle" class="icon-xs"></i> Chưa cung cấp thông tin tài khoản ngân hàng.</span> <a href="javascript:void(0)" onclick="document.querySelector('[data-tab=\\'tab-profile\\']').click()" class="gui-225">Cập nhật ngay tại Hồ Sơ Cá Nhân &rarr;</a>`;
          }
        }

        // Vẽ biểu đồ doanh thu 12 tháng thực tế kết nối CSDL SQL Server của HDV
        renderGuideRevenueChart(summary.monthlyStats, filterPeriod, summary.targetYear || '2026');

        const tbody = document.getElementById('revTableBody');
        if (!tbody) return;

        if (!summary.trips || summary.trips.length === 0) {
          if (emptyState) emptyState.style.display = 'block';
          if (tableContainer) tableContainer.style.display = 'none';
          if (window.lucide) window.lucide.createIcons();
          return;
        } else {
          if (emptyState) emptyState.style.display = 'none';
          if (tableContainer) tableContainer.style.display = 'block';
        }

        // Hiển thị danh sách chuyến đi và các khoản thu 
        tbody.innerHTML = summary.trips.map(trip => {
          let moneyStatus = '';

          if (trip.isDisputed) {
            moneyStatus = `<span class="dispute-held-tag"><i data-lucide="shield-alert" class="icon-xs"></i> Đang được giữ do khiếu nại</span>`;
          } else if (trip.paymentStatus === 'paid_to_guide') {
            moneyStatus = `<span class="status-badge badge-paid gui-226"><i data-lucide="check" class="icon-xs"></i> Đã thanh toán</span>`;
          } else if (trip.paymentStatus === 'refunded_to_customer') {
            moneyStatus = `<span class="status-badge badge-cancelled">Đã Hoàn Khách</span>`;
          } else {
            moneyStatus = `<span class="status-badge badge-upcoming">Tạm Giữ Escrow (Chờ đi)</span>`;
          }

          const totalAmt = trip.totalAmount || 0;
          const platFee = trip.platformFee !== undefined ? trip.platformFee : Math.round(totalAmt * 0.1);
          const guidePay = trip.guidePayout !== undefined ? trip.guidePayout : Math.round(totalAmt * 0.9);

          return `
      <tr>
        <td><strong>${trip.id || '-'}</strong></td>
        <td>${trip.location || 'Việt Nam'}</td>
        <td>${trip.customerName || 'Du khách'}</td>
        <td>${trip.startDate || '-'}</td>
        <td><strong>${totalAmt.toLocaleString('vi-VN')}₫</strong></td>
        <td class="gui-227">${platFee.toLocaleString('vi-VN')}₫</td>
        <td class="gui-228">${guidePay.toLocaleString('vi-VN')}₫</td>
        <td>${moneyStatus}</td>
        <td class="gui-80">
          <button class="btn-sm-action gui-229" onclick="openTripRevenueDetail('${trip.id}')" title="Xem chi tiết khoản thu: tiền chuyến, phí sàn, thực nhận">
            <i data-lucide="eye" class="icon-xs"></i> Chi Tiết
          </button>
        </td>
      </tr>
    `;
        }).join('');

        if (window.lucide) window.lucide.createIcons();
      }




      function applyRevenueFilters() {
        renderRevenueTab();
      }



      /**
       * Vẽ Biểu Đồ Doanh Thu Thực Nhận 12 Tháng của HDV kết nối CSDL SQL Server
       * Chỉ thể hiện 3 trạng thái duy nhất:
       * 1. Tháng Có Doanh Thu (Gradient xanh lá)
       * 2. Tháng Đang Chọn (Xanh đậm viền sáng)
       * 3. Chưa Có Doanh Thu (Màu xám nhạt)
       */
      function renderGuideRevenueChart(monthlyStats, selectedMonth, selectedYear = '2026') {
        const grid = document.getElementById('revMonthlyGrid');
        if (!grid) return;

        const chartTitle = document.getElementById('revChartTitle');
        if (chartTitle) chartTitle.textContent = `Biểu Đồ Doanh Thu Thực Nhận 12 Tháng (Năm ${selectedYear})`;

        let stats = (monthlyStats && monthlyStats.length === 12) ? monthlyStats : [];
        if (stats.length === 0) {
          stats = [];
          for (let m = 1; m <= 12; m++) {
            stats.push({ month: m, monthLabel: `Thg ${m}`, totalGMV: 0, guidePayout: 0, platformFee: 0, tripsCount: 0 });
          }
        }

        // Tìm mức thu nhập lớn nhất trong 12 tháng để làm mốc tỷ lệ 100%
        const maxPayout = Math.max(...stats.map(s => s.guidePayout || 0), 1000000);

        // Chuẩn hóa selectedMonth
        let selM = null;
        if (selectedMonth && selectedMonth !== 'all') {
          if (String(selectedMonth).includes('-')) {
            const p = String(selectedMonth).split('-');
            selM = parseInt(p[1], 10);
          } else {
            selM = parseInt(selectedMonth, 10);
          }
        }

        grid.innerHTML = stats.map(s => {
          const payout = s.guidePayout || 0;
          const gmv = s.totalGMV || 0;
          const fee = s.platformFee || (gmv > 0 ? Math.round(gmv * 0.1) : 0);
          const hasData = payout > 0;
          const isSelected = (selM !== null && selM === s.month);

          let heightPercent = 6;
          if (hasData) {
            heightPercent = Math.max(25, Math.min(100, Math.round((payout / maxPayout) * 100)));
          }

          let barColor = 'linear-gradient(180deg, #10b981 0%, #059669 100%)';
          if (isSelected) {
            barColor = 'linear-gradient(180deg, #059669 0%, #047857 100%)';
          } else if (!hasData) {
            barColor = '#e2e8f0';
          }

          const shortText = payout > 0 ? `+${(payout / 1000000).toFixed(1)}M` : '0₫';

          return `
      <div class="m-bar-col ${isSelected ? 'active-selected' : ''} gui-230" 
           onclick="selectGuideRevenueMonth(${s.month})"
           title="Bấm để lọc chi tiết Tháng ${s.month}">
        
        <div class="m-bar-tooltip gui-231">
          <strong>Tháng ${s.month}/${selectedYear}</strong> ${isSelected ? '★ (Đang xem)' : ''}<br>
          Thực nhận: <strong>${payout.toLocaleString('vi-VN')}₫</strong><br>
          Doanh số tour (GMV): <strong>${gmv.toLocaleString('vi-VN')}₫</strong><br>
          Phí sàn khấu trừ: <strong>${fee.toLocaleString('vi-VN')}₫</strong><br>
          Số chuyến đi: <strong>${s.tripsCount || 0} chuyến</strong>
        </div>

        ${isSelected ? `
          <div class="gui-232">
            ★ Đang xem
          </div>
        ` : ''}

        <div class="m-bar-track" style="height:120px; width:100%; max-width:44px; display:flex; align-items:flex-end; border-radius:8px 8px 0 0; background:rgba(226, 232, 240, 0.4); ${isSelected ? 'outline:2.5px solid #059669; box-shadow:0 0 12px rgba(5,150,105,0.4);' : ''}">
          <div class="m-bar-fill" style="height:${heightPercent}%; width:100%; border-radius:6px 6px 0 0; background:${barColor}; ${hasData ? 'box-shadow:0 4px 10px rgba(16,185,129,0.3);' : ''} transition:all 0.3s ease;"></div>
        </div>

        <span class="m-bar-label" style="font-size:0.78rem; margin-top:8px; font-weight:${isSelected ? '800' : '600'}; color:${isSelected ? '#047857' : '#334155'};">
          ${s.monthLabel}
        </span>
        <span style="font-size:0.72rem; font-weight:700; color:${hasData ? '#059669' : '#94a3b8'}; margin-top:2px;">
          ${shortText}
        </span>
      </div>
    `;
        }).join('');
      }



      function selectGuideRevenueMonth(m) {
        const periodSelect = document.getElementById('revFilterPeriod');
        if (periodSelect) {
          periodSelect.value = String(m);
        }


        renderRevenueTab();
        showToast(`Đang lọc chi tiết chuyến đi & doanh thu Tháng ${m}

/2026`, 'info');
      }



      function resetRevenueFilter() {
        const filterPeriod = document.getElementById('revFilterPeriod');
        const filterStatus = document.getElementById('revFilterStatus');
        if (filterPeriod) filterPeriod.value = 'all';
        if (filterStatus) filterStatus.value = 'all';
        isRevenueLoadError = false;
        renderRevenueTab();
        showToast('Đã đặt lại bộ lọc doanh thu!', 'success');
      }




      function simulateRevenueLoadError() {
        isRevenueLoadError = true;
        renderRevenueTab();
        showToast('Đã kích hoạt trạng thái: Không tải được dữ liệu !', 'warning');
      }




      function retryRevenueLoad() {
        isRevenueLoadError = false;
        renderRevenueTab();
        showToast('Tải lại dữ liệu doanh thu thành công!', 'success');
      }




      function openTripRevenueDetail(tripId) {
        const store = window.guidiaStore;
        const trip = store.getTrips().find(t => t.id === tripId);
        if (!trip) {
          showToast('Không tìm thấy thông tin chuyến đi!', 'error');
          return;
        }



        const modal = document.getElementById('tripRevenueDetailModal');
        if (!modal) return;

        const elCode = document.getElementById('revDetailTripCode');
        const elLoc = document.getElementById('revDetailLocation');
        const elCust = document.getElementById('revDetailCustomer');
        const elDate = document.getElementById('revDetailDate');
        const elGuests = document.getElementById('revDetailGuests');
        const elDur = document.getElementById('revDetailDuration');

        if (elCode) elCode.textContent = trip.id;
        if (elLoc) elLoc.textContent = trip.location;
        if (elCust) elCust.textContent = `${trip.customerName}

 (${trip.customerPhone || 'N/A'}

)`;
        if (elDate) elDate.textContent = `${trip.startTime || '08:00'}

 ${trip.startDate}

 đến ${trip.endTime || '17:30'}

 ${trip.endDate || trip.startDate}

`;
        if (elGuests) elGuests.textContent = `${trip.guests || trip.groupSize || trip.number_of_guests || 2}

 khách`;
        if (elDur) elDur.textContent = trip.duration || '1 ngày (Trọn gói)';

        // Bóc tách 3 khoản: tiền chuyến, phí sàn 10%, thực nhận 90%
        const elTotal = document.getElementById('revDetailTotalAmount');
        const elFee = document.getElementById('revDetailPlatformFee');
        const elPayout = document.getElementById('revDetailGuidePayout');

        if (elTotal) elTotal.textContent = trip.totalAmount.toLocaleString('vi-VN') + '₫';
        if (elFee) elFee.textContent = '- ' + trip.platformFee.toLocaleString('vi-VN') + '₫';
        if (elPayout) elPayout.textContent = trip.guidePayout.toLocaleString('vi-VN') + '₫';


        const statusBox = document.getElementById('revDetailCashflowStatusBox');
        if (statusBox) {
          if (trip.isDisputed) {
            statusBox.innerHTML = `
        <div class="gui-233">
          <div class="gui-234">
            <i data-lucide="shield-alert" class="gui-136"></i>
            Trạng Thái Dòng Tiền: Đang được giữ do khiếu nại 
          </div>
          <p class="gui-235">
            Khoản thù lao thực nhận <strong>${trip.guidePayout.toLocaleString('vi-VN')}

₫</strong> của chuyến này hiện <strong>Đang được giữ do khiếu nại</strong> từ khách hàng. Bộ phận CSKH / Admin đang đối soát các bằng chứng và giải quyết tranh chấp để bảo vệ quyền lợi hợp pháp của bạn.
          </p>
        </div>
      `;
          }

          else if (trip.paymentStatus === 'paid_to_guide') {
            const gObj = store.getGuides().find(g => String(g.id) === String(trip.guideId || currentGuideId));
            const bankInfoStr = (gObj && gObj.bankAccount && gObj.bankName)
              ? `tài khoản ${gObj.bankName}

 (STK: ${gObj.bankAccount}

 - Chủ TK: ${gObj.bankOwner || gObj.name}

)`
              : `tài khoản ngân hàng của bạn`;
            statusBox.innerHTML = `
        <div class="gui-236">
          <div class="gui-237">
            <i data-lucide="check-circle" class="gui-238"></i>
            Trạng Thái Dòng Tiền: Đã thanh toán
          </div>
          <p class="gui-239">
            Khoản thực nhận <strong>${trip.guidePayout.toLocaleString('vi-VN')}₫</strong> (sau khi trừ phí sàn) đã được hệ thống thanh toán thành công vào ${bankInfoStr} ngay khi tour kết thúc.
          </p>
        </div>
      `;
          }

          else {
            statusBox.innerHTML = `
        <div class="gui-240">
          <div class="gui-241">
            <i data-lucide="shield" class="gui-242"></i>
            Trạng Thái Dòng Tiền: Đang Ký Quỹ Escrow An Toàn
          </div>
          <p class="gui-243">
            Khách hàng đã thanh toán đầy đủ 100%. Tiền đang được ký quỹ Escrow bảo đảm và sẽ tự động giải ngân thẳng vào tài khoản ngân hàng của bạn ngay khi chuyến đi hoàn tất.
          </p>
        </div>
      `;
          }


        }



        modal.style.display = 'flex';
        if (window.lucide) window.lucide.createIcons();
      }



      function closeTripRevenueDetailModal() {
        const modal = document.getElementById('tripRevenueDetailModal');
        if (modal) modal.style.display = 'none';
      }



      function showBankTransferNotice() {
        showToast('Chính sách Guidia: Khi tour hoàn thành và tất toán, thù lao được Cổng thanh toán chuyển khoản TRỰC TIẾP vào Tài khoản Ngân hàng (Vietcombank) của HDV trong vòng 2-4 giờ. Bạn KHÔNG CẦN tạo lệnh rút tiền hay giữ tiền qua ví trung gian!', 'warning');
      }



      // =========================================================================
      // 5. NHẮN TIN TRAO ĐỔI 
      // =========================================================================
      function renderChatTab() {
        const store = window.guidiaStore;
        const guideTrips = store.getTrips().filter(t => String(t.guideId) === String(currentGuideId));
        const bookedCustomerIds = new Set(guideTrips.map(t => String(t.customerId)));

        const allMessages = store.getMessages();
        // Khách hàng chủ động nhắn tin hoặc có tin nhắn 2 chiều với HDV này
        const messagedCustomerIds = new Set();
        allMessages.forEach(m => {
          if (String(m.receiverId) === String(currentGuideId)) {
            messagedCustomerIds.add(String(m.senderId));
          } else if (String(m.senderId) === String(currentGuideId)) {
            messagedCustomerIds.add(String(m.receiverId));
          }
        });

        const allUsers = store.getUsers();
        const eligibleUsers = [];
        const addedIds = new Set();

        allUsers.forEach(u => {
          const sId = String(u.id);
          if ((bookedCustomerIds.has(sId) || messagedCustomerIds.has(sId)) && !addedIds.has(sId)) {
            eligibleUsers.push(u);
            addedIds.add(sId);
          }
        });

        // Bổ sung từ trips nếu khách đặt tour nhưng chưa có object trong store.getUsers()
        guideTrips.forEach(t => {
          const cIdStr = String(t.customerId);
          if (!addedIds.has(cIdStr)) {
            eligibleUsers.push({
              id: t.customerId,
              name: t.customerName || `Khách hàng #${t.customerId}`,
              phone: t.customerPhone || '',
              email: t.customerEmail || '',
              role: 'customer',
              status: 'active'
            });
            addedIds.add(cIdStr);
          }
        });

        // Bổ sung khách có tin nhắn nhưng chưa có trong eligibleUsers
        messagedCustomerIds.forEach(cId => {
          if (!addedIds.has(cId)) {
            const uObj = allUsers.find(u => String(u.id) === cId);
            eligibleUsers.push(uObj || {
              id: isNaN(Number(cId)) ? cId : Number(cId),
              name: `Khách hàng #${cId}`,
              phone: '',
              email: '',
              role: 'customer',
              status: 'active'
            });
            addedIds.add(cId);
          }
        });

        // Sắp xếp khách hàng có tin nhắn mới nhất lên đầu danh sách
        eligibleUsers.sort((a, b) => {
          const msgsA = allMessages.filter(m => (String(m.senderId) === String(a.id) && String(m.receiverId) === String(currentGuideId)) || (String(m.senderId) === String(currentGuideId) && String(m.receiverId) === String(a.id)));
          const msgsB = allMessages.filter(m => (String(m.senderId) === String(b.id) && String(m.receiverId) === String(currentGuideId)) || (String(m.senderId) === String(currentGuideId) && String(m.receiverId) === String(b.id)));
          const lastA = msgsA[msgsA.length - 1];
          const lastB = msgsB[msgsB.length - 1];
          const timeA = lastA ? (lastA.createdAt || new Date(lastA.timestamp || 0).getTime()) : 0;
          const timeB = lastB ? (lastB.createdAt || new Date(lastB.timestamp || 0).getTime()) : 0;
          return timeB - timeA;
        });

        const convoList = document.getElementById('chatConversationList');
        if (!convoList) return;

        if (eligibleUsers.length === 0) {
          convoList.innerHTML = `
      <div class="gui-244">
        <i data-lucide="message-square-dashed" class="gui-245"></i>
        <div class="gui-219">Chưa có hội thoại nào</div>
        <p class="gui-246">
          Hộp thư chỉ hiển thị những khách hàng đã đặt lịch hoặc chủ động nhắn tin tới bạn.
        </p>
      </div>
    `;
          currentChatPartnerId = null;
          renderActiveChatMessages();
          if (window.lucide) window.lucide.createIcons();
          return;
        }

        // Nếu partner hiện tại không nằm trong danh sách được phép thì chọn khách đầu tiên
        if (!currentChatPartnerId || !eligibleUsers.some(u => String(u.id) === String(currentChatPartnerId))) {
          currentChatPartnerId = eligibleUsers[0].id;
        }

        convoList.innerHTML = eligibleUsers.map(user => {
          const isCurrent = String(user.id) === String(currentChatPartnerId);
          const hasBooked = bookedCustomerIds.has(String(user.id));
          const hasMessaged = messagedCustomerIds.has(String(user.id));
          const custMsgs = allMessages.filter(m =>
            (String(m.senderId) === String(user.id) && String(m.receiverId) === String(currentGuideId)) ||
            (String(m.senderId) === String(currentGuideId) && String(m.receiverId) === String(user.id))
          );
          const lastMsg = custMsgs[custMsgs.length - 1];
          const unreadCount = custMsgs.filter(m => String(m.receiverId) === String(currentGuideId) && !m.isRead).length;

          let tagBadge = '';
          if (hasBooked) {
            tagBadge = '<span class="gui-247"><i data-lucide="calendar-check" class="gui-248"></i> Đã đặt lịch</span>';
          } else if (hasMessaged) {
            tagBadge = '<span class="gui-249"><i data-lucide="message-square" class="gui-248"></i> Khách nhắn tin</span>';
          }

          return `
      <div class="chat-convo-item ${isCurrent ? 'active' : ''} gui-250" onclick="selectChatPartner('${user.id}')" style="position:relative;cursor:pointer;">
        <div class="gui-251" style="position:relative;flex-shrink:0;">
          ${user.avatar ? `<img src="${user.avatar}" style="width:100%;height:100%;border-radius:50%;object-fit:cover;">` : (user.name ? user.name.split(' ').pop().substring(0, 2).toUpperCase() : 'KH')}
          ${unreadCount > 0 ? `<span style="position:absolute;top:-4px;right:-4px;background:#ef4444;color:#fff;font-size:11px;font-weight:700;width:18px;height:18px;border-radius:50%;display:flex;align-items:center;justify-content:center;border:2px solid #fff;">${unreadCount}</span>` : ''}
        </div>
        <div class="gui-252" style="flex:1;min-width:0;">
          <div class="gui-253" style="display:flex;justify-content:space-between;align-items:center;">
            <div class="gui-254" style="font-weight:600;font-size:14px;color:#1e293b;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">
              ${user.name}
            </div>
            ${lastMsg && lastMsg.time ? `<span style="font-size:11px;color:#94a3b8;margin-left:6px;">${lastMsg.time}</span>` : ''}
          </div>
          <p style="margin:2px 0 4px;font-size:12px;color:${unreadCount > 0 ? '#0f172a;font-weight:700;' : '#64748b;'}white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">
            ${lastMsg ? (lastMsg.text || 'Đã gửi một hình ảnh') : 'Bắt đầu cuộc trò chuyện'}
          </p>
          <div class="gui-255" style="display:flex;align-items:center;gap:6px;">
            ${tagBadge}
            ${user.status === 'suspended' ? '<span class="gui-256">(Đã khóa)</span>' : ''}
          </div>
        </div>
      </div>
    `;
        }).join('');

        if (window.lucide) window.lucide.createIcons();
        renderActiveChatMessages();
      }



      function selectChatPartner(userId) {
        currentChatPartnerId = userId;
        renderChatTab();
      }



      let selectedChatImageUrl = null;
      let selectedChatImageTitle = '';

      function renderActiveChatMessages() {
        const store = window.guidiaStore;
        const nameEl = document.getElementById('chatPartnerName');
        const statusBadge = document.getElementById('chatPartnerStatusBadge');
        const suspendedNotice = document.getElementById('chatSuspendedNotice');
        const chatInput = document.getElementById('chatInputText');
        const sendBtn = document.getElementById('btnSendChatMessage');
        const container = document.getElementById('chatMessagesContainer');

        if (!currentChatPartnerId) {
          if (nameEl) nameEl.textContent = 'Chưa chọn khách hàng';
          if (statusBadge) statusBadge.innerHTML = '';
          if (suspendedNotice) suspendedNotice.style.display = 'none';
          if (chatInput) {
            chatInput.placeholder = 'Chưa có cuộc trò chuyện nào...';
            chatInput.disabled = true;
          }


          if (sendBtn) sendBtn.disabled = true;
          if (container) {
            container.innerHTML = `
        <div class="gui-257">
          <i data-lucide="message-circle" class="gui-258"></i>
          <p class="gui-259">Chưa có cuộc trò chuyện nào để hiển thị</p>
          <span class="gui-260">Hộp thư chỉ hiển thị những khách hàng đã đặt lịch hoặc chủ động nhắn tin tới bạn.</span>
        </div>
      `;
            if (window.lucide) window.lucide.createIcons();
          }


          return;
        }



        if (chatInput) chatInput.disabled = false;
        if (sendBtn) sendBtn.disabled = false;

        const partner = store.getUsers().find(u => String(u.id) === String(currentChatPartnerId)) || { name: 'Khách du lịch', id: currentChatPartnerId }

          ;
        const messages = store.getConversation(currentGuideId, currentChatPartnerId);
        if (store.markMessagesAsRead && currentGuideId && currentChatPartnerId) {
          store.markMessagesAsRead(currentGuideId, currentChatPartnerId);
        }

        if (nameEl) nameEl.textContent = partner.name;

        if (partner.status === 'suspended') {
          if (suspendedNotice) suspendedNotice.style.display = 'flex';
          if (statusBadge) {
            statusBadge.innerHTML = `<span class="gui-261"><i data-lucide="slash" class="gui-262"></i> Tài khoản bị khóa</span>`;
          }


          if (chatInput) chatInput.placeholder = 'Tài khoản của khách đã bị khóa do vi phạm ...';
          if (sendBtn) sendBtn.style.opacity = '0.6';
        }

        else {
          if (suspendedNotice) suspendedNotice.style.display = 'none';
          if (statusBadge) {
            statusBadge.innerHTML = `<span class="gui-85"></span> Đang trực tuyến`;
          }


          if (chatInput) chatInput.placeholder = 'Nhập tin nhắn trao đổi với du khách...';
          if (sendBtn) sendBtn.style.opacity = '1';
        }



        if (!container) return;

        if (messages.length === 0) {
          container.innerHTML = `
      <div class="gui-263">
        Bắt đầu cuộc trò chuyện với ${partner.name}

...
      </div>
    `;
          return;
        }



        container.innerHTML = messages.map(msg => {
          const isSentByGuide = String(msg.senderId) === String(currentGuideId);
          return `
      <div class="chat-bubble ${isSentByGuide ? 'sent' : 'received'}

">
        <div>${msg.text || msg.content || ''}

</div>
        ${msg.imageUrl ? `<img src="${msg.imageUrl}

" alt="Hình ảnh đính kèm" onclick="window.open('${msg.imageUrl}

', '_blank')" title="Bấm để xem ảnh phóng to" class="gui-264">` : ''}


        <div class="chat-bubble-time">
          ${msg.timestamp}

 • ${msg.status === 'seen' ? 'Đã xem' : 'Đã gửi'}


        </div>
      </div>
    `;
        }

        ).join('');

        if (window.lucide) window.lucide.createIcons();

        // Cuộn mượt mà và chắc chắn xuống tin nhắn mới nhất ở đáy
        const scrollToBottom = () => {
          if (container) {
            container.scrollTop = container.scrollHeight;
          }


        }

          ;
        scrollToBottom();
        requestAnimationFrame(scrollToBottom);
        setTimeout(scrollToBottom, 60);
        setTimeout(scrollToBottom, 200);

        const imgs = container.querySelectorAll('img');
        imgs.forEach(img => {
          if (!img.complete) {
            img.addEventListener('load', scrollToBottom);
          }


        }

        );
      }



      function handleSendGuideChatMessage(e) {
        if (e) e.preventDefault();
        if (!currentChatPartnerId) {
          showToast('Vui lòng chọn khách hàng để nhắn tin!', 'warning');
          return;
        }


        const input = document.getElementById('chatInputText');
        const text = input ? input.value.trim() : '';
        if (!text) return;

        const res = window.guidiaStore.sendMessage(currentGuideId, currentChatPartnerId, text);
        if (res.success) {
          if (input) {
            input.value = '';
            input.focus();
          }


          renderActiveChatMessages();
          renderChatTab();
        }

        else {
          showToast(res.message, 'error');
        }


      }



      // Modal chọn ảnh gửi tin nhắn (thay thế cho prompt)
      function openChatImageModal() {
        selectedChatImageUrl = null;
        selectedChatImageTitle = '';
        const previewBox = document.getElementById('chatUploadPreviewBox');
        const confirmBtn = document.getElementById('btnConfirmSendChatImg');
        if (previewBox) previewBox.style.display = 'none';
        if (confirmBtn) {
          confirmBtn.disabled = true;
          confirmBtn.style.opacity = '0.6';
        }



        // Reset border các ảnh có sẵn
        document.querySelectorAll('.preset-img-item').forEach(el => {
          el.style.borderColor = 'transparent';
          el.style.transform = 'scale(1)';
        }

        );

        const modal = document.getElementById('chatImageModal');
        if (modal) {
          modal.style.display = 'flex';
          if (window.lucide) window.lucide.createIcons();
        }


      }



      function closeChatImageModal() {
        const modal = document.getElementById('chatImageModal');
        if (modal) modal.style.display = 'none';
      }



      function handleChatImageFileChange(input) {
        if (input.files && input.files[0]) {
          const file = input.files[0];
          compressImageFile(file, 1200, 0.82, (compressedDataUrl) => {
            selectedChatImageUrl = compressedDataUrl;
            selectedChatImageTitle = file.name;

            const previewBox = document.getElementById('chatUploadPreviewBox');
            const previewImg = document.getElementById('chatUploadPreviewImg');
            const confirmBtn = document.getElementById('btnConfirmSendChatImg');

            if (previewImg) previewImg.src = compressedDataUrl;
            if (previewBox) previewBox.style.display = 'block';

            // Bỏ chọn preset
            document.querySelectorAll('.preset-img-item').forEach(el => {
              el.style.borderColor = 'transparent';
              el.style.transform = 'scale(1)';
            });

            if (confirmBtn) {
              confirmBtn.disabled = false;
              confirmBtn.style.opacity = '1';
            }
          });
        }
      }

      function selectPresetChatImage(url, title, el) {
        selectedChatImageUrl = url;
        selectedChatImageTitle = title;

        // Ẩn preview tải lên
        const previewBox = document.getElementById('chatUploadPreviewBox');
        if (previewBox) previewBox.style.display = 'none';

        // Highlight ô đã chọn
        document.querySelectorAll('.preset-img-item').forEach(item => {
          item.style.borderColor = 'transparent';
          item.style.transform = 'scale(1)';
        }

        );
        if (el) {
          el.style.borderColor = '#059669';
          el.style.transform = 'scale(0.96)';
        }



        const confirmBtn = document.getElementById('btnConfirmSendChatImg');
        if (confirmBtn) {
          confirmBtn.disabled = false;
          confirmBtn.style.opacity = '1';
        }


      }



      function confirmSendChatImage() {
        if (!selectedChatImageUrl) {
          showToast('Vui lòng chọn hoặc tải lên một hình ảnh!', 'warning');
          return;
        }



        const res = window.guidiaStore.sendMessage(
          currentGuideId,
          currentChatPartnerId,
          selectedChatImageTitle ? `[Hình ảnh: ${selectedChatImageTitle}

]` : 'Đã gửi một hình ảnh điểm đến:',
          selectedChatImageUrl
        );

        if (res.success) {
          closeChatImageModal();
          renderActiveChatMessages();
          renderChatTab();
          showToast('Đã gửi hình ảnh thành công!', 'success');
        }

        else {

          showToast(res.message, 'error');
        }


      }



      // =========================================================================
      // 6. PHẢN HỒI ĐÁNH GIÁ 
      // =========================================================================
      function renderReviewsTab() {
        const store = window.guidiaStore;
        const trips = store.getTrips().filter(t => String(t.guideId) === String(currentGuideId) && t.review);

        // Ưu tiên hiển thị đánh giá mới chưa phản hồi lên trước 
        trips.sort((a, b) => {
          const aNeedsReply = !a.review.reply;
          const bNeedsReply = !b.review.reply;
          if (aNeedsReply && !bNeedsReply) return -1;
          if (!aNeedsReply && bNeedsReply) return 1;
          return 0;
        }

        );

        const container = document.getElementById('reviewsListContainer');
        if (!container) return;

        if (trips.length === 0) {
          container.innerHTML = `
      <div class="gui-265">
        Chưa có đánh giá nào cho các chuyến đi của bạn.
      </div>
    `;
          return;
        }



        container.innerHTML = trips.map(trip => {
          const rev = trip.review;
          const hasReply = !!rev.reply;
          const cleanTripId = String(trip.id || '').trim();

          return `
      <div class="gui-266">
        <div class="gui-267">
          <div>
            <div class="gui-41">
              <strong class="gui-268">${trip.customerName || 'Khách Du Lịch'}</strong>
              <span class="gui-269">
                ${'★'.repeat(rev.stars || 5)}${'☆'.repeat(5 - (rev.stars || 5))}
              </span>
              <span class="gui-270">${rev.createdAt || ''}</span>
            </div>
            <div class="gui-271">
              Tour: ${trip.location || 'Tour cá nhân'} (${cleanTripId})
            </div>
          </div>
          ${!hasReply ? '<span class="status-badge badge-pending-guide">Chưa Phản Hồi</span>' : '<span class="status-badge badge-paid">Đã Phản Hồi</span>'}
        </div>

        <p class="gui-272">
          "${rev.comment || ''}"
        </p>

        <!-- Khối hiển thị hoặc form phản hồi -->
        ${hasReply ? `
          <div class="gui-273">
            <div class="gui-274">
              <strong class="gui-275">Phản hồi từ bạn:</strong>
              <span class="gui-276">${rev.repliedAt || ''}</span>
            </div>
            <p class="gui-277">${rev.reply}</p>
            <button type="button" class="btn-ghost gui-278" onclick="openEditReplyModal('${cleanTripId}')">
              <i data-lucide="edit-3" class="icon-xs"></i> Chỉnh sửa phản hồi 
            </button>
          </div>
        ` : `
          <div class="gui-279">
            <form onsubmit="handleGuideSendReply(event, '${cleanTripId}')" class="gui-110">
              <input type="text" id="replyInput_${cleanTripId}" class="form-control gui-89" placeholder="Nhập lời cảm ơn hoặc phản hồi nhận xét của khách..." required>
              <button type="submit" class="btn-primary gui-90">
                <i data-lucide="corner-down-left"></i> Gửi Phản Hồi
              </button>
            </form>
          </div>
        `}
      </div>
    `;
        }).join('');

        if (window.lucide) window.lucide.createIcons();
      }

      function handleGuideSendReply(e, tripId) {
        e.preventDefault();
        const cleanId = String(tripId || '').trim();
        const input = document.getElementById(`replyInput_${cleanId}`);
        const text = input ? input.value : '';

        if (!text || !text.trim()) {
          showToast('Nội dung phản hồi không được để trống !', 'error');
          return;
        }

        const res = window.guidiaStore.replyReview(cleanId, text.trim());
        if (res.success) {
          showToast(res.message, 'success');
          renderReviewsTab();
        } else {
          showToast(res.message, 'error');
        }
      }

      // Modal Chỉnh Sửa Phản Hồi (thay thế prompt)
      function openEditReplyModal(tripId, oldReplyEncoded) {
        const cleanId = String(tripId || '').trim();
        let oldReply = '';
        if (oldReplyEncoded !== undefined && oldReplyEncoded !== null && oldReplyEncoded !== '') {
          try { oldReply = decodeURIComponent(oldReplyEncoded); } catch (e) { oldReply = oldReplyEncoded; }
        } else {
          const trip = window.guidiaStore.getTrips().find(t =>
            String(t.id).trim() === cleanId ||
            (t.dbBookingId && String(t.dbBookingId).trim() === cleanId) ||
            (t.bookingCode && String(t.bookingCode).trim() === cleanId)
          );
          if (trip && trip.review && trip.review.reply) {
            oldReply = trip.review.reply;
          }
        }
        document.getElementById('editReplyTripId').value = cleanId;
        document.getElementById('editReplyContentText').value = oldReply;
        const modal = document.getElementById('editReplyModal');
        if (modal) {
          modal.style.display = 'flex';
          if (window.lucide) window.lucide.createIcons();
          setTimeout(() => {
            const ta = document.getElementById('editReplyContentText');
            if (ta) ta.focus();
          }, 50);
        }
      }

      function closeEditReplyModal() {
        const modal = document.getElementById('editReplyModal');
        if (modal) modal.style.display = 'none';
      }

      function confirmSaveEditReply() {
        const tripId = document.getElementById('editReplyTripId').value.trim();
        const newReply = document.getElementById('editReplyContentText').value.trim();

        if (!newReply) {
          showToast('Nội dung phản hồi không được để trống !', 'error');
          return;
        }

        const res = window.guidiaStore.replyReview(tripId, newReply);
        if (res.success) {
          closeEditReplyModal();
          showToast('Đã cập nhật phản hồi mới thành công!', 'success');
          renderReviewsTab();
        } else {
          showToast(res.message, 'error');
        }
      }



      // =========================================================================
      // 7. KHIẾU NẠI & TRANH CHẤP 
      // =========================================================================
      function viewTripDispute(tripId) {
        // Chuyển tab sang Khiếu Nại & Hỗ Trợ
        const tabBtn = document.querySelector('[data-tab="tab-disputes"]');
        if (tabBtn) tabBtn.click();
        setTimeout(() => {
          const store = window.guidiaStore;
          const trip = store.getTrips().find(t => t.id === tripId);
          const dispute = store.getDisputes().find(d =>
            d.tripId === tripId ||
            (trip && String(trip.dbBookingId) === String(d.bookingId))
          );
          if (dispute) {
            const card = document.getElementById('dispute-card-' + (dispute.id || dispute.disputeCode));
            if (card) {
              card.scrollIntoView({ behavior: 'smooth', block: 'center' }

              );
              card.style.outline = '3px solid #e11d48';
              card.style.boxShadow = '0 0 20px rgba(225, 29, 72, 0.4)';
              setTimeout(() => {
                card.style.outline = '';
                card.style.boxShadow = '';
              }

                , 3500);
            }


          }


        }

          , 250);
      }



      function renderDisputesTab() {
        const store = window.guidiaStore;
        const trips = store.getTrips().filter(t => String(t.guideId) === String(currentGuideId));

        // Cập nhật select chuyến đi trong form
        const select = document.getElementById('disputeTripSelect');
        if (select) {
          select.innerHTML = trips.map(t => `
      <option value="${t.id}">${t.id} - ${t.location} (${t.customerName})</option>
    `).join('');
        }



        // Lọc chính xác các khiếu nại liên quan đến HDV này (lấy trực tiếp từ CSDL SQL Server)
        const disputes = store.getDisputes().filter(d =>
          String(d.guideId) === String(currentGuideId) ||
          String(d.reportedUserId) === String(currentGuideId) ||
          String(d.reporterId) === String(currentGuideId) ||
          trips.some(t => t.id === d.tripId || (t.dbBookingId && String(t.dbBookingId) === String(d.bookingId)))
        );

        const container = document.getElementById('disputesListContainer');
        if (!container) return;

        if (disputes.length === 0) {
          container.innerHTML = `<p class="gui-280">Hiện không có hồ sơ khiếu nại nào liên quan đến tài khoản của bạn.</p>`;
          return;
        }



        container.innerHTML = disputes.map(d => {
          // Chỉ có đúng 2 tag: "Đã xử lý" và "Chờ xử lý"
          const hasAdminNote = (d.adminDecision && d.adminDecision.trim().length > 0) || (d.adminNote && d.adminNote.trim().length > 0);
          const isProcessed = (
            d.status === 'resolved_refund' ||
            d.status === 'rejected_to_guide' ||
            d.status === 'resolved' ||
            d.dbStatus === 'APPROVED_REFUND' ||
            d.dbStatus === 'REJECTED' ||
            hasAdminNote
          );

          const statusBadge = isProcessed ? `
      <span class="status-badge gui-281">
        <i data-lucide="check-circle" class="icon-xs gui-43"></i> Đã Xử Lý
      </span>
    ` : `
      <span class="status-badge gui-282">
        <i data-lucide="clock" class="icon-xs gui-53"></i> Chờ Xử Lý
      </span>
    `;

          return `
      <div id="dispute-card-${d.id || d.disputeCode}

" class="gui-283">
        <div class="gui-284">
          <div class="gui-89">
            <div class="gui-28">
              <strong class="gui-285">Mã Vụ Việc: ${d.id || d.disputeCode}

</strong>
              ${statusBadge}


            </div>
            <div class="gui-286">
              Liên quan chuyến đi: <strong>${d.tripId}

</strong> &bull; Điểm đến: ${d.tourLocation || d.location || 'Việt Nam'}

 &bull; Số tiền tranh chấp: <strong>${(d.amount || 0).toLocaleString('vi-VN')}

₫</strong>
            </div>
            <p class="gui-287">
              Người báo cáo: <strong>${d.complainantName}

</strong> &bull; Loại sự cố: <strong>${d.disputeType || 'Khiếu nại sự cố'}

</strong><br/>
              Lý do khiếu nại: <strong>${d.reason}

</strong>
            </p>
            ${d.evidenceUrl ? `
              <div class="gui-288">
                <span class="gui-289">Bằng chứng ảnh đính kèm:</span><br/>
                <a href="${d.evidenceUrl}

" target="_blank" class="gui-290">
                  <img src="${d.evidenceUrl}

" alt="Bằng chứng khiếu nại" class="gui-291" onerror="this.onerror=null; this.src='img/bang-chung-tre.jpg'">
                </a>
              </div>
            ` : ''}


            ${d.evidenceText ? `
              <div class="gui-292">
                Ghi chú bằng chứng: "${d.evidenceText}

"
              </div>
            ` : ''}


            ${d.adminDecision ? `
              <div class="gui-293">
                ⚖️ <strong>Phán quyết của Quản trị viên:</strong> ${d.adminDecision}


              </div>
            ` : `
              <div class="gui-294">
                ⏳ <strong>Hồ sơ đang trong quá trình thẩm định của Ban Quản Trị. Khoản tiền chuyến đi đang được đóng băng an toàn.</strong>
              </div>
            `}


          </div>
        </div>
      </div>
    `;
        }

        ).join('');

        if (window.lucide) window.lucide.createIcons();
      }



      function handleGuideSubmitDispute(e) {
        e.preventDefault();
        const tripId = document.getElementById('disputeTripSelect').value;
        const reasonType = document.getElementById('disputeReasonType').value;
        const desc = document.getElementById('disputeDescription').value;
        const evidenceText = document.getElementById('disputeEvidenceText').value;
        const evidenceUrl = document.getElementById('disputeEvidenceUrl').value;

        const store = window.guidiaStore;
        const trip = store.getTrips().find(t => t.id === tripId);
        const guide = store.getGuides().find(g => String(g.id) === String(currentGuideId));

        const res = store.submitDispute({
          tripId,
          role: 'guide',
          complainantName: guide ? guide.name : 'Hướng dẫn viên',
          defendantName: trip ? trip.customerName : 'Du khách',
          tourLocation: trip ? trip.location : 'Việt Nam',
          amount: trip ? trip.totalAmount : 1500000,
          reason: `${reasonType}

: ${desc}

`,
          evidenceText,
          evidenceUrl
        }

        );

        if (res.success) {
          showToast(res.message);
          document.getElementById('disputeDescription').value = '';
          document.getElementById('disputeEvidenceText').value = '';
          renderDisputesTab();
          renderTripsTab();
          renderRevenueTab();
        }

        else {

          showToast(res.message, 'error');
        }


      }



      // =========================================================================
      // 8. HỒ SƠ NĂNG LỰC & THÔNG TIN CÁ NHÂN 
      // =========================================================================
      const guideProfileFieldIds = [
        'profGuideAvatar', 'profGuideName', 'profGuidePhone', 'profGuideCity',
        'profGuideHourlyPrice', 'profGuideDailyPrice', 'profGuideSpecialties',
        'profGuideLanguages', 'profGuideBio', 'profGuideCertType', 'profGuideCertNumber',
        'profGuideIssuedBy', 'profGuideCertFileInput', 'profGuideBankName',
        'profGuideBankAccount', 'profGuideBankOwner', 'profOldPassword', 'profNewPassword'
      ];

      function setGuideProfileFieldsDisabled(disabled) {
        guideProfileFieldIds.forEach(id => {
          const el = document.getElementById(id);
          if (el) el.disabled = disabled;
        });
      }

      function enableGuideProfileEdit() {
        setGuideProfileFieldsDisabled(false);
        const initActions = document.getElementById('guideProfileInitialActions');
        const editActions = document.getElementById('guideProfileEditActions');
        if (initActions) initActions.style.display = 'none';
        if (editActions) editActions.style.display = 'flex';
        const firstInput = document.getElementById('profGuideName');
        if (firstInput) firstInput.focus();
        showToast('Đã mở khóa chế độ chỉnh sửa hồ sơ. Hãy cập nhật và bấm "Lưu Thay Đổi Hồ Sơ".');
      }

      function cancelGuideProfileEdit() {
        renderProfileTab();
        const initActions = document.getElementById('guideProfileInitialActions');
        const editActions = document.getElementById('guideProfileEditActions');
        if (initActions) initActions.style.display = 'flex';
        if (editActions) editActions.style.display = 'none';
        setGuideProfileFieldsDisabled(true);
        const oldPwd = document.getElementById('profOldPassword');
        const newPwd = document.getElementById('profNewPassword');
        if (oldPwd) oldPwd.value = '';
        if (newPwd) newPwd.value = '';
        showToast('Đã hủy chỉnh sửa. Giữ nguyên toàn bộ thông tin ban đầu.');
      }

      function renderProfileTab() {
        const store = window.guidiaStore;
        const guide = store.getGuides().find(g => String(g.id) === String(currentGuideId)) || store.getGuides()[0];
        const user = store.getUsers().find(u => String(u.id) === String(currentGuideId));

        if (!guide) return;

        const nameInput = document.getElementById('profGuideName');
        const phoneInput = document.getElementById('profGuidePhone');
        const cityInput = document.getElementById('profGuideCity');
        const hourlyInput = document.getElementById('profGuideHourlyPrice');
        const dailyInput = document.getElementById('profGuideDailyPrice');
        const specInput = document.getElementById('profGuideSpecialties');
        const langInput = document.getElementById('profGuideLanguages');
        const bioInput = document.getElementById('profGuideBio');

        const certTypeSelect = document.getElementById('profGuideCertType');
        const certNumberInput = document.getElementById('profGuideCertNumber');
        const issuedByInput = document.getElementById('profGuideIssuedBy');
        const certImageInput = document.getElementById('profGuideCertImage');

        if (nameInput) nameInput.value = guide.name || '';
        if (phoneInput) phoneInput.value = guide.phone || '';
        if (cityInput) cityInput.value = guide.city || '';
        if (hourlyInput) hourlyInput.value = guide.hourlyPrice || '';
        if (dailyInput) dailyInput.value = guide.dailyPrice || '';
        if (specInput) specInput.value = guide.specialties || '';
        if (langInput) langInput.value = guide.languages || '';
        if (bioInput) bioInput.value = guide.bio || '';

        if (certTypeSelect) certTypeSelect.value = guide.certType || 'Thẻ Hướng Dẫn Viên Du Lịch Nội Địa';
        if (certNumberInput) certNumberInput.value = guide.certNumber || '';
        if (issuedByInput) issuedByInput.value = guide.issuedBy || '';
        if (certImageInput) certImageInput.value = guide.certImage || 'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=600';

        const certPreviewImg = document.getElementById('profGuideCertPreviewImg');
        if (certPreviewImg) {
          certPreviewImg.src = guide.certImage || 'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=600';
        }

        const avatarInput = document.getElementById('profGuideAvatar');
        const avatarPreview = document.getElementById('profGuideAvatarPreview');
        const userAvatar = (guide && guide.avatar) || (user && user.avatar) || 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150';
        if (avatarInput) avatarInput.value = (guide && guide.avatar) || (user && user.avatar) || '';
        if (avatarPreview) avatarPreview.src = userAvatar;

        // Nạp thông tin tài khoản ngân hàng của HDV
        const bankNameInput = document.getElementById('profGuideBankName');
        const bankAccountInput = document.getElementById('profGuideBankAccount');
        const bankOwnerInput = document.getElementById('profGuideBankOwner');
        if (bankNameInput) bankNameInput.value = guide.bankName || '';
        if (bankAccountInput) bankAccountInput.value = guide.bankAccount || '';
        if (bankOwnerInput) bankOwnerInput.value = guide.bankOwner || guide.name || '';

        const tagContainer = document.getElementById('certStatusTagProfile');
        if (tagContainer) {
          if (guide.certStatus === 'approved') {
            tagContainer.innerHTML = `<span class="badge-tag-status status-active"><i data-lucide="shield-check" class="icon-xs"></i> Đã Duyệt Thẻ HDV</span>`;
          } else {
            tagContainer.innerHTML = `<span class="badge-tag-status status-pending"><i data-lucide="clock" class="icon-xs"></i> Chờ Duyệt Thẻ HDV</span>`;
          }
        }

        // Luôn vô hiệu hóa input và hiển thị nút Chỉnh Sửa ban đầu
        setGuideProfileFieldsDisabled(true);
        const initActions = document.getElementById('guideProfileInitialActions');
        const editActions = document.getElementById('guideProfileEditActions');
        if (initActions) initActions.style.display = 'flex';
        if (editActions) editActions.style.display = 'none';

        if (window.lucide) window.lucide.createIcons();
      }



      function previewGuideCertFile(event) {
        const file = event.target.files && event.target.files[0];
        if (file) {
          compressImageFile(file, 1200, 0.82, (compressedDataUrl) => {
            const previewImg = document.getElementById('profGuideCertPreviewImg');
            const hiddenInput = document.getElementById('profGuideCertImage');
            if (previewImg) previewImg.src = compressedDataUrl;
            if (hiddenInput) hiddenInput.value = compressedDataUrl;
            showToast('Đã tải ảnh thẻ hành nghề lên! Bạn có thể xem hình ảnh thực tế bên dưới.');
          });
        }
      }



      function compressImageFile(file, maxDimension, quality, callback) {
        if (!file) return;
        const reader = new FileReader();
        reader.onload = function (evt) {
          const rawResult = evt.target.result;
          const img = new Image();
          img.onload = function () {
            let width = img.width;
            let height = img.height;
            const max = maxDimension || 1200;
            if (width > max || height > max) {
              if (width > height) {
                height = Math.round((height * max) / width);
                width = max;
              } else {
                width = Math.round((width * max) / height);
                height = max;
              }
            }
            const canvas = document.createElement('canvas');
            canvas.width = width;
            canvas.height = height;
            const ctx = canvas.getContext('2d');
            ctx.drawImage(img, 0, 0, width, height);
            const dataUrl = canvas.toDataURL('image/jpeg', quality || 0.82);
            callback(dataUrl);
          };
          img.onerror = function () {
            callback(rawResult);
          };
          img.src = rawResult;
        };
        reader.readAsDataURL(file);
      }

      function previewDisputeEvidence(event) {
        const file = event.target.files && event.target.files[0];
        if (file) {
          compressImageFile(file, 1200, 0.82, (compressedDataUrl) => {
            const previewImg = document.getElementById('disputeEvidencePreviewImg');
            const hiddenInput = document.getElementById('disputeEvidenceUrl');
            if (previewImg) previewImg.src = compressedDataUrl;
            if (hiddenInput) hiddenInput.value = compressedDataUrl;
            showToast('Đã tải tệp bằng chứng lên! Ảnh đã hiển thị xem trước bên dưới.');
          });
        }
      }



      function handleGuideSaveProfile(e) {
        e.preventDefault();
        const store = window.guidiaStore;
        const guide = store.getGuides().find(g => String(g.id) === String(currentGuideId)) || store.getGuides()[0];

        const name = document.getElementById('profGuideName').value;
        const phone = document.getElementById('profGuidePhone').value;
        const city = document.getElementById('profGuideCity').value;
        const hourlyPrice = document.getElementById('profGuideHourlyPrice').value;
        const dailyPrice = document.getElementById('profGuideDailyPrice').value;
        const specialties = document.getElementById('profGuideSpecialties').value;
        const languages = document.getElementById('profGuideLanguages').value;
        const bio = document.getElementById('profGuideBio').value;

        const certType = document.getElementById('profGuideCertType').value;
        const certNumber = document.getElementById('profGuideCertNumber').value;
        const issuedBy = document.getElementById('profGuideIssuedBy').value;
        const certImage = document.getElementById('profGuideCertImage').value;

        const oldPassword = document.getElementById('profOldPassword').value;
        const newPassword = document.getElementById('profNewPassword').value;

        const bankName = document.getElementById('profGuideBankName') ? document.getElementById('profGuideBankName').value.trim() : '';
        const bankAccount = document.getElementById('profGuideBankAccount') ? document.getElementById('profGuideBankAccount').value.trim() : '';
        const bankOwner = document.getElementById('profGuideBankOwner') ? document.getElementById('profGuideBankOwner').value.trim() : '';

        // Cập nhật thông tin tài khoản ngân hàng và đồng bộ SQL Server
        if (bankName || bankAccount) {
          store.updateGuideBankAccount(currentGuideId, {
            bankName,
            bankAccount,
            bankOwner: bankOwner || name
          }

          );
        }



        const isImportantChange = (
          certNumber !== (guide.certNumber || '') ||
          certType !== (guide.certType || '') ||
          issuedBy !== (guide.issuedBy || '') ||
          (certImage && certImage !== (guide.certImage || ''))
        );

        const avatar = document.getElementById('profGuideAvatar') ? document.getElementById('profGuideAvatar').value.trim() : '';

        const res = store.updateGuideProfile(currentGuideId, {
          name,
          phone,
          city,
          hourlyPrice,
          dailyPrice,
          specialties,
          languages,
          bio,
          avatar,
          certType,
          certNumber,
          issuedBy,
          certImage,
          oldPassword,
          newPassword,
          bankName,
          bankAccount,
          bankOwner
        }

          , isImportantChange);

        if (res.success) {
          showToast(res.message, 'success');
          checkCurrentGuideAccountStatus();
          renderProfileTab();
          renderRevenueTab();
        }

        else {
          showToast(res.message, 'error');
        }


      }



      // Toast Helper
      function showToast(message, type = 'success') {
        const toast = document.getElementById('toastNotification');
        const text = document.getElementById('toastMessage');
        const icon = toast ? toast.querySelector('.toast-icon') : null;
        if (!toast || !text) return;

        text.textContent = message;
        toast.classList.remove('toast-error', 'toast-warning', 'toast-success');
        toast.classList.add('toast-' + type);

        if (icon) {
          if (type === 'error') {
            icon.setAttribute('data-lucide', 'alert-circle');
            icon.style.color = '#ef4444';
          }

          else if (type === 'warning') {
            icon.setAttribute('data-lucide', 'alert-triangle');
            icon.style.color = '#f59e0b';
          }

          else {
            icon.setAttribute('data-lucide', 'check-circle');
            icon.style.color = '#34d399';
          }


          if (window.lucide) window.lucide.createIcons();
        }



        toast.classList.add('show');
        if (window._toastTimer) clearTimeout(window._toastTimer);
        window._toastTimer = setTimeout(() => {
          toast.classList.remove('show');
        }

          , 4200);
      }



      function handleGuideLogout() {
        localStorage.removeItem('guidia_active_user');
        localStorage.removeItem('guidia_current_user');
        localStorage.removeItem('guidia_current_guide_id_v2');
        sessionStorage.removeItem('guidia_current_user');
        sessionStorage.clear();
        window.location.href = 'login.jsp';
      }



    </script>
  </body>

  </html>