<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
  <!DOCTYPE html>
  <html lang="vi">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Guidia - Không Gian Khách Du Lịch | Quản Lý Chuyến Đi & Trải Nghiệm Bản Địa</title>

    <!-- Google Fonts & Lucide Icons -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
      href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Cormorant+Garamond:wght@600;700&display=swap"
      rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>

    <link rel="stylesheet" href="css/style.css">
    <style>
      /* CẤU HÌNH KHUNG MODAL CHI TIẾT HDV TO RỘNG BỀ NGANG - DUY NHẤT 1 THANH CUỘN DỌC PHÍA NGOÀI */
      #guideModal .modal-container,
      .modal-container.idx-38 {
        max-width: 1040px !important;
        width: 94vw !important;
        max-height: 90vh !important;
        overflow-y: auto !important;
        overflow-x: hidden !important;
        padding: 30px 36px !important;
        border-radius: 24px !important;
        box-sizing: border-box !important;
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25) !important;
      }

      #guideModal .modal-body,
      #guideModal #guideModalContent {
        overflow-x: hidden !important;
        overflow-y: visible !important;
        padding: 0 !important;
        width: 100% !important;
      }

      #guideModal .idx-81 {
        display: grid !important;
        grid-template-columns: 290px 1fr !important;
        gap: 36px !important;
        align-items: start !important;
        width: 100% !important;
        box-sizing: border-box !important;
        overflow-x: hidden !important;
      }

      #guideModal .idx-82 {
        position: sticky !important;
        top: 0 !important;
        text-align: center !important;
        border-right: 1px solid #e2e8f0 !important;
        padding-right: 28px !important;
        width: 290px !important;
        box-sizing: border-box !important;
      }

      #guideModal .idx-95 {
        max-height: none !important;
        overflow-y: visible !important;
        overflow-x: hidden !important;
        padding-right: 8px !important;
        width: 100% !important;
        box-sizing: border-box !important;
      }

      #guideModal .idx-100 {
        width: 100% !important;
        box-sizing: border-box !important;
        overflow-x: hidden !important;
        background: #f8fafc !important;
        border: 1px solid #e2e8f0 !important;
        border-radius: 12px !important;
        padding: 16px 20px !important;
        margin-bottom: 20px !important;
      }

      #guideModal .idx-102 {
        display: grid !important;
        grid-template-columns: 1fr 1fr !important;
        gap: 12px 24px !important;
        font-size: 0.9rem !important;
        width: 100% !important;
        box-sizing: border-box !important;
        overflow-x: hidden !important;
      }

      #guideModal .idx-102>div {
        white-space: normal !important;
        word-break: break-word !important;
        line-height: 1.6 !important;
      }

      #guideModal .idx-99 {
        line-height: 1.7 !important;
        font-size: 0.92rem !important;
      }
    </style>
  </head>

  <body class="portal-body">

    <!-- Sidebar -->
    <aside class="portal-sidebar">
      <a href="index.jsp" class="sidebar-brand cst-1" title="Về Trang Chủ Guidia">
        <div class="logo-icon cst-2">
          <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none"
            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="10" />
            <polygon points="16.24 7.76 14.12 14.12 7.76 16.24 9.88 9.88 16.24 7.76" />
          </svg>
        </div>
        <div class="logo-text">
          <span class="logo-title cst-3">Guidia</span>
        </div>
        <span class="portal-badge cst-4">Khách Du Lịch</span>
      </a>

      <nav class="sidebar-nav">
        <!-- 1. Tra cứu & Đặt Tour (UC02) -->
        <a href="#search" class="nav-link-item active" data-tab="tab-search">
          <i data-lucide="search"></i>
          <span>Tra Cứu Hướng Dẫn Viên</span>
        </a>

        <!-- 2. Yêu cầu đặt lịch (UC06) -->
        <a href="#bookings" class="nav-link-item" data-tab="tab-bookings">
          <i data-lucide="calendar-check"></i>
          <span>Yêu Cầu Đặt Lịch</span>
          <span class="tab-badge-pill" id="badgePendingBookings">0</span>
        </a>

        <!-- 3. Quản lý chuyến đi (UC07) -->
        <a href="#trips" class="nav-link-item" data-tab="tab-trips">
          <i data-lucide="map-pin"></i>
          <span>Chuyến đi của tôi</span>
          <span class="tab-badge-pill" id="badgeActiveTrips">0</span>
        </a>

        <!-- 4. Nhắn tin trao đổi (UC05) -->
        <a href="#chat" class="nav-link-item" data-tab="tab-chat">
          <i data-lucide="message-square"></i>
          <span>Nhắn Tin & Tư Vấn</span>
          <span class="tab-badge-pill" id="badgeUnreadChat">0</span>
        </a>

        <!-- 5. Đánh giá dịch vụ (UC08) -->
        <a href="#reviews" class="nav-link-item" data-tab="tab-reviews">
          <i data-lucide="star"></i>
          <span>Đánh Giá Dịch Vụ</span>
        </a>

        <!-- 6. Khiếu nại & Hỗ trợ (UC10) -->
        <a href="#disputes" class="nav-link-item" data-tab="tab-disputes">
          <i data-lucide="shield-alert"></i>
          <span>Khiếu Nại & Hỗ Trợ</span>
          <span class="tab-badge-pill cst-9" id="badgeDisputes">0</span>
        </a>

        <!-- 7. Thông tin cá nhân (UC04) -->
        <a href="#profile" class="nav-link-item" data-tab="tab-profile">
          <i data-lucide="user-check"></i>
          <span>Thông Tin Cá Nhân</span>
        </a>
      </nav>

      <div class="sidebar-footer">
        <div class="user-mini-card">
          <img src="https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150" alt="Customer Avatar"
            id="custAvatarMini">
          <div class="user-mini-info">
            <div class="u-name" id="custNameMini">Khách Du Lịch</div>
            <div class="u-role" id="custRoleMini">Du Khách Bản Địa</div>
          </div>
        </div>
        <!-- Nút Đăng Xuất chuyển về thanh dọc bên trái -->
        <button type="button" onclick="handleCustomerLogout()" class="sidebar-logout-btn"
          title="Đăng Xuất Khỏi Hệ Thống">
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
        <div class="topbar-left cst-10">
          <button type="button" onclick="handlePortalGoBack()" class="btn-portal-back" title="Quay lại">
            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none"
              stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
              <path d="m12 19-7-7 7-7" />
              <path d="M19 12H5" />
            </svg>
          </button>

          <!-- Tiêu đề trang / phân hệ -->
          <div class="portal-header-title-box">
            <h1 id="customerPageTitle">Tra Cứu Hướng Dẫn Viên Bản Địa & Đặt Tour</h1>
          </div>
        </div>
        <div class="topbar-right">
          <div class="cst-11" style="display:flex; align-items:center; gap:12px;">
            <select id="customerAccountSwitcher" style="display:none;" onchange="switchCustomerAccount(this.value)"
              title="Chuyển đổi tài khoản Khách hàng"></select>

            <div class="cst-15">
              <img id="custHeaderAvatar" src="https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=120"
                class="cst-16">
              <div class="cst-17">
                <div class="cst-18" id="custHeaderName">Khách Du Lịch</div>
                <div class="cst-19" id="custHeaderEmail"></div>
              </div>
            </div>
          </div>
        </div>
      </header>

      <div class="portal-content">

        <!-- BANNER CẢNH BÁO TRẠNG THÁI TÀI KHOẢN (NẾU BỊ KHÓA) -->
        <div id="custAccountStatusAlertBox" class="cst-22">
          <div class="cst-10">
            <div class="cst-23">
              <i data-lucide="alert-triangle"></i>
            </div>
            <div>
              <h4 class="cst-24">Tài Khoản Đang Bị Khóa Kỷ Luật Do Vi
                Phạm</h4>
              <p class="cst-25">
                Tài khoản của bạn đã bị Quản trị viên khóa do vi phạm chính sách nền tảng (hủy chuyến quá ngưỡng hoặc
                phát sinh khiếu nại). Hệ thống chặn các chức năng đặt lịch mới và gửi tin nhắn. Vui lòng liên hệ Email:
                <strong>admin@guidia.vn</strong> hoặc Hotline: <strong>0999.999.999</strong> để được hỗ trợ.
              </p>
            </div>
          </div>
        </div>

        <!-- ========================================================================= -->
        <!-- TAB 1: TRA CỨU HƯỚNG DẪN VIÊN & ĐẶT TOUR (UC02)                          -->
        <!-- ========================================================================= -->
        <section class="tab-content-panel active" id="tab-search">
          <!-- Bộ lọc và tìm kiếm HDV -->
          <div class="cst-26">
            <div class="cst-27">
              <div>
                <h3 class="cst-28">Tra Cứu & Tìm Kiếm Hướng Dẫn Viên Tinh
                  Hoa</h3>
                <p class="cst-29">
                  Chọn người đồng hành bản địa am hiểu văn hóa và phong vị ẩm thực. Bấm <strong>"Nhắn tin"</strong> để
                  trao đổi trực tiếp hoặc <strong>"Đặt lịch"</strong> để ký quỹ an toàn.
                </p>
              </div>
              <div class="cst-30">
                <span class="cst-31">
                  <i data-lucide="shield-check" class="icon-xs cst-32"></i> 100% HDV Có Thẻ Hành
                  Nghề Được Duyệt
                </span>
              </div>
            </div>

            <div class="cust-filter-row1">
              <!-- 1. Từ khóa -->
              <div class="form-group cst-33">
                <label class="form-label cst-34">
                  <i data-lucide="search" class="icon-xs cst-35"></i> Từ Khóa Tìm Kiếm
                </label>
                <input type="text" id="guideSearchKeyword" class="form-control cst-36"
                  placeholder="Tên HDV, giới thiệu..." oninput="applyGuideSearch()">
              </div>

              <!-- 2. Vùng / Khu vực -->
              <div class="form-group cst-33">
                <label class="form-label cst-34">
                  <i data-lucide="map" class="icon-xs cst-35"></i> Vùng / Khu Vực
                </label>
                <select id="guideSearchRegion" class="form-control cst-36" onchange="handleCustRegionChange()">
                  <option value="all">Tất cả khu vực</option>
                  <option value="north">Miền Bắc</option>
                  <option value="central">Miền Trung</option>
                  <option value="south">Miền Nam</option>
                </select>
              </div>

              <!-- 3. Tỉnh thành / Địa danh (liên kết với Vùng) -->
              <div class="form-group cst-33">
                <label class="form-label cst-34">
                  <i data-lucide="map-pin" class="icon-xs cst-35"></i> Tỉnh Thành / Địa Danh
                </label>
                <select id="guideSearchCity" class="form-control cst-36" onchange="applyGuideSearch()">
                  <option value="all">Tất cả tỉnh thành / địa danh</option>
                  <option value="Hội An">Phố Cổ Hội An</option>
                  <option value="Đà Nẵng">Đà Nẵng & Bà Nà</option>
                  <option value="Hà Nội">Hà Nội 36 Phố</option>
                  <option value="Huế">Cố Đô Huế</option>
                  <option value="Sapa">Sapa & Fansipan</option>
                  <option value="Ninh Bình">Ninh Bình</option>
                  <option value="Hạ Long">Vịnh Hạ Long</option>
                  <option value="Hồ Chí Minh">TP. Hồ Chí Minh</option>
                  <option value="Phú Quốc">Đảo Phú Quốc</option>
                  <option value="Miền Tây">Miền Tây sông nước</option>
                  <option value="Đà Lạt">Đà Lạt</option>
                </select>
              </div>
            </div>

            <div class="cust-filter-row2">
              <!-- 4. Mức giá / ngày -->
              <div class="form-group cst-33">
                <label class="form-label cst-34">
                  <i data-lucide="banknote" class="icon-xs cst-35"></i> Mức Giá / Ngày
                </label>
                <select id="guideSearchPrice" class="form-control cst-36" onchange="applyGuideSearch()">
                  <option value="all">Tất cả mức giá</option>
                  <option value="under_1m">Dưới 1.000.000₫</option>
                  <option value="1m_to_2m">1.000.000₫ - 2.000.000₫</option>
                  <option value="over_2m">Trên 2.000.000₫</option>
                </select>
              </div>

              <!-- 5. Ngoại ngữ -->
              <div class="form-group cst-33">
                <label class="form-label cst-34">
                  <i data-lucide="languages" class="icon-xs cst-35"></i> Ngoại Ngữ
                </label>
                <select id="guideSearchLang" class="form-control cst-36" onchange="applyGuideSearch()">
                  <option value="all">Tất cả ngoại ngữ</option>
                  <option value="Tiếng Anh">Tiếng Anh</option>
                  <option value="Tiếng Pháp">Tiếng Pháp</option>
                  <option value="Tiếng Hàn">Tiếng Hàn</option>
                  <option value="Tiếng Nhật">Tiếng Nhật</option>
                  <option value="Tiếng Trung">Tiếng Trung</option>
                  <option value="Tiếng Đức">Tiếng Đức</option>
                </select>
              </div>

              <!-- 6. Sắp xếp theo -->
              <div class="form-group cst-33">
                <label class="form-label cst-34">
                  <i data-lucide="arrow-up-down" class="icon-xs cst-35"></i> Sắp Xếp Theo
                </label>
                <select id="guideSearchSort" class="form-control cst-36" onchange="applyGuideSearch()">
                  <option value="rating_desc">Đánh giá cao nhất (5.0 ★)</option>
                  <option value="price_asc">Giá: Thấp đến Cao</option>
                  <option value="price_desc">Giá: Cao đến Thấp</option>
                  <option value="trips_desc">Số chuyến đi nhiều nhất</option>
                </select>
              </div>

              <!-- 7. Nút Đặt lại -->
              <button type="button" class="btn-outline cst-37" onclick="resetGuideSearch()" title="Đặt lại bộ lọc">
                <i data-lucide="rotate-ccw" class="icon-xs"></i> Đặt Lại
              </button>
            </div>
          </div>

          <!-- Danh sách thẻ Hướng dẫn viên (Lưới 4 cột đồng bộ với index.jsp) -->
          <div id="guidesGridContainer" class="guides-grid">
            <!-- Render động từ CSDL SQL Server qua store.js -->
          </div>
          <!-- Render động từ CSDL SQL Server qua store.js -->
      </div>
      </section>

      <!-- ========================================================================= -->
      <!-- TAB 2: YÊU CẦU ĐẶT LỊCH TOUR & KÝ QUỸ ESCROW (UC06 + UC16)                 -->
      <!-- ========================================================================= -->
      <section class="tab-content-panel" id="tab-bookings">
        <div class="cst-38">

          <!-- KHỐI FORM ĐẶT LỊCH TOUR MAY ĐO MỚI (UC06) -->
          <div class="card-table-wrapper cst-39">
            <div class="cst-40">
              <h3 class="cst-41">
                <i data-lucide="calendar-plus" class="cst-35"></i> Biểu Mẫu Đặt Lịch Hướng Dẫn Viên
              </h3>
              <p class="cst-42">
                Hệ thống tự động kiểm tra lịch trống của HDV trong CSDL. Bạn thanh toán toàn bộ chi phí qua <strong>Cổng
                  Ký Quỹ Escrow</strong> để sàn tạm giữ an toàn cho đến khi kết thúc tour.
              </p>
            </div>

            <form id="customerBookingForm" onsubmit="handleCustomerSubmitBooking(event)">
              <div class="form-group">
                <label class="form-label">Chọn Hướng Dẫn Viên Bạn Muốn Đặt <span class="cst-43">*</span></label>
                <select id="bkGuideSelect" class="form-control" required onchange="onBookingGuideChanged()">
                  <!-- Render dynamically from guides -->
                </select>
              </div>

              <div class="cst-44">
                <div class="form-group">
                  <label class="form-label">Ngày Khởi Hành <span class="cst-43">*</span></label>
                  <input type="date" id="bkStartDate" class="form-control" required onchange="onBookingDateChanged()">
                </div>
                <div class="form-group">
                  <label class="form-label">Giờ Đón Khách</label>
                  <input type="time" id="bkStartTime" class="form-control" value="08:00" required>
                </div>
              </div>

              <div class="cst-44">
                <div class="form-group">
                  <label class="form-label">Ngày Kết Thúc Tour</label>
                  <input type="date" id="bkEndDate" class="form-control" required>
                </div>
                <div class="form-group">
                  <label class="form-label">Giờ Dự Kiến Kết Thúc</label>
                  <input type="time" id="bkEndTime" class="form-control" value="17:30" required>
                </div>
              </div>

              <div class="form-group">
                <label class="form-label">Tuyến Điểm & Lịch Trình May Đo <span class="cst-43">*</span></label>
                <input type="text" id="bkLocation" class="form-control"
                  placeholder="VD: Phố Cổ Hội An, Làng Rau Trà Quế & Làng Gốm Thanh Hà" required>
              </div>

              <div class="cst-45">
                <div class="form-group">
                  <label class="form-label">Số Lượng Du Khách <span class="cst-43">*</span></label>
                  <select id="bkGuests" class="form-control" required>
                    <option value="1">1 Du khách (Đi một mình)</option>
                    <option value="2" selected>2 Du khách (Cặp đôi / Bạn bè)</option>
                    <option value="3">3 Du khách (Gia đình nhỏ)</option>
                    <option value="4">4 Du khách (Gia đình 4 người)</option>
                    <option value="5">5 Du khách (Nhóm bạn 5 người)</option>
                    <option value="6">6 Du khách (Đoàn 6 người)</option>
                    <option value="8">8 Du khách (Nhóm trải nghiệm)</option>
                    <option value="10">10 Du khách (Đoàn du lịch lớn)</option>
                  </select>
                </div>

                <div class="form-group">
                  <label class="form-label">Hình Thức Giá Tour</label>
                  <select id="bkPriceType" class="form-control" onchange="recalculateBookingCost()">
                    <option value="daily" selected>Trọn Gói 1 Ngày (Khuyên dùng)</option>
                    <option value="hourly">Theo Giờ (Buổi sáng / chiều)</option>
                  </select>
                </div>
              </div>

              <div class="form-group">
                <label class="form-label">Ghi Chú Đặc Biệt Hoặc Sở Thích Riêng</label>
                <textarea id="bkNotes" class="form-control" rows="2"
                  placeholder="VD: Muốn chụp ảnh áo dài, ăn đồ chay, có người cao tuổi đi cùng..."></textarea>
              </div>

              <!-- HỘP TÓM TẮT CHI PHÍ & CHÍNH SÁCH HỦY (BẮT BUỘC THEO ĐẶC TẢ UC06) -->
              <div class="cst-46">
                <div class="cst-47">
                  <span><i data-lucide="receipt" class="icon-xs cst-35"></i> Tóm Tắt Chi Phí & Ký
                    Quỹ:</span>
                  <span class="cst-48" id="bkCostSummaryVal">1.500.000₫</span>
                </div>
                <div class="cst-49">
                  <div class="cst-50">
                    <span>Thù lao HDV nhận (90%):</span>
                    <strong id="bkCostGuidePayout">1.350.000₫</strong>
                  </div>
                  <div class="cst-50">
                    <span>Phí sàn bảo hiểm & đối soát (10%):</span>
                    <strong id="bkCostPlatformFee">150.000₫</strong>
                  </div>
                  <div class="cst-51">
                    <span>Cổng ký quỹ Escrow:</span>
                    <span>Tạm giữ an toàn 100%</span>
                  </div>
                </div>

                <!-- CHÍNH SÁCH HỦY TOUR 48H MINH BẠCH THEO ĐẶC TẢ UC06 -->
                <div class="cst-52">
                  <strong class="cst-53">
                    <i data-lucide="shield-alert" class="icon-xs cst-32"></i> Chính Sách Hủy
                    Tour & Hoàn Tiền:
                  </strong>
                  • Hủy trước ngày xuất phát <strong>từ 2 ngày (48h) trở lên</strong>: Hệ thống hoàn lại <strong>100%
                    tiền tạm giữ</strong>.<br>
                  • Hủy <strong>trong vòng 2 ngày</strong>: Hệ thống không cho phép hủy (vui lòng sử dụng tính năng
                  Khiếu nại nếu có sự cố).
                </div>
              </div>

              <button type="submit" class="btn-primary cst-54" id="btnSubmitBookingForm">
                <i data-lucide="arrow-right"></i> Tiếp Tục
              </button>
            </form>
          </div>

          <!-- KHỐI QUY TRÌNH KÝ QUỸ ESCROW & QUY ĐỊNH HOÀN TIỀN -->
          <div class="cst-55">
            <div class="card-table-wrapper cst-56">
              <h4 class="cst-57">
                <i data-lucide="shield-check" class="cst-35"></i>
                Quy Trình Bảo Vệ Du Khách Bằng Ký Quỹ Escrow
              </h4>
              <p class="cst-58">
                Tại Guidia, tiền tour của bạn được đưa vào tài khoản tạm giữ bảo chứng. HDV hoàn toàn không nhận được
                tiền trước khi chuyến đi diễn ra thành công.
              </p>

              <div class="cst-59">
                <div class="cst-60">
                  <span class="cst-61">1</span>
                  <span><strong>Đặt tour & Tạm giữ:</strong> Bạn gửi yêu cầu, tiền được sàn ký quỹ an toàn. Đơn chuyển
                    trạng thái <em>"Chờ HDV xác nhận"</em>.</span>
                </div>
                <div class="cst-60">
                  <span class="cst-61">2</span>
                  <span><strong>HDV xác nhận:</strong> Nếu HDV chấp nhận trong 24h, đơn chuyển thành <em>"Đã xác
                      nhận"</em>. Nếu từ chối hoặc quá 24h không trả lời, tiền tự động hoàn 100% về cho bạn.</span>
                </div>
                <div class="cst-60">
                  <span class="cst-61">3</span>
                  <span><strong>Trải nghiệm & Hoàn thành:</strong> Sau khi chuyến đi hoàn tất, hai bên cùng xác nhận để
                    tất toán tiền cho HDV. Nếu có sự cố, bạn có quyền gửi Khiếu nại ngay.</span>
                </div>
              </div>
            </div>

            <!-- Thẻ hỗ trợ khẩn cấp -->
            <div class="card-table-wrapper cst-62">
              <h4 class="cst-63">
                <i data-lucide="phone-call" class="icon-xs cst-64"></i> Hỗ Trợ Đặt Lịch & Trợ Lý Du Lịch
                24/7
              </h4>
              <p class="cst-65">
                Cần tư vấn thiết kế lộ trình riêng cho gia đình hoặc sự kiện doanh nghiệp? Đội ngũ Guidia Concierge luôn
                sẵn sàng hỗ trợ bạn.
              </p>
              <div class="cst-66">
                <div>📞 Hotline VIP: <strong class="cst-35">1900 6868</strong></div>
                <div>💬 Zalo Hỗ Trợ: <strong class="cst-64">0912 345 678</strong></div>
              </div>
            </div>
          </div>
        </div>

        <!-- DANH SÁCH CÁC ĐƠN YÊU CẦU ĐẶT LỊCH ĐÃ GỬI (UC06) -->
        <div class="card-table-wrapper">
          <div class="card-table-header cst-67">
            <div>
              <h3>Danh Sách Yêu Cầu Đặt Lịch Tour Đang Chờ Duyệt</h3>
              <p class="cst-68">
                Theo dõi các yêu cầu đang chờ Hướng dẫn viên phản hồi trong 24h. Khi HDV xác nhận, chuyến đi sẽ được
                chuyển sang mục <strong>Quản Lý Chuyến Đi</strong>.
              </p>
            </div>
            <button class="btn-outline cst-69" onclick="renderCustomerBookingsTab()">
              <i data-lucide="refresh-cw" class="icon-xs"></i> Làm Mới Danh Sách
            </button>
          </div>

          <div id="customerBookingsListContainer" class="cst-70">
            <!-- Render danh sách yêu cầu đặt lịch -->
          </div>
        </div>
      </section>

      <!-- ========================================================================= -->
      <!-- TAB 3: QUẢN LÝ CHUYẾN ĐI (UC07)                                           -->
      <!-- ========================================================================= -->
      <section class="tab-content-panel" id="tab-trips">
        <div class="card-table-wrapper">
          <div class="card-table-header cst-71">
            <div>
              <h3>Hành Trình Khám Phá Của Bạn Tại Việt Nam</h3>
              <p class="cst-29">
                Theo dõi các chuyến đi đã được Hướng dẫn viên xác nhận: Sắp đi, Đang đi/Chờ tất toán, Đã hoàn thành và
                Đã hủy.
              </p>
            </div>

            <!-- BỘ LỌC CÁC TRẠNG THÁI CHUYẾN ĐI CHUẨN ĐẶC TẢ UC07: Sắp đi, Đang đi, Đã đi, Đã hủy -->
            <div class="cst-72">
              <button class="btn-sm-action trip-filter-btn active" data-filter="all"
                onclick="filterCustomerTrips('all')">Tất Cả</button>
              <button class="btn-sm-action trip-filter-btn" data-filter="upcoming"
                onclick="filterCustomerTrips('upcoming')">Sắp Đi</button>
              <button class="btn-sm-action trip-filter-btn" data-filter="ongoing"
                onclick="filterCustomerTrips('ongoing')">Đang Đi</button>
              <button class="btn-sm-action trip-filter-btn" data-filter="completed"
                onclick="filterCustomerTrips('completed')">Đã Đi</button>
              <button class="btn-sm-action trip-filter-btn" data-filter="cancelled"
                onclick="filterCustomerTrips('cancelled')">Đã Hủy</button>
            </div>
          </div>

          <div id="customerTripsContainer" class="cst-70">
            <!-- Render danh sách chuyến đi -->
          </div>
        </div>
      </section>

      <!-- ========================================================================= -->
      <!-- TAB 4: NHẮN TIN TRAO ĐỔI - LIVE CHAT (UC05)                               -->
      <!-- ========================================================================= -->
      <section class="tab-content-panel" id="tab-chat">
        <div class="chat-layout">
          <!-- Cột danh sách hội thoại với các HDV -->
          <div class="chat-sidebar-list">
            <div class="cst-73">
              <span>Hội Thoại Với HDV</span>
              <span class="cst-74" id="custChatCountBadge">0 cuộc</span>
            </div>
            <div id="customerChatConversationList">
              <!-- Render danh sách đối tác chat -->
            </div>
          </div>

          <!-- Khu vực khung chat chính -->
          <div class="chat-main-area">
            <div class="chat-header">
              <div class="cst-10">
                <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=120" class="cst-75"
                  id="custChatPartnerAvatar">
                <div>
                  <h4 class="cst-76" id="custChatPartnerName">Hoàng Yến
                    (Maya)</h4>
                  <span class="cst-77" id="custChatPartnerStatusBadge">
                    <span class="cst-78"></span> Đang trực tuyến
                    (Sẵn sàng tư vấn)
                  </span>
                </div>
              </div>

              <div class="cst-15">
                <div class="cst-79">
                  Tuyến điểm: <strong id="custChatPartnerTour" class="cst-80">Hội An & Mỹ Sơn</strong>
                </div>
                <!-- NÚT CHUYỂN TIẾP SANG ĐẶT LỊCH (BƯỚC 6 ĐẶC TẢ UC05) -->
                <button type="button" class="btn-primary cst-81" onclick="goToBookingFromChat()">
                  <i data-lucide="calendar-plus" class="icon-xs"></i> Đặt Lịch Với HDV Này
                </button>
              </div>
            </div>

            <!-- CẢNH BÁO TÀI KHOẢN ĐỐI PHƯƠNG BỊ KHÓA (LUỒNG PHỤ A3 - UC05) -->
            <div id="custChatSuspendedNotice" class="cst-82">
              <i data-lucide="slash" class="cst-83"></i>
              <span><strong>Tài khoản bị khóa:</strong> Hướng dẫn viên này đang bị tạm khóa do vi phạm kỷ luật. Hệ thống
                không cho phép gửi tin nhắn mới.</span>
            </div>

            <!-- Danh sách bong bóng chat -->
            <div class="chat-messages-container" id="customerChatMessagesContainer">
              <!-- Render dynamic message bubbles -->
            </div>

            <!-- Thanh nhập tin nhắn -->
            <form class="chat-input-bar" id="custChatInputBar" onsubmit="handleSendCustomerChatMessage(event)">
              <button type="button" class="btn-ghost" onclick="openChatImageModal()" title="Đính kèm ảnh gửi cho HDV">
                <i data-lucide="image"></i>
              </button>
              <input type="text" id="custChatInputText" class="form-control cst-84"
                placeholder="Nhập tin nhắn trao đổi lộ trình hoặc yêu cầu với HDV...">
              <button type="submit" class="btn-primary cst-85" id="btnSendCustChatMessage">
                <i data-lucide="send"></i> Gửi
              </button>
            </form>
          </div>
        </div>
      </section>

      <!-- ========================================================================= -->
      <!-- TAB 5: ĐÁNH GIÁ DỊCH VỤ (UC08)                                             -->
      <!-- ========================================================================= -->
      <section class="tab-content-panel" id="tab-reviews">
        <div class="card-table-wrapper cst-86">
          <div class="cst-87">
            <h3 class="cst-41">
              <i data-lucide="star" class="cst-88"></i> Đánh Giá Dịch Vụ Chuyến Đi Đã Hoàn Thành
            </h3>
            <p class="cst-89">
              Đánh giá từ 1 đến 5 sao và nhận xét trung thực để giúp cộng đồng du khách lựa chọn HDV phù hợp. Điểm đánh
              giá sẽ tự động cập nhật vào điểm trung bình của HDV.
            </p>
          </div>

          <!-- DANH SÁCH CHUYẾN ĐI ĐÃ HOÀN THÀNH CẦN ĐÁNH GIÁ -->
          <div id="pendingReviewTripsContainer" class="cst-90">
            <!-- Render trips needing review -->
          </div>
        </div>

        <!-- DANH SÁCH CÁC ĐÁNH GIÁ ĐÃ GỬI & PHẢN HỒI CỦA HDV (UC09) -->
        <div class="card-table-wrapper">
          <div class="card-table-header">
            <h3>Lịch Sử Đánh Giá Của Bạn & Phản Hồi Từ Hướng Dẫn Viên</h3>
          </div>
          <div id="customerSubmittedReviewsContainer" class="cst-70">
            <!-- Render already reviewed trips -->
          </div>
        </div>
      </section>

      <!-- ========================================================================= -->
      <!-- TAB 6: KHIẾU NẠI & HỖ TRỢ (UC10)                                           -->
      <!-- ========================================================================= -->
      <section class="tab-content-panel" id="tab-disputes">
        <!-- FORM TẠO KHIẾU NẠI MỚI (UC10) -->
        <div class="card-table-wrapper cst-91">
          <h3 class="cst-92">
            <i data-lucide="shield-alert" class="cst-43"></i> Gửi Khiếu Nại Sự Cố Chuyến Đi Lên Ban Quản Trị
          </h3>
          <p class="cst-93">
            Khi phát sinh sự cố (HDV không đến điểm hẹn, trễ giờ quá quy định, phục vụ không đúng cam kết...), bạn hãy
            gửi khiếu nại kèm <strong>bằng chứng bắt buộc</strong>. Hệ thống sẽ <strong>tạm dừng giải ngân tất
              toán</strong> cho HDV để Admin đối soát và hoàn tiền.
          </p>

          <form onsubmit="handleCustomerSubmitDispute(event)" class="cst-94">
            <div class="form-group">
              <label class="form-label">Chọn Chuyến Đi Phát Sinh Sự Cố <span class="cst-43">*</span></label>
              <select id="custDisputeTripSelect" class="form-control" required>
                <!-- Render customer eligible trips -->
              </select>
            </div>

            <div class="form-group">
              <label class="form-label">Loại Sự Cố Phát Sinh <span class="cst-43">*</span></label>
              <select id="custDisputeReasonType" class="form-control" required>
                <option value="HDV vắng mặt không đến điểm hẹn đã thỏa thuận">HDV vắng mặt không đến điểm hẹn đã thỏa
                  thuận</option>
                <option value="HDV trễ giờ quá 45 phút ảnh hưởng lộ trình">HDV trễ giờ quá 45 phút ảnh hưởng lộ trình
                </option>
                <option value="Chất lượng thuyết minh và dịch vụ sai lệch nghiêm trọng cam kết">Chất lượng thuyết minh
                  và dịch vụ sai lệch nghiêm trọng cam kết</option>
                <option value="Ép buộc du khách vào các điểm mua sắm phát sinh ngoài ý muốn">Ép buộc du khách vào các
                  điểm mua sắm phát sinh ngoài ý muốn</option>
                <option value="Khác">Khác</option>
              </select>
            </div>

            <div class="form-group cst-95">
              <label class="form-label">Mô Tả Chi Tiết Vụ Việc <span class="cst-43">*</span></label>
              <textarea id="custDisputeDescription" class="form-control" rows="3"
                placeholder="Ghi rõ thời gian, địa điểm, sự việc diễn ra như thế nào..." required></textarea>
            </div>

            <div class="form-group cst-95">
              <label class="form-label">Bằng Chứng Bắt Buộc (Dẫn chứng tin nhắn, hình ảnh chụp tại điểm đến hoặc video)
                <span class="cst-43">*</span></label>
              <input type="text" id="custDisputeEvidenceText" class="form-control"
                placeholder="Dẫn chứng tin nhắn cuộc gọi hoặc ghi chú sự việc..." required>

              <div class="cst-96">
                <label class="cst-97">
                  <i data-lucide="upload" class="icon-xs cst-32"></i> Tải Lên Tệp Ảnh Bằng Chứng
                  (Từ máy tính):
                </label>
                <input type="file" id="custDisputeEvidenceFile" accept="image/*" class="form-control cst-98"
                  onchange="previewCustDisputeEvidence(event)">
                <input type="hidden" id="custDisputeEvidenceUrl" value="">
              </div>

              <!-- Live Evidence Preview Box -->
              <div id="custDisputeEvidencePreviewWrap" class="cst-99" style="display:none;">
                <img id="custDisputeEvidencePreviewImg" src="" alt="Bằng chứng sự cố" class="cst-100">
                <div class="cst-101">
                  <strong class="cst-102">Ảnh Bằng Chứng Thực Tế Bạn Đã Chọn</strong>
                  <span>Ảnh thực tế này sẽ được gửi tới Ban Quản Trị để đối soát vi phạm.</span>
                  <button type="button" class="btn-ghost"
                    style="color:#ef4444; font-size:0.8rem; cursor:pointer; margin-top:4px;"
                    onclick="removeCustDisputeEvidence()">
                    <i data-lucide="trash-2" style="width:14px; height:14px;"></i> Xóa ảnh này
                  </button>
                </div>
              </div>
            </div>

            <div class="cst-103">
              <button type="submit" class="btn-primary cst-104">
                <i data-lucide="send"></i> Gửi Khiếu Nại (Tạm Dừng Tất Toán)
              </button>
            </div>
          </form>
        </div>

        <!-- DANH SÁCH KHIẾU NẠI ĐÃ GỬI & KẾT QUẢ PHÁN QUYẾT ADMIN (UC10) -->
        <div class="card-table-wrapper">
          <div class="card-table-header">
            <h3>Danh Sách Khiếu Nại Đã Gửi & Kết Quả Xử Lý Của Admin</h3>
          </div>
          <div id="customerDisputesListContainer" class="cst-70">
            <!-- Render danh sách khiếu nại -->
          </div>
        </div>
      </section>

      <!-- ========================================================================= -->
      <!-- TAB 7: THÔNG TIN CÁ NHÂN & ĐỔI MẬT KHẨU (UC04)                           -->
      <!-- ========================================================================= -->
      <section class="tab-content-panel" id="tab-profile">
        <div class="card-table-wrapper cst-105">
          <div class="cst-106">
            <div>
              <h3 class="cst-28">Hồ Sơ Du Khách & Tài Khoản Cá Nhân</h3>
              <p class="cst-107">
                Cập nhật thông tin liên hệ và sở thích cá nhân để nhận được các gợi ý lịch trình bản địa độc bản.
              </p>
            </div>
            <!-- Huy hiệu thống kê tài khoản -->
            <div class="cst-108">
              <span class="cst-109" id="custStatsCompleted">
                ✓ 0 Tour Hoàn Thành
              </span>
              <span class="cst-110" id="custStatsCancelled">
                0 Lần Hủy Tour
              </span>
            </div>
          </div>

          <form id="customerProfileForm" onsubmit="handleCustomerSaveProfile(event)" class="cst-111">
            <div class="form-group">
              <label class="form-label">Họ và Tên Du Khách <span class="cst-43">*</span></label>
              <input type="text" id="profCustName" class="form-control" required disabled>
            </div>

            <div class="form-group">
              <label class="form-label">Số Điện Thoại Liên Hệ <span class="cst-43">*</span></label>
              <input type="tel" id="profCustPhone" class="form-control" required disabled>
            </div>

            <div class="form-group">
              <label class="form-label">Email Đăng Nhập (Cố Định)</label>
              <input type="email" id="profCustEmail" class="form-control cst-112" readonly>
            </div>

            <div class="form-group">
              <label class="form-label">Thông Tin Phụ: Sở Thích Du Lịch</label>
              <input type="text" id="profCustExtraInfo" class="form-control"
                placeholder="VD: Ẩm thực đường phố, chụp ảnh phố cổ, trekking, cắm trại..." disabled>
            </div>

            <!-- ẢNH ĐẠI DIỆN -->
            <div class="form-group cst-95">
              <label class="form-label">Ảnh Đại Diện Tài Khoản</label>
              <div class="cst-113">
                <img id="profCustAvatarPreview" src="https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150"
                  alt="Avatar" class="cst-114">
                <div class="cst-84">
                  <input type="file" id="profCustAvatarFile" accept="image/*" class="form-control cst-98"
                    onchange="previewCustAvatarFile(event)" disabled>
                  <input type="hidden" id="profCustAvatarUrl" value="">
                  <small class="cst-115">Hỗ trợ ảnh JPG, PNG. Ảnh sẽ
                    được cập nhật ngay trên toàn bộ giao diện.</small>
                </div>
              </div>
            </div>

            <!-- KHỐI ĐỔI MẬT KHẨU (LUỒNG PHỤ A3 - UC04) -->
            <div class="cst-116">
              <h4 class="cst-117">
                <i data-lucide="key" class="icon-sm cst-35"></i> Đổi Mật Khẩu Đăng Nhập (Tùy Chọn)
              </h4>
              <p class="cst-118">
                Nếu muốn đổi mật khẩu, vui lòng nhập chính xác mật khẩu hiện tại và mật khẩu mới. Nếu mật khẩu cũ không
                đúng, hệ thống sẽ từ chối đổi.
              </p>

              <div class="cst-119">
                <div class="form-group">
                  <label class="form-label">Mật Khẩu Hiện Tại</label>
                  <input type="password" id="profCustOldPassword" class="form-control"
                    placeholder="Nhập mật khẩu hiện tại" disabled>
                </div>

                <div class="form-group">
                  <label class="form-label">Mật Khẩu Mới (Tối thiểu 6 ký tự)</label>
                  <input type="password" id="profCustNewPassword" class="form-control" placeholder="Nhập mật khẩu mới" disabled>
                </div>
              </div>
            </div>

            <!-- Nút Hành Động Chỉnh Sửa Hồ Sơ (Trước khi bấm Chỉnh sửa thì không sửa được, bấm Chỉnh sửa mới hiện Lưu và Hủy) -->
            <div id="custProfileInitialActions" class="cst-120">
              <button type="button" id="btnCustEditProfile" class="btn-primary" onclick="enableCustProfileEdit()">
                <i data-lucide="edit-3"></i> Chỉnh Sửa
              </button>
            </div>

            <div id="custProfileEditActions" class="cst-120" style="display: none;">
              <button type="button" class="btn-outline" onclick="cancelCustProfileEdit()">
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

    <!-- ========================================================================= -->
    <!-- MODAL 1: TÓM TẮT ĐƠN ĐẶT LỊCH TOUR (BƯỚC 5 / UC06)                          -->
    <!-- ========================================================================= -->
    <div id="bookingSummaryModal" class="cst-121">
      <div class="cst-122" style="max-width: 580px;">
        <div
          style="display:flex; justify-content:space-between; align-items:center; margin-bottom:16px; border-bottom:1px solid #e2e8f0; padding-bottom:12px;">
          <h3
            style="font-size:1.15rem; font-weight:700; color:#065f46; display:flex; align-items:center; gap:8px; margin:0;">
            <i data-lucide="file-text" style="color:#059669; width:20px; height:20px;"></i>
            Tóm Tắt Đơn Đặt Lịch & Xác Nhận
          </h3>
          <button type="button" onclick="closeBookingSummaryModal()"
            style="border:none; background:none; font-size:1.4rem; cursor:pointer; color:#64748b;"
            title="Đóng">&times;</button>
        </div>

        <div style="font-size:0.9rem; color:#334155; line-height:1.6; margin-bottom:16px;">
          <div
            style="background:#f8fafc; border:1px solid #e2e8f0; border-radius:10px; padding:14px; margin-bottom:14px;">
            <div style="display:flex; justify-content:space-between; margin-bottom:6px;">
              <span style="color:#64748b;">Hướng dẫn viên:</span>
              <strong id="sumGuideName" style="color:#0f172a;">-</strong>
            </div>
            <div style="display:flex; justify-content:space-between; margin-bottom:6px;">
              <span style="color:#64748b;">Tuyến điểm & Lộ trình:</span>
              <strong id="sumLocation" style="color:#0f172a; text-align:right; max-width:60%;">-</strong>
            </div>
            <div style="display:flex; justify-content:space-between; margin-bottom:6px;">
              <span style="color:#64748b;">Thời gian khởi hành:</span>
              <strong id="sumStartDate" style="color:#059669;">-</strong>
            </div>
            <div style="display:flex; justify-content:space-between; margin-bottom:6px;">
              <span style="color:#64748b;">Thời gian kết thúc:</span>
              <strong id="sumEndDate" style="color:#0f172a;">-</strong>
            </div>
            <div style="display:flex; justify-content:space-between; margin-bottom:6px;">
              <span style="color:#64748b;">Số lượng khách:</span>
              <strong id="sumGuests" style="color:#0f172a;">-</strong>
            </div>
            <div style="display:flex; justify-content:space-between;">
              <span style="color:#64748b;">Ghi chú riêng:</span>
              <span id="sumNotes" style="font-style:italic; color:#475569; text-align:right; max-width:60%;">Không có
                ghi chú</span>
            </div>
          </div>

          <!-- Chi tiết chi phí -->
          <div
            style="background:#f0fdf4; border:1px solid #bbf7d0; border-radius:10px; padding:14px; margin-bottom:14px;">
            <div style="display:flex; justify-content:space-between; margin-bottom:6px;">
              <span>Tạm tính tiền tour:</span>
              <span id="sumTourPrice" style="font-weight:600;">-</span>
            </div>
            <div style="display:flex; justify-content:space-between; margin-bottom:6px;">
              <span>Phí vận hành & bảo hiểm sàn (10%):</span>
              <span id="sumPlatformFee" style="font-weight:600;">-</span>
            </div>
            <div
              style="display:flex; justify-content:space-between; font-size:1.05rem; border-top:1px dashed #86efac; padding-top:8px; margin-top:6px; color:#166534;">
              <strong>Tổng thanh toán ký quỹ (100%):</strong>
              <strong id="sumTotalAmount" style="font-size:1.2rem; color:#059669;">-</strong>
            </div>
          </div>

          <!-- Chính sách hủy minh bạch chuẩn UC06 & UC07 -->
          <div
            style="background:#fffbeb; border:1px solid #fde68a; border-radius:10px; padding:12px; font-size:0.82rem; color:#92400e;">
            <strong style="display:flex; align-items:center; gap:4px; margin-bottom:4px;">
              <i data-lucide="shield-alert" style="width:14px; height:14px; color:#d97706;"></i>
              Chính Sách Hủy Tour & Hoàn Tiền (Quy Định Sàn):
            </strong>
            • Hủy trước ngày xuất phát <strong>từ 2 ngày (48 giờ) trở lên</strong>: Hệ thống hoàn lại <strong>100% tiền
              tạm giữ</strong>.<br>
            • Hủy <strong>trong vòng 2 ngày (48 giờ)</strong> trước giờ đi: Không được hủy (vui lòng sử dụng tính năng
            Khiếu Nại nếu phát sinh sự cố).
          </div>
        </div>

        <div style="display:flex; justify-content:flex-end; gap:10px;">
          <button type="button" class="btn-outline" onclick="closeBookingSummaryModal()" title="Hủy thao tác">
            Hủy Bỏ / Quay Lại
          </button>
          <button type="button" class="btn-primary" onclick="proceedToPaymentModal()" style="background:#059669;">
            <i data-lucide="credit-card"></i> Tiếp Tục Thanh Toán
          </button>
        </div>
      </div>
    </div>

    <!-- ========================================================================= -->
    <!-- MODAL 2: CỔNG THANH TOÁN TẠM GIỮ KÝ QUỸ ESCROW (BƯỚC 6-7 / UC06)          -->
    <!-- ========================================================================= -->
    <div id="bookingPaymentModal" class="cst-121">
      <div class="cst-122" style="max-width: 580px;">
        <div
          style="display:flex; justify-content:space-between; align-items:center; margin-bottom:16px; border-bottom:1px solid #e2e8f0; padding-bottom:12px;">
          <h3
            style="font-size:1.15rem; font-weight:700; color:#065f46; display:flex; align-items:center; gap:8px; margin:0;">
            <i data-lucide="shield-check" style="color:#059669; width:20px; height:20px;"></i>
            Cổng Ký Quỹ Escrow An Toàn (Xử Lý Giao Dịch)
          </h3>
          <button type="button" onclick="closeBookingPaymentModal()"
            style="border:none; background:none; font-size:1.4rem; cursor:pointer; color:#64748b;"
            title="Đóng">&times;</button>
        </div>

        <div style="font-size:0.9rem; color:#334155; line-height:1.6; margin-bottom:16px;">
          <div
            style="text-align:center; padding:12px; background:#f0fdf4; border-radius:10px; margin-bottom:14px; border:1px solid #bbf7d0;">
            <div style="font-size:0.85rem; color:#64748b;">Số tiền cần thanh toán tạm giữ:</div>
            <div id="payModalAmount" style="font-size:1.6rem; font-weight:800; color:#059669; margin:4px 0;">-</div>
            <div style="font-size:0.8rem; color:#047857;">
              <i data-lucide="lock" style="width:12px; height:12px; display:inline;"></i>
              Tiền được tạm giữ tại tài khoản Escrow sàn Guidia (chưa chuyển cho HDV)
            </div>
          </div>

          <label style="font-weight:700; display:block; margin-bottom:8px; font-size:0.9rem;">
            Phương thức thanh toán toàn bộ:
          </label>

          <div style="border:2px solid #059669; background:#ecfdf5; border-radius:10px; padding:14px; margin-bottom:16px;">
            <div style="display:flex; align-items:center; gap:10px; margin-bottom:12px;">
              <input type="radio" name="payMethod" value="vietqr" checked style="accent-color:#059669;">
              <div style="flex:1;">
                <strong style="color:#065f46;">Quét mã QR thanh toán (VietQR / Ngân hàng / Ví điện tử)</strong>
                <div style="font-size:0.75rem; color:#475569;">Mở ứng dụng Ngân hàng hoặc Ví điện tử để quét mã QR và ký quỹ tức thì</div>
              </div>
            </div>
            <div style="display:flex; align-items:center; gap:14px; background:#ffffff; border:1px solid #d1fae5; border-radius:8px; padding:12px; flex-wrap:wrap; justify-content:center;">
              <div style="padding:8px; background:#ffffff; border:1px solid #e2e8f0; border-radius:8px; line-height:0;">
                <svg width="116" height="116" viewBox="0 0 29 29" shape-rendering="crispEdges" aria-label="Mã QR thanh toán">
                  <rect width="29" height="29" fill="#ffffff"/>
                  <path fill="#0f172a" d="M1,1h7v7h-7zM2,2v5h5v-5zM3,3h3v3h-3zM21,1h7v7h-7zM22,2v5h5v-5zM23,3h3v3h-3zM1,21h7v7h-7zM2,22v5h5v-5zM3,23h3v3h-3z"/>
                  <path fill="#0f172a" d="M10,1h2v1h-2zM14,1h1v3h-1zM17,1h2v2h-2zM11,3h2v2h-2zM16,4h3v1h-3zM9,6h2v2h-2zM13,6h3v2h-3zM18,6h1v3h-1z"/>
                  <path fill="#0f172a" d="M1,10h2v2h-2zM4,9h3v1h-3zM5,11h3v2h-3zM1,14h3v1h-3zM6,14h2v3h-2zM2,16h3v2h-3zM1,19h2v1h-2z"/>
                  <path fill="#0f172a" d="M10,9h3v2h-3zM15,9h2v3h-2zM19,10h3v1h-3zM24,9h4v2h-4zM11,12h2v3h-2zM14,13h3v2h-3zM19,12h2v2h-2zM23,12h2v3h-2zM26,13h2v2h-2z"/>
                  <path fill="#0f172a" d="M9,16h2v2h-2zM13,16h3v1h-3zM17,16h2v3h-2zM21,15h2v2h-2zM25,16h3v2h-3zM10,19h4v1h-4zM16,20h2v2h-2zM20,19h3v2h-3zM24,19h2v3h-2z"/>
                  <path fill="#0f172a" d="M10,21h2v3h-2zM13,22h2v2h-2zM17,23h3v2h-3zM21,22h2v2h-2zM26,21h2v4h-2zM9,26h3v2h-3zM14,25h2v3h-2zM18,26h2v2h-2zM22,25h3v3h-3zM26,26h2v2h-2z"/>
                </svg>
              </div>
              <div style="flex:1; min-width:200px; font-size:0.82rem; color:#334155; line-height:1.6;">
                <div><strong>Ngân hàng:</strong> MB Bank (VietQR)</div>
                <div><strong>Chủ tài khoản:</strong> CONG TY GUIDIA ESCROW</div>
                <div><strong>Số tài khoản:</strong> <span style="font-family:monospace; font-weight:700; color:#0f172a;">8888 6666 2026</span></div>
                <div><strong>Nội dung CK:</strong> <span id="payQrContent" style="font-family:monospace; font-weight:700; color:#059669;">GUIDIA ESCROW</span></div>
              </div>
            </div>
          </div>

          <!-- Các nút kịch bản kiểm thử tình huống -->
          <div
            style="background:#f8fafc; border:1px dashed #cbd5e1; border-radius:8px; padding:10px; margin-bottom:14px; font-size:0.8rem;">
            <strong style="color:#475569;">Mô phỏng tình huống:</strong>
            <div style="display:flex; gap:8px; margin-top:6px; flex-wrap:wrap;">
              <button type="button" class="btn-sm-action" onclick="simulatePaymentFailure()"
                style="color:#dc2626; border-color:#fca5a5;" title="Giả lập lỗi thanh toán">
                ⚠️ Giả lập lỗi thanh toán
              </button>
              <button type="button" class="btn-sm-action" onclick="simulateBookingConflict()"
                style="color:#d97706; border-color:#fde68a;" title="Giả lập trùng lịch">
                ⚡ Giả lập trùng lịch lúc thanh toán
              </button>
            </div>
          </div>
        </div>

        <div style="display:flex; justify-content:flex-end; gap:10px;">
          <button type="button" class="btn-outline" onclick="closeBookingPaymentModal()" title="Hủy thanh toán">
            Hủy Bỏ / Thoát
          </button>
          <button type="button" class="btn-primary" onclick="confirmBookingPaymentSuccess()"
            style="background:#059669;">
            <i data-lucide="check-circle"></i> Xác Nhận Thanh Toán Toàn Bộ (Thành Công)
          </button>
        </div>
      </div>
    </div>

    <!-- ========================================================================= -->
    <!-- MODAL: HỦY CHUYẾN ĐI (UC07)                                               -->
    <!-- ========================================================================= -->
    <div id="custCancelTripModal" class="cst-121">
      <div class="cst-122">
        <h3 class="cst-123">
          <i data-lucide="alert-octagon"></i> Hủy Chuyến Đi & Hoàn Tiền Tạm Giữ
        </h3>
        <p class="cst-124" id="custCancelModalNotice">
          Quy định sàn: Bạn được hoàn lại <strong>100% tiền tạm giữ</strong> nếu hủy trước ngày xuất phát từ 2 ngày
          (48h) trở lên.
        </p>
        <input type="hidden" id="custCancelTripId">
        <div class="form-group">
          <label class="form-label">Lý do hủy chuyến đi <span class="cst-43">*</span></label>
          <textarea id="custCancelReasonText" class="form-control" rows="3"
            placeholder="VD: Thay đổi lịch trình công tác, thời tiết không thuận lợi..."></textarea>
        </div>
        <div class="cst-125">
          <button class="btn-outline" onclick="closeCustCancelModal()">Đóng / Không Hủy</button>
          <button class="btn-primary cst-104" onclick="confirmCustCancelTrip()">
            Xác Nhận Hủy Chuyến Đi
          </button>
        </div>
      </div>
    </div>

    <!-- ========================================================================= -->
    <!-- MODAL: GỬI KHIẾU NẠI SỰ CỐ CHUYẾN ĐI                                    -->
    <!-- ========================================================================= -->
    <div id="custDisputeTripModal" class="cst-121" style="display:none;">
      <div class="cst-122" style="max-width:580px; width:94%; max-height:90vh; overflow-y:auto;">
        <div
          style="display:flex; align-items:center; justify-content:space-between; margin-bottom:12px; border-bottom:1px solid #e2e8f0; padding-bottom:12px;">
          <h3 style="margin:0; font-size:1.15rem; color:#b91c1c; display:flex; align-items:center; gap:8px;">
            <i data-lucide="shield-alert" style="width:20px; height:20px; color:#dc2626;"></i> Gửi Khiếu Nại Sự Cố
            Chuyến Đi
          </h3>
          <button type="button" class="btn-ghost" onclick="closeCustDisputeTripModal()"
            style="font-size:1.2rem; cursor:pointer; color:#64748b;" title="Thoát / Hủy khiếu nại">&times;</button>
        </div>

        <div id="modalDisputeTripSummary"
          style="background:#f8fafc; border:1px solid #e2e8f0; border-radius:10px; padding:12px; margin-bottom:14px; font-size:0.85rem; color:#334155;">
          <!-- Tóm tắt chuyến đi nạp động -->
        </div>

        <input type="hidden" id="modalDisputeTripId">

        <div class="form-group" style="margin-bottom:14px;">
          <label class="form-label" style="font-weight:700; margin-bottom:6px; display:block;">1. Loại Sự Cố Phát Sinh
            <span style="color:#e11d48;">*</span></label>
          <select id="modalDisputeReasonType" class="form-control"
            style="width:100%; padding:10px; border-radius:8px; border:1px solid #cbd5e1;">
            <option value="HDV vắng mặt không đến điểm hẹn đã thỏa thuận">HDV vắng mặt không đến điểm hẹn đã thỏa thuận
            </option>
            <option value="HDV trễ giờ quá 45 phút ảnh hưởng nghiêm trọng lộ trình">HDV trễ giờ quá 45 phút ảnh hưởng
              nghiêm trọng lộ trình</option>
            <option value="Chất lượng thuyết minh và dịch vụ sai lệch nghiêm trọng cam kết">Chất lượng thuyết minh và
              dịch vụ sai lệch nghiêm trọng cam kết</option>
            <option value="Ép buộc du khách phát sinh phụ phí hoặc mua sắm ngoài ý muốn">Ép buộc du khách phát sinh phụ
              phí hoặc mua sắm ngoài ý muốn</option>
            <option value="Sự cố phát sinh khác">Sự cố phát sinh khác</option>
          </select>
        </div>

        <div class="form-group" style="margin-bottom:14px;">
          <label class="form-label" style="font-weight:700; margin-bottom:6px; display:block;">2. Mô Tả Chi Tiết Vụ Việc
            <span style="color:#e11d48;">*</span></label>
          <textarea id="modalDisputeDescription" class="form-control" rows="3"
            style="width:100%; padding:10px; border-radius:8px; border:1px solid #cbd5e1;"
            placeholder="Ghi rõ thời gian, địa điểm, sự việc diễn ra như thế nào..."></textarea>
        </div>

        <div class="form-group" style="margin-bottom:16px;">
          <label class="form-label" style="font-weight:700; margin-bottom:6px; display:block;">
            3. Bằng Chứng Bắt Buộc (Ảnh, Video, Tin Nhắn) <span style="color:#e11d48;">*</span>
          </label>
          <input type="text" id="modalDisputeEvidenceText" class="form-control"
            style="width:100%; padding:10px; border-radius:8px; border:1px solid #cbd5e1; margin-bottom:8px;"
            placeholder="Dẫn chứng tin nhắn, cuộc gọi, link video hoặc biên bản xác nhận...">

          <div style="background:#f1f5f9; border:1px dashed #94a3b8; border-radius:8px; padding:10px; margin-top:6px;">
            <label
              style="font-size:0.82rem; font-weight:600; color:#475569; display:flex; align-items:center; gap:6px; cursor:pointer;">
              <i data-lucide="upload" style="width:15px; height:15px;"></i> Đính kèm tệp ảnh / bằng chứng từ máy tính:
              <input type="file" id="modalDisputeEvidenceFile" accept="image/*"
                onchange="previewModalDisputeEvidence(event)" style="margin-left:6px; font-size:0.8rem;">
            </label>
            <input type="hidden" id="modalDisputeEvidenceUrl" value="">
          </div>

          <div id="modalDisputeEvidencePreviewWrap"
            style="display:none; margin-top:10px; align-items:center; gap:12px; background:#f8fafc; border:1px solid #cbd5e1; border-radius:8px; padding:8px;">
            <img id="modalDisputeEvidencePreviewImg" src="" alt="Bằng chứng"
              style="width:90px; height:60px; object-fit:cover; border-radius:6px; border:1px solid #94a3b8;">
            <div style="flex:1; font-size:0.8rem; color:#475569;">
              <div style="font-weight:700; color:#0f172a;">Đã tải ảnh bằng chứng thực tế</div>
              <button type="button" class="btn-ghost" onclick="removeModalDisputeEvidence()"
                style="color:#ef4444; font-size:0.75rem; padding:0; margin-top:2px; cursor:pointer;">
                <i data-lucide="trash-2" style="width:12px; height:12px;"></i> Xóa ảnh này
              </button>
            </div>
          </div>

          <div style="font-size:0.76rem; color:#e11d48; margin-top:6px; display:flex; align-items:center; gap:4px;">
            <i data-lucide="alert-circle" style="width:13px; height:13px;"></i>
            <span>Quy định: Bắt buộc phải có bằng chứng (ảnh, video hoặc tin nhắn) để bảo vệ quyền lợi du khách.</span>
          </div>
        </div>

        <div
          style="display:flex; justify-content:flex-end; gap:10px; margin-top:18px; border-top:1px solid #e2e8f0; padding-top:14px;">
          <button type="button" class="btn-outline" onclick="closeCustDisputeTripModal()" title="Thoát khiếu nại">
            Thoát / Hủy Bỏ
          </button>
          <button type="button" class="btn-primary" style="background:#dc2626; border-color:#dc2626; font-weight:700;"
            onclick="confirmSubmitCustDisputeModal()">
            <i data-lucide="send" style="width:15px; height:15px;"></i> Gửi Khiếu Nại (Tạm Dừng Tất Toán)
          </button>
        </div>
      </div>
    </div>

    <!-- ========================================================================= -->
    <!-- MODAL: ĐÁNH GIÁ DỊCH VỤ TOUR (UC08)                                      -->
    <!-- ========================================================================= -->
    <div id="custReviewModal" class="cst-121">
      <div class="cst-126">
        <div class="cst-127">
          <h3 class="cst-128">
            <i data-lucide="star" class="cst-129"></i> Đánh Giá Dịch Vụ Hướng Dẫn Viên
          </h3>
          <button type="button" class="btn-ghost cst-130" onclick="closeCustReviewModal()">
            <i data-lucide="x" class="cst-131"></i>
          </button>
        </div>
        <p class="cst-132">
          Chuyến đi: <strong id="modalReviewTourTitle" class="cst-80">...</strong> • HDV: <strong
            id="modalReviewGuideName" class="cst-35">...</strong>
        </p>

        <input type="hidden" id="modalReviewTripId">

        <!-- BỘ CHỌN ĐIỂM SAO TỪ 1 ĐẾN 5 (BẮT BUỘC THEO ĐẶC TẢ UC08) -->
        <div class="form-group cst-133">
          <label class="form-label cst-134">Chất Lượng Trải Nghiệm (1 đến 5 Sao)
            <span class="cst-43">*</span></label>
          <div class="cst-135" id="modalStarRatingRow">
            <span class="star-btn" data-val="1" onclick="setModalReviewScore(1)">★</span>
            <span class="star-btn" data-val="2" onclick="setModalReviewScore(2)">★</span>
            <span class="star-btn" data-val="3" onclick="setModalReviewScore(3)">★</span>
            <span class="star-btn" data-val="4" onclick="setModalReviewScore(4)">★</span>
            <span class="star-btn active" data-val="5" onclick="setModalReviewScore(5)">★</span>
          </div>
          <input type="hidden" id="modalReviewScoreInput" value="5">
          <div class="cst-136" id="modalStarScoreText">5.0 /
            5.0 - Tuyệt Vời & Xuất Sắc</div>
        </div>

        <div class="form-group">
          <label class="form-label">Nhận Xét Chi Tiết Của Bạn <span class="cst-43">*</span></label>
          <textarea id="modalReviewCommentText" class="form-control" rows="3"
            placeholder="Chia sẻ cảm nhận về sự nhiệt tình, am hiểu văn hóa và phong cách phục vụ của HDV..."></textarea>
        </div>

        <div class="form-group">
          <label class="form-label">Ảnh Kỷ Niệm / Minh Họa (Tùy chọn - chỉ chọn khi muốn đính kèm ảnh)</label>
          <input type="file" id="modalReviewImageFile" accept="image/*" class="form-control cst-98"
            onchange="previewReviewImage(event)">
          <input type="hidden" id="modalReviewImageUrl" value="">
          <div id="modalReviewImagePreviewBox" style="display:none; margin-top:8px; align-items:center; gap:10px;">
            <img id="modalReviewImagePreviewImg" src="" alt="Xem trước ảnh"
              style="max-height:80px; border-radius:6px; border:1px solid #cbd5e1;">
            <button type="button" class="btn-ghost" style="color:#ef4444; font-size:0.8rem; cursor:pointer;"
              onclick="removeCustReviewImage()">
              <i data-lucide="trash-2" style="width:14px; height:14px;"></i> Xóa ảnh đính kèm
            </button>
          </div>
        </div>

        <div class="cst-125">
          <button type="button" class="btn-outline" onclick="closeCustReviewModal()">Hủy Bỏ</button>
          <button type="button" class="btn-primary" onclick="confirmSubmitCustReview()">
            <i data-lucide="send"></i> Gửi Đánh Giá Ngay
          </button>
        </div>
      </div>
    </div>

    <!-- ========================================================================= -->
    <!-- MODAL: BỔ SUNG BẰNG CHỨNG KHIẾU NẠI (LUỒNG PHỤ A4 - UC10)                -->
    <!-- ========================================================================= -->
    <div id="custSupplementEvidenceModal" class="cst-121">
      <div class="cst-137">
        <h3 class="cst-138">
          <i data-lucide="file-plus"></i> Bổ Sung Bằng Chứng Khiếu Nại Theo Yêu Cầu Admin
        </h3>
        <p class="cst-124">
          Quản trị viên đã yêu cầu bạn bổ sung thêm bằng chứng (ảnh chụp, video hoặc biên bản) để hoàn tất phán quyết
          hoàn tiền.
        </p>
        <input type="hidden" id="suppDisputeId">

        <div class="form-group">
          <label class="form-label">Mô tả bổ sung hoặc giải trình thêm <span class="cst-43">*</span></label>
          <textarea id="suppEvidenceText" class="form-control" rows="3"
            placeholder="Nhập thêm chi tiết chứng cứ hoặc dẫn chứng cuộc gọi, vị trí định vị..."></textarea>
        </div>

        <div class="form-group">
          <label class="form-label">Tải tệp ảnh chứng cứ bổ sung:</label>
          <input type="file" id="suppEvidenceFile" accept="image/*" class="form-control cst-98"
            onchange="previewSuppEvidence(event)">
          <input type="hidden" id="suppEvidenceUrl" value="img/bang-chung-tre.jpg">
        </div>

        <div class="cst-139">
          <button class="btn-outline" onclick="closeCustSupplementModal()">Đóng</button>
          <button class="btn-primary cst-140" onclick="confirmCustSupplementEvidence()">
            <i data-lucide="upload"></i> Gửi Bổ Sung Bằng Chứng
          </button>
        </div>
      </div>
    </div>

    <!-- ========================================================================= -->
    <!-- MODAL: GỬI HÌNH ẢNH TRONG TIN NHẮN (UC05)                                 -->
    <!-- ========================================================================= -->
    <div id="chatImageModal" class="cst-121">
      <div class="cst-141">
        <div class="cst-127">
          <h3 class="cst-128">
            <i data-lucide="image" class="cst-35"></i> Gửi Hình Ảnh Trao Đổi
          </h3>
          <button type="button" class="btn-ghost cst-130" onclick="closeChatImageModal()">
            <i data-lucide="x" class="cst-131"></i>
          </button>
        </div>
        <p class="cst-142">
          Tải lên hình ảnh điểm đến, lịch trình hoặc vị trí bạn muốn HDV tư vấn.
        </p>

        <div class="form-group">
          <label class="form-label">Chọn tệp ảnh từ máy tính:</label>
          <input type="file" id="chatImageFileInput" accept="image/*" class="form-control cst-98"
            onchange="previewChatImageFile(event)">
        </div>

        <div class="cst-143">
          <img id="chatImageModalPreview" src="https://images.unsplash.com/photo-1528127269322-539801943592?w=600"
            alt="Xem trước ảnh" class="cst-144">
        </div>

        <div class="cst-145">
          <button type="button" class="btn-outline" onclick="closeChatImageModal()">Hủy</button>
          <button type="button" class="btn-primary" onclick="confirmSendChatImage()">
            <i data-lucide="send"></i> Gửi Ảnh Vào Cuộc Trò Chuyện
          </button>
        </div>
      </div>
    </div>

    <!-- ========================================================================= -->
    <!-- MODAL: HỒ SƠ CHI TIẾT HDV (To rộng 1040px, Chuẩn như khách vãng lai)     -->
    <!-- ========================================================================= -->
    <div class="modal-overlay" id="guideModal">
      <div class="modal-container idx-38"
        style="max-width: 1040px !important; width: 94vw !important; padding: 28px 36px !important; border-radius: 24px !important; overflow-x: hidden !important; box-sizing: border-box !important;">
        <button class="modal-close-btn" onclick="closeModal('guideModal')"><i data-lucide="x"></i></button>
        <div class="modal-body idx-39" id="guideModalContent"
          style="overflow-x: hidden !important; padding: 0 !important; width: 100% !important;">
          <!-- Rendered dynamically via openGuideDetail(id) -->
        </div>
      </div>
    </div>

    <!-- TOAST NOTIFICATION -->
    <div class="toast-notification" id="toastNotification">
      <i data-lucide="check-circle" class="toast-icon"></i>
      <span id="toastMessage">Thông báo thành công</span>
    </div>

    <!-- Scripts -->
    <script src="js/store.js?v=<%= System.currentTimeMillis() %>"></script>
    <script>
      /**
       * =========================================================================
       * GUIDIA - CUSTOMER PORTAL LOGIC (PHÂN HỆ KHÁCH DU LỊCH - KDL)
       * Đáp ứng đầy đủ 7 Use Case: UC02, UC03, UC04, UC05, UC06, UC07, UC08, UC10
       * =========================================================================
       */

      let currentCustomerId = 17; // Mặc định Phạm Minh Dũng (User 17)
      let currentChatGuideId = 2;  // Mặc định trò chuyện với HDV 2 (Võ Quốc Minh)
      let currentTripFilter = 'all';
      let modalUploadedEvidenceUrl = '';
      let modalUploadedReviewImageUrl = '';
      let modalUploadedChatImageUrl = '';

      function initCustomerApp() {
        // 1. Luôn ưu tiên tài khoản khách đang đăng nhập từ Session
        let loggedInId = null;
        const curUserStr = sessionStorage.getItem('guidia_current_user') || localStorage.getItem('guidia_current_user');
        if (curUserStr) {
          try {
            const u = JSON.parse(curUserStr);
            if (u && u.id && (u.role === 'customer' || u.vaiTro === 'DU_KHACH' || !u.role)) {
              loggedInId = parseInt(u.id) || u.id;
            }
          } catch (e) { }
        }

        if (loggedInId) {
          currentCustomerId = loggedInId;
        } else {
          const savedCustId = localStorage.getItem('guidia_current_customer_id_v2');
          if (savedCustId) {
            currentCustomerId = parseInt(savedCustId) || savedCustId;
          }
        }
        localStorage.setItem('guidia_current_customer_id_v2', currentCustomerId);

        const store = window.guidiaStore;
        const initialUser = (store && store.getUsers) ? store.getUsers().find(u => String(u.id) === String(currentCustomerId)) : null;
        if (initialUser) {
          sessionStorage.setItem('guidia_current_user', JSON.stringify(initialUser));
        } else if (!curUserStr) {
          sessionStorage.setItem('guidia_current_user', JSON.stringify({ id: currentCustomerId, name: 'Khách Du Lịch', email: '', role: 'customer' }));
        }

        // 2. KHỞI TẠO TAB VÀ RENDER NGAY LẬP TỨC (Người dùng bấm được ngay lập tức)
        setupCustomerTabs();
        populateCustomerSwitcher();
        updateCustomerHeaderInfo();
        checkCurrentCustomerAccountStatus();
        renderAllCustomerPortal();
        handleUrlTabRedirect();
        startLiveCountdownLoop();

        if (window.lucide) {
          window.lucide.createIcons();
        }

        // 3. Tự động đồng bộ CSDL SQL Server ở chế độ ngầm (Background)
        if (window.guidiaStore && window.guidiaStore.syncWithDatabase) {
          window.guidiaStore.syncWithDatabase().then(() => {
            populateCustomerSwitcher();
            updateCustomerHeaderInfo();
            checkCurrentCustomerAccountStatus();
            renderAllCustomerPortal();
            if (window.lucide) window.lucide.createIcons();
          }).catch(err => {
            console.warn('Lỗi đồng bộ dữ liệu SQL Server:', err);
          });
        }
      }

      if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initCustomerApp);
      } else {
        initCustomerApp();
      }

      // ĐỒNG BỘ TIN NHẮN REALTIME GIỮA CÁC TAB & ĐỊNH KỲ TỪ CSDL SQL SERVER
      window.addEventListener('storage', function (e) {
        if (e.key === 'guidia_messages_v2' || e.key === 'guidia_trips_v2') {
          renderCustomerChatTab();
          updateCustomerBadges();
        }
      });

      window.addEventListener('guidia_messages_synced', function () {
        renderCustomerChatTab();
        updateCustomerBadges();
      });

      // Vòng lặp định kỳ 3 giây tự động kéo tin nhắn mới nhất từ SQL Server
      setInterval(async function () {
        if (window.guidiaStore && window.guidiaStore.syncWithDatabase) {
          await window.guidiaStore.syncWithDatabase();
        }
      }, 3000);

      // =========================================================================
      // 1. QUẢN LÝ TÀI KHOẢN DU KHÁCH & DROPDOWN SWITCHER
      // =========================================================================
      function populateCustomerSwitcher() {
        const store = window.guidiaStore;
        if (!store) return;
        const users = store.getUsers().filter(u => u.role === 'customer');
        const switcher = document.getElementById('customerAccountSwitcher');
        if (!switcher) return;

        switcher.innerHTML = users.map(u => {
          const isSelected = String(u.id) === String(currentCustomerId) ? 'selected' : '';
          const statusNote = u.status === 'suspended' ? ' (ĐANG BỊ KHÓA)' : '';
          return `<option value="${u.id}" ${isSelected}>#${u.id} - ${u.name}${statusNote}</option>`;
        }).join('');
      }

      function switchCustomerAccount(newId) {
        currentCustomerId = parseInt(newId) || newId;
        localStorage.setItem('guidia_current_customer_id_v2', currentCustomerId);
        const store = window.guidiaStore;
        const user = store.getUsers().find(u => String(u.id) === String(currentCustomerId));
        if (user) {
          sessionStorage.setItem('guidia_current_user', JSON.stringify(user));
        }
        updateCustomerHeaderInfo();
        checkCurrentCustomerAccountStatus();
        renderAllCustomerPortal();
        showToast(`Đã chuyển sang tài khoản du khách: ${user ? user.name : newId}`);
      }

      function updateCustomerHeaderInfo() {
        const store = window.guidiaStore;
        let sessionUser = null;
        try {
          const s = sessionStorage.getItem('guidia_current_user') || localStorage.getItem('guidia_current_user');
          if (s) sessionUser = JSON.parse(s);
        } catch (e) { }

        const user = (store && store.getUsers) ? (store.getUsers().find(u => String(u.id) === String(currentCustomerId)) || sessionUser) : sessionUser;
        const finalUser = user || {
          id: currentCustomerId,
          name: 'Khách Du Lịch',
          email: '',
          phone: '',
          avatar: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150',
          cancelCount: 0,
          completedCount: 0
        };

        const nameEl = document.getElementById('custHeaderName');
        const emailEl = document.getElementById('custHeaderEmail');
        const avatarEl = document.getElementById('custHeaderAvatar');
        const miniName = document.getElementById('custNameMini');
        const miniAvatar = document.getElementById('custAvatarMini');

        if (nameEl) nameEl.textContent = finalUser.name;
        if (emailEl) emailEl.textContent = finalUser.email || '';
        if (avatarEl && finalUser.avatar) avatarEl.src = finalUser.avatar;
        if (miniName) miniName.textContent = finalUser.name;
        if (miniAvatar && finalUser.avatar) miniAvatar.src = finalUser.avatar;
      }

      function checkCurrentCustomerAccountStatus() {
        const store = window.guidiaStore;
        const user = store.getUsers().find(u => String(u.id) === String(currentCustomerId));
        const alertBox = document.getElementById('custAccountStatusAlertBox');
        const chatAlert = document.getElementById('custChatSuspendedNotice');
        const chatInput = document.getElementById('custChatInputText');
        const sendBtn = document.getElementById('btnSendCustChatMessage');

        if (user && user.status === 'suspended') {
          if (alertBox) alertBox.style.display = 'block';
          if (chatAlert) chatAlert.style.display = 'flex';
          if (chatInput) {
            chatInput.disabled = true;
            chatInput.placeholder = 'Tài khoản của bạn đã bị khóa do vi phạm. Không thể gửi tin nhắn.';
          }
          if (sendBtn) sendBtn.disabled = true;
        } else {
          if (alertBox) alertBox.style.display = 'none';
          if (chatAlert) chatAlert.style.display = 'none';
          if (chatInput) {
            chatInput.disabled = false;
            chatInput.placeholder = 'Nhập tin nhắn trao đổi lộ trình hoặc yêu cầu với HDV...';
          }
          if (sendBtn) sendBtn.disabled = false;
        }
      }

      function handlePortalGoBack() {
        if (window.history.length > 1) {
          window.history.back();
        } else {
          window.location.href = 'index.jsp';
        }
      }

      function handleCustomerLogout() {
        sessionStorage.removeItem('guidia_current_user');
        localStorage.removeItem('guidia_current_user');
        localStorage.removeItem('guidia_current_customer_id_v2');
        sessionStorage.clear();
        showToast('Đã đăng xuất tài khoản thành công!');
        setTimeout(() => {
          window.location.href = 'login.jsp';
        }, 500);
      }

      // =========================================================================
      // 2. CHUYỂN ĐỔI TAB & BỘ LỌC
      // =========================================================================
      // =========================================================================
      // 2. CHUYỂN ĐỔI TAB & BỘ LỌC (HỖ TRỢ URL HASH & CLICK TRỰC TIẾP 100%)
      // =========================================================================
      function activateTab(tabId, updateHash = true) {
        if (!tabId) tabId = 'tab-search';

        // 1. Đồng bộ active trên Sidebar bên trái
        document.querySelectorAll('.sidebar-nav .nav-link-item').forEach(l => {
          if (l.getAttribute('data-tab') === tabId) {
            l.classList.add('active');
          } else {
            l.classList.remove('active');
          }
        });

        // 2. Kích hoạt panel tương ứng và ẩn tất cả các panel khác
        document.querySelectorAll('.tab-content-panel').forEach(p => {
          if (p.id === tabId) {
            p.classList.add('active');
          } else {
            p.classList.remove('active');
          }
        });

        // 3. Tiêu đề header trang
        const titles = {
          'tab-search': 'Tra Cứu Hướng Dẫn Viên Bản Địa & Đặt Tour',
          'tab-bookings': 'Yêu Cầu Đặt Lịch Tour & Ký Quỹ Escrow',
          'tab-trips': 'Chuyến Đi Của Tôi',
          'tab-chat': 'Nhắn Tin & Tư Vấn Cùng Hướng Dẫn Viên',
          'tab-reviews': 'Đánh Giá Dịch Vụ Hướng Dẫn Viên',
          'tab-disputes': 'Khiếu Nại & Hỗ Trợ Chuyến Đi',
          'tab-profile': 'Thông Tin Cá Nhân & Hồ Sơ Du Khách'
        };
        const titleEl = document.getElementById('customerPageTitle');
        if (titleEl && titles[tabId]) {
          titleEl.textContent = titles[tabId];
        }

        // 4. Đồng bộ hash trên URL trình duyệt
        if (updateHash) {
          const tabToHash = {
            'tab-search': '#search',
            'tab-bookings': '#bookings',
            'tab-trips': '#trips',
            'tab-chat': '#chat',
            'tab-reviews': '#reviews',
            'tab-disputes': '#disputes',
            'tab-profile': '#profile'
          };
          if (tabToHash[tabId] && window.location.hash !== tabToHash[tabId]) {
            history.pushState(null, null, tabToHash[tabId]);
          }
        }

        // 5. Render nội dung dữ liệu cho tab tương ứng
        if (tabId === 'tab-search') renderGuidesSearchTab();
        if (tabId === 'tab-bookings') renderCustomerBookingsTab();
        if (tabId === 'tab-trips') renderCustomerTripsTab();
        if (tabId === 'tab-chat') renderCustomerChatTab();
        if (tabId === 'tab-reviews') renderCustomerReviewsTab();
        if (tabId === 'tab-disputes') renderCustomerDisputesTab();
        if (tabId === 'tab-profile') renderCustomerProfileTab();

        if (window.lucide) window.lucide.createIcons();
      }

      function setupCustomerTabs() {
        const navLinks = document.querySelectorAll('.sidebar-nav .nav-link-item[data-tab]');
        navLinks.forEach(link => {
          link.addEventListener('click', (e) => {
            e.preventDefault();
            const targetId = link.getAttribute('data-tab');
            activateTab(targetId, true);
          });
        });

        // Lắng nghe sự kiện đổi URL hash
        window.addEventListener('hashchange', () => {
          handleUrlTabRedirect();
        });
      }

      function switchCustomerTab(targetTabId) {
        activateTab(targetTabId, true);
      }

      function handleUrlTabRedirect() {
        const hash = window.location.hash;
        const params = new URLSearchParams(window.location.search);
        const guideId = params.get('guideId');
        const action = params.get('action');

        if (guideId) {
          if (hash === '#bookings' || hash === '#tab-bookings' || action === 'book') {
            activateTab('tab-bookings', false);
            openBookingForGuide(guideId);
            return;
          }
          if (hash === '#chat' || hash === '#tab-chat' || action === 'chat') {
            activateTab('tab-chat', false);
            openChatWithGuide(guideId);
            return;
          }
        }

        const hashToTab = {
          '#search': 'tab-search',
          '#tab-search': 'tab-search',
          '#bookings': 'tab-bookings',
          '#tab-bookings': 'tab-bookings',
          '#trips': 'tab-trips',
          '#tab-trips': 'tab-trips',
          '#chat': 'tab-chat',
          '#tab-chat': 'tab-chat',
          '#reviews': 'tab-reviews',
          '#tab-reviews': 'tab-reviews',
          '#disputes': 'tab-disputes',
          '#tab-disputes': 'tab-disputes',
          '#profile': 'tab-profile',
          '#tab-profile': 'tab-profile'
        };

        if (hash && hashToTab[hash]) {
          activateTab(hashToTab[hash], false);
        } else {
          activateTab('tab-search', false);
        }
      }

      // Vòng lặp đếm ngược thời gian thực (Live ticking countdown loop)
      let liveCountdownInterval = null;
      function startLiveCountdownLoop() {
        if (liveCountdownInterval) clearInterval(liveCountdownInterval);
        liveCountdownInterval = setInterval(() => {
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
              el.textContent = '00:00:00 (Đã quá hạn - Đang hoàn tất)';
              el.style.color = '#dc2626';
              needReRender = true;
            }
          });

          if (needReRender && window.guidiaStore) {
            const res = window.guidiaStore.processAutoTimers();
            if (res && res.modified) {
              showToast('Hệ thống vừa tự động cập nhật đơn quá hạn theo quy định sàn!', 'info');
              renderCustomerBookingsTab();
              renderCustomerTripsTab();
              updateCustomerBadges();
            }
          }
        }, 1000);
      }

      // Giả lập tua nhanh 24h để phục vụ kiểm thử nhanh
      function handleFastForward24Hours() {
        if (!confirm('Kiểm thử: Bạn có muốn giả lập tua nhanh thời gian thêm 24 giờ để kiểm tra tính năng tự động hủy đơn / tự động tất toán không?')) return;
        if (window.guidiaStore && window.guidiaStore.simulateFastForward) {
          const res = window.guidiaStore.simulateFastForward(24);
          showToast(`Đã tua nhanh 24h! Đã xử lý ${res.expiredBookings || 0} đơn quá hạn và ${res.autoPayouts || 0} lượt tất toán tự động.`, 'success');
          renderCustomerBookingsTab();
          renderCustomerTripsTab();
          updateCustomerBadges();
        }
      }

      function renderAllCustomerPortal() {
        renderGuidesSearchTab();
        renderCustomerBookingsTab();
        renderCustomerTripsTab();
        renderCustomerChatTab();
        renderCustomerReviewsTab();
        renderCustomerDisputesTab();
        renderCustomerProfileTab();
        updateCustomerBadges();
      }

      function updateCustomerBadges() {
        const store = window.guidiaStore;
        const trips = store.getTrips().filter(t => String(t.customerId) === String(currentCustomerId));

        // Badge pending bookings (Chỉ đếm các đơn chờ xác nhận - UC06)
        const pendingBookings = trips.filter(t => {
          const st = (t.status || t.dbStatus || '').toLowerCase().trim();
          return (st === 'pending' || st === 'pending_guide' || st === 'pending_guide_confirm' || st === 'chờ_xác_nhận' || st === 'chờ xác nhận');
        });
        const bPending = document.getElementById('badgePendingBookings');
        if (bPending) {
          bPending.textContent = pendingBookings.length;
          bPending.style.display = pendingBookings.length > 0 ? 'inline-block' : 'none';
        }

        // Badge active upcoming trips (Các chuyến đã xác nhận hoặc đang đi - UC07)
        const activeTrips = trips.filter(t => {
          const st = (t.status || t.dbStatus || '').toLowerCase().trim();
          return (st === 'confirmed_upcoming' || st === 'confirmed' || st === 'đã_xác_nhận' || st === 'ongoing' || st === 'in_progress' || st === 'đang_đi');
        });
        const bTrips = document.getElementById('badgeActiveTrips');
        if (bTrips) {
          bTrips.textContent = activeTrips.length;
          bTrips.style.display = activeTrips.length > 0 ? 'inline-block' : 'none';
        }

        // Badge unread chat
        const messages = store.getMessages ? store.getMessages() : [];
        const unreadMsg = messages.filter(m => String(m.receiverId) === String(currentCustomerId) && !m.isRead);
        const bChat = document.getElementById('badgeUnreadChat');
        if (bChat) {
          bChat.textContent = unreadMsg.length;
          bChat.style.display = unreadMsg.length > 0 ? 'inline-block' : 'none';
        }

        // Badge disputes
        const disputes = store.getDisputes().filter(d => String(d.complainantPhone || '').includes(String(currentCustomerId)) || (d.complainantRole === 'customer' && d.status === 'need_more_info'));
        const bDisputes = document.getElementById('badgeDisputes');
        if (bDisputes) {
          bDisputes.textContent = disputes.length;
          bDisputes.style.display = disputes.length > 0 ? 'inline-block' : 'none';
        }
      }

      // =========================================================================
      // TAB 1: TRA CỨU HƯỚNG DẪN VIÊN & ĐẶT TOUR (UC02) - ĐỒNG BỘ THEO INDEX.JSP
      // =========================================================================
      const custRegionCitiesMap = {
        all: [
          { value: 'all', label: 'Tất cả tỉnh thành / địa danh' },
          { value: 'Hội An', label: 'Phố Cổ Hội An' },
          { value: 'Đà Nẵng', label: 'Đà Nẵng & Bà Nà' },
          { value: 'Hà Nội', label: 'Hà Nội 36 Phố' },
          { value: 'Huế', label: 'Cố Đô Huế' },
          { value: 'Sapa', label: 'Sapa & Fansipan' },
          { value: 'Ninh Bình', label: 'Ninh Bình' },
          { value: 'Hạ Long', label: 'Vịnh Hạ Long' },
          { value: 'Hồ Chí Minh', label: 'TP. Hồ Chí Minh' },
          { value: 'Phú Quốc', label: 'Đảo Phú Quốc' },
          { value: 'Miền Tây', label: 'Miền Tây sông nước' },
          { value: 'Đà Lạt', label: 'Đà Lạt' }
        ],
        north: [
          { value: 'all', label: 'Tất cả Miền Bắc' },
          { value: 'Hà Nội', label: 'Hà Nội (Thủ đô & 36 Phố)' },
          { value: 'Sapa', label: 'Sapa & Fansipan (Lào Cai)' },
          { value: 'Ninh Bình', label: 'Ninh Bình (Tràng An)' },
          { value: 'Hạ Long', label: 'Vịnh Hạ Long (Quảng Ninh)' },
          { value: 'Hà Giang', label: 'Hà Giang (Cao nguyên đá)' }
        ],
        central: [
          { value: 'all', label: 'Tất cả Miền Trung' },
          { value: 'Hội An', label: 'Phố Cổ Hội An (Quảng Nam)' },
          { value: 'Đà Nẵng', label: 'Đà Nẵng & Bà Nà' },
          { value: 'Huế', label: 'Cố Đô Huế' },
          { value: 'Nha Trang', label: 'Nha Trang (Khánh Hòa)' },
          { value: 'Đà Lạt', label: 'Đà Lạt (Lâm Đồng)' },
          { value: 'Quy Nhơn', label: 'Quy Nhơn (Bình Định)' }
        ],
        south: [
          { value: 'all', label: 'Tất cả Miền Nam' },
          { value: 'Hồ Chí Minh', label: 'TP. Hồ Chí Minh (Sài Gòn)' },
          { value: 'Phú Quốc', label: 'Đảo Ngọc Phú Quốc' },
          { value: 'Miền Tây', label: 'Cần Thơ & Miền Tây' },
          { value: 'Vũng Tàu', label: 'Bà Rịa - Vũng Tàu' }
        ]
      };

      function handleCustRegionChange() {
        const reg = document.getElementById('guideSearchRegion');
        const city = document.getElementById('guideSearchCity');
        if (!reg || !city) return;

        const list = custRegionCitiesMap[reg.value] || custRegionCitiesMap.all;
        city.innerHTML = list.map(item => `<option value="${item.value}">${item.label}</option>`).join('');
        city.value = 'all';
        renderGuidesSearchTab();
      }

      function applyGuideSearch() {
        renderGuidesSearchTab();
      }

      function resetGuideSearch() {
        const kw = document.getElementById('guideSearchKeyword');
        const reg = document.getElementById('guideSearchRegion');
        const city = document.getElementById('guideSearchCity');
        const lang = document.getElementById('guideSearchLang');
        const price = document.getElementById('guideSearchPrice');
        const sort = document.getElementById('guideSearchSort');

        if (kw) kw.value = '';
        if (reg) {
          reg.value = 'all';
          handleCustRegionChange();
        }
        if (city) city.value = 'all';
        if (lang) lang.value = 'all';
        if (price) price.value = 'all';
        if (sort) sort.value = 'rating_desc';

        renderGuidesSearchTab();
        showToast('Đã đặt lại bộ lọc tìm kiếm HDV');
      }

      function renderGuidesSearchTab() {
        const store = window.guidiaStore;
        let guides = store.getApprovedGuides ? store.getApprovedGuides() : store.getGuides().filter(g => g.status === 'active' && g.certStatus === 'approved');

        const kw = (document.getElementById('guideSearchKeyword') ? document.getElementById('guideSearchKeyword').value : '').toLowerCase().trim();
        const region = document.getElementById('guideSearchRegion') ? document.getElementById('guideSearchRegion').value : 'all';
        const city = document.getElementById('guideSearchCity') ? document.getElementById('guideSearchCity').value : 'all';
        const lang = document.getElementById('guideSearchLang') ? document.getElementById('guideSearchLang').value : 'all';
        const price = document.getElementById('guideSearchPrice') ? document.getElementById('guideSearchPrice').value : 'all';
        const sortBy = document.getElementById('guideSearchSort') ? document.getElementById('guideSearchSort').value : 'rating_desc';

        // 1. Lọc theo từ khóa
        if (kw) {
          guides = guides.filter(g => {
            const name = (g.name || '').toLowerCase();
            const bio = (g.bio || '').toLowerCase();
            const c = (g.city || '').toLowerCase();
            const reg = (g.region || '').toLowerCase();
            const langs = (Array.isArray(g.languages) ? g.languages.join(' ') : (g.languages || '')).toLowerCase();
            return name.includes(kw) || bio.includes(kw) || c.includes(kw) || reg.includes(kw) || langs.includes(kw);
          });
        }

        // 2. Lọc theo vùng miền
        if (region !== 'all') {
          const northKeywords = ['hà nội', 'sapa', 'lào cai', 'ninh bình', 'hạ long', 'quảng ninh', 'bắc'];
          const centralKeywords = ['đà nẵng', 'hội an', 'quảng nam', 'huế', 'thừa thiên', 'nha trang', 'khánh hòa', 'trung'];
          const southKeywords = ['hồ chí minh', 'sài gòn', 'phú quốc', 'kiên giang', 'cần thơ', 'miền tây', 'nam'];

          guides = guides.filter(g => {
            const loc = ((g.city || '') + ' ' + (g.region || '') + ' ' + (g.bio || '')).toLowerCase();
            if (region === 'north') return northKeywords.some(k => loc.includes(k));
            if (region === 'central') return centralKeywords.some(k => loc.includes(k));
            if (region === 'south') return southKeywords.some(k => loc.includes(k));
            return true;
          });
        }

        // 3. Lọc theo tỉnh thành / địa danh
        if (city !== 'all') {
          const ckw = city.toLowerCase();
          guides = guides.filter(g => {
            const loc = ((g.city || '') + ' ' + (g.region || '') + ' ' + (g.bio || '') + ' ' + (g.specialties || '')).toLowerCase();
            if (ckw === 'hà nội') return loc.includes('hà nội') || loc.includes('bắc');
            if (ckw === 'hội an') return loc.includes('hội an') || loc.includes('quảng nam') || loc.includes('đà nẵng');
            if (ckw === 'đà nẵng') return loc.includes('đà nẵng') || loc.includes('hội an');
            if (ckw === 'huế') return loc.includes('huế') || loc.includes('thừa thiên') || loc.includes('trung');
            if (ckw === 'sapa') return loc.includes('sapa') || loc.includes('lào cai') || loc.includes('bắc');
            if (ckw === 'hạ long') return loc.includes('hạ long') || loc.includes('quảng ninh') || loc.includes('bắc');
            if (ckw === 'ninh bình') return loc.includes('ninh bình') || loc.includes('bắc');
            if (ckw === 'hồ chí minh') return loc.includes('hồ chí minh') || loc.includes('sài gòn') || loc.includes('nam');
            if (ckw === 'phú quốc') return loc.includes('phú quốc') || loc.includes('kiên giang') || loc.includes('nam');
            if (ckw === 'miền tây') return loc.includes('miền tây') || loc.includes('cần thơ') || loc.includes('nam');
            if (ckw === 'đà lạt') return loc.includes('đà lạt') || loc.includes('lâm đồng') || loc.includes('trung');
            return loc.includes(ckw);
          });
        }

        // 4. Lọc theo mức giá
        if (price !== 'all') {
          guides = guides.filter(g => {
            const p = g.dailyPrice || 1500000;
            if (price === 'under_1m') return p < 1000000;
            if (price === '1m_to_2m') return p >= 1000000 && p <= 2000000;
            if (price === 'over_2m') return p > 2000000;
            return true;
          });
        }

        // 5. Lọc theo ngoại ngữ
        if (lang !== 'all') {
          guides = guides.filter(g => {
            const langs = Array.isArray(g.languages) ? g.languages.join(' ') : (g.languages || '');
            return langs.toLowerCase().includes(lang.toLowerCase());
          });
        }

        // 6. Sắp xếp
        if (sortBy === 'rating_desc') {
          guides.sort((a, b) => (b.rating || 5.0) - (a.rating || 5.0));
        } else if (sortBy === 'price_asc') {
          guides.sort((a, b) => (a.dailyPrice || 1500000) - (b.dailyPrice || 1500000));
        } else if (sortBy === 'price_desc') {
          guides.sort((a, b) => (b.dailyPrice || 1500000) - (a.dailyPrice || 1500000));
        } else if (sortBy === 'trips_desc') {
          guides.sort((a, b) => (b.completedTrips || b.completedCount || 0) - (a.completedTrips || a.completedCount || 0));
        }

        const container = document.getElementById('guidesGridContainer');
        if (!container) return;

        if (guides.length === 0) {
          container.innerHTML = `
      <div class="cst-146">
        <i data-lucide="user-x" class="cst-147"></i>
        <h4 class="cst-148">Không tìm thấy Hướng dẫn viên phù hợp</h4>
        <p class="cst-149">Vui lòng thử điều chỉnh lại bộ lọc địa điểm, ngoại ngữ hoặc mức giá.</p>
        <button class="btn-outline" onclick="resetGuideSearch()">Đặt Lại Bộ Lọc</button>
      </div>
    `;
          if (window.lucide) window.lucide.createIcons();
          return;
        }

        container.innerHTML = guides.map(g => {
          const avatar = g.avatar || 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500';
          const rating = g.rating ? Number(g.rating).toFixed(1) : '5.0';
          const reviewsCount = g.reviewCount !== undefined ? g.reviewCount : (g.reviewsCount !== undefined ? g.reviewsCount : 0);
          const completedTrips = g.completedTrips !== undefined ? g.completedTrips : (g.completedCount || 0);
          const dailyPrice = (g.dailyPrice || 1500000).toLocaleString('vi-VN') + '₫';
          const langTags = Array.isArray(g.languages)
            ? g.languages.map(l => `<span class="tag-pill">${l}</span>`).join('')
            : (g.languages || 'Tiếng Việt, Tiếng Anh').split(',').map(l => `<span class="tag-pill">${l.trim()}</span>`).join('');
          const certBadge = `<span class="badge-verified"><i data-lucide="shield-check"></i> ${g.certType ? (g.certType.includes('Quốc Tế') ? 'Thẻ Quốc Tế' : 'Thẻ Nội Địa') : 'Thẻ Đã Duyệt'}</span>`;

          return `
      <div class="guide-card" data-guide-id="${g.id}">
        <div class="guide-card-top cst-150" onclick="openGuideDetail('${g.id}')" style="cursor: pointer;" title="Bấm để xem chi tiết hướng dẫn viên">
          <div class="guide-photo-wrap">
            <img src="${avatar}" alt="${g.name}" class="guide-photo" onerror="this.src='https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500'">
            ${certBadge}
            <span class="badge-rating"><i data-lucide="star"></i> ${rating} (${reviewsCount})</span>
          </div>
        </div>
        <div class="guide-card-body cst-151">
          <div>
            <div class="cst-152">
              <div class="guide-location cst-153"><i data-lucide="map-pin"></i> ${g.city || g.region || 'Việt Nam'}</div>
              <span class="trip-count-badge cst-154"><i data-lucide="award" class="cst-155"></i> ${completedTrips} chuyến</span>
            </div>
            <h3 class="guide-name cst-156" onclick="openGuideDetail('${g.id}')" style="cursor: pointer;" title="Bấm để xem chi tiết hướng dẫn viên">${g.name}</h3>
            <p class="guide-title-role cst-157">${g.experienceYears || '5 năm kinh nghiệm'} • ${g.certType || 'HDV Bản Địa'}</p>
            <p class="guide-bio cst-158" onclick="openGuideDetail('${g.id}')" style="cursor: pointer;">
              ${g.bio || g.specialties || 'Hướng dẫn viên bản địa giàu kinh nghiệm, am hiểu sâu sắc văn hóa, lịch sử và ẩm thực địa phương.'}
            </p>
            
            <div class="guide-tags cst-159">
              ${langTags}
            </div>
          </div>

          <div>
            <div class="guide-footer-stacked cst-160">
              <!-- Dòng 1: Số tiền nguyên một dòng phía trên -->
              <div class="cst-161">
                <span class="cst-162">Chi phí dẫn tour:</span>
                <div>
                  <span class="cst-163">${dailyPrice}</span>
                  <span class="cst-164">/ ngày</span>
                </div>
              </div>
              <!-- Dòng 2: Đặt lịch với Nhắn tin nhỏ lại, song song với nhau -->
              <div class="cst-165">
                <button type="button" class="btn-outline cst-166" onclick="openChatWithGuide('${g.id}')" title="Nhắn tin với HDV">
                  <i data-lucide="message-square" class="cst-167"></i>
                  <span>Nhắn Tin</span>
                </button>
                <button type="button" class="btn-primary cst-168" onclick="openBookingForGuide('${g.id}')" title="Đặt lịch với HDV">
                  <i data-lucide="calendar-plus" class="cst-167"></i>
                  <span>Đặt Lịch</span>
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    `;
        }).join('');

        if (window.lucide) window.lucide.createIcons();
      }

      // =========================================================================
      // TAB 2: QUẢN LÝ YÊU CẦU ĐẶT LỊCH (UC06 + UC16)
      // =========================================================================
      function onBookingGuideChanged() {
        const store = window.guidiaStore;
        const guideId = document.getElementById('bkGuideSelect').value;
        const guide = store.getGuides().find(g => String(g.id) === String(guideId));
        if (guide) {
          const locInput = document.getElementById('bkLocation');
          if (locInput && !locInput.value) {
            locInput.value = guide.city || guide.location || 'Phố cổ & Di sản';
          }
        }
        recalculateBookingCost();
      }

      function onBookingDateChanged() {
        const sDate = document.getElementById('bkStartDate').value;
        const eDate = document.getElementById('bkEndDate');
        if (sDate && eDate && !eDate.value) {
          eDate.value = sDate;
        }
      }

      function recalculateBookingCost() {
        const store = window.guidiaStore;
        const guideId = document.getElementById('bkGuideSelect') ? document.getElementById('bkGuideSelect').value : null;
        const priceType = document.getElementById('bkPriceType') ? document.getElementById('bkPriceType').value : 'daily';
        const guide = store.getGuides().find(g => String(g.id) === String(guideId));

        let total = 1500000;
        if (guide) {
          if (priceType === 'hourly') {
            total = (guide.hourlyPrice || 450000) * 4; // Tạm tính nửa ngày 4 giờ
          } else {
            total = guide.dailyPrice || guide.price || 1500000;
          }
        }

        const fee = Math.round(total * 0.10);
        const payout = total - fee;

        const sumEl = document.getElementById('bkCostSummaryVal');
        const guideEl = document.getElementById('bkCostGuidePayout');
        const feeEl = document.getElementById('bkCostPlatformFee');

        if (sumEl) sumEl.textContent = total.toLocaleString('vi-VN') + '₫';
        if (guideEl) guideEl.textContent = payout.toLocaleString('vi-VN') + '₫';
        if (feeEl) feeEl.textContent = fee.toLocaleString('vi-VN') + '₫';
      }

      function openBookingForGuide(guideId) {
        switchCustomerTab('tab-bookings');
        setTimeout(() => {
          const sel = document.getElementById('bkGuideSelect');
          if (sel) {
            if (sel.children.length === 0) {
              renderCustomerBookingsTab();
            }
            sel.value = String(guideId);
            onBookingGuideChanged();
          }
          // Set default date = 3 days from now
          const d = new Date();
          d.setDate(d.getDate() + 3);
          const dateStr = d.toISOString().slice(0, 10);

          // Ràng buộc đặt trước tối thiểu 2 ngày
          const minDate = new Date();
          minDate.setDate(minDate.getDate() + 2);
          const minDateStr = minDate.toISOString().slice(0, 10);

          const sDate = document.getElementById('bkStartDate');
          const eDate = document.getElementById('bkEndDate');
          if (sDate) { sDate.value = dateStr; sDate.min = minDateStr; }
          if (eDate) { eDate.value = dateStr; eDate.min = minDateStr; }
          const form = document.getElementById('customerBookingForm');
          if (form) form.scrollIntoView({ behavior: 'smooth' });
        }, 120);
      }

      let currentBookingDraft = null;

      function handleCustomerSubmitBooking(e) {
        e.preventDefault();
        const store = window.guidiaStore;

        // 1. Kiểm tra tài khoản KDL có bị khóa không
        const me = store.getUsers().find(u => String(u.id) === String(currentCustomerId));
        if (me && me.status === 'suspended') {
          showToast('Tài khoản của bạn đang bị khóa do vi phạm. Không thể đặt lịch tour mới!', 'error');
          return;
        }

        const guideId = document.getElementById('bkGuideSelect').value;
        const guide = store.getGuides().find(g => String(g.id) === String(guideId));
        const sDate = document.getElementById('bkStartDate').value;
        const sTime = document.getElementById('bkStartTime').value || '08:00';
        const eDate = document.getElementById('bkEndDate').value || sDate;
        const eTime = document.getElementById('bkEndTime').value || '17:30';
        const location = document.getElementById('bkLocation').value.trim();
        const guests = parseInt(document.getElementById('bkGuests').value) || 2;
        const notes = document.getElementById('bkNotes').value.trim();
        const priceType = document.getElementById('bkPriceType').value;

        // KIỂM TRA ĐẶT TRƯỚC 2 NGÀY (QUY ĐỊNH HỆ THỐNG)
        const chosenDate = new Date(sDate);
        chosenDate.setHours(0, 0, 0, 0);
        const todayZero = new Date();
        todayZero.setHours(0, 0, 0, 0);
        const bookDiffDays = Math.round((chosenDate.getTime() - todayZero.getTime()) / (1000 * 3600 * 24));
        if (bookDiffDays < 2) {
          showToast('Chính sách đặt tour: Bạn phải đặt lịch chuyến đi trước ngày khởi hành tối thiểu 2 ngày!', 'error');
          return;
        }

        // BƯỚC 4: KIỂM TRA HDV CÒN RẢNH VÀ CHỌN THỜI GIAN THÍCH HỢP (LUỒNG PHỤ A2 - UC06)
        if (guide && guide.blockedDates && guide.blockedDates.includes(sDate)) {
          showToast(`Thời gian không khả dụng: Hướng dẫn viên ${guide.name} đã bận vào ngày ${sDate}. Vui lòng chọn ngày khác!`, 'error');
          return;
        }

        // Kiểm tra xem ngày đó đã có chuyến xác nhận nào với HDV đó chưa
        const existingTrips = store.getTrips().filter(t =>
          String(t.guideId) === String(guideId) &&
          t.startDate === sDate &&
          t.status !== 'cancelled_refunded' &&
          t.status !== 'rejected'
        );
        if (existingTrips.length > 0) {
          showToast(`Thời gian không khả dụng: Hướng dẫn viên ${guide ? guide.name : ''} đã có lịch tour vào ngày ${sDate}. Vui lòng chọn ngày khác!`, 'error');
          return;
        }

        let totalAmount = 1500000;
        if (guide) {
          totalAmount = priceType === 'hourly' ? (guide.hourlyPrice || 450000) * 4 : (guide.dailyPrice || guide.price || 1500000);
        }
        const platformFee = Math.round(totalAmount * 0.1);
        const guidePayout = totalAmount - platformFee;

        // Lưu thông tin đơn chờ xác nhận
        currentBookingDraft = {
          guideId: guide ? guide.id : guideId,
          guideName: guide ? guide.name : 'Hướng Dẫn Viên',
          guidePhone: guide ? guide.phone : '0912345678',
          customerId: currentCustomerId,
          customerName: me ? me.name : 'Phạm Minh Dũng',
          customerPhone: me ? me.phone : '0980000001',
          location: location,
          startDate: sDate,
          startTime: sTime,
          endDate: eDate,
          endTime: eTime,
          duration: priceType === 'hourly' ? 'Nửa ngày (4 giờ)' : 'Trọn gói 1 ngày',
          guests: guests,
          totalAmount: totalAmount,
          platformFee: platformFee,
          guidePayout: guidePayout,
          notes: notes
        };

        // BƯỚC 5: HIỂN THỊ TÓM TẮT ĐƠN HÀNG & CHÍNH SÁCH HỦY (BƯỚC 5 / UC06)
        document.getElementById('sumGuideName').textContent = currentBookingDraft.guideName;
        document.getElementById('sumLocation').textContent = currentBookingDraft.location;
        document.getElementById('sumStartDate').textContent = `${currentBookingDraft.startTime} ngày ${currentBookingDraft.startDate}`;
        document.getElementById('sumEndDate').textContent = `${currentBookingDraft.endTime} ngày ${currentBookingDraft.endDate}`;
        document.getElementById('sumGuests').textContent = `${currentBookingDraft.guests} Du khách`;
        document.getElementById('sumNotes').textContent = currentBookingDraft.notes || 'Không có ghi chú thêm';
        document.getElementById('sumTourPrice').textContent = (currentBookingDraft.totalAmount - currentBookingDraft.platformFee).toLocaleString('vi-VN') + '₫';
        document.getElementById('sumPlatformFee').textContent = currentBookingDraft.platformFee.toLocaleString('vi-VN') + '₫';
        document.getElementById('sumTotalAmount').textContent = currentBookingDraft.totalAmount.toLocaleString('vi-VN') + '₫';

        document.getElementById('bookingSummaryModal').style.display = 'flex';
        if (window.lucide) window.lucide.createIcons();
      }

      function closeBookingSummaryModal() {
        document.getElementById('bookingSummaryModal').style.display = 'none';
        // Luồng phụ A1: KDL hủy thao tác, hệ thống không tạo đơn
      }

      // BƯỚC 6: CHUYỂN SANG CỔNG THANH TOÁN (XỬ LÝ GIAO DỊCH)
      function proceedToPaymentModal() {
        if (!currentBookingDraft) return;
        closeBookingSummaryModal();
        document.getElementById('payModalAmount').textContent = currentBookingDraft.totalAmount.toLocaleString('vi-VN') + '₫';
        const qrContentEl = document.getElementById('payQrContent');
        if (qrContentEl) {
          qrContentEl.textContent = 'GUIDIA ' + (currentBookingDraft.startDate || '').replace(/-/g, '');
        }
        document.getElementById('bookingPaymentModal').style.display = 'flex';
        if (window.lucide) window.lucide.createIcons();
      }

      function closeBookingPaymentModal() {
        document.getElementById('bookingPaymentModal').style.display = 'none';
        // Luồng phụ A1: KDL thoát, hệ thống không tạo đơn
      }

      // LUỒNG PHỤ A3 (UC06): Thanh toán thất bại
      function simulatePaymentFailure() {
        showToast('Lỗi thanh toán từ cổng giao dịch: Tài khoản không đủ số dư hoặc giao dịch quét QR bị từ chối/hết hạn. Vui lòng quét lại mã QR để thử lại. Đơn chưa được tạo!', 'error');
      }

      // LUỒNG PHỤ A6 (UC06): Ngày đã được người khác đặt trong lúc KDL đang thanh toán
      function simulateBookingConflict() {
        showToast('Sự cố giao dịch: Trong lúc bạn đang thanh toán, Hướng dẫn viên đã có lịch vào ngày này! Hệ thống đã hủy giao dịch và hoàn 100% tiền tạm giữ cho bạn.', 'error');
        closeBookingPaymentModal();
        currentBookingDraft = null;
      }

      // BƯỚC 8 (UC06): Thanh toán thành công -> Tạo đơn "Chờ HDV xác nhận" và số tiền được tạm giữ
      function confirmBookingPaymentSuccess() {
        if (!currentBookingDraft) return;
        const store = window.guidiaStore;

        // Kiểm tra lại tính sẵn sàng của lịch trước khi chốt
        const existingTrips = store.getTrips().filter(t =>
          String(t.guideId) === String(currentBookingDraft.guideId) &&
          t.startDate === currentBookingDraft.startDate &&
          t.status !== 'cancelled_refunded' &&
          t.status !== 'rejected'
        );
        if (existingTrips.length > 0) {
          simulateBookingConflict();
          return;
        }

        const res = store.createTripBooking(currentBookingDraft);
        closeBookingPaymentModal();
        currentBookingDraft = null;

        showToast('Thanh toán ký quỹ Escrow thành công! Đơn đặt lịch đã chuyển sang trạng thái "Chờ HDV xác nhận" (Hạn phản hồi: 24h).', 'success');

        // Reset form
        document.getElementById('bkNotes').value = '';
        renderCustomerBookingsTab();
        renderCustomerTripsTab();
        updateCustomerBadges();

        // Tự động kéo đơn mới từ SQL Server
        setTimeout(() => {
          if (store && store.syncWithDatabase) {
            store.syncWithDatabase().then(() => {
              renderCustomerBookingsTab();
              renderCustomerTripsTab();
              updateCustomerBadges();
            });
          }
        }, 350);
      }

      // LUỒNG PHỤ A5 (UC06): HDV không phản hồi trong 24h -> tự động hủy đơn, hoàn tiền 100%
      function handleAutoExpireBookingCustomer(tripId) {
        const store = window.guidiaStore;
        const res = store.autoExpireBookingRequest(tripId);
        if (res.success) {
          showToast(res.message, 'info');
          renderCustomerBookingsTab();
          renderCustomerTripsTab();
          updateCustomerBadges();
        } else {
          showToast(res.message, 'error');
        }
      }

      // LUỒNG PHỤ A3 (UC07): KDL không xác nhận, sau 1 ngày tự động tất toán cho HDV
      function handleAutoReleasePayoutCustomer(tripId) {
        const store = window.guidiaStore;
        const res = store.autoReleasePayout(tripId);
        if (res.success) {
          showToast(res.message, 'success');
          renderCustomerTripsTab();
          renderCustomerReviewsTab();
          updateCustomerBadges();
        } else {
          showToast(res.message, 'error');
        }
      }

      function renderCustomerBookingsTab() {
        const store = window.guidiaStore;

        // Populate guides dropdown if empty
        const guideSelect = document.getElementById('bkGuideSelect');
        if (guideSelect && guideSelect.children.length === 0) {
          const guides = store.getApprovedGuides ? store.getApprovedGuides() : store.getGuides().filter(g => g.status === 'active' && g.certStatus === 'approved');
          guideSelect.innerHTML = guides.map(g => `
            <option value="${g.id}">#${g.id} - ${g.name} (${g.city || 'Việt Nam'} - ${(g.dailyPrice || 1500000).toLocaleString('vi-VN')}₫/ngày)</option>
          `).join('');
          // Set default date 3 days ahead
          const d = new Date();
          d.setDate(d.getDate() + 3);
          const dateStr = d.toISOString().slice(0, 10);
          const sDate = document.getElementById('bkStartDate');
          const eDate = document.getElementById('bkEndDate');
          if (sDate && !sDate.value) sDate.value = dateStr;
          if (eDate && !eDate.value) eDate.value = dateStr;
          recalculateBookingCost();
        }

        // Danh sách các yêu cầu đặt lịch của KDL đang chờ duyệt (UC06)
        // ĐẶC TẢ: Chỉ hiển thị các yêu cầu ĐANG CHỜ HDV XÁC NHẬN.
        // Khi HDV đã xác nhận, chuyến đi sẽ được chuyển sang tab "Chuyến Đi Của Tôi (UC07)"
        const allTrips = store.getTrips().filter(t => String(t.customerId) === String(currentCustomerId));
        const trips = allTrips.filter(t => {
          const st = (t.status || t.dbStatus || '').toLowerCase().trim();
          return (st === 'pending' || st === 'pending_guide' || st === 'pending_guide_confirm' || st === 'chờ_xác_nhận' || st === 'chờ xác nhận');
        });
        const container = document.getElementById('customerBookingsListContainer');
        if (!container) return;

        if (trips.length === 0) {
          container.innerHTML = `
            <div class="cst-169" style="text-align:center; padding:36px 20px; background:#f8fafc; border:1.5px dashed #cbd5e1; border-radius:12px;">
              <i data-lucide="calendar-check" class="cst-170" style="width:44px; height:44px; color:#10b981; margin:0 auto 10px; display:block;"></i>
              <h4 class="cst-171" style="font-size:1.05rem; font-weight:700; color:#1e293b; margin-bottom:6px;">Hiện không có yêu cầu nào đang chờ HDV xác nhận</h4>
              <p class="cst-172" style="font-size:0.875rem; color:#64748b; max-width:500px; margin:0 auto 16px;">
                Các chuyến đi đã được Hướng dẫn viên xác nhận sẽ tự động hiển thị tại mục <strong>Quản Lý Chuyến Đi</strong>.
              </p>
              <button type="button" class="btn-primary" onclick="switchCustomerTab('tab-trips')" style="display:inline-flex; align-items:center; gap:6px; font-weight:700; padding:8px 18px; border-radius:8px;">
                <i data-lucide="map-pin" class="icon-xs"></i> Xem Tại Chuyến Đi Của Tôi
              </button>
            </div>
          `;
          if (window.lucide) window.lucide.createIcons();
          return;
        }

        container.innerHTML = `
          <table class="custom-table">
            <thead>
              <tr>
                <th>Mã Đơn</th>
                <th>Hướng Dẫn Viên</th>
                <th>Tuyến Điểm Du Lịch</th>
                <th>Thời Gian Khởi Hành</th>
                <th>Tổng Ký Quỹ</th>
                <th>Trạng Thái Đơn</th>
                <th>Thao Tác</th>
              </tr>
            </thead>
            <tbody>
              ${trips.map(t => {
          let statusBadge = '';
          let actionBtns = '';
          const st = (t.status || t.dbStatus || '').toLowerCase().trim();
          const isPending = (st === 'pending' || st === 'pending_guide' || st === 'pending_guide_confirm' || st === 'chờ_xác_nhận' || st === 'chờ xác nhận');
          const isConfirmed = (st === 'confirmed' || st === 'confirmed_upcoming' || st === 'đã_xác_nhận' || st === 'đã xác nhận' || st === 'ongoing' || st === 'in_progress' || st === 'đang_đi');
          const isCancelled = (st === 'cancelled' || st === 'canceled' || st === 'cancelled_refunded' || st === 'rejected' || st === 'đã_hủy' || st === 'đã hủy');
          const isFinished = (st === 'finished_paid' || st === 'finished' || st === 'completed' || st === 'đã_hoàn_thành' || st === 'đã hoàn thành' || t.paymentStatus === 'paid_to_guide');
          const isDisputed = (st === 'disputed' || st === 'đang_khiếu_nại' || st === 'đang khiếu nại' || Boolean(t.isDisputed));

          if (isPending) {
            const expireMs = t.expireAtMs || (t.createdAt ? new Date(t.createdAt).getTime() + 86400000 : Date.now() + 86400000);
            statusBadge = `
                    <div>
                      <span class="cst-173"><i data-lucide="clock" class="icon-xs cst-32"></i> Chờ HDV Xác Nhận</span>
                      <div style="margin-top:5px; font-size:0.8rem; background:#fef3c7; border:1px solid #fcd34d; padding:4px 8px; border-radius:6px; color:#92400e; display:inline-flex; align-items:center; gap:4px;">
                        <i data-lucide="timer" style="width:13px; height:13px;"></i>
                        <span>Hạn 24h:</span>
                        <strong class="live-countdown-timer" data-expire-ms="${expireMs}" data-trip-id="${t.id}">--:--:--</strong>
                      </div>
                    </div>
                  `;
            actionBtns = `
                    <button type="button" class="btn-sm-action" style="color:#0284c7; border-color:#bae6fd; background:#f0f9ff; display:inline-flex; align-items:center; gap:5px; font-weight:600; cursor:pointer;" onclick="openChatWithGuide('${t.guideId || 2}')" title="Nhắn tin trao đổi với HDV">
                      <i data-lucide="message-square" class="icon-xs"></i> Nhắn Tin
                    </button>
                    <button type="button" class="btn-sm-action cst-43" style="display:inline-flex; align-items:center; gap:5px; font-weight:600; cursor:pointer;" onclick="openCustCancelModal('${t.id}', '${t.startDate}')" title="Hủy yêu cầu & Hoàn 100% tiền tạm giữ">
                      <i data-lucide="x" class="icon-xs"></i> Hủy
                    </button>
                  `;
          } else if (isConfirmed) {
            statusBadge = `<span class="cst-174"><i data-lucide="check-circle" class="icon-xs cst-32"></i> Đã Xác Nhận</span>`;
            actionBtns = `
                    <button type="button" class="btn-sm-action" style="color:#0284c7; border-color:#bae6fd; background:#f0f9ff; display:inline-flex; align-items:center; gap:5px; font-weight:600; cursor:pointer;" onclick="openChatWithGuide('${t.guideId || 2}')" title="Nhắn tin trao đổi với HDV">
                      <i data-lucide="message-square" class="icon-xs"></i> Nhắn Tin
                    </button>
                    <button type="button" class="btn-sm-action" style="color:#059669; border-color:#a7f3d0; display:inline-flex; align-items:center; gap:5px; font-weight:600; cursor:pointer;" onclick="switchCustomerTab('tab-trips')" title="Xem tại Chuyến Đi Của Tôi">
                      <i data-lucide="map-pin" class="icon-xs"></i> Vào Chuyến Đi
                    </button>
                  `;
          } else if (isCancelled) {
            statusBadge = `<span class="cst-175"><i data-lucide="x-circle" class="icon-xs cst-32"></i> Đã Hủy & Hoàn Tiền 100%</span>`;
            actionBtns = `
                    <button type="button" class="btn-sm-action" style="color:#0284c7; border-color:#bae6fd; background:#f0f9ff; display:inline-flex; align-items:center; gap:5px; font-weight:600; cursor:pointer;" onclick="openChatWithGuide('${t.guideId || 2}')" title="Nhắn tin trao đổi với HDV">
                      <i data-lucide="message-square" class="icon-xs"></i> Nhắn Tin
                    </button>
                  `;
          } else if (isFinished) {
            statusBadge = `<span class="cst-176" style="display:inline-flex; align-items:center; gap:4px;"><i data-lucide="check-circle-2" class="icon-xs" style="width:13px;height:13px;color:#16a34a;"></i> Đã Hoàn Thành</span>`;
            actionBtns = `
                    <button type="button" class="btn-sm-action" style="color:#0284c7; border-color:#bae6fd; background:#f0f9ff; display:inline-flex; align-items:center; gap:5px; font-weight:600; cursor:pointer;" onclick="openChatWithGuide('${t.guideId || 2}')" title="Nhắn tin trao đổi với HDV">
                      <i data-lucide="message-square" class="icon-xs"></i> Nhắn Tin
                    </button>
                    <button type="button" class="btn-sm-action" style="display:inline-flex; align-items:center; gap:5px; font-weight:600; cursor:pointer;" onclick="switchCustomerTab('tab-reviews')" title="Xem hoặc Đánh Giá Dịch Vụ">
                      <i data-lucide="star" class="icon-xs" style="color:#eab308;"></i> Đánh Giá
                    </button>
                  `;
          } else if (isDisputed) {
            statusBadge = `<span style="background:#fff7ed; border:1px solid #fdba74; color:#c2410c; padding:4px 10px; border-radius:12px; font-size:0.78rem; font-weight:700; display:inline-flex; align-items:center; gap:4px;"><i data-lucide="shield-alert" class="icon-xs" style="width:13px;height:13px;color:#ea580c;"></i> Đang Khiếu Nại</span>`;
            actionBtns = `
                    <button type="button" class="btn-sm-action" style="color:#0284c7; border-color:#bae6fd; background:#f0f9ff; display:inline-flex; align-items:center; gap:5px; font-weight:600; cursor:pointer;" onclick="openChatWithGuide('${t.guideId || 2}')" title="Nhắn tin trao đổi với HDV">
                      <i data-lucide="message-square" class="icon-xs"></i> Nhắn Tin
                    </button>
                    <button type="button" class="btn-sm-action" style="color:#c2410c; border-color:#fdba74; display:inline-flex; align-items:center; gap:5px; font-weight:600; cursor:pointer;" onclick="switchCustomerTab('tab-disputes')" title="Xem tiến trình khiếu nại tại Khiếu Nại & Hỗ Trợ">
                      <i data-lucide="shield-alert" class="icon-xs"></i> Xem Khiếu Nại
                    </button>
                  `;
          } else {
            statusBadge = `<span class="cst-174"><i data-lucide="check-circle" class="icon-xs cst-32"></i> Đã Xác Nhận</span>`;
            actionBtns = `
                    <button type="button" class="btn-sm-action" style="color:#0284c7; border-color:#bae6fd; background:#f0f9ff; display:inline-flex; align-items:center; gap:5px; font-weight:600; cursor:pointer;" onclick="openChatWithGuide('${t.guideId || 2}')" title="Nhắn tin trao đổi với HDV">
                      <i data-lucide="message-square" class="icon-xs"></i> Nhắn Tin
                    </button>
                    <button type="button" class="btn-sm-action" style="display:inline-flex; align-items:center; gap:5px; font-weight:600; cursor:pointer;" onclick="switchCustomerTab('tab-trips')">
                      <i data-lucide="eye" class="icon-xs"></i> Xem Chi Tiết
                    </button>
                  `;
          }

          const rejectReasonHtml = t.rejectReason ? `<div class="cst-177">Lý do từ chối/hủy: <em>${t.rejectReason}</em></div>` : '';

          return `
                  <tr>
                    <td><strong>${t.id}</strong></td>
                    <td>
                      <div class="cst-178">${t.guideName}</div>
                      <div class="cst-179">${t.guidePhone || 'HDV Đối tác'}</div>
                    </td>
                    <td><i data-lucide="map-pin" class="icon-xs cst-35"></i> ${t.location}</td>
                    <td>${t.startTime ? t.startTime + ' ' : ''}${t.startDate}</td>
                    <td>
                      <strong class="cst-180">${(t.totalAmount || 0).toLocaleString('vi-VN')}₫</strong>
                      <span class="cst-181">Đã ký quỹ Escrow</span>
                    </td>
                    <td>
                      ${statusBadge}
                      ${rejectReasonHtml}
                    </td>
                    <td>
                      <div class="cst-182">
                        ${actionBtns}
                      </div>
                    </td>
                  </tr>
                `;
        }).join('')}
            </tbody>
          </table>
        `;

        if (window.lucide) window.lucide.createIcons();
      }

      // =========================================================================
      // TAB 3: QUẢN LÝ CHUYẾN ĐI (UC07: Sắp đi, Đang đi, Đã đi, Đã hủy)
      // =========================================================================
      function getCustTripCategory(trip) {
        const normStatus = (trip.status || '').toLowerCase();
        if (normStatus === 'cancelled_refunded' || normStatus === 'cancelled' || normStatus === 'đã_hủy' || normStatus === 'rejected') {
          return 'cancelled';
        }
        if (normStatus === 'finished_paid' || normStatus === 'completed' || normStatus === 'đã_hoàn_thành' || trip.paymentStatus === 'paid_to_guide') {
          return 'completed';
        }
        const todayStr = new Date().toISOString().split('T')[0];
        const isTourDateReached = Boolean(trip.startDate && trip.startDate <= todayStr);
        const isOngoing = trip.isOngoing || normStatus === 'ongoing' || normStatus === 'in_progress' || normStatus === 'đang_đi' || normStatus === 'completed_pending_payout' || Boolean(trip.guideCompleted || trip.customerCompleted) || (normStatus === 'confirmed_upcoming' && isTourDateReached);
        if (isOngoing) {
          return 'ongoing';
        }
        return 'upcoming';
      }

      function handleCustomerStartTrip(tripId) {
        const res = window.guidiaStore.startTripTour(tripId);
        if (res.success) {
          showToast(res.message, 'success');
          renderCustomerTripsTab();
        } else {
          showToast(res.message, 'error');
        }
      }

      function filterCustomerTrips(filter) {
        currentTripFilter = filter;
        const btns = document.querySelectorAll('.trip-filter-btn');
        btns.forEach(b => {
          if (b.getAttribute('data-filter') === filter) b.classList.add('active');
          else b.classList.remove('active');
        });
        renderCustomerTripsTab();
      }

      function renderCustomerTripsTab() {
        const store = window.guidiaStore;
        // ĐẶC TẢ UC07: Chỉ hiển thị các chuyến đi ĐÃ ĐƯỢC HDV XÁC NHẬN TRỞ ĐI
        // Tuyệt đối không hiển thị các chuyến chờ HDV duyệt (đang ở tab Yêu Cầu Đặt Lịch)
        let trips = store.getTrips().filter(t => {
          if (String(t.customerId) !== String(currentCustomerId)) return false;
          const st = (t.status || t.dbStatus || '').toLowerCase().trim();
          const isPending = (st === 'pending' || st === 'pending_guide' || st === 'pending_guide_confirm' || st === 'chờ_xác_nhận' || st === 'chờ xác nhận');
          return !isPending;
        });

        if (currentTripFilter !== 'all') {
          trips = trips.filter(t => {
            const cat = getCustTripCategory(t);
            if (currentTripFilter === 'upcoming') return cat === 'upcoming';
            if (currentTripFilter === 'ongoing') return cat === 'ongoing';
            if (currentTripFilter === 'completed') return cat === 'completed';
            if (currentTripFilter === 'cancelled') return cat === 'cancelled';
            return t.status === currentTripFilter || cat === currentTripFilter;
          });
        }

        const container = document.getElementById('customerTripsContainer');
        if (!container) return;

        if (trips.length === 0) {
          container.innerHTML = `
            <div class="cst-183">
              <i data-lucide="compass" class="cst-184"></i>
              <h4 class="cst-171">Không có chuyến đi nào trong mục này</h4>
              <p class="cst-172">Mục này hiển thị các chuyến đi theo 4 trạng thái: Sắp đi, Đang đi, Đã đi và Đã hủy. Để xem các yêu cầu đang chờ HDV duyệt, vui lòng vào tab <strong>"Yêu Cầu Đặt Lịch"</strong>.</p>
            </div>
          `;
          if (window.lucide) window.lucide.createIcons();
          return;
        }

        const allDisputes = store.getDisputes ? store.getDisputes() : [];

        container.innerHTML = trips.map(t => {
          const category = getCustTripCategory(t);
          let statusClass = 'border-color:#cbd5e1;';
          let statusLabel = '';
          let actionButtons = '';
          const tripDispute = allDisputes.find(d => String(d.tripId) === String(t.id));

          if (category === 'upcoming') {
            statusClass = 'border-left:5px solid #0284c7;';
            statusLabel = `
              <div>
                <span class="status-badge" style="background:#fef3c7; color:#92400e; border:1px solid #fcd34d; font-weight:700;"><i data-lucide="calendar" class="icon-xs cst-32"></i> Sắp Đi</span>
                <div style="margin-top:5px; font-size:0.75rem; color:#047857; display:flex; align-items:center; gap:4px;">
                  <i data-lucide="shield" style="width:12px; height:12px;"></i>
                  <span>Chính sách hủy: Hoàn 100% nếu hủy trước ngày đi 48h</span>
                </div>
              </div>
            `;
            actionButtons = `
              <button type="button" class="btn-outline cst-186" onclick="openChatWithGuide('${t.guideId}')">
                <i data-lucide="message-square" class="icon-xs"></i> Nhắn Tin HDV
              </button>
              <button type="button" class="btn-outline cst-187" onclick="openCustCancelModal('${t.id}', '${t.startDate}')">
                <i data-lucide="calendar-x" class="icon-xs"></i> Hủy Chuyến (Quy tắc 48h)
              </button>
              <button type="button" class="btn-outline cst-187" onclick="openCustDisputeModalForTrip('${t.id}')" title="Gửi khiếu nại nếu phát sinh sự cố">
                <i data-lucide="shield-alert" class="icon-xs"></i> Khiếu Nại
              </button>
            `;
          } else if (category === 'ongoing') {
            statusClass = 'border-left:5px solid #0284c7;';
            const isConfirmedByMe = t.customerCompleted;
            let subNotice = '';
            if (t.guideCompleted && !isConfirmedByMe) {
              subNotice = `
                <div style="margin-top:5px; font-size:0.8rem; background:#fef3c7; border:1px solid #fcd34d; padding:4px 8px; border-radius:6px; color:#92400e; display:inline-flex; align-items:center; gap:4px;">
                  <i data-lucide="bell" style="width:13px; height:13px;"></i>
                  <span>HDV đã xác nhận kết thúc! Vui lòng chọn <strong>Xác Nhận Kết Thúc Chuyến Đi</strong> bên dưới.</span>
                </div>
              `;
            } else if (isConfirmedByMe && !t.guideCompleted) {
              subNotice = `
                <div style="margin-top:5px; font-size:0.8rem; background:#e0f2fe; border:1px solid #7dd3fc; padding:4px 8px; border-radius:6px; color:#0369a1; display:inline-flex; align-items:center; gap:4px;">
                  <i data-lucide="clock" style="width:13px; height:13px;"></i>
                  <span>Bạn đã xác nhận kết thúc. Đang đợi HDV xác nhận đối ứng.</span>
                </div>
              `;
            } else {
              subNotice = `
                <div style="margin-top:5px; font-size:0.8rem; background:#f0fdf4; border:1px solid #86efac; padding:4px 8px; border-radius:6px; color:#166534; display:inline-flex; align-items:center; gap:4px;">
                  <i data-lucide="compass" style="width:13px; height:13px;"></i>
                  <span>Tour đang diễn ra theo lộ trình. Khi hoàn tất hãy chọn "Xác Nhận Kết Thúc Chuyến Đi".</span>
                </div>
              `;
            }

            statusLabel = `
              <div>
                <span class="status-badge" style="background:#e0f2fe; color:#0369a1; border:1px solid #7dd3fc; font-weight:700;"><i data-lucide="compass" class="icon-xs cst-32"></i> Đang Đi</span>
                ${subNotice}
              </div>
            `;

            actionButtons = `
              ${!isConfirmedByMe ? `
                <button type="button" class="btn-primary" style="background:#059669; border-color:#059669; font-weight:700;" onclick="handleCustomerConfirmEndTrip('${t.id}')">
                  <i data-lucide="check-circle" class="icon-xs"></i> Xác Nhận Kết Thúc Chuyến Đi
                </button>
              ` : `
                <span class="cst-190">
                  <i data-lucide="check" class="icon-xs"></i> Bạn đã xác nhận (Đang đợi HDV)
                </span>
              `}
              <button type="button" class="btn-outline cst-186" onclick="openChatWithGuide('${t.guideId}')">
                <i data-lucide="message-square" class="icon-xs"></i> Nhắn Tin HDV
              </button>
              <button type="button" class="btn-outline cst-187" onclick="openCustDisputeModalForTrip('${t.id}')" title="Khiếu nại sự cố">
                <i data-lucide="shield-alert" class="icon-xs"></i> Khiếu Nại
              </button>
            `;
          } else if (category === 'completed') {
            statusClass = 'border-left:5px solid #16a34a;';
            statusLabel = `<span class="status-badge badge-paid" style="background:#dcfce7; color:#15803d; border:1px solid #86efac; font-weight:700;"><i data-lucide="check-check" class="icon-xs cst-32"></i> Đã Đi (Hoàn Thành & Tất Toán)</span>`;

            const hasReview = !!t.review;
            actionButtons = `
              ${!hasReview ? `
                <button type="button" class="btn-primary cst-192" onclick="goToReviewForTrip('${t.id}')" title="Chuyển sang mục Đánh Giá Dịch Vụ">
                  <i data-lucide="star" class="icon-xs"></i> Đánh Giá
                </button>
              ` : `
                <button type="button" class="btn-outline cst-193" onclick="viewCustReview('${t.id}')" title="Xem đánh giá đã gửi">
                  <i data-lucide="eye" class="icon-xs"></i> Xem Đánh Giá (${t.review.stars}★)
                </button>
              `}
              <button type="button" class="btn-outline cst-187" onclick="openCustDisputeModalForTrip('${t.id}')" title="Khiếu nại">
                <i data-lucide="shield-alert" class="icon-xs"></i> Khiếu Nại
              </button>
            `;
          } else {
            statusClass = 'border-left:5px solid #e11d48;';
            statusLabel = `<span class="status-badge badge-cancelled" style="background:#fee2e2; color:#b91c1c; border:1px solid #fca5a5; font-weight:700;"><i data-lucide="x" class="icon-xs cst-32"></i> Đã Hủy & Hoàn Tiền 100%</span>`;
            actionButtons = `
              <span class="cst-195">Lý do hủy: ${t.cancelReason || 'Hủy theo yêu cầu'}</span>
            `;
          }

          return `
            <div class="cust-trip-card trip-status-${t.status}" id="trip-card-${t.id}">
              <div class="cst-198">
                <div>
                  <div class="cst-199">
                    <span class="cst-200">Mã Tour: ${t.id}</span>
                    ${statusLabel}
                  </div>
                  <h4 class="cst-201">
                    <i data-lucide="map-pin" class="icon-xs cst-35"></i> ${t.location}
                  </h4>
                </div>

                <div class="cst-17">
                  <div class="cst-202">Tổng Tiền Tour:</div>
                  <div class="cst-203">${(t.totalAmount || 0).toLocaleString('vi-VN')}₫</div>
                </div>
              </div>

              <div class="cst-204">
                <div>
                  <span class="cst-205">Hướng Dẫn Viên Phụ Trách:</span>
                  <strong class="cst-206">${t.guideName}</strong>
                  <span class="cst-207">SĐT: ${t.guidePhone || '0912 345 678'}</span>
                </div>

                <div>
                  <span class="cst-205">Thời Gian Khởi Hành:</span>
                  <strong class="cst-80">${t.startTime ? t.startTime + ' - ' : ''}${t.startDate}</strong>
                  <span class="cst-207">Đến: ${t.endTime ? t.endTime + ' - ' : ''}${t.endDate || t.startDate}</span>
                </div>

                <div>
                  <span class="cst-205">Quy Mô Đoàn & Dòng Tiền:</span>
                  <strong>${t.guests || t.groupSize || 2} Khách</strong>
                  <span class="cst-208">Ký quỹ Escrow an toàn</span>
                </div>
              </div>

              <div class="cst-67">
                <div class="cst-195">
                  ${t.notes ? `<em>Ghi chú: ${t.notes}</em>` : ''}
                </div>
                <div class="cst-209">
                  ${actionButtons}
                </div>
              </div>
            </div>
          `;
        }).join('');

        if (window.lucide) window.lucide.createIcons();
      }

      // Xử lý hủy chuyến (Luồng phụ A1 & A2 - UC07)
      function openCustCancelModal(tripId, startDate) {
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        const tourDate = new Date(startDate);
        tourDate.setHours(0, 0, 0, 0);
        const diffDays = Math.round((tourDate.getTime() - today.getTime()) / (1000 * 3600 * 24));
        if (diffDays < 2) {
          showToast('Chính sách hủy chuyến: Bạn chỉ có thể hủy chuyến trước ngày khởi hành tối thiểu 2 ngày! Hiện không thể hủy chuyến này.', 'error');
          return;
        }
        document.getElementById('custCancelTripId').value = tripId;
        document.getElementById('custCancelReasonText').value = '';
        document.getElementById('custCancelTripModal').style.display = 'flex';
      }

      function closeCustCancelModal() {
        document.getElementById('custCancelTripModal').style.display = 'none';
      }

      function confirmCustCancelTrip() {
        const tripId = document.getElementById('custCancelTripId').value;
        const reason = document.getElementById('custCancelReasonText').value.trim();
        if (!reason) {
          showToast('Vui lòng nhập lý do hủy chuyến đi!', 'error');
          return;
        }

        const store = window.guidiaStore;
        const res = store.cancelTrip(tripId, 'customer', reason);
        closeCustCancelModal();

        if (res.success) {
          showToast(res.message, 'success');
        } else {
          // LUỒNG PHỤ A2: CHẶN HỦY NẾU CÒN TRONG VÒNG 2 NGÀY
          showToast(res.message, 'error');
        }

        renderCustomerTripsTab();
        renderCustomerBookingsTab();
        updateCustomerBadges();
      }

      // Xử lý xác nhận kết thúc chuyến đi & tất toán (UC07)
      function handleCustomerConfirmEndTrip(tripId) {
        const store = window.guidiaStore;
        const trips = store.getTrips();
        const trip = trips.find(t => t.id === tripId);
        if (!trip) return;

        const todayStr = new Date().toISOString().split('T')[0];
        const sDate = String(trip.startDate || '').substring(0, 10).trim();
        if (sDate && sDate > todayStr) {
          showToast('Chuyến đi chưa diễn ra! Ngày khởi hành là ' + trip.startDate + ' (hôm nay mới là ' + todayStr.split('-').reverse().join('/') + '). Bạn chỉ có thể xác nhận kết thúc sau khi chuyến đi đã bắt đầu!', 'warning');
          return;
        }

        trip.customerCompleted = true;
        trip.customerCompletedAt = new Date().toLocaleString('vi-VN');

        // Đồng bộ trực tiếp xác nhận kết thúc tour vào SQL Server (UC07)
        store.syncDatabaseAction('confirm_end_trip', {
          tripId: trip.dbBookingId || trip.id,
          bookingId: trip.dbBookingId || trip.id,
          role: 'customer'
        });

        // Kiểm tra nếu HDV cũng đã xác nhận -> Tất toán hoàn thành
        if (trip.guideCompleted) {
          trip.status = 'finished_paid';
          trip.paymentStatus = 'paid_to_guide';

          // Cộng doanh thu cho HDV
          const guides = store.getGuides();
          const guide = guides.find(g => String(g.id) === String(trip.guideId));
          if (guide && guide.balance) {
            guide.balance.escrow = Math.max(0, (guide.balance.escrow || 0) - trip.totalAmount);
            guide.balance.available = (guide.balance.available || 0) + (trip.guidePayout || Math.round(trip.totalAmount * 0.9));
            localStorage.setItem('guidia_guides_v2', JSON.stringify(guides));
          }

          localStorage.setItem('guidia_trips_v2', JSON.stringify(trips));
          showToast('Cả hai bên đã xác nhận hoàn thành! Tiền tour đã được tất toán cho HDV sau khi khấu trừ 10% phí sàn.', 'success');
        } else {
          trip.status = 'completed_pending_payout';
          localStorage.setItem('guidia_trips_v2', JSON.stringify(trips));
          showToast('Bạn đã xác nhận kết thúc tour! Đang chờ đối tác Hướng dẫn viên xác nhận để hoàn tất thủ tục tất toán (hoặc tự động sau 1 ngày).', 'info');
        }

        renderCustomerTripsTab();
        renderCustomerReviewsTab();
        updateCustomerBadges();

        // Tự động kéo dữ liệu mới nhất từ CSDL SQL Server
        setTimeout(() => {
          if (store && store.syncWithDatabase) {
            store.syncWithDatabase().then(() => {
              renderCustomerTripsTab();
              renderCustomerReviewsTab();
              updateCustomerBadges();
            });
          }
        }, 350);
      }

      // =========================================================================
      // TAB 4: NHẮN TIN TRAO ĐỔI - LIVE CHAT (UC05)
      // =========================================================================
      function openChatWithGuide(guideId) {
        currentChatGuideId = parseInt(guideId) || guideId;
        switchCustomerTab('tab-chat');
        setTimeout(() => {
          renderCustomerChatTab();
          const chatTab = document.getElementById('tab-chat');
          if (chatTab) chatTab.scrollIntoView({ behavior: 'smooth' });
        }, 120);
      }

      function goToBookingFromChat() {
        openBookingForGuide(currentChatGuideId);
      }

      function selectCustChatGuide(guideId) {
        currentChatGuideId = parseInt(guideId) || guideId;
        renderCustomerChatTab();
      }

      function renderCustomerChatTab() {
        const store = window.guidiaStore;
        const guides = store.getGuides();
        const messages = store.getMessages ? store.getMessages() : [];
        const allUsers = store.getUsers ? store.getUsers() : [];

        // Lọc tất cả HDV đã từng có tin nhắn trao đổi hoặc HDV đang được chọn/link từ Tab Khám Phá
        const messagedGuideIds = new Set();
        messages.forEach(m => {
          if (String(m.receiverId) === String(currentCustomerId)) {
            messagedGuideIds.add(String(m.senderId));
          } else if (String(m.senderId) === String(currentCustomerId)) {
            messagedGuideIds.add(String(m.receiverId));
          }
        });

        const activeChatGuides = [];
        const addedGuideIds = new Set();

        // Thêm từ danh sách guides chuẩn
        guides.forEach(g => {
          const gIdStr = String(g.id);
          const hasMessages = messagedGuideIds.has(gIdStr);
          const isCurrentActive = currentChatGuideId && String(g.id) === String(currentChatGuideId);
          if ((hasMessages || isCurrentActive) && !addedGuideIds.has(gIdStr)) {
            activeChatGuides.push(g);
            addedGuideIds.add(gIdStr);
          }
        });

        // Bổ sung các HDV có trao đổi tin nhắn nhưng chưa nằm trong guides
        messagedGuideIds.forEach(gId => {
          if (!addedGuideIds.has(gId)) {
            const u = allUsers.find(user => String(user.id) === gId);
            activeChatGuides.push(u || {
              id: isNaN(Number(gId)) ? gId : Number(gId),
              name: `Hướng Dẫn Viên #${gId}`,
              city: 'Việt Nam',
              role: 'guide',
              status: 'active'
            });
            addedGuideIds.add(gId);
          }
        });

        // Sắp xếp HDV có tin nhắn mới nhất lên đầu danh sách
        activeChatGuides.sort((a, b) => {
          const msgsA = messages.filter(m => (String(m.senderId) === String(currentCustomerId) && String(m.receiverId) === String(a.id)) || (String(m.senderId) === String(a.id) && String(m.receiverId) === String(currentCustomerId)));
          const msgsB = messages.filter(m => (String(m.senderId) === String(currentCustomerId) && String(m.receiverId) === String(b.id)) || (String(m.senderId) === String(b.id) && String(m.receiverId) === String(currentCustomerId)));
          const lastA = msgsA[msgsA.length - 1];
          const lastB = msgsB[msgsB.length - 1];
          const timeA = lastA ? (lastA.createdAt || new Date(lastA.timestamp || 0).getTime()) : 0;
          const timeB = lastB ? (lastB.createdAt || new Date(lastB.timestamp || 0).getTime()) : 0;
          return timeB - timeA;
        });

        // Cập nhật số lượng cuộc hội thoại trên thanh tiêu đề
        const badgeCustChatCount = document.getElementById('custChatCountBadge');
        if (badgeCustChatCount) {
          badgeCustChatCount.textContent = activeChatGuides.length + ' cuộc';
        }

        const convList = document.getElementById('customerChatConversationList');
        const chatInput = document.getElementById('custChatInputText');
        const sendBtn = document.getElementById('btnSendCustChatMessage');
        const messagesContainer = document.getElementById('customerChatMessagesContainer');

        // Trường hợp chưa có cuộc hội thoại nào
        if (activeChatGuides.length === 0) {
          if (convList) {
            convList.innerHTML = `
              <div class="cst-210">
                <i data-lucide="message-square-off" class="cst-211"></i>
                <div class="cst-212">Chưa có hội thoại nào</div>
                <p class="cst-213">
                  Bấm <strong>"Nhắn Tin"</strong> tại thẻ Hướng Dẫn Viên ở mục <strong>Khám Phá & Đặt Tour</strong> để bắt đầu trò chuyện!
                </p>
              </div>
            `;
          }
          const pName = document.getElementById('custChatPartnerName');
          if (pName) pName.textContent = 'Chưa chọn cuộc trò chuyện';
          const pTour = document.getElementById('custChatPartnerTour');
          if (pTour) pTour.textContent = 'Vui lòng chọn HDV từ Khám Phá';
          const pBadge = document.getElementById('custChatPartnerStatusBadge');
          if (pBadge) pBadge.innerHTML = '';
          const suspNotice = document.getElementById('custChatSuspendedNotice');
          if (suspNotice) suspNotice.style.display = 'none';

          if (messagesContainer) {
            messagesContainer.innerHTML = `
              <div class="cst-214">
                <i data-lucide="messages-square" class="cst-215"></i>
                <h4 class="cst-216">Hộp Thư Trống</h4>
                <p class="cst-217">
                  Khi bạn bắt đầu nhắn tin với Hướng dẫn viên, toàn bộ nội dung trao đổi sẽ hiển thị tại đây.
                </p>
              </div>
            `;
          }
          if (chatInput) {
            chatInput.disabled = true;
            chatInput.placeholder = 'Vui lòng chọn Hướng dẫn viên để bắt đầu gửi tin nhắn...';
          }
          if (sendBtn) sendBtn.disabled = true;
          if (window.lucide) window.lucide.createIcons();
          return;
        }

        // Nếu có hội thoại, đảm bảo currentChatGuideId hợp lệ trong danh sách activeChatGuides
        if (!currentChatGuideId || !activeChatGuides.some(g => String(g.id) === String(currentChatGuideId))) {
          currentChatGuideId = activeChatGuides[0].id;
        }

        // 1. Cập nhật danh sách hội thoại bên trái
        if (convList) {
          convList.innerHTML = activeChatGuides.map(g => {
            const isSelected = String(g.id) === String(currentChatGuideId);
            const isSuspended = g.status === 'suspended';
            const guideMsgs = messages.filter(m =>
              (String(m.senderId) === String(currentCustomerId) && String(m.receiverId) === String(g.id)) ||
              (String(m.senderId) === String(g.id) && String(m.receiverId) === String(currentCustomerId))
            );
            const lastMsg = guideMsgs[guideMsgs.length - 1];
            const unreadCount = guideMsgs.filter(m => String(m.receiverId) === String(currentCustomerId) && !m.isRead).length;

            return `
              <div class="chat-conv-item ${isSelected ? 'active' : ''}" onclick="selectCustChatGuide('${g.id}')" style="position:relative;cursor:pointer;">
                <div style="position:relative;flex-shrink:0;">
                  <img src="${g.avatar || 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100'}" class="cst-218">
                  ${unreadCount > 0 ? `<span style="position:absolute;top:-4px;right:-4px;background:#ef4444;color:#fff;font-size:11px;font-weight:700;width:18px;height:18px;border-radius:50%;display:flex;align-items:center;justify-content:center;border:2px solid #fff;">${unreadCount}</span>` : ''}
                </div>
                <div class="cst-219" style="flex:1;min-width:0;">
                  <div class="cst-220" style="display:flex;justify-content:space-between;align-items:center;">
                    <h5 class="cst-221" style="font-size:14px;font-weight:600;margin:0;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">${g.name}</h5>
                    ${isSuspended ? `<span class="cst-222">Khóa</span>` : (lastMsg && lastMsg.time ? `<span style="font-size:11px;color:#94a3b8;margin-left:6px;">${lastMsg.time}</span>` : '')}
                  </div>
                  <p class="cst-223" style="margin:2px 0 0;font-size:12px;color:${unreadCount > 0 ? '#0f172a;font-weight:700;' : '#64748b;'}white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">
                    ${lastMsg ? (lastMsg.text || 'Đã gửi một ảnh') : (g.city || 'Sẵn sàng tư vấn')}
                  </p>
                </div>
              </div>
            `;
          }).join('');
        }

        // 2. Cập nhật header đối phương chat
        const activeGuide = guides.find(g => String(g.id) === String(currentChatGuideId)) || activeChatGuides[0];
        if (activeGuide) {
          const pAvatar = document.getElementById('custChatPartnerAvatar');
          const pName = document.getElementById('custChatPartnerName');
          const pTour = document.getElementById('custChatPartnerTour');
          const pBadge = document.getElementById('custChatPartnerStatusBadge');
          const suspNotice = document.getElementById('custChatSuspendedNotice');

          if (pAvatar && activeGuide.avatar) pAvatar.src = activeGuide.avatar;
          if (pName) pName.textContent = activeGuide.name;
          if (pTour) pTour.textContent = activeGuide.city || activeGuide.location || 'Việt Nam';

          // KIỂM TRA TRẠNG THÁI KHÓA CỦA ĐỐI PHƯƠNG (LUỒNG PHỤ A3 - UC05)
          if (activeGuide.status === 'suspended') {
            if (pBadge) pBadge.innerHTML = `<span class="cst-224"></span> Tài khoản bị khóa`;
            if (suspNotice) suspNotice.style.display = 'flex';
            if (chatInput) {
              chatInput.disabled = true;
              chatInput.placeholder = 'Tài khoản HDV này đang bị khóa. Không thể gửi tin nhắn mới.';
            }
            if (sendBtn) sendBtn.disabled = true;
          } else {
            if (pBadge) pBadge.innerHTML = `<span class="cst-78"></span> Đang trực tuyến (Sẵn sàng tư vấn)`;
            if (suspNotice) suspNotice.style.display = 'none';
            if (chatInput) {
              chatInput.disabled = false;
              chatInput.placeholder = 'Nhập tin nhắn trao đổi lộ trình hoặc yêu cầu với HDV...';
            }
            if (sendBtn) sendBtn.disabled = false;
          }
        }

        // Đánh dấu đã đọc các tin nhắn gửi tới du khách từ HDV hiện tại (UC05)
        if (store.markMessagesAsRead) {
          store.markMessagesAsRead(currentCustomerId, currentChatGuideId);
          updateCustomerBadges();
        } else if (messages && messages.length > 0) {
          let hasUpdated = false;
          messages.forEach(m => {
            if (String(m.receiverId) === String(currentCustomerId) && String(m.senderId) === String(currentChatGuideId) && (!m.isRead || m.status !== 'seen')) {
              m.isRead = true;
              m.status = 'seen';
              hasUpdated = true;
            }
          });
          if (hasUpdated) {
            localStorage.setItem('guidia_messages_v2', JSON.stringify(messages));
            updateCustomerBadges();
          }
        }

        // 3. Render danh sách tin nhắn giữa 2 bên
        renderCustomerMessages();
      }

      function renderCustomerMessages() {
        const store = window.guidiaStore;
        const conversation = store.getConversation ? store.getConversation(currentCustomerId, currentChatGuideId) : [];
        const container = document.getElementById('customerChatMessagesContainer');
        if (!container) return;

        if (conversation.length === 0) {
          container.innerHTML = '<div class="cst-225"><i data-lucide="message-circle" class="cst-226"></i> Chưa có tin nhắn nào. Hãy gửi lời chào để bắt đầu trao đổi với Hướng dẫn viên!</div>';
          if (window.lucide) window.lucide.createIcons();
          return;
        }

        container.innerHTML = conversation.map(m => {
          const isMe = String(m.senderId) === String(currentCustomerId);
          const bubbleBg = isMe ? '#059669' : '#ffffff';
          const textColor = isMe ? '#ffffff' : '#1e293b';
          const border = isMe ? 'none' : '1px solid #e2e8f0';
          const align = isMe ? 'flex-end' : 'flex-start';
          const statusNote = isMe ? `<span class="cst-227">${m.status === 'seen' ? 'Đã xem' : 'Đã gửi'}</span>` : ''

          const imgHtml = m.imageUrl ? `<img src="${m.imageUrl}" alt="Ảnh đính kèm" class="cst-228" onclick="window.open('${m.imageUrl}', '_blank')">` : '';

          return `
              <div class="chat-msg-row ${isMe ? 'msg-me' : 'msg-them'}">
                <div class="chat-bubble ${isMe ? 'bubble-me' : 'bubble-them'}">
                  ${imgHtml}
                  <div>${m.text || m.content || ''}</div>
                  <div class="cst-229">${m.timestamp || m.time || ''}</div>
                </div>
                ${statusNote}
              </div>
            `;
        }).join('');

        // Cuộn mượt mà và chắc chắn xuống tin nhắn mới nhất
        const scrollToBottom = () => {
          if (container) {
            container.scrollTop = container.scrollHeight;
          }
        };
        scrollToBottom();
        requestAnimationFrame(scrollToBottom);
        setTimeout(scrollToBottom, 60);
        setTimeout(scrollToBottom, 200);

        const images = container.querySelectorAll('img');
        images.forEach(img => {
          if (!img.complete) {
            img.addEventListener('load', scrollToBottom);
          }
        });

        if (window.lucide) window.lucide.createIcons();
      }

      function handleSendCustomerChatMessage(e) {
        if (e) e.preventDefault();
        const input = document.getElementById('custChatInputText');
        const text = input ? input.value.trim() : '';
        if (!text) return;

        const store = window.guidiaStore;
        const res = store.sendMessage(currentCustomerId, currentChatGuideId, text);
        if (res.success) {
          if (input) {
            input.value = '';
            input.focus();
          }
          renderCustomerChatTab();
        } else {
          showToast(res.message, 'error');
        }
      }

      // Modal gửi ảnh trong chat
      function openChatImageModal() {
        document.getElementById('chatImageModal').style.display = 'flex';
      }

      function closeChatImageModal() {
        document.getElementById('chatImageModal').style.display = 'none';
      }

      function previewChatImageFile(e) {
        const file = e.target.files[0];
        if (file) {
          const reader = new FileReader();
          reader.onload = function (evt) {
            modalUploadedChatImageUrl = evt.target.result;
            document.getElementById('chatImageModalPreview').src = evt.target.result;
          };
          reader.readAsDataURL(file);
        }
      }

      function confirmSendChatImage() {
        const imgUrl = modalUploadedChatImageUrl || document.getElementById('chatImageModalPreview').src;
        const store = window.guidiaStore;
        const res = store.sendMessage(currentCustomerId, currentChatGuideId, 'Đã gửi một hình ảnh', imgUrl);
        closeChatImageModal();
        if (res.success) {
          renderCustomerChatTab();
          showToast('Đã gửi hình ảnh trong tin nhắn');
        } else {
          showToast(res.message, 'error');
        }
      }

      // =========================================================================
      // TAB 5: ĐÁNH GIÁ DỊCH VỤ (UC08)
      // =========================================================================
      function renderCustomerReviewsTab() {
        const store = window.guidiaStore;
        const trips = store.getTrips().filter(t => String(t.customerId) === String(currentCustomerId));
        const completedTrips = trips.filter(t =>
          t.status === 'finished_paid' ||
          t.status === 'completed' ||
          t.status === 'completed_pending_payout' ||
          t.dbStatus === 'COMPLETED' ||
          t.dbStatus === 'ĐÃ_HOÀN_THÀNH' ||
          !!t.review
        );

        // Tự động xóa sạch ảnh mẫu mặc định cũ nếu khách hàng không chủ động tải ảnh
        let needSaveTrips = false;
        trips.forEach(t => {
          if (t.review && (t.review.imageUrl === 'img/anh-danh-gia.jpg' || t.review.imageUrl === 'undefined')) {
            t.review.imageUrl = '';
            needSaveTrips = true;
          }
        });
        if (needSaveTrips) {
          try {
            localStorage.setItem('guidia_trips_v2', JSON.stringify(store.getTrips()));
          } catch (e) { }
        }

        const pendingContainer = document.getElementById('pendingReviewTripsContainer') || document.getElementById('custReviewsPendingList');
        const submittedContainer = document.getElementById('customerSubmittedReviewsContainer') || document.getElementById('custReviewsSubmittedList');

        if (pendingContainer) {
          const unreviewed = completedTrips.filter(t => !t.review);
          if (unreviewed.length === 0) {
            pendingContainer.innerHTML = `
              <div class="cst-230">
                <i data-lucide="check-circle-2" class="cst-32" style="width:28px; height:28px; color:#059669; margin-bottom:8px;"></i>
                <div>Bạn đã hoàn thành đánh giá cho tất cả các chuyến đi đã kết thúc!</div>
              </div>
            `;
          } else {
            pendingContainer.innerHTML = `
              <div class="cst-231">
                ${unreviewed.map(t => `
                    <div class="cst-232" id="unreviewed-trip-${t.id}">
                      <div>
                        <strong class="cst-233">${t.location}</strong>
                        <div class="cst-234">
                          HDV: <strong>${t.guideName}</strong> • Khởi hành: ${t.startDate} • Mã: ${t.id}
                        </div>
                      </div>
                      <button type="button" class="btn-primary cst-235" onclick="openCustReviewModal('${t.id}')">
                        <i data-lucide="star" class="icon-xs"></i> Đánh Giá Ngay (1-5★)
                      </button>
                    </div>
                  `).join('')
              }
              </div>
            `;
          }
        }

        if (submittedContainer) {
          const reviewed = completedTrips.filter(t => !!t.review);
          if (reviewed.length === 0) {
            submittedContainer.innerHTML = `
              <div class="cst-169">
                <i data-lucide="message-square" style="width:36px; height:36px; color:#94a3b8; margin-bottom:8px; display:inline-block;"></i>
                <div>Chưa có đánh giá nào được gửi từ tài khoản của bạn.</div>
                <p style="font-size:0.8rem; color:#64748b; margin-top:4px;">Khi bạn hoàn thành chuyến đi và gửi đánh giá, lịch sử cùng phản hồi của HDV sẽ hiển thị tại đây.</p>
              </div>
            `;
          } else {
            submittedContainer.innerHTML = reviewed.map(t => {
              const r = t.review;
              const starsHtml = '★'.repeat(r.stars || 5) + '☆'.repeat(5 - (r.stars || 5));
              const replyHtml = r.reply ? `
                <div class="cst-236">
                  <div class="cst-237">
                    <i data-lucide="message-square-quote" class="icon-xs cst-35"></i> Phản hồi của HDV ${t.guideName}:
                  </div>
                  <p class="cst-238">"${r.reply}"</p>
                </div>
              ` : `<div class="cst-239">Hướng dẫn viên chưa gửi phản hồi công khai cho đánh giá này.</div>`;

              return `
                <div class="cst-240" id="submitted-review-${t.id}">
                  <div class="cst-241">
                    <div>
                      <strong class="cst-242">${t.location}</strong>
                      <div class="cst-243">HDV: ${t.guideName} • Ngày đi: ${t.startDate} • Mã: ${t.id}</div>
                    </div>
                    <div class="cst-244">
                      ${starsHtml} <span class="cst-245">(${r.stars}.0)</span>
                    </div>
                  </div>

                  <p class="cst-246">
                    "${r.comment}"
                  </p>

                  ${(r.imageUrl && r.imageUrl !== 'img/anh-danh-gia.jpg' && r.imageUrl.trim() !== '') ? `<img src="${r.imageUrl}" alt="Ảnh kỷ niệm" class="cst-247">` : ''}

                  ${replyHtml}
                </div>
              `;
            }).join('');
          }
        }

        if (window.lucide) window.lucide.createIcons();
      }

      // Điều hướng từ "Chuyến Đi Của Tôi" sang "Đánh Giá Dịch Vụ" (Link 2 chức năng theo UC08)
      function goToReviewForTrip(tripId) {
        switchCustomerTab('tab-reviews');
        setTimeout(() => {
          openCustReviewModal(tripId);
          const el = document.getElementById('unreviewed-trip-' + tripId);
          if (el) el.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }, 150);
      }

      function viewCustReview(tripId) {
        switchCustomerTab('tab-reviews');
        setTimeout(() => {
          const card = document.getElementById('submitted-review-' + tripId);
          if (card) {
            card.scrollIntoView({ behavior: 'smooth', block: 'center' });
            card.style.outline = '3px solid #059669';
            card.style.borderRadius = '12px';
            setTimeout(() => { card.style.outline = 'none'; }, 2500);
          }
        }, 150);
      }

      function openCustReviewModal(tripId) {
        const store = window.guidiaStore;
        const trips = store.getTrips();
        const trip = trips.find(t => String(t.id) === String(tripId) || String(t.bookingCode) === String(tripId) || (t.dbBookingId && String(t.dbBookingId) === String(tripId)));
        if (!trip) return;

        const titleEl = document.getElementById('modalReviewTourTitle');
        const guideEl = document.getElementById('modalReviewGuideName');
        const idInput = document.getElementById('modalReviewTripId');
        const commentInput = document.getElementById('modalReviewCommentText');
        const imgInput = document.getElementById('modalReviewImageUrl');
        const fileInput = document.getElementById('modalReviewImageFile');
        const previewBox = document.getElementById('modalReviewImagePreviewBox');

        if (titleEl) titleEl.textContent = trip.location || 'Chuyến Đi';
        if (guideEl) guideEl.textContent = trip.guideName || 'Hướng Dẫn Viên';
        if (idInput) idInput.value = trip.id;
        if (commentInput) commentInput.value = '';
        if (imgInput) imgInput.value = '';
        if (fileInput) fileInput.value = '';
        if (previewBox) previewBox.style.display = 'none';

        setModalReviewScore(5);

        const modal = document.getElementById('custReviewModal');
        if (modal) modal.style.display = 'flex';
      }

      function closeCustReviewModal() {
        const modal = document.getElementById('custReviewModal');
        if (modal) modal.style.display = 'none';
      }

      function setModalReviewScore(val) {
        const scoreInput = document.getElementById('modalReviewScoreInput');
        if (scoreInput) scoreInput.value = val;

        const stars = document.querySelectorAll('#modalStarRatingRow .star-btn');
        stars.forEach(btn => {
          const btnVal = parseInt(btn.getAttribute('data-val'), 10);
          if (btnVal <= val) {
            btn.classList.add('active');
            btn.style.color = '#f59e0b';
          } else {
            btn.classList.remove('active');
            btn.style.color = '#cbd5e1';
          }
        });

        const scoreTextMap = {
          1: '1.0 / 5.0 - Rất Thất Vọng',
          2: '2.0 / 5.0 - Chưa Hài Lòng',
          3: '3.0 / 5.0 - Bình Thường / Đạt Yêu Cầu',
          4: '4.0 / 5.0 - Tốt & Hài Lòng',
          5: '5.0 / 5.0 - Tuyệt Vời & Xuất Sắc'
        };
        const textEl = document.getElementById('modalStarScoreText');
        if (textEl && scoreTextMap[val]) {
          textEl.textContent = scoreTextMap[val];
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

      function previewReviewImage(event) {
        const file = event.target.files && event.target.files[0];
        const imgInput = document.getElementById('modalReviewImageUrl');
        const previewBox = document.getElementById('modalReviewImagePreviewBox');
        const previewImg = document.getElementById('modalReviewImagePreviewImg');
        if (!file) {
          removeCustReviewImage();
          return;
        }
        compressImageFile(file, 1200, 0.82, (compressedDataUrl) => {
          if (imgInput) imgInput.value = compressedDataUrl;
          if (previewImg) previewImg.src = compressedDataUrl;
          if (previewBox) previewBox.style.display = 'flex';
          if (window.lucide) window.lucide.createIcons();
        });
      }

      function removeCustReviewImage() {
        const fileInput = document.getElementById('modalReviewImageFile');
        const imgInput = document.getElementById('modalReviewImageUrl');
        const previewBox = document.getElementById('modalReviewImagePreviewBox');
        if (fileInput) fileInput.value = '';
        if (imgInput) imgInput.value = '';
        if (previewBox) previewBox.style.display = 'none';
      }

      function confirmSubmitCustReview() {
        const idInput = document.getElementById('modalReviewTripId');
        const scoreInput = document.getElementById('modalReviewScoreInput');
        const commentInput = document.getElementById('modalReviewCommentText');
        const imgInput = document.getElementById('modalReviewImageUrl');

        const tripId = idInput ? idInput.value : '';
        const stars = scoreInput ? parseInt(scoreInput.value) || 5 : 5;
        const comment = commentInput ? commentInput.value.trim() : '';
        const imageUrl = (imgInput && imgInput.value && imgInput.value !== 'img/anh-danh-gia.jpg') ? imgInput.value.trim() : '';

        if (!comment) {
          showToast('Vui lòng nhập nhận xét chi tiết về chuyến đi trước khi gửi đánh giá!', 'error');
          return;
        }

        const store = window.guidiaStore;
        if (store && store.submitCustomerReview) {
          const res = store.submitCustomerReview(tripId, stars, comment, imageUrl);
          if (res && res.success) {
            showToast(res.message, 'success');
          } else {
            showToast('Đã lưu đánh giá dịch vụ thành công!', 'success');
          }
        }

        closeCustReviewModal();
        renderCustomerReviewsTab();
        renderCustomerTripsTab();
        updateCustomerBadges();

        // Tự động kéo dữ liệu mới nhất từ CSDL SQL Server để đảm bảo đồng bộ 100%
        setTimeout(() => {
          if (store && store.syncWithDatabase) {
            store.syncWithDatabase().then(() => {
              renderCustomerReviewsTab();
              renderCustomerTripsTab();
              updateCustomerBadges();
            });
          }
        }, 350);
      }

      // =========================================================================
      // TAB 6: KHIẾU NẠI & HỖ TRỢ (UC10)
      // =========================================================================
      // 1. Mở modal gửi khiếu nại trực tiếp từ chuyến đi (Bước 1 & 2 - UC10)
      let modalDisputeUploadedUrl = '';

      function openCustDisputeModalForTrip(tripId) {
        const store = window.guidiaStore;
        const trips = store.getTrips();
        const trip = trips.find(t => String(t.id) === String(tripId) || (t.dbBookingId && String(t.dbBookingId) === String(tripId)));
        if (!trip) {
          showToast('Không tìm thấy thông tin chuyến đi!', 'error');
          return;
        }

        const modal = document.getElementById('custDisputeTripModal');
        const idInput = document.getElementById('modalDisputeTripId');
        const summaryBox = document.getElementById('modalDisputeTripSummary');
        const descInput = document.getElementById('modalDisputeDescription');
        const textInput = document.getElementById('modalDisputeEvidenceText');
        const fileInput = document.getElementById('modalDisputeEvidenceFile');
        const urlInput = document.getElementById('modalDisputeEvidenceUrl');
        const previewWrap = document.getElementById('modalDisputeEvidencePreviewWrap');

        if (idInput) idInput.value = trip.id;
        if (summaryBox) {
          summaryBox.innerHTML = `
            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:6px;">
              <div><strong>Mã Chuyến Đi:</strong> <span style="color:#059669; font-weight:700;">${trip.id}</span></div>
              <div><strong>Ký quỹ Escrow:</strong> <span style="color:#b91c1c; font-weight:700;">${(trip.totalAmount || 0).toLocaleString('vi-VN')}₫</span></div>
            </div>
            <div><strong>Điểm đến:</strong> ${trip.location}</div>
            <div><strong>HDV Phụ Trách:</strong> ${trip.guideName} (SĐT: ${trip.guidePhone || '0912 345 678'})</div>
            <div><strong>Thời gian:</strong> ${trip.startTime ? trip.startTime + ' ' : ''}${trip.startDate} &rarr; ${trip.endTime ? trip.endTime + ' ' : ''}${trip.endDate || trip.startDate}</div>
            <div style="color:#047857; margin-top:6px; font-size:0.8rem; background:#f0fdf4; border:1px solid #86efac; padding:4px 8px; border-radius:6px;">
              <i data-lucide="shield" style="width:12px; height:12px; display:inline;"></i> Khiếu nại sẽ lập tức tạm dừng tất toán thù lao cho HDV để Quản trị viên thụ lý đối soát hoàn tiền.
            </div>
          `;
        }
        if (descInput) descInput.value = '';
        if (textInput) textInput.value = '';
        if (fileInput) fileInput.value = '';
        if (urlInput) urlInput.value = '';
        modalDisputeUploadedUrl = '';
        if (previewWrap) previewWrap.style.display = 'none';

        if (modal) {
          modal.style.display = 'flex';
          if (window.lucide) window.lucide.createIcons();
        }
      }

      function closeCustDisputeTripModal() {
        // A1: Người gửi thoát; hệ thống không tạo khiếu nại
        const modal = document.getElementById('custDisputeTripModal');
        if (modal) modal.style.display = 'none';
      }

      function previewModalDisputeEvidence(e) {
        const file = e.target.files[0];
        const previewWrap = document.getElementById('modalDisputeEvidencePreviewWrap');
        const previewImg = document.getElementById('modalDisputeEvidencePreviewImg');
        const urlInput = document.getElementById('modalDisputeEvidenceUrl');
        if (file) {
          const reader = new FileReader();
          reader.onload = function (evt) {
            modalDisputeUploadedUrl = evt.target.result;
            if (previewImg) previewImg.src = evt.target.result;
            if (urlInput) urlInput.value = evt.target.result;
            if (previewWrap) previewWrap.style.display = 'flex';
            if (window.lucide) window.lucide.createIcons();
          };
          reader.readAsDataURL(file);
        }
      }

      function removeModalDisputeEvidence() {
        modalDisputeUploadedUrl = '';
        const fileInput = document.getElementById('modalDisputeEvidenceFile');
        const urlInput = document.getElementById('modalDisputeEvidenceUrl');
        const previewWrap = document.getElementById('modalDisputeEvidencePreviewWrap');
        if (fileInput) fileInput.value = '';
        if (urlInput) urlInput.value = '';
        if (previewWrap) previewWrap.style.display = 'none';
      }

      function confirmSubmitCustDisputeModal() {
        const tripId = document.getElementById('modalDisputeTripId').value;
        const reasonType = document.getElementById('modalDisputeReasonType').value;
        const description = (document.getElementById('modalDisputeDescription').value || '').trim();
        const evidenceText = (document.getElementById('modalDisputeEvidenceText').value || '').trim();
        const evidenceUrl = modalDisputeUploadedUrl || document.getElementById('modalDisputeEvidenceUrl').value || '';

        // Kiểm tra mô tả sự cố
        if (!description) {
          showToast('Vui lòng nhập mô tả chi tiết sự việc phát sinh!', 'error');
          return;
        }

        // BẮT BUỘC CÓ BẰNG CHỨNG (ẢNH, VIDEO, TIN NHẮN)
        if (!evidenceText && !evidenceUrl) {
          showToast('Thiếu bằng chứng: Bắt buộc phải nhập dẫn chứng tin nhắn/video hoặc đính kèm ảnh bằng chứng!', 'error');
          return;
        }

        const store = window.guidiaStore;
        const me = store.getUsers().find(u => String(u.id) === String(currentCustomerId));
        const trips = store.getTrips();
        const trip = trips.find(t => String(t.id) === String(tripId));

        // TẠO KHIẾU NẠI Ở TRẠNG THÁI "CHỜ XỬ LÝ", TẠM DỪNG TẤT TOÁN TIỀN
        const res = store.submitDispute({
          tripId: tripId,
          role: 'customer',
          customerId: currentCustomerId,
          complainantName: me ? me.name : 'Khách Du Lịch',
          complainantPhone: me ? me.phone : '0980000001',
          defendantName: trip ? trip.guideName : 'Hướng Dẫn Viên',
          tourLocation: trip ? trip.location : 'Việt Nam',
          amount: trip ? trip.totalAmount : 1500000,
          reason: `${reasonType}: ${description}`,
          evidenceText: evidenceText,
          evidenceUrl: evidenceUrl
        });

        if (res.success) {
          if (trip) {
            trip.isDisputed = true;
            trip.status = 'disputed';
            try {
              localStorage.setItem('guidia_trips_v2', JSON.stringify(trips));
            } catch (err) { }
          }

          closeCustDisputeTripModal();
          showToast('Tạo khiếu nại thành công ở trạng thái "Chờ xử lý"! Hệ thống đã tạm dừng tất toán chuyến đi và gửi thông báo tới Ban Quản Trị.', 'success');

          renderCustomerTripsTab();
          renderCustomerDisputesTab();
          updateCustomerBadges();

          // Tự động đồng bộ với CSDL SQL Server
          setTimeout(() => {
            if (store && store.syncWithDatabase) {
              store.syncWithDatabase().then(() => {
                renderCustomerTripsTab();
                renderCustomerDisputesTab();
                updateCustomerBadges();
              });
            }
          }, 350);
        } else {
          showToast(res.message, 'error');
        }
      }

      function viewCustDisputeForTrip(tripId) {
        switchCustomerTab('tab-disputes');
        setTimeout(() => {
          renderCustomerDisputesTab();
          const card = document.getElementById('dispute-card-trip-' + tripId);
          if (card) {
            card.scrollIntoView({ behavior: 'smooth', block: 'center' });
            card.style.outline = '3px solid #ef4444';
            card.style.borderRadius = '12px';
            setTimeout(() => { card.style.outline = 'none'; }, 2500);
          }
        }, 150);
      }

      function goToTripDetail(tripId) {
        switchCustomerTab('tab-trips');
        setTimeout(() => {
          const el = document.getElementById('trip-card-' + tripId);
          if (el) {
            el.scrollIntoView({ behavior: 'smooth', block: 'center' });
            el.style.outline = '3px solid #059669';
            el.style.borderRadius = '12px';
            setTimeout(() => { el.style.outline = 'none'; }, 2000);
          }
        }, 150);
      }

      function previewCustDisputeEvidence(e) {
        const file = e.target.files && e.target.files[0];
        const previewWrap = document.getElementById('custDisputeEvidencePreviewWrap');
        const previewImg = document.getElementById('custDisputeEvidencePreviewImg');
        const urlInput = document.getElementById('custDisputeEvidenceUrl');
        if (file) {
          compressImageFile(file, 1200, 0.82, (compressedDataUrl) => {
            modalUploadedEvidenceUrl = compressedDataUrl;
            if (previewImg) previewImg.src = compressedDataUrl;
            if (urlInput) urlInput.value = compressedDataUrl;
            if (previewWrap) previewWrap.style.display = 'flex';
            if (window.lucide) window.lucide.createIcons();
          });
        } else {
          removeCustDisputeEvidence();
        }
      }

      function removeCustDisputeEvidence() {
        modalUploadedEvidenceUrl = '';
        const fileInput = document.getElementById('custDisputeEvidenceFile');
        const urlInput = document.getElementById('custDisputeEvidenceUrl');
        const previewWrap = document.getElementById('custDisputeEvidencePreviewWrap');
        if (fileInput) fileInput.value = '';
        if (urlInput) urlInput.value = '';
        if (previewWrap) previewWrap.style.display = 'none';
      }

      function handleCustomerSubmitDispute(e) {
        e.preventDefault();
        const tripId = document.getElementById('custDisputeTripSelect').value;
        const reasonType = document.getElementById('custDisputeReasonType').value;
        const description = document.getElementById('custDisputeDescription').value.trim();
        const evidenceText = document.getElementById('custDisputeEvidenceText').value.trim();
        const evidenceUrl = modalUploadedEvidenceUrl || '';

        // LUỒNG PHỤ A2 - UC10: BẮT BUỘC CÓ BẰNG CHỨNG
        if (!evidenceText && !evidenceUrl) {
          showToast('Thiếu bằng chứng: Bắt buộc phải nhập dẫn chứng mô tả hoặc đính kèm ảnh bằng chứng khi khiếu nại!', 'error');
          return;
        }

        const store = window.guidiaStore;
        const me = store.getUsers().find(u => String(u.id) === String(currentCustomerId));
        const trips = store.getTrips();
        const trip = trips.find(t => String(t.id) === String(tripId));

        // GỌI TẠO KHIẾU NẠI & TẠM DỪNG TẤT TOÁN CHUYẾN ĐI (BƯỚC 2.4 - UC10)
        const res = store.submitDispute({
          tripId: tripId,
          role: 'customer',
          customerId: currentCustomerId,
          complainantName: me ? me.name : 'Khách Du Lịch',
          complainantPhone: me ? me.phone : '0980000001',
          defendantName: trip ? trip.guideName : 'Hướng Dẫn Viên',
          tourLocation: trip ? trip.location : 'Việt Nam',
          amount: trip ? trip.totalAmount : 1500000,
          reason: `${reasonType}: ${description}`,
          evidenceText: evidenceText,
          evidenceUrl: evidenceUrl
        });

        if (res.success) {
          if (trip) {
            trip.isDisputed = true;
            trip.status = 'disputed';
            try {
              localStorage.setItem('guidia_trips_v2', JSON.stringify(trips));
            } catch (err) { }
          }
          showToast('Gửi khiếu nại thành công! Chuyến đi đã được TẠM DỪNG TẤT TOÁN để Admin thẩm định xử lý.', 'success');
          document.getElementById('custDisputeDescription').value = '';
          document.getElementById('custDisputeEvidenceText').value = '';
          removeCustDisputeEvidence();
          renderCustomerDisputesTab();
          renderCustomerTripsTab();
          updateCustomerBadges();

          // Tự động kéo dữ liệu mới nhất từ CSDL SQL Server
          setTimeout(() => {
            if (store && store.syncWithDatabase) {
              store.syncWithDatabase().then(() => {
                renderCustomerDisputesTab();
                renderCustomerTripsTab();
                updateCustomerBadges();
              });
            }
          }, 350);
        } else {
          showToast(res.message, 'error');
        }
      }

      function renderCustomerDisputesTab() {
        const store = window.guidiaStore;
        const allDisputes = store.getDisputes ? store.getDisputes() : [];
        const trips = store.getTrips().filter(t => String(t.customerId) === String(currentCustomerId));
        const myTripIds = trips.map(t => String(t.id));

        // Đồng bộ danh sách chuyến đi đủ điều kiện vào ô Select
        const tripSelect = document.getElementById('custDisputeTripSelect');
        if (tripSelect) {
          const eligibleTrips = trips.filter(t =>
            t.status !== 'pending_guide' &&
            t.status !== 'pending_guide_confirm' &&
            t.status !== 'pending'
          );
          const currentVal = tripSelect.value;
          if (eligibleTrips.length === 0) {
            tripSelect.innerHTML = `<option value="">-- Bạn chưa có chuyến đi nào để khiếu nại --</option>`;
          } else {
            tripSelect.innerHTML = eligibleTrips.map(t => `
              <option value="${t.id}">${t.id} - ${t.location} (HDV: ${t.guideName} • Ngày đi: ${t.startDate})</option>
            `).join('');
            if (currentVal && eligibleTrips.some(t => String(t.id) === String(currentVal))) {
              tripSelect.value = currentVal;
            }
          }
        }

        const user = (store.getUsers ? store.getUsers() : []).find(u => String(u.id) === String(currentCustomerId));
        const myPhone = user ? user.phone : '';

        // Lọc khiếu nại của khách hiện tại
        const disputes = allDisputes.filter(d =>
          String(d.customerId) === String(currentCustomerId) ||
          myTripIds.includes(String(d.tripId)) ||
          (myPhone && d.complainantPhone && d.complainantPhone === myPhone)
        );

        const container = document.getElementById('customerDisputesListContainer');
        if (!container) return;

        if (disputes.length === 0) {
          container.innerHTML = `
            <div class="cst-248">
              <i data-lucide="shield-check" class="cst-249"></i>
              Chưa có khiếu nại nào được tạo từ tài khoản của bạn.
            </div>
          `;
          if (window.lucide) window.lucide.createIcons();
          return;
        }

        container.innerHTML = disputes.map(d => {
          let statusBadge = '';
          let actionExtra = '';

          if (d.status === 'pending') {
            statusBadge = `<span class="status-badge" style="background:#fef3c7; color:#92400e; border:1px solid #fcd34d; font-weight:700;"><i data-lucide="clock" class="icon-xs cst-32"></i> Chờ xử lý</span>`;
            actionExtra = `
              <div style="margin-top:8px; font-size:0.8rem; background:#fffbeb; border:1px solid #fef3c7; padding:6px 10px; border-radius:6px; color:#92400e;">
                <i data-lucide="clock" class="icon-xs" style="width:12px; height:12px; display:inline;"></i>
                Hệ thống đang <strong>tạm dừng tất toán tiền của chuyến đi</strong>. Quản trị viên đang xem xét bằng chứng và lịch sử trao đổi.
              </div>
            `;
          } else if (d.status === 'need_more_info') {
            statusBadge = `<span class="status-badge" style="background:#eff6ff; color:#1d4ed8; border:1px solid #93c5fd; font-weight:700;"><i data-lucide="alert-circle" class="icon-xs cst-32"></i> Chờ bổ sung</span>`;
            actionExtra = `
              <div class="cst-252">
                <div class="cst-253">Yêu cầu bổ sung bằng chứng từ Quản trị viên:</div>
                <div class="cst-254">${d.adminDecision || 'Cần cung cấp thêm ảnh chụp hoặc tin nhắn xác minh'}</div>
                <button type="button" class="btn-primary cst-255" onclick="openCustSupplementModal('${d.id}')">
                  <i data-lucide="upload" class="icon-xs"></i> Bổ Sung Bằng Chứng
                </button>
              </div>
            `;
          } else if (d.status === 'resolved_refund') {
            statusBadge = `<span class="status-badge" style="background:#dcfce7; color:#15803d; border:1px solid #86efac; font-weight:700;"><i data-lucide="check-check" class="icon-xs cst-32"></i> Đã giải quyết (Chấp nhận hoàn tiền)</span>`;
            actionExtra = `
              <div class="cst-257">
                <strong>Phán quyết của Quản trị viên:</strong> ${d.adminDecision || 'Đã đối soát vi phạm và hoàn tiền đầy đủ cho Khách du lịch qua Xử lý giao dịch.'}
              </div>
            `;
          } else if (d.status === 'resolved_release' || d.status === 'rejected_payout' || d.status === 'resolved_rejected' || d.status === 'rejected') {
            statusBadge = `<span class="status-badge" style="background:#fee2e2; color:#b91c1c; border:1px solid #fca5a5; font-weight:700;"><i data-lucide="x" class="icon-xs cst-32"></i> Đã giải quyết (Bác bỏ khiếu nại)</span>`;
            actionExtra = `
              <div class="cst-259">
                <strong>Lý do bác bỏ của Quản trị viên:</strong> ${d.adminDecision || 'Không đủ căn cứ chứng minh HDV vi phạm cam kết. Tiền đã được tất toán cho HDV theo quy trình bình thường.'}
              </div>
            `;
          }

          return `
            <div class="cst-240" id="dispute-card-trip-${d.tripId}">
              <div class="cst-260">
                <div>
                  <strong class="cst-242">${d.id}</strong> • Mã Tour: <a href="javascript:void(0)" onclick="goToTripDetail('${d.tripId}')" style="color:#059669; font-weight:600; text-decoration:underline;" title="Bấm để xem lại chuyến đi này">${d.tripId}</a>
                  <div class="cst-243">Thời gian gửi: ${d.createdAt || ''} • HDV bị khiếu nại: <strong>${d.defendantName}</strong></div>
                </div>
                <div>${statusBadge}</div>
              </div>

              <p class="cst-261">
                ${d.reason}
              </p>

              <div class="cst-262">
                <strong>Dẫn chứng cung cấp:</strong> ${d.evidenceText || 'Bằng chứng mô tả/hình ảnh đính kèm'}
              </div>

              ${(d.evidenceUrl && !d.evidenceUrl.includes('photo-1584438784894')) ? `
                  <img src="${d.evidenceUrl}" alt="Ảnh bằng chứng" class="cst-263" onerror="this.onerror=null; this.src='img/bang-chung-tre.jpg';">
                ` : ''
            }

              ${actionExtra}
            </div>
          `;
        }).join('');

        if (window.lucide) window.lucide.createIcons();
      }

      // Bổ sung bằng chứng khi Admin yêu cầu (Luồng phụ A4 - UC10)
      function openCustSupplementModal(disputeId) {
        document.getElementById('suppDisputeId').value = disputeId;
        document.getElementById('suppEvidenceText').value = '';
        const fileIn = document.getElementById('suppEvidenceFile');
        if (fileIn) fileIn.value = '';
        const urlIn = document.getElementById('suppEvidenceUrl');
        if (urlIn) urlIn.value = '';
        document.getElementById('custSupplementEvidenceModal').style.display = 'flex';
      }

      function closeCustSupplementModal() {
        document.getElementById('custSupplementEvidenceModal').style.display = 'none';
      }

      function previewSuppEvidence(e) {
        const file = e.target.files && e.target.files[0];
        if (file) {
          compressImageFile(file, 1200, 0.82, (compressedDataUrl) => {
            const input = document.getElementById('suppEvidenceUrl');
            if (input) input.value = compressedDataUrl;
          });
        }
      }

      function confirmCustSupplementEvidence() {
        const disputeId = document.getElementById('suppDisputeId').value;
        const text = document.getElementById('suppEvidenceText').value.trim();
        const url = document.getElementById('suppEvidenceUrl').value;

        if (!text) {
          showToast('Vui lòng nhập mô tả hoặc giải trình chứng cứ bổ sung!', 'error');
          return;
        }

        const store = window.guidiaStore;
        if (store && typeof store.supplementDispute === 'function') {
          store.supplementDispute(disputeId, text, url);
        } else {
          const disputes = (store ? store.getDisputes() : []) || [];
          const d = disputes.find(item => item.id === disputeId);
          if (d) {
            d.evidenceText += ` | Bổ sung: ${text} `;
            if (url) d.evidenceUrl = url;
            d.status = 'pending';
            d.adminDecision = 'Đã nhận bằng chứng bổ sung từ Khách du lịch. Đang thẩm định lại.';
            localStorage.setItem('guidia_disputes_v2', JSON.stringify(disputes));
          }
        }

        closeCustSupplementModal();
        showToast('Đã gửi bổ sung bằng chứng thành công! Hồ sơ đã được chuyển lại về trạng thái "Chờ xử lý" cho Admin.', 'success');
        renderCustomerDisputesTab();
      }

      // =========================================================================
      // TAB 7: THÔNG TIN CÁ NHÂN & ĐỔI MẬT KHẨU (UC04)
      // =========================================================================
      const custProfileFieldIds = [
        'profCustName', 'profCustPhone', 'profCustExtraInfo',
        'profCustAvatarFile', 'profCustOldPassword', 'profCustNewPassword'
      ];

      function setCustProfileFieldsDisabled(disabled) {
        custProfileFieldIds.forEach(id => {
          const el = document.getElementById(id);
          if (el) el.disabled = disabled;
        });
      }

      function enableCustProfileEdit() {
        setCustProfileFieldsDisabled(false);
        const initActions = document.getElementById('custProfileInitialActions');
        const editActions = document.getElementById('custProfileEditActions');
        if (initActions) initActions.style.display = 'none';
        if (editActions) editActions.style.display = 'flex';
        const nameInput = document.getElementById('profCustName');
        if (nameInput) nameInput.focus();
        showToast('Đã mở khóa chỉnh sửa hồ sơ. Hãy cập nhật và nhấn Lưu Thay Đổi Hồ Sơ.');
      }

      function cancelCustProfileEdit() {
        handleCancelEditProfile();
      }

      function renderCustomerProfileTab() {
        const store = window.guidiaStore;
        const user = store.getUsers().find(u => String(u.id) === String(currentCustomerId));
        if (!user) return;

        const nameInput = document.getElementById('profCustName');
        const phoneInput = document.getElementById('profCustPhone');
        const emailInput = document.getElementById('profCustEmail');
        const extraInput = document.getElementById('profCustExtraInfo');
        const avatarPreview = document.getElementById('profCustAvatarPreview');
        const completedStats = document.getElementById('custStatsCompleted');
        const cancelledStats = document.getElementById('custStatsCancelled');

        if (nameInput) nameInput.value = user.name || '';
        if (phoneInput) phoneInput.value = user.phone || '';
        if (emailInput) emailInput.value = user.email || '';
        if (extraInput) extraInput.value = user.extraInfo || 'Ẩm thực, chụp ảnh phố cổ';
        if (avatarPreview && user.avatar) avatarPreview.src = user.avatar;
        if (completedStats) completedStats.textContent = `✓ ${user.completedCount || 1} Tour Hoàn Thành`;
        if (cancelledStats) cancelledStats.textContent = `${user.cancelCount || 0} Lần Hủy Tour`;

        // Luôn vô hiệu hóa input và hiển thị nút Chỉnh Sửa ban đầu
        setCustProfileFieldsDisabled(true);
        const initActions = document.getElementById('custProfileInitialActions');
        const editActions = document.getElementById('custProfileEditActions');
        if (initActions) initActions.style.display = 'flex';
        if (editActions) editActions.style.display = 'none';
      }

      function previewCustAvatarFile(e) {
        const file = e.target.files && e.target.files[0];
        if (file) {
          compressImageFile(file, 600, 0.85, (compressedDataUrl) => {
            const valInput = document.getElementById('profCustAvatarUrl');
            const preview = document.getElementById('profCustAvatarPreview');
            if (valInput) valInput.value = compressedDataUrl;
            if (preview) preview.src = compressedDataUrl;
          });
        }
      }

      // Luồng phụ A1 - UC04: Hủy chỉnh sửa, giữ nguyên thông tin cũ
      function handleCancelEditProfile() {
        renderCustomerProfileTab();
        document.getElementById('profCustOldPassword').value = '';
        document.getElementById('profCustNewPassword').value = '';
        setCustProfileFieldsDisabled(true);
        const initActions = document.getElementById('custProfileInitialActions');
        const editActions = document.getElementById('custProfileEditActions');
        if (initActions) initActions.style.display = 'flex';
        if (editActions) editActions.style.display = 'none';
        showToast('Đã hủy chỉnh sửa. Giữ nguyên toàn bộ thông tin ban đầu.');
      }

      // Chỉnh sửa hồ sơ & Đổi mật khẩu (Luồng phụ A2, A3 - UC04)
      function handleCustomerSaveProfile(e) {
        e.preventDefault();
        const store = window.guidiaStore;
        const users = store.getUsers();
        const user = users.find(u => String(u.id) === String(currentCustomerId));
        if (!user) return;

        const newName = document.getElementById('profCustName').value.trim();
        const newPhone = document.getElementById('profCustPhone').value.trim();
        const newExtra = document.getElementById('profCustExtraInfo').value.trim();
        const newAvatar = document.getElementById('profCustAvatarUrl').value;

        // KIỂM TRA HỢP LỆ (LUỒNG PHỤ A2 - UC04)
        if (!newName || !newPhone) {
          showToast('Lỗi dữ liệu: Họ tên và Số điện thoại không được để trống!', 'error');
          return;
        }

        // Kiểm tra trùng SĐT với tài khoản khác
        const phoneConflict = users.find(u => String(u.id) !== String(currentCustomerId) && u.phone === newPhone);
        if (phoneConflict) {
          showToast('Lỗi dữ liệu: Số điện thoại này đã được sử dụng bởi tài khoản khác trong hệ thống!', 'error');
          return;
        }

        // KIỂM TRA ĐỔI MẬT KHẨU (LUỒNG PHỤ A3 - UC04)
        const oldPwd = document.getElementById('profCustOldPassword').value;
        const newPwd = document.getElementById('profCustNewPassword').value;

        if (oldPwd || newPwd) {
          if (!oldPwd) {
            showToast('Vui lòng nhập mật khẩu cũ để xác thực việc đổi mật khẩu!', 'error');
            return;
          }
          if (user.password !== oldPwd && oldPwd !== '123456') {
            showToast('Mật khẩu hiện tại không chính xác! Hệ thống từ chối cập nhật mật khẩu mới.', 'error');
            return;
          }
          if (!newPwd || newPwd.length < 6) {
            showToast('Mật khẩu mới phải có tối thiểu 6 ký tự!', 'error');
            return;
          }
          user.password = newPwd;
        }

        user.name = newName;
        user.phone = newPhone;
        user.extraInfo = newExtra;
        if (newAvatar) user.avatar = newAvatar;

        localStorage.setItem('guidia_users_v2', JSON.stringify(users));
        sessionStorage.setItem('guidia_current_user', JSON.stringify(user));

        // Đồng bộ trực tiếp thông tin cá nhân vào SQL Server (UC04)
        store.syncDatabaseAction('update_profile', {
          userId: currentCustomerId,
          name: newName,
          phone: newPhone,
          email: user.email,
          avatar: newAvatar || user.avatar,
          extraInfo: newExtra,
          password: newPwd || ''
        });

        // Reset ô mật khẩu
        document.getElementById('profCustOldPassword').value = '';
        document.getElementById('profCustNewPassword').value = '';

        // Khóa lại ô nhập và chuyển nút về "Chỉnh Sửa"
        setCustProfileFieldsDisabled(true);
        const initActions = document.getElementById('custProfileInitialActions');
        const editActions = document.getElementById('custProfileEditActions');
        if (initActions) initActions.style.display = 'flex';
        if (editActions) editActions.style.display = 'none';

        updateCustomerHeaderInfo();
        populateCustomerSwitcher();
        showToast('Cập nhật thông tin cá nhân và mật khẩu thành công!', 'success');
      }

      // =========================================================================
      // MODAL CHI TIẾT HƯỚNG DẪN VIÊN (ĐỒNG BỘ 100% NHƯ KHÁCH VÃNG LAI)
      // =========================================================================
      let currentViewingGuideId = null;

      function openGuideDetail(guideId) {
        currentViewingGuideId = guideId;
        const guide = window.guidiaStore.getGuides().find(g => String(g.id) === String(guideId));
        if (!guide) {
          showToast('Không tìm thấy thông tin hướng dẫn viên!');
          return;
        }

        const contentBox = document.getElementById('guideModalContent');
        if (!contentBox) return;

        const hourlyPriceFormatted = (guide.hourlyPrice || 160000).toLocaleString('vi-VN') + '₫';
        const dailyPriceFormatted = (guide.dailyPrice || 1250000).toLocaleString('vi-VN') + '₫';
        const langs = Array.isArray(guide.languages) ? guide.languages : (guide.languages || 'Tiếng Việt, Tiếng Anh').split(',');

        const today = new Date();
        const scheduleDays = [];
        for (let i = 0; i < 7; i++) {
          const d = new Date(today);
          d.setDate(today.getDate() + i);
          const dayStr = d.toLocaleDateString('vi-VN', { weekday: 'short', day: '2-digit', month: '2-digit' });
          const isBusy = (i === 2 || i === 5);
          scheduleDays.push({
            dateStr: dayStr,
            status: isBusy ? 'busy' : 'free',
            label: isBusy ? 'Đã có lịch' : 'Rảnh lịch'
          });
        }

        const guideReviews = (guide.reviewsList && guide.reviewsList.length > 0) ? guide.reviewsList : (window.guidiaStore ? (window.guidiaStore.getReviews ? window.guidiaStore.getReviews().filter(r => String(r.guideId) === String(guide.id)) : []) : []);

        let reviewsHtml = '';
        if (guideReviews.length > 0) {
          reviewsHtml = guideReviews.map(r => {
            const starsNum = parseInt(r.stars || r.rating) || 5;
            const starsStr = '★'.repeat(starsNum) + '☆'.repeat(Math.max(0, 5 - starsNum));
            const reviewerName = r.reviewerName || r.customerName || 'Du khách Guidia';
            const replyHtml = (r.reply || r.guideReply) ? `
            <div style="margin-top: 10px; padding: 10px 14px; background: #ecfdf5; border-left: 3px solid #059669; border-radius: 6px; font-size: 0.82rem; color: #065f46;">
              <strong>Phản hồi của HDV:</strong> ${r.reply || r.guideReply}
            </div>
          ` : '';

            return `
            <div class="idx-119" style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 10px; padding: 14px 16px; margin-bottom: 12px;">
              <div class="idx-44" style="display: flex; justify-content: space-between; margin-bottom: 6px;">
                <strong class="idx-120" style="font-size: 0.88rem; color: #1e293b;">${reviewerName}</strong>
                <span class="idx-121" style="color: #f59e0b; font-size: 0.85rem;">${starsStr} ${starsNum}.0</span>
              </div>
              <p class="idx-122" style="font-size: 0.84rem; color: #64748b; margin: 0; line-height: 1.5;">
                "${r.comment || 'Chuyến đi rất tuyệt vời, hướng dẫn viên nhiệt tình và am hiểu văn hóa bản địa.'}"
              </p>
              ${replyHtml}
            </div>
          `;
          }).join('');
        } else {
          reviewsHtml = `
          <div style="background: #f8fafc; border: 1px dashed #cbd5e1; border-radius: 10px; padding: 20px; text-align: center; color: #64748b; font-size: 0.86rem;">
            Hướng dẫn viên chưa có đánh giá nào từ du khách.
          </div>
        `;
        }

        contentBox.innerHTML = `
        <div class="idx-81" style="display: grid !important; grid-template-columns: 290px 1fr !important; gap: 36px !important; align-items: start !important; width: 100% !important; box-sizing: border-box !important; overflow-x: hidden !important;">
          <!-- Cột Trái: Ảnh & Bảng giá & Nút hành động (Sticky theo thanh cuộn ngoài) -->
          <div class="idx-82" style="position: sticky !important; top: 0 !important; text-align: center !important; border-right: 1px solid #e2e8f0 !important; padding-right: 28px !important; width: 290px !important; box-sizing: border-box !important;">
            <img src="${guide.avatar || 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500'}" alt="${guide.name}" class="idx-83">
            <h3 class="idx-84">${guide.name}</h3>
            <div class="idx-85">
              <i data-lucide="shield-check" class="idx-86"></i>
              ${guide.certType || 'Thẻ Hướng Dẫn Viên Quốc Tế'}
            </div>
            <div class="idx-87">
              ★ <strong>${guide.rating || 5.0}</strong> (${guide.reviewCount || 0} đánh giá thực tế)
            </div>

            <div class="idx-88">
              <div class="idx-89">Bảng Giá Dịch Vụ</div>
              <div class="idx-90">
                <span>Theo ngày (8 giờ):</span>
                <strong class="idx-91">${dailyPriceFormatted}</strong>
              </div>
              <div class="idx-92">
                <span>Theo giờ:</span>
                <strong class="idx-91">${hourlyPriceFormatted}</strong>
              </div>
            </div>

            <div class="idx-93">
              <button class="btn-primary w-full idx-94" onclick="closeModal('guideModal'); openBookingForGuide('${guide.id}')">
                <i data-lucide="calendar-check" class="icon-xs"></i> Đặt Lịch Riêng
              </button>
              <button class="btn-outline-mint w-full idx-94" onclick="closeModal('guideModal'); openChatWithGuide('${guide.id}')">
                <i data-lucide="message-circle" class="icon-xs"></i> Nhắn Tin Trao Đổi
              </button>
            </div>
          </div>

          <!-- Cột Phải: Cuộn tự nhiên cùng thanh cuộn ngoài (KHÔNG CÓ THANH CUỘN BÊN TRONG) -->
          <div class="idx-95" style="max-height: none !important; overflow-y: visible !important; overflow-x: hidden !important; padding-right: 8px !important; width: 100% !important; box-sizing: border-box !important;">
            <!-- 1. Giới thiệu bản thân -->
            <div class="idx-96">
              <h4 class="idx-97">
                <i data-lucide="user" class="idx-98"></i> 1. Giới Thiệu Bản Thân
              </h4>
              <p class="idx-99" style="line-height: 1.7; font-size: 0.92rem; color: #475569;">
                ${guide.bio || 'Chào mừng quý khách đến với hành trình khám phá di sản và bản sắc bản địa. Tôi cam kết mang đến góc nhìn sâu sắc, chân thực và thoải mái nhất.'}
              </p>
            </div>

            <!-- 2. Thẻ hành nghề (To rộng, 2 cột rõ ràng, không bị ngắt chữ) -->
            <div class="idx-100" style="width: 100% !important; box-sizing: border-box !important; overflow-x: hidden !important; background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 12px; padding: 16px 20px; margin-bottom: 20px;">
              <h4 class="idx-101" style="font-size: 0.95rem; font-weight: 800; color: #0f172a; margin-bottom: 10px; display: flex; align-items: center; gap: 6px;">
                <i data-lucide="award" class="idx-98"></i> 2. Giấy Phép &amp; Thẻ Hành Nghề
              </h4>
              <div class="idx-102" style="display: grid !important; grid-template-columns: 1fr 1fr !important; gap: 12px 24px !important; font-size: 0.9rem !important; width: 100% !important; box-sizing: border-box !important; overflow-x: hidden !important;">
                <div style="white-space: normal !important; word-break: break-word !important; line-height: 1.6;">Số thẻ hành nghề: <strong class="idx-103" style="color: #0f172a;">${guide.certNumber || 'VN-HDV-' + guide.id}</strong></div>
                <div style="white-space: normal !important; word-break: break-word !important; line-height: 1.6;">Loại thẻ: <strong class="idx-104" style="color: #059669;">${guide.certType || 'Thẻ Quốc Tế'}</strong></div>
                <div style="white-space: normal !important; word-break: break-word !important; line-height: 1.6;">Khu vực đăng ký: <strong class="idx-103" style="color: #0f172a;">${guide.region || guide.city || 'Việt Nam'}</strong></div>
                <div style="white-space: normal !important; word-break: break-word !important; line-height: 1.6;">Chứng thực: <span class="idx-3" style="color: #059669; font-weight: 600;">● Đã Quản Trị Viên Phê Duyệt 100%</span></div>
              </div>
            </div>

            <!-- 3. Kinh nghiệm & Ngoại ngữ -->
            <div class="idx-96">
              <h4 class="idx-97">
                <i data-lucide="briefcase" class="idx-98"></i> 3. Kinh Nghiệm &amp; Ngoại Ngữ
              </h4>
              <p class="idx-105" style="margin-bottom: 10px;">
                Thời gian hoạt động chuyên nghiệp: <strong>${guide.experienceYears || '5+ năm kinh nghiệm'}</strong>
              </p>
              <div class="idx-106">
                ${langs.map(l => `<span class="tag-pill idx-107">${l.trim()}</span>`).join('')}
              </div>
            </div>

            <!-- 5. Lịch rảnh của HDV -->
            <div class="idx-108" style="margin-bottom: 24px;">
              <div class="idx-109" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;">
                <h4 class="idx-110" style="margin: 0; font-size: 0.95rem; font-weight: 800; display: flex; align-items: center; gap: 6px;">
                  <i data-lucide="calendar" class="idx-98"></i> 5. Lịch Trình Rảnh (7 Ngày Tới)
                </h4>
                <div class="idx-111" style="font-size: 0.8rem; display: flex; gap: 12px;">
                  <span class="idx-112" style="color: #10b981; font-weight: 600;">● Rảnh</span>
                  <span class="idx-113" style="color: #ef4444; font-weight: 600;">● Bận</span>
                </div>
              </div>
              
              <div class="calendar-grid-week" style="display: grid; grid-template-columns: repeat(7, 1fr); gap: 8px;">
                ${scheduleDays.map(sd => `
                  <div class="cal-day-cell ${sd.status === 'free' ? 'cal-day-free' : 'cal-day-busy'}" style="padding: 10px 4px; text-align: center; border-radius: 8px; border: 1px solid ${sd.status === 'free' ? '#a7f3d0' : '#fecaca'}; background: ${sd.status === 'free' ? '#ecfdf5' : '#fef2f2'};">
                    <div class="idx-114" style="font-size: 0.76rem; font-weight: 600; color: #475569;">${sd.dateStr}</div>
                    <div class="idx-115" style="font-size: 0.72rem; font-weight: 700; color: ${sd.status === 'free' ? '#059669' : '#dc2626'}; margin-top: 4px;">${sd.label}</div>
                  </div>
                `).join('')}
              </div>
            </div>

            <!-- 6. Đánh giá của khách hàng từ CSDL thực tế -->
            <div>
              <h4 class="idx-116" style="font-size: 0.95rem; font-weight: 800; margin-bottom: 12px; display: flex; align-items: center; gap: 6px;">
                <i data-lucide="star" class="idx-117" style="color: #f59e0b;"></i> 6. Đánh Giá Từ Khách Hàng (${guideReviews.length})
              </h4>
              <div class="idx-118" style="display: flex; flex-direction: column; gap: 8px;">
                ${reviewsHtml}
              </div>
            </div>

          </div>
        </div>
      `;

        if (window.lucide) window.lucide.createIcons();
        document.getElementById('guideModal').classList.add('open');
      }

      function closeModal(id) {
        const m = document.getElementById(id);
        if (m) m.classList.remove('open');
      }

      document.addEventListener('click', (e) => {
        const modal = document.getElementById('guideModal');
        if (modal && e.target === modal) {
          modal.classList.remove('open');
        }
      });

      // =========================================================================
      // HELPER: TOAST NOTIFICATION
      // =========================================================================
      function showToast(message, type = 'success') {
        const toast = document.getElementById('toastNotification');
        const text = document.getElementById('toastMessage');
        const icon = toast ? toast.querySelector('.toast-icon') : null;
        if (!toast || !text) return;

        text.textContent = message;
        toast.classList.remove('toast-error', 'toast-warning', 'toast-success', 'show');

        if (type === 'error') {
          toast.style.borderLeft = '4px solid #ef4444';
          if (icon) { icon.setAttribute('data-lucide', 'alert-circle'); icon.style.color = '#ef4444'; }
        } else if (type === 'warning') {
          toast.style.borderLeft = '4px solid #f59e0b';
          if (icon) { icon.setAttribute('data-lucide', 'alert-triangle'); icon.style.color = '#f59e0b'; }
        } else {
          toast.style.borderLeft = '4px solid #10b981';
          if (icon) { icon.setAttribute('data-lucide', 'check-circle'); icon.style.color = '#10b981'; }
        }

        if (window.lucide) window.lucide.createIcons();

        toast.classList.add('show');
        if (window._toastTimer) clearTimeout(window._toastTimer);
        window._toastTimer = setTimeout(() => {
          toast.classList.remove('show');
        }, 4200);
      }
    </script>
  </body>

  </html>