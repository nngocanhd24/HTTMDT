<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
  <!DOCTYPE html>
  <html lang="vi">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Guidia Admin Command Center | Trung Tâm Điều Hành Nền Tảng</title>

    <!-- Google Fonts & Lucide Icons -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
      href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Cormorant+Garamond:wght@600;700&display=swap"
      rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>

    <link rel="stylesheet" href="css/style.css">
  </head>

  <body class="portal-body">

    <!-- Sidebar -->
    <aside class="portal-sidebar">
      <a href="admin.jsp" class="sidebar-brand adm-1" title="Về Trang Quản Trị Guidia">
        <div class="logo-icon adm-2">
          <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none"
            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="10" />
            <polygon points="16.24 7.76 14.12 14.12 7.76 16.24 9.88 9.88 16.24 7.76" />
          </svg>
        </div>
        <div class="logo-text">
          <span class="logo-title adm-3">Guidia</span>
        </div>
        <span class="portal-badge admin-portal-badge">Quản Trị Viên</span>
      </a>

      <nav class="sidebar-nav">
        <!-- 1. Báo cáo thống kê toàn hệ thống -->
        <a href="#dashboard" class="nav-link-item active" data-tab="tab-admin-dashboard">
          <i data-lucide="bar-chart-3"></i>
          <span>Báo Cáo Thống Kê</span>
        </a>

        <!-- 2. Quản lý tài khoản (Đã tích hợp Thẩm định thẻ HDV) -->
        <a href="#users" class="nav-link-item" data-tab="tab-admin-users">
          <i data-lucide="users"></i>
          <span>Quản Lý Tài Khoản</span>
          <span class="tab-badge-pill adm-8" id="badgePendingCerts">0</span>
        </a>

        <!-- 3. Giải quyết khiếu nại -->
        <a href="#disputes" class="nav-link-item" data-tab="tab-admin-disputes">
          <i data-lucide="scale"></i>
          <span>Xử Lý Khiếu Nại</span>
          <span class="tab-badge-pill adm-8" id="badgePendingDisputes">0</span>
        </a>
      </nav>

      <div class="sidebar-footer">
        <div class="user-mini-card">
          <div class="adm-9">AD</div>
          <div class="user-mini-info">
            <div class="u-name" id="adminSidebarName">Nguyễn Quản Trị</div>
            <div class="u-role">Super Administrator</div>
          </div>
        </div>
        <!-- Nút Đăng Xuất chuyển về thanh dọc bên trái -->
        <button type="button" onclick="handleAdminLogout()" class="sidebar-logout-btn" title="Đăng Xuất Khỏi Hệ Thống">
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
        <div class="topbar-left adm-10">
          <button type="button"
            onclick="if (window.history.length > 1) { window.history.back(); } else { window.location.href = 'admin.jsp'; }"
            class="btn-portal-back" title="Quay lại">
            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none"
              stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
              <path d="m12 19-7-7 7-7" />
              <path d="M19 12H5" />
            </svg>
          </button>

          <!-- Logo Guidia đồng bộ -->
          <a href="admin.jsp" class="brand-logo portal-header-brand" title="Guidia - Private Local Guides Vietnam">
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
            <h1 id="adminPageTitle">Báo Cáo Thống Kê Toàn Hệ Thống</h1>
          </div>
        </div>
        <div class="topbar-right">
          <div class="adm-11">
            <div class="adm-12">
              <div class="adm-13" id="adminAvatarInitials">AD</div>
              <div class="adm-14">
                <div class="adm-15" id="adminHeaderName">Nguyễn Quản Trị</div>
                <div class="adm-16" id="adminHeaderEmail">admin@guidia.vn</div>
              </div>
            </div>
          </div>
        </div>
      </header>

      <div class="portal-content">

        <!-- ========================================================================= -->
        <!-- TAB 1: BÁO CÁO THỐNG KÊ TOÀN HỆ THỐNG -->
        <!-- ========================================================================= -->
        <section class="tab-content-panel active" id="tab-admin-dashboard">
          <!-- Bộ lọc thời gian (Tháng, Năm) và khu vực -->
          <div class="filter-toolbar adm-18">
            <div class="adm-19">
              <div>
                <label class="adm-20">Năm</label>
                <select id="reportYearFilter" class="form-control adm-21" onchange="handleGenerateReport()">
                  <option value="all">Tất Cả Năm</option>
                  <option value="2025">Năm 2025</option>
                  <option value="2026" selected>Năm 2026</option>
                  <option value="2027">Năm 2027</option>
                </select>
              </div>

              <div>
                <label class="adm-20">Tháng</label>
                <select id="reportMonthFilter" class="form-control adm-22" onchange="handleGenerateReport()">
                  <option value="all" selected>Tất Cả Các Tháng</option>
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

              <div>
                <label class="adm-20">Khu Vực Tuyến Điểm</label>
                <select id="reportRegionFilter" class="form-control adm-23" onchange="handleGenerateReport()">
                  <option value="all">Toàn Quốc</option>
                  <option value="north">Miền Bắc</option>
                  <option value="central">Miền Trung</option>
                  <option value="south">Miền Nam</option>
                </select>
              </div>
            </div>

            <div class="adm-24">
              <button class="btn-primary adm-25" onclick="handleGenerateReport()">
                <i data-lucide="filter"></i> Lọc Thống Kê
              </button>
              <button class="btn-outline adm-26" onclick="resetReportFilters()">
                <i data-lucide="rotate-ccw"></i> Đặt Lại
              </button>
            </div>
          </div>

          <!-- HÀNG THẺ THỐNG KÊ TỔNG QUAN HỆ THỐNG (Người dùng, Chuyến đi, Chuyến hủy, Khiếu nại, Doanh thu sàn) -->
          <div class="stats-row adm-28">
            <!-- 1. Số Người Dùng -->
            <div class="stat-card adm-29" onclick="switchAdminTab('tab-admin-users')"
              title="Bấm để xem chi tiết danh sách tài khoản">
              <div class="stat-info">
                <div class="stat-lbl">Số Người Dùng</div>
                <div class="stat-val adm-30" id="statUsersCount">46</div>
                <span class="stat-sub adm-31" id="statUsersSub">30 Khách • 15 HDV</span>
              </div>
              <div class="stat-icon-wrap adm-32">
                <i data-lucide="users"></i>
              </div>
            </div>

            <!-- 2. Số Chuyến Đi -->
            <div class="stat-card">
              <div class="stat-info">
                <div class="stat-lbl">Số Chuyến Đi</div>
                <div class="stat-val adm-30" id="statTripsCount">88</div>
                <span class="stat-sub adm-33" id="statTripsSub">GMV: 185.900.000₫</span>
              </div>
              <div class="stat-icon-wrap adm-34">
                <i data-lucide="compass"></i>
              </div>
            </div>

            <!-- 3. Số Chuyến Hủy -->
            <div class="stat-card">
              <div class="stat-info">
                <div class="stat-lbl">Số Chuyến Hủy</div>
                <div class="stat-val adm-35" id="statCancelledCount">15</div>
                <span class="stat-sub adm-35" id="statCancelledSub">Hoàn tiền cho khách</span>
              </div>
              <div class="stat-icon-wrap icon-rose">
                <i data-lucide="calendar-x"></i>
              </div>
            </div>

            <!-- 4. Số Khiếu Nại -->
            <div class="stat-card adm-29" onclick="switchAdminTab('tab-admin-disputes')"
              title="Bấm để mở trung tâm xử lý khiếu nại">
              <div class="stat-info">
                <div class="stat-lbl">Khiếu Nại Sự Cố</div>
                <div class="stat-val adm-36" id="statDisputesCount">15</div>
                <span class="stat-sub adm-37" id="statDisputesSub">Hồ sơ tranh chấp</span>
              </div>
              <div class="stat-icon-wrap icon-amber">
                <i data-lucide="alert-triangle"></i>
              </div>
            </div>

            <!-- 5. Doanh Thu Phí Sàn (10%) -->
            <div class="stat-card">
              <div class="stat-info">
                <div class="stat-lbl">Doanh Thu Phí Sàn (10%)</div>
                <div class="stat-val adm-38" id="statPlatformFee">18.590.000₫</div>
                <span class="stat-sub adm-33" id="statPlatformFeeSub">Thực nhận hoa hồng sàn</span>
              </div>
              <div class="stat-icon-wrap adm-39">
                <i data-lucide="piggy-bank"></i>
              </div>
            </div>
          </div>

          <!-- Thông báo rỗng khi không có dữ liệu -->
          <div id="reportEmptyAlert" class="adm-40">
            <div class="adm-41">
              <i data-lucide="info" class="adm-36"></i>
              <span id="reportEmptyMessage">Không có dữ liệu doanh thu phí sàn nào trong khoảng thời gian đã
                chọn.</span>
            </div>
          </div>

          <!-- BIỂU ĐỒ TRỰC QUAN DOANH THU PHÍ SÀN THEO THÁNG & NĂM -->
          <div class="card-table-wrapper adm-42">
            <div class="adm-43">
              <div>
                <h3 class="adm-44">
                  <i data-lucide="bar-chart-2" class="adm-45"></i>
                  Biểu Đồ Doanh Thu Phí Sàn (10% GMV) Theo Tháng & Năm
                </h3>
                <p class="adm-46" id="chartSubtitleText">
                  Thống kê doanh thu nền tảng theo 12 tháng trong năm. Nhấp vào cột tháng để lọc chi tiết.
                </p>
              </div>
              <div class="adm-47">
                <div class="adm-48">
                  <i data-lucide="piggy-bank"></i>
                </div>
                <div class="adm-14">
                  <span class="adm-49" id="chartTotalFeeLabel">Doanh Thu Phí Sàn (10%)</span>
                  <div class="adm-50" id="chartTotalFeeText">0₫</div>
                </div>
              </div>
            </div>

            <!-- Vùng render Biểu Đồ Cột Theo Tháng -->
            <div id="revenueChartContainer" class="adm-51">
              <!-- Render dynamic monthly chart bars -->
            </div>

            <!-- Chú thích biểu đồ -->
            <div class="adm-52">
              <div class="adm-53">
                💡 Mẹo: Bấm trực tiếp vào cột của bất kỳ tháng nào để xem danh sách chuyến đi chi tiết của tháng đó.
              </div>
              <div class="adm-54">
                <span class="adm-55"><span class="adm-56"></span> Tháng Có Doanh Thu</span>
                <span class="adm-55"><span class="adm-57"></span> Tháng Đang Chọn</span>
                <span class="adm-55"><span class="adm-58"></span> Chưa Có Doanh Thu</span>
              </div>
            </div>
          </div>

          <!-- BẢNG DANH SÁCH CÁC KHOẢN DOANH THU PHÍ SÀN NHẬN ĐƯỢC -->
          <div class="card-table-wrapper">
            <div class="card-table-header">
              <div>
                <h3>Danh Sách Các Khoản Doanh Thu Phí Sàn Nhận Được</h3>
                <p class="adm-59">
                  Chi tiết các khoản phí dịch vụ 10% nền tảng thu nhận từ các đơn tour theo khoảng thời gian và khu vực
                  đã chọn.
                </p>
              </div>
            </div>
            <table class="custom-table">
              <thead>
                <tr>
                  <th>Mã Đơn</th>
                  <th>Điểm Đến & Tuyến Điểm</th>
                  <th>Ngày Đi</th>
                  <th>Doanh Số Tour (GMV)</th>
                  <th>Tỷ Lệ</th>
                  <th>Phí Sàn Admin Nhận</th>
                  <th>Hướng Dẫn Viên</th>
                  <th>Du Khách</th>
                  <th>Trạng Thái</th>
                </tr>
              </thead>
              <tbody id="admRecentTripsBody">
                <!-- Render dynamically -->
              </tbody>
            </table>
          </div>
        </section>

        <!-- ========================================================================= -->
        <!-- TAB 2: QUẢN LÝ TÀI KHOẢN (TÍCH HỢP THẨM ĐỊNH THẺ HDV) -->
        <!-- ========================================================================= -->
        <section class="tab-content-panel" id="tab-admin-users">
          <div class="card-table-wrapper">
            <div class="card-table-header">
              <div>
                <h3>Danh Sách Tài Khoản & Thẩm Định Thẻ Hướng Dẫn Viên</h3>
                <p class="adm-60">
                  Thông tin tài khoản đã bao gồm thẻ hành nghề HDV từ lúc đăng ký hoặc cập nhật. Trạng thái thẻ:
                  <strong>Chờ duyệt</strong> và <strong>Đã duyệt</strong>.
                </p>
              </div>
              <!-- Bộ lọc người dùng & thẻ HDV -->
              <div class="adm-61">
                <select id="userRoleFilter" class="form-control adm-62" onchange="renderAdminUsers()">
                  <option value="all">Tất Cả Vai Trò</option>
                  <option value="guide">Hướng Dẫn Viên</option>
                  <option value="customer">Khách Du Lịch</option>
                </select>
                <select id="userStatusFilter" class="form-control adm-62" onchange="renderAdminUsers()">
                  <option value="all">Tất Cả Trạng Thái</option>
                  <option value="active">Đang Hoạt Động</option>
                  <option value="pending_approval">Chờ Duyệt Hồ Sơ</option>
                  <option value="suspended">Đang Bị Khóa</option>
                </select>
                <select id="userCertFilter" class="form-control adm-63" onchange="renderAdminUsers()">
                  <option value="all">Tất Cả Thẻ HDV</option>
                  <option value="pending">Chờ Duyệt</option>
                  <option value="approved">Đã Duyệt</option>
                </select>
                <input type="text" id="userSearchInput" class="form-control adm-64" placeholder="Tìm tên, SĐT, Email..."
                  oninput="renderAdminUsers()">
              </div>
            </div>

            <table class="custom-table">
              <thead>
                <tr>
                  <th>Hồ Sơ Thành Viên</th>
                  <th>Vai Trò</th>
                  <th>Liên Hệ (SĐT / Email)</th>
                  <th>Tình Trạng Thẻ Hành Nghề</th>
                  <th>Số Lần Hủy / Vi Phạm</th>
                  <th>Trạng Thái</th>
                  <th>Chi Tiết & Thao Tác</th>
                </tr>
              </thead>
              <tbody id="admUsersTableBody">
                <!-- Render dynamically -->
              </tbody>
            </table>
          </div>
        </section>

        <!-- ========================================================================= -->
        <!-- TAB 3: TRUNG TÂM GIẢI QUYẾT KHIẾU NẠI -->
        <!-- ========================================================================= -->
        <section class="tab-content-panel" id="tab-admin-disputes">
          <div class="card-table-wrapper">
            <div class="card-table-header">
              <div>
                <h3>Trung Tâm Xử Lý Khiếu Nại & Tranh Chấp Tour</h3>
                <p class="adm-60">
                  Danh sách các vụ việc khiếu nại giữa du khách và hướng dẫn viên. Nhấn vào đơn để xem chi tiết nội dung
                  và thực hiện phê duyệt, không duyệt hoặc yêu cầu bổ sung.
                </p>
              </div>
            </div>
            <table class="custom-table">
              <thead>
                <tr>
                  <th>Mã Khiếu Nại</th>
                  <th>Bên Khiếu Nại</th>
                  <th>Bên Bị Khiếu Nại</th>
                  <th>Thời Gian Gửi</th>
                  <th>Số Tiền Tranh Chấp</th>
                  <th>Trạng Thái Xử Lý</th>
                  <th>Chi Tiết & Thao Tác</th>
                </tr>
              </thead>
              <tbody id="admDisputesTableBody">
                <!-- Render dynamically -->
              </tbody>
            </table>
          </div>
        </section>

      </div>
    </main>

    <!-- ========================================================================= -->
    <!-- MODAL 1: CHI TIẾT TÀI KHOẢN, HỒ SƠ & THẺ HDV -->
    <!-- ========================================================================= -->
    <div id="adminUserDetailModal" class="adm-71">
      <div class="adm-72">

        <!-- Header -->
        <div class="adm-73">
          <div class="adm-10">
            <div class="adm-74">
              <i data-lucide="user-check"></i>
            </div>
            <div>
              <h3 class="adm-75" id="modalUserTitle">Hồ Sơ Chi Tiết Tài Khoản</h3>
              <span class="adm-76" id="modalUserSubtitle">ID: ...</span>
            </div>
          </div>
          <button onclick="closeAdminUserDetailModal()" class="btn-outline adm-77">
            ✕
          </button>
        </div>

        <!-- Body Content -->
        <div class="adm-78" id="modalUserContent">
          <!-- Dynamic Profile Content -->
        </div>

        <!-- Action Footer Toolbar -->
        <div class="adm-79" id="modalUserActions">
          <!-- Dynamic Action Buttons -->
        </div>
      </div>
    </div>

    <!-- ========================================================================= -->
    <!-- MODAL 2: KHÓA TÀI KHOẢN (CẢNH BÁO CHUYẾN ĐI CHƯA HOÀN THÀNH) -->
    <!-- ========================================================================= -->
    <div id="banUserModal" class="adm-80">
      <div class="adm-81">
        <h3 class="adm-82">
          <i data-lucide="slash"></i> Khóa Tài Khoản Người Dùng
        </h3>
        <p class="adm-83">
          Nhập lý do kỷ luật khóa tài khoản. Hệ thống sẽ kiểm tra và cảnh báo nếu người dùng đang có chuyến đi chưa hoàn
          thành.
        </p>
        <input type="hidden" id="banUserId">
        <div id="banActiveTripsWarning" class="adm-84">
          <!-- Dynamic warning -->
        </div>
        <div class="form-group">
          <label class="form-label">Lý do khóa tài khoản <span class="adm-35">*</span></label>
          <textarea id="banReasonText" class="form-control" rows="3"
            placeholder="Nhập lý do khóa (VD: Vi phạm quy định an toàn, hủy tour quá số lần cho phép...)"></textarea>
        </div>
        <div class="adm-85">
          <button class="btn-outline" onclick="closeBanUserModal()">Hủy Bỏ</button>
          <button class="btn-primary adm-86" onclick="confirmBanUser()">
            Khóa Tài Khoản Ngay
          </button>
        </div>
      </div>
    </div>

    <!-- ========================================================================= -->
    <!-- MODAL 3: XEM CHI TIẾT NỘI DUNG KHIẾU NẠI & CÁC THAO TÁC XỬ LÝ -->
    <!-- ========================================================================= -->
    <div id="disputeDetailModal" class="adm-71">
      <div class="adm-87">
        <!-- Header -->
        <div class="adm-73">
          <div class="adm-12">
            <div class="adm-88">
              <i data-lucide="scale"></i>
            </div>
            <div>
              <h3 class="adm-75" id="disputeDetailModalTitle">Chi Tiết Đơn Khiếu Nại</h3>
              <span class="adm-76" id="disputeDetailModalSubtitle">Mã đơn: ...</span>
            </div>
          </div>
          <button onclick="closeDisputeDetailModal()" class="btn-outline adm-77">
            ✕
          </button>
        </div>

        <!-- Body Content (Từng nội dung xuống dòng riêng biệt cực kỳ thoáng) -->
        <div class="adm-89" id="disputeDetailModalContent">
          <!-- Dynamic Render Content -->
        </div>

        <!-- Action Footer Toolbar (Duyệt, Không duyệt, Yêu cầu bổ sung) -->
        <div class="adm-79" id="disputeDetailModalActions">
          <!-- Dynamic Action Buttons -->
        </div>
      </div>
    </div>

    <!-- ========================================================================= -->
    <!-- MODAL 4: PHÁN QUYẾT KHIẾU NẠI (NHẬP LÝ DO DUYỆT / KHÔNG DUYỆT / YÊU CẦU BỔ SUNG) -->
    <!-- ========================================================================= -->
    <div id="disputeDecisionModal" class="adm-90">
      <div class="adm-81">
        <h3 class="adm-91" id="modalDisputeTitle">
          Phán Quyết Khiếu Nại
        </h3>
        <p class="adm-83">
          Nhập lý do và căn cứ cho quyết định xử lý để ghi nhận vào hồ sơ và thông báo chính thức đến các bên liên quan.
        </p>
        <input type="hidden" id="modalDisputeId">
        <input type="hidden" id="modalDisputeDecisionType">
        <div class="form-group">
          <label class="form-label">Lý do và căn cứ của Quản trị viên <span class="adm-35">*</span></label>
          <textarea id="modalDisputeReasonText" class="form-control" rows="3"
            placeholder="Nhập căn cứ xử lý dựa trên hợp đồng lộ trình, bằng chứng hình ảnh hoặc trao đổi..."></textarea>
        </div>
        <div class="adm-85">
          <button class="btn-outline" onclick="closeDisputeDecisionModal()">Hủy Bỏ</button>
          <button class="btn-primary" id="btnConfirmDispute" onclick="confirmDisputeDecision()">
            Ban Hành Quyết Định
          </button>
        </div>
      </div>
    </div>

    <!-- Toast Notification -->
    <div class="toast-notification" id="toastNotification">
      <i data-lucide="check-circle" class="toast-icon"></i>
      <span id="toastMessage">Thông báo</span>
    </div>

    <!-- Scripts -->
    <script src="js/store.js?v=<%= System.currentTimeMillis() %>"></script>
    <script>
      /**
       * GUIDIA - Admin Command Center Controller Logic
       * Chuyên biệt cho Quản Trị Viên Sàn Du Lịch Việt Nam
       */

      document.addEventListener('DOMContentLoaded', async () => {
        // Đồng bộ thông tin Quản trị viên đang đăng nhập
        const curUserStr = sessionStorage.getItem('guidia_current_user') || localStorage.getItem('guidia_current_user');
        if (curUserStr) {
          try {
            const u = JSON.parse(curUserStr);
            if (u.name) {
              const hName = document.getElementById('adminHeaderName');
              const sName = document.getElementById('adminSidebarName');
              if (hName) hName.textContent = u.name;
              if (sName) sName.textContent = u.name;
            }
            if (u.email) {
              const hEmail = document.getElementById('adminHeaderEmail');
              if (hEmail) hEmail.textContent = u.email;
            }
          } catch (e) { }
        }

        // Khởi tạo tab và hiển thị dữ liệu ngay lập tức
        setupAdminTabs();
        renderAllAdminPanels();

        // Tự động kéo dữ liệu thực tế từ SQL Server (QL_Du_Lich)
        if (window.guidiaStore && window.guidiaStore.syncWithDatabase) {
          try {
            await window.guidiaStore.syncWithDatabase();
            renderAllAdminPanels();
          } catch (err) {
            console.warn('Lỗi đồng bộ dữ liệu SQL Server:', err);
          }
        }

        if (window.lucide) {
          window.lucide.createIcons();
        }
      });

      // Thiết lập chuyển Tab Admin
      function setupAdminTabs() {
        const navLinks = document.querySelectorAll('.sidebar-nav .nav-link-item');
        const panels = document.querySelectorAll('.tab-content-panel');
        const titleEl = document.getElementById('adminPageTitle');

        const titles = {
          'tab-admin-dashboard': 'Báo Cáo Thống Kê Toàn Hệ Thống',
          'tab-admin-users': 'Quản Lý Tài Khoản & Thẩm Định Thẻ Hướng Dẫn Viên',
          'tab-admin-disputes': 'Trung Tâm Xử Lý Khiếu Nại & Tranh Chấp',
        };

        const hashToTab = {
          '#dashboard': 'tab-admin-dashboard',
          '#tab-admin-dashboard': 'tab-admin-dashboard',
          '#users': 'tab-admin-users',
          '#tab-admin-users': 'tab-admin-users',
          '#disputes': 'tab-admin-disputes',
          '#tab-admin-disputes': 'tab-admin-disputes'
        };

        const tabToHash = {
          'tab-admin-dashboard': '#dashboard',
          'tab-admin-users': '#users',
          'tab-admin-disputes': '#disputes'
        };

        function activateAdminTab(targetId, updateHash = true) {
          if (!targetId) targetId = 'tab-admin-dashboard';

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

          if (titleEl && titles[targetId]) {
            titleEl.textContent = titles[targetId];
          }

          if (updateHash && tabToHash[targetId] && window.location.hash !== tabToHash[targetId]) {
            try {
              history.pushState(null, '', tabToHash[targetId]);
            } catch (e) {
              window.location.hash = tabToHash[targetId];
            }
          }

          try {
            if (targetId === 'tab-admin-dashboard') handleGenerateReport();
            if (targetId === 'tab-admin-users') renderAdminUsers();
            if (targetId === 'tab-admin-disputes') renderAdminDisputes();
          } catch (err) {
            console.error('Lỗi khi render tab admin ' + targetId, err);
          }

          if (window.lucide) window.lucide.createIcons();
        }

        window.activateAdminTab = activateAdminTab;

        navLinks.forEach(link => {
          link.addEventListener('click', (e) => {
            e.preventDefault();
            const targetId = link.getAttribute('data-tab');
            activateAdminTab(targetId, true);
          });
        });

        // Lắng nghe sự kiện đổi URL hash (back/forward)
        window.addEventListener('hashchange', () => {
          const hash = window.location.hash;
          if (hash && hashToTab[hash]) {
            activateAdminTab(hashToTab[hash], false);
          }
        });

        // Tự động kích hoạt tab dựa trên hash URL (ví dụ #disputes, #users, #dashboard)
        const initialHash = window.location.hash;
        if (initialHash && hashToTab[initialHash]) {
          activateAdminTab(hashToTab[initialHash], false);
        }
      }

      function switchAdminTab(targetTabId) {
        if (window.activateAdminTab) {
          window.activateAdminTab(targetTabId, true);
        } else {
          const navLink = document.querySelector(`.sidebar-nav .nav-link-item[data-tab="${targetTabId}"]`);
          if (navLink) {
            navLink.click();
          }
        }
      }

      function renderAllAdminPanels() {
        handleGenerateReport();
        renderAdminUsers();
        renderAdminDisputes();
        updateAdminBadges();
      }

      function updateAdminBadges() {
        const store = window.guidiaStore;
        const certs = store.getCertificates().filter(c => c.status === 'pending');
        const disputes = store.getDisputes().filter(d => d.status === 'pending');

        const bCerts = document.getElementById('badgePendingCerts');
        if (bCerts) {
          bCerts.textContent = certs.length;
          bCerts.style.display = certs.length > 0 ? 'inline-block' : 'none';
        }

        const bDisputes = document.getElementById('badgePendingDisputes');
        if (bDisputes) {
          bDisputes.textContent = disputes.length;
          bDisputes.style.display = disputes.length > 0 ? 'inline-block' : 'none';
        }
      }

      // =========================================================================
      // 1. BÁO CÁO DOANH THU SÀN (LỌC THEO THÁNG & NĂM)
      // =========================================================================
      function resetReportFilters() {
        const yearInput = document.getElementById('reportYearFilter');
        const monthInput = document.getElementById('reportMonthFilter');
        const regionInput = document.getElementById('reportRegionFilter');
        if (yearInput) yearInput.value = '2026';
        if (monthInput) monthInput.value = 'all';
        if (regionInput) regionInput.value = 'all';
        handleGenerateReport();
        showToast('Đã đặt lại bộ lọc: Năm 2026, Tất cả các tháng', 'info');
      }

      function selectReportMonth(m) {
        const monthInput = document.getElementById('reportMonthFilter');
        if (monthInput) {
          monthInput.value = String(m);
          handleGenerateReport();
        }
      }

      function handleGenerateReport() {
        const store = window.guidiaStore;
        const year = document.getElementById('reportYearFilter') ? document.getElementById('reportYearFilter').value : '2026';
        const month = document.getElementById('reportMonthFilter') ? document.getElementById('reportMonthFilter').value : 'all';
        const region = document.getElementById('reportRegionFilter') ? document.getElementById('reportRegionFilter').value : 'all';

        const emptyAlert = document.getElementById('reportEmptyAlert');
        if (emptyAlert) emptyAlert.style.display = 'none';

        const report = store.getAdminReportSummary({
          month,
          year,
          region
        });

        const trips = report.trips || [];

        // 0. Cập nhật các chỉ số thẻ thống kê tổng quan (Người dùng, Chuyến đi, Hủy chuyến, Khiếu nại, Phí sàn)
        const statUsers = document.getElementById('statUsersCount');
        const statUsersSub = document.getElementById('statUsersSub');
        if (statUsers) statUsers.textContent = report.totalUsers || 46;
        if (statUsersSub) statUsersSub.textContent = `${report.customersCount || 30} Khách • ${report.guidesCount || 15} HDV`;

        const statTrips = document.getElementById('statTripsCount');
        const statTripsSub = document.getElementById('statTripsSub');
        if (statTrips) statTrips.textContent = trips.length;
        if (statTripsSub) statTripsSub.textContent = `GMV: ${(report.totalGMV || 0).toLocaleString('vi-VN')}₫`;

        const statCancelled = document.getElementById('statCancelledCount');
        const statCancelledSub = document.getElementById('statCancelledSub');
        if (statCancelled) statCancelled.textContent = report.cancelledTrips || 0;
        if (statCancelledSub) {
          const cancelRate = trips.length > 0 ? (((report.cancelledTrips || 0) / trips.length) * 100).toFixed(1) : 0;
          statCancelledSub.textContent = `Tỷ lệ hủy: ${cancelRate}%`;
        }

        const statDisputes = document.getElementById('statDisputesCount');
        const statDisputesSub = document.getElementById('statDisputesSub');
        if (statDisputes) statDisputes.textContent = report.disputesCount || 0;
        if (statDisputesSub) statDisputesSub.textContent = `${report.disputesCount || 0} hồ sơ tranh chấp`;

        const statFee = document.getElementById('statPlatformFee');
        const statFeeSub = document.getElementById('statPlatformFeeSub');
        if (statFee) statFee.textContent = (report.totalPlatformFee || 0).toLocaleString('vi-VN') + '₫';
        if (statFeeSub) statFeeSub.textContent = `Thực nhận hoa hồng sàn`;

        // Thông báo khi không có dữ liệu
        if (report.emptyData || trips.length === 0) {
          if (emptyAlert) {
            emptyAlert.style.display = 'flex';
            const msgEl = document.getElementById('reportEmptyMessage');
            if (msgEl) {
              const mStr = month === 'all' ? 'các tháng' : `Tháng ${month}`;
              const yStr = year === 'all' ? 'tất cả năm' : `năm ${year}`;
              msgEl.textContent = `Không có dữ liệu chuyến đi hoặc doanh thu nào trong ${mStr} ${yStr} (${region === 'all' ? 'Toàn Quốc' : region}).`;
            }
          }
        }

        // 1. Vẽ biểu đồ trực quan doanh thu phí sàn theo Tháng & Năm
        renderRevenueChart(report, month, year);

        // 2. Bảng danh sách các khoản doanh thu phí sàn nhận được
        const tbody = document.getElementById('admRecentTripsBody');
        if (tbody) {
          if (trips.length === 0) {
            tbody.innerHTML = `<tr><td colspan="9" class="adm-92">Không có khoản doanh thu phí sàn nào trong khoảng thời gian Tháng / Năm đã chọn.</td></tr>`;
          } else {
            tbody.innerHTML = trips.map(trip => {
              const fee = trip.platformFee || Math.round((trip.totalAmount || 0) * 0.1);
              return `
          <tr>
            <td><strong>${trip.id}</strong></td>
            <td><i data-lucide="map-pin" class="icon-xs adm-45"></i> ${trip.location}</td>
            <td><span class="adm-93">${trip.startTime ? trip.startTime + ' ' : ''}${trip.startDate} &rarr; ${trip.endTime ? trip.endTime + ' ' : ''}${trip.endDate || trip.startDate}</span></td>
            <td><strong>${(trip.totalAmount || 0).toLocaleString('vi-VN')}₫</strong></td>
            <td><span class="badge-tag-status adm-94">10%</span></td>
            <td><strong class="adm-95">+${fee.toLocaleString('vi-VN')}₫</strong></td>
            <td><strong>${trip.guideName}</strong></td>
            <td>${trip.customerName}</td>
            <td>${getFourTripStatusBadge(trip.status, trip.paymentStatus)}</td>
          </tr>
        `;
            }).join('');
          }
        }

        if (window.lucide) window.lucide.createIcons();
      }

      /**
       * Vẽ Biểu Đồ Cột Trực Quan Cho Doanh Thu Phí Sàn (10% GMV) THEO THÁNG & NĂM
       * Hiển thị 12 cột tháng của năm được chọn, tự động tính tổng và highlight tháng active
       */
      function renderRevenueChart(report, selectedMonth, selectedYear) {
        const container = document.getElementById('revenueChartContainer');
        const totalFeeText = document.getElementById('chartTotalFeeText');
        const totalFeeLabel = document.getElementById('chartTotalFeeLabel');
        const subtitleEl = document.getElementById('chartSubtitleText');
        if (!container) return;

        let monthlyStats = (report && report.monthlyStats && report.monthlyStats.length > 0) ? report.monthlyStats : [];
        if (monthlyStats.length === 0) {
          monthlyStats = [];
          for (let m = 1; m <= 12; m++) {
            monthlyStats.push({
              month: m,
              monthLabel: `Tháng ${m}`,
              totalGMV: 0,
              platformFee: 0,
              tripsCount: 0
            });
          }
          const allTrips = (report && report.trips && report.trips.length > 0) ? report.trips : (window.guidiaStore ? window.guidiaStore.getTrips() : []);
          allTrips.forEach(t => {
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
        }

        // Tính tổng phí sàn thực thu theo bộ lọc
        const totalFee = report.totalPlatformFee || 0;
        if (totalFeeText) totalFeeText.textContent = totalFee.toLocaleString('vi-VN') + '₫';

        if (totalFeeLabel) {
          if (selectedMonth !== 'all') {
            totalFeeLabel.textContent = `Doanh Thu Phí Sàn Tháng ${selectedMonth}/${selectedYear === 'all' ? 'Toàn Bộ' : selectedYear}`;
          } else {
            totalFeeLabel.textContent = `Tổng Phí Sàn ${selectedYear === 'all' ? 'Tất Cả Năm' : 'Năm ' + selectedYear}`;
          }
        }

        if (subtitleEl) {
          if (selectedMonth !== 'all') {
            subtitleEl.innerHTML = `Đang xem chi tiết <strong>Tháng ${selectedMonth}</strong> năm <strong>${selectedYear === 'all' ? 'Toàn Bộ' : selectedYear}</strong>: ${totalFee.toLocaleString('vi-VN')}₫ (${report.totalTrips || 0} tour). Nhấp vào cột tháng khác để chuyển nhanh.`;
          } else {
            subtitleEl.innerHTML = `Thống kê doanh thu nền tảng theo 12 tháng năm <strong>${selectedYear === 'all' ? 'Toàn Bộ' : selectedYear}</strong>: ${totalFee.toLocaleString('vi-VN')}₫ (${report.totalTrips || 0} tour). Nhấp vào cột tháng bất kỳ để lọc chi tiết.`;
          }
        }

        // Tìm mức phí lớn nhất trong 12 tháng để làm mốc tỷ lệ 100%
        const maxFee = Math.max(...monthlyStats.map(m => m.platformFee), 1000000);

        const barsHtml = monthlyStats.map(m => {
          const fee = m.platformFee || 0;
          const gmv = m.totalGMV || 0;
          const isSelected = (selectedMonth !== 'all' && String(selectedMonth) === String(m.month));
          const hasData = fee > 0;

          let heightPercent = 4;
          if (hasData) {
            heightPercent = Math.max(16, Math.min(100, Math.round((fee / maxFee) * 100)));
          }

          let barColor = 'linear-gradient(180deg, #10b981 0%, #059669 100%)';
          if (isSelected) {
            barColor = 'linear-gradient(180deg, #059669 0%, #047857 100%)';
          } else if (!hasData) {
            barColor = '#e2e8f0';
          }

          const shortFeeText = fee > 0 ? `+${(fee / 1000000).toFixed(1)}M` : '0₫';

          return `
      <div class="m-bar-col ${isSelected ? 'active-selected' : ''} adm-96" 
           onclick="selectReportMonth(${m.month})"
           title="Bấm để lọc chi tiết Tháng ${m.month}">
        
        <div class="m-bar-tooltip adm-97">
          <strong>${m.monthLabel}/${selectedYear === 'all' ? 'Toàn Bộ' : selectedYear}</strong> ${isSelected ? '★ (Đang xem)' : ''}<br>
          Doanh thu phí sàn: <strong>${fee.toLocaleString('vi-VN')}₫</strong> (10%)<br>
          Tổng giá trị tour (GMV): <strong>${gmv.toLocaleString('vi-VN')}₫</strong><br>
          Số lượng tour: <strong>${m.tripsCount} chuyến đi</strong>
        </div>

        ${isSelected ? `
          <div class="adm-98">
            ★ Đang xem
          </div>
        ` : ''}

        <div class="m-bar-track" style="height:120px; width:100%; max-width:44px; display:flex; align-items:flex-end; border-radius:8px 8px 0 0; background:rgba(226, 232, 240, 0.4); ${isSelected ? 'outline:2.5px solid #059669; box-shadow:0 0 12px rgba(5,150,105,0.4);' : ''}">
          <div class="m-bar-fill" style="height:${heightPercent}%; width:100%; border-radius:6px 6px 0 0; background:${barColor}; transition:all 0.3s ease;"></div>
        </div>

        <span class="m-bar-label" style="font-size:0.78rem; margin-top:8px; font-weight:${isSelected ? '800' : '600'}; color:${isSelected ? '#047857' : '#334155'};">
          ${m.monthLabel}
        </span>
        <span style="font-size:0.72rem; font-weight:700; color:${hasData ? '#059669' : '#94a3b8'}; margin-top:2px;">
          ${shortFeeText}
        </span>
      </div>
    `;
        }).join('');

        container.innerHTML = `
    <div class="adm-99">
      ${barsHtml}
    </div>
  `;
      }

      /**
       * 4 LOẠI TRẠNG THÁI TRONG BÁO CÁO THỐNG KÊ:
       * 1. Tạm Giữ
       * 2. Thanh Toán
       * 3. Đã Hủy
       * 4. Hoàn Tiền
       */
      function getFourTripStatusBadge(status, paymentStatus) {
        if (status === 'disputed' || status === 'DISPUTED') {
          return `<span class="status-badge adm-100"><i data-lucide="alert-triangle" class="icon-xs"></i> Đang Có Khiếu Nại</span>`;
        }
        if (paymentStatus === 'refunded_to_customer' || status === 'cancelled_refunded') {
          return `<span class="status-badge adm-101"><i data-lucide="rotate-ccw" class="icon-xs"></i> Hoàn Tiền</span>`;
        }
        if (status === 'cancelled') {
          return `<span class="status-badge adm-102"><i data-lucide="x-circle" class="icon-xs"></i> Đã Hủy</span>`;
        }
        if (paymentStatus === 'paid_to_guide' || status === 'finished_paid' || status === 'completed') {
          return `<span class="status-badge adm-103"><i data-lucide="check-circle" class="icon-xs"></i> Thanh Toán</span>`;
        }
        return `<span class="status-badge adm-104"><i data-lucide="clock" class="icon-xs"></i> Tạm Giữ</span>`;
      }

      // Xuất báo cáo CSV
      function exportAdminReport() {
        const store = window.guidiaStore;
        const year = document.getElementById('reportYearFilter') ? document.getElementById('reportYearFilter').value : '2026';
        const month = document.getElementById('reportMonthFilter') ? document.getElementById('reportMonthFilter').value : 'all';
        const region = document.getElementById('reportRegionFilter') ? document.getElementById('reportRegionFilter').value : 'all';

        const report = store.getAdminReportSummary({ month, year, region });
        const trips = report.trips || store.getTrips();

        let csvContent = 'data:text/csv;charset=utf-8,\uFEFF';
        csvContent += 'Mã Đơn,Tuyến Du Lịch,Ngày Đi,Giá Trị Tour (GMV),Tỷ Lệ,Phí Sàn Admin Nhận,Hướng Dẫn Viên,Du Khách,Trạng Thái\n';

        trips.forEach(t => {
          const fee = t.platformFee || Math.round((t.totalAmount || 0) * 0.1);
          let stateText = 'Tạm Giữ';
          if (t.paymentStatus === 'refunded_to_customer' || t.status === 'cancelled_refunded') stateText = 'Hoàn Tiền';
          else if (t.status === 'cancelled') stateText = 'Đã Hủy';
          else if (t.paymentStatus === 'paid_to_guide' || t.status === 'finished_paid' || t.status === 'completed') stateText = 'Thanh Toán';

          csvContent += `"${t.id}","${t.location}","${t.startDate}",${t.totalAmount},"10%",${fee},"${t.guideName}","${t.customerName}","${stateText}"\n`;
        });

        const encodedUri = encodeURI(csvContent);
        const link = document.createElement('a');
        link.setAttribute('href', encodedUri);
        const monthText = month === 'all' ? 'CaNam' : `Thang_${month}`;
        const yearText = year === 'all' ? 'TatCaNam' : `Nam_${year}`;
        link.setAttribute('download', `Bao_Cao_Doanh_Thu_San_${monthText}_${yearText}.csv`);
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        showToast('Đã xuất tệp Báo cáo doanh thu sàn thành công!');
      }

      // =========================================================================
      // 2. QUẢN LÝ TÀI KHOẢN (TRẠNG THÁI THẺ CHỈ CÓ: CHỜ DUYỆT VÀ ĐÃ DUYỆT)
      // =========================================================================
      function renderAdminUsers() {
        const store = window.guidiaStore;
        let users = store.getUsers().filter(u => u.role !== 'admin');
        const certs = store.getCertificates();

        const roleFilter = document.getElementById('userRoleFilter') ? document.getElementById('userRoleFilter').value : 'all';
        const statusFilter = document.getElementById('userStatusFilter') ? document.getElementById('userStatusFilter').value : 'all';
        const certFilter = document.getElementById('userCertFilter') ? document.getElementById('userCertFilter').value : 'all';
        const searchQuery = document.getElementById('userSearchInput') ? document.getElementById('userSearchInput').value.trim().toLowerCase() : '';

        // Lọc vai trò
        if (roleFilter !== 'all') {
          users = users.filter(u => u.role === roleFilter);
        }

        // Lọc trạng thái
        if (statusFilter !== 'all') {
          users = users.filter(u => u.status === statusFilter);
        }

        // Lọc trạng thái thẻ HDV (Chỉ có: Chờ duyệt hoặc Đã duyệt)
        if (certFilter !== 'all') {
          users = users.filter(u => {
            if (u.role !== 'guide') return false;
            const cert = certs.find(c => c.guideId === u.id);
            if (!cert) return false;
            return cert.status === certFilter;
          });
        }

        // Tìm kiếm
        if (searchQuery) {
          users = users.filter(u =>
            u.name.toLowerCase().includes(searchQuery) ||
            u.phone.includes(searchQuery) ||
            u.email.toLowerCase().includes(searchQuery) ||
            u.id.toLowerCase().includes(searchQuery)
          );
        }

        const tbody = document.getElementById('admUsersTableBody');
        if (!tbody) return;

        if (users.length === 0) {
          tbody.innerHTML = `<tr><td colspan="7" class="adm-105">Không tìm thấy tài khoản nào khớp với bộ lọc.</td></tr>`;
          return;
        }

        tbody.innerHTML = users.map(user => {
          const details = store.getUserDetails(user.id);
          const isGuide = user.role === 'guide';
          const cert = details.cert;
          const isHighRisk = details.isViolationExceeded;

          // Tình trạng thẻ HDV: Bắt buộc chỉ có Chờ duyệt và Đã duyệt
          let certHtml = '';
          if (isGuide) {
            if (cert) {
              if (cert.status === 'approved') {
                certHtml = `<span class="badge-tag-status status-active"><i data-lucide="shield-check" class="icon-xs"></i> Đã Duyệt</span><div class="adm-106">${cert.certNumber}</div>`;
              } else {
                certHtml = `<span class="badge-tag-status status-pending"><i data-lucide="clock" class="icon-xs"></i> Chờ Duyệt</span><div class="adm-106">${cert.certType}</div>`;
              }
            } else {
              certHtml = `<span class="badge-tag-status status-pending"><i data-lucide="clock" class="icon-xs"></i> Chờ Duyệt</span>`;
            }
          } else {
            certHtml = `<span class="adm-107">Thành viên du khách</span>`;
          }

          const cancelViolationText = isGuide
            ? `${details.violationCount} lần vi phạm • ${details.cancelledTrips} lần hủy`
            : `${details.cancelCount} lần hủy tour`;

          return `
      <tr>
        <td>
          <div class="user-avatar-cell">
            <img src="${user.avatar}" alt="Avatar" class="user-avatar-img">
            <div>
              <strong class="adm-108">${user.name}</strong>
              <div class="adm-76">${user.id}</div>
            </div>
          </div>
        </td>
        <td>
          <span class="badge-tag-status ${isGuide ? 'status-active' : 'status-pending'} adm-109">
            ${isGuide ? '🧭 Hướng Dẫn Viên' : '🎒 Khách Du Lịch'}
          </span>
        </td>
        <td>
          <div class="adm-110">${user.phone}</div>
          <div class="adm-76">${user.email}</div>
        </td>
        <td>
          ${certHtml}
        </td>
        <td>
          <span style="font-weight:700; color:${isHighRisk ? '#e11d48' : 'var(--text-main)'}; font-size:0.85rem;">
            ${cancelViolationText}
          </span>
          ${isHighRisk ? '<br><span class="adm-111">⚠️ Vi Phạm Vượt Ngưỡng</span>' : ''}
        </td>
        <td>
          ${getUserStatusBadge(user.status)}
        </td>
        <td>
          <button class="btn-sm-action btn-approve adm-112" onclick="openAdminUserDetailModal('${user.id}')" title="Xem đầy đủ hồ sơ, lịch sử tour & thẩm định">
            <i data-lucide="eye" class="icon-xs"></i> Xem Hồ Sơ & Xử Lý
          </button>
        </td>
      </tr>
    `;
        }).join('');

        if (window.lucide) window.lucide.createIcons();
      }

      function getUserStatusBadge(status) {
        if (status === 'active') {
          return `<span class="badge-tag-status status-active"><i data-lucide="check-circle" class="icon-xs"></i> Hoạt Động</span>`;
        }
        if (status === 'pending_approval') {
          return `<span class="badge-tag-status status-pending"><i data-lucide="clock" class="icon-xs"></i> Chờ Duyệt</span>`;
        }
        if (status === 'warned') {
          return `<span class="badge-tag-status adm-113"><i data-lucide="alert-triangle" class="icon-xs"></i> Cảnh Cáo</span>`;
        }
        if (status === 'suspended') {
          return `<span class="badge-tag-status status-suspended"><i data-lucide="slash" class="icon-xs"></i> Đang Bị Khóa</span>`;
        }
        return `<span class="badge-tag-status">${status}</span>`;
      }

      // Xem chi tiết tài khoản
      function openAdminUserDetailModal(userId) {
        const store = window.guidiaStore;
        const details = store.getUserDetails(userId);
        if (!details) {
          showToast('Không tìm thấy dữ liệu người dùng!', 'error');
          return;
        }

        const user = details.user;
        const isGuide = details.isGuide;
        const guide = details.guide;
        const cert = details.cert;
        const userTrips = details.userTrips;

        const modal = document.getElementById('adminUserDetailModal');
        const titleEl = document.getElementById('modalUserTitle');
        const subEl = document.getElementById('modalUserSubtitle');
        const contentEl = document.getElementById('modalUserContent');
        const actionsEl = document.getElementById('modalUserActions');

        if (!modal || !contentEl || !actionsEl) return;

        titleEl.textContent = `Hồ Sơ: ${user.name} (${isGuide ? 'Hướng Dẫn Viên' : 'Khách Du Lịch'})`;
        subEl.textContent = `Mã tài khoản: ${user.id} • Ngày tham gia: ${user.createdAt || '2026'}`;

        // Tìm tất cả các vụ khiếu nại mà tài khoản này là bên bị khiếu nại (lấy từ dữ liệu CSDL)
        const allDisputes = store.getDisputes ? store.getDisputes() : [];
        const userDisputes = allDisputes.filter(d =>
          String(d.reportedUserId) === String(user.id) ||
          (d.defendantName && d.defendantName.trim().toLowerCase() === user.name.trim().toLowerCase())
        );
        // Số lần vi phạm là những khiếu nại bị hoàn tiền
        const userViolations = userDisputes.filter(d =>
          d.status === 'resolved_refund' ||
          (d.dbStatus && (d.dbStatus.toUpperCase().includes('HOÀN_TIỀN') || d.dbStatus.toUpperCase().includes('REFUND')))
        );
        const complaintCount = userDisputes.length;
        const violationCount = userViolations.length;

        // Phần 1: Thông tin cá nhân & Ảnh đại diện HDV
        const userAvatar = user.avatar || (guide && guide.avatar) || 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150';
        let personalHtml = `
    <div class="adm-114">
      <h4 class="adm-115">
        <i data-lucide="user" class="adm-45"></i> 1. Thông Tin Hồ Sơ Cá Nhân & Định Danh
      </h4>
      <div style="display:flex; gap:20px; align-items:flex-start; flex-wrap:wrap; margin-bottom:12px;">
        <div style="text-align:center; min-width:110px;">
          <img src="${userAvatar}" alt="Ảnh đại diện ${user.name}" style="width:100px; height:100px; border-radius:50%; object-fit:cover; border:3px solid var(--mint-500); box-shadow:0 4px 10px rgba(0,0,0,0.12); margin-bottom:6px;">
          <div style="font-size:0.75rem; color:#64748b; font-weight:700;">Ảnh Đại Diện</div>
        </div>
        <div class="adm-116" style="flex:1; min-width:260px;">
          <div><strong>Họ và tên:</strong> ${user.name}</div>
          <div><strong>Số điện thoại:</strong> ${user.phone}</div>
          <div><strong>Địa chỉ Email:</strong> ${user.email}</div>
          <div><strong>Số CCCD / Hộ chiếu:</strong> ${user.cccd || '001201008899'}</div>
          <div><strong>Địa chỉ cư trú:</strong> ${user.address || 'Việt Nam'}</div>
          <div><strong>Trạng thái tài khoản:</strong> ${getUserStatusBadge(user.status)}</div>
        </div>
      </div>
      ${user.bio ? `<div class="adm-117">"${user.bio}"</div>` : ''}
      ${user.banReason ? `<div class="adm-118"><strong>Lý do khóa tài khoản:</strong> ${user.banReason} (Khóa lúc: ${user.bannedAt || 'Gần đây'})</div>` : ''}
    </div>
  `;

        // Phần 2: Thẻ HDV (Chỉ có Chờ duyệt và Đã duyệt)
        let certSectionHtml = '';
        if (isGuide) {
          if (cert) {
            const isApproved = cert.status === 'approved';
            certSectionHtml = `
        <div class="adm-119">
          <h4 class="adm-115">
            <i data-lucide="file-check" class="adm-45"></i> 2. Thẩm Định Thẻ Hành Nghề Hướng Dẫn Viên Du Lịch
          </h4>
          <div class="adm-120">
            <div>
              <img src="${cert.documentUrl}" alt="Ảnh thẻ HDV" class="adm-121" onclick="window.open('${cert.documentUrl}', '_blank')" title="Bấm để xem ảnh phóng to">
              <div class="adm-122">🔍 Bấm xem ảnh gốc</div>
            </div>
            <div class="adm-123">
              <div class="adm-41">
                <strong class="adm-124">${cert.certType}</strong>
                <span class="badge-tag-status ${isApproved ? 'status-active' : 'status-pending'}">
                  ${isApproved ? 'Đã Duyệt' : 'Chờ Duyệt'}
                </span>
              </div>
              <div>Số hiệu thẻ: <strong>${cert.certNumber}</strong> • Cấp bởi: <strong>${cert.issuedBy}</strong></div>
              <div>Ngày hết hạn thẻ: <strong>${cert.expiryDate}</strong> • Tuyến chuyên môn: <strong>${guide ? guide.city : 'Việt Nam'}</strong></div>
              <div>Kinh nghiệm: <strong>${guide ? guide.experienceYears : '3 năm'}</strong> • Ngoại ngữ: <strong>${guide && guide.languages ? guide.languages.join(', ') : 'Tiếng Việt'}</strong></div>
              <div class="adm-125">"${cert.note || 'Cam kết dẫn tour đúng đạo đức nghề nghiệp và pháp luật du lịch Việt Nam'}"</div>
            </div>
          </div>
        </div>
      `;
          }
        }

        // Phần 3: Kỷ luật, Lịch Sử Vi Phạm & Hủy Chuyến (Chỉ hiện số lần vi phạm & số lần bị khiếu nại từ CSDL)
        const isViolationExceeded = violationCount >= 2 || complaintCount >= 2;
        let violationHtml = `
    <div style="background:#ffffff; border:1px solid ${isViolationExceeded ? '#fecdd3' : 'var(--mint-200)'}; border-radius:12px; padding:16px 20px;">
      <h4 style="font-size:0.95rem; color:${isViolationExceeded ? '#be123c' : 'var(--mint-950)'}; margin-bottom:10px; display:flex; align-items:center; gap:8px;">
        <i data-lucide="alert-triangle" style="color:${isViolationExceeded ? '#e11d48' : 'var(--mint-700)'};"></i> 3. Kỷ Luật & Lịch Sử Vi Phạm
      </h4>
      <div class="adm-126" style="display:grid; grid-template-columns:repeat(auto-fit, minmax(220px, 1fr)); gap:12px;">
        <div>Số lần vi phạm: <strong style="color:${violationCount >= 2 ? '#e11d48' : 'var(--mint-900)'}; font-size:1.05rem;">${violationCount} lần</strong></div>
        <div>Số lần bị khiếu nại: <strong style="color:${complaintCount >= 2 ? '#e11d48' : 'var(--mint-900)'}; font-size:1.05rem;">${complaintCount} lần</strong></div>
      </div>
      ${isViolationExceeded ? `
        <div class="adm-128" style="margin-top:10px;">
          <strong>⚠️ CẢNH BÁO VI PHẠM:</strong> Tài khoản này đã có ${violationCount} lần vi phạm và ${complaintCount} lần bị khiếu nại trên hệ thống. Quản trị viên cần kiểm tra kỹ hồ sơ trước khi mở/duyệt.
        </div>
      ` : ''}
    </div>
  `;

        // Phần 4: Lịch sử vi phạm (Các khiếu nại bị xử phạt hoàn tiền)
        let tripsHtml = `
    <div class="adm-114">
      <h4 class="adm-129">
        <i data-lucide="alert-octagon" class="adm-45" style="color:#e11d48;"></i> 4. Lịch Sử Vi Phạm (${userViolations.length} vụ việc bị xử phạt hoàn tiền)
      </h4>
      ${userViolations.length === 0 ? `
        <p class="adm-130" style="color:#059669; font-weight:600;"><i data-lucide="shield-check" class="icon-xs"></i> Tài khoản này hiện chưa ghi nhận lịch sử vi phạm (khiếu nại bị phán quyết hoàn tiền) nào trên hệ thống.</p>
      ` : `
        <table class="custom-table adm-131">
          <thead>
            <tr>
              <th>Mã Khiếu Nại</th>
              <th>Mã Tour</th>
              <th>Loại Vi Phạm / Lý Do</th>
              <th>Bên Khiếu Nại</th>
              <th>Ngày Ghi Nhận</th>
              <th>Phán Quyết / Trạng Thái</th>
            </tr>
          </thead>
          <tbody>
            ${userViolations.map(d => `
              <tr>
                <td><strong>${d.id}</strong></td>
                <td><strong>${d.tripId || d.bookingId || '---'}</strong></td>
                <td>${d.disputeType || d.reason || 'Sự cố dịch vụ'}</td>
                <td>${d.complainantName || 'Du khách'}</td>
                <td>${d.createdAt || 'Gần đây'}</td>
                <td>${getDisputeStatusBadge(d.status)}</td>
              </tr>
            `).join('')}
          </tbody>
        </table>
      `}
    </div>
  `;

        contentEl.innerHTML = personalHtml + certSectionHtml + violationHtml + tripsHtml;

        // Thao tác QTV: Duyệt thẻ nếu đang chờ duyệt, Khóa/Mở khóa tài khoản, Đóng
        let buttonsHtml = '<div class="adm-61">';

        if (isGuide && cert && cert.status === 'pending') {
          buttonsHtml += `
      <button class="btn-primary adm-132" onclick="handleApproveCertFromModal('${cert.id}')">
        <i data-lucide="check-circle"></i> Duyệt Thẻ HDV
      </button>
    `;
        }

        if (user.status === 'suspended') {
          buttonsHtml += `
      <button class="btn-primary adm-132" onclick="handleUnbanUserFromModal('${user.id}')">
        <i data-lucide="unlock"></i> Mở Khóa Tài Khoản
      </button>
    `;
        } else {
          buttonsHtml += `
      <button class="btn-primary adm-86" onclick="openBanUserModalFromModal('${user.id}')">
        <i data-lucide="slash"></i> Khóa Tài Khoản
      </button>
    `;
        }

        buttonsHtml += '</div>';

        buttonsHtml += `
    <button class="btn-outline adm-133" onclick="closeAdminUserDetailModal()">
      <i data-lucide="x"></i> Đóng / Hủy Thao Tác
    </button>
  `;

        actionsEl.innerHTML = buttonsHtml;
        modal.style.display = 'flex';
        if (window.lucide) window.lucide.createIcons();
      }

      function closeAdminUserDetailModal() {
        const modal = document.getElementById('adminUserDetailModal');
        if (modal) modal.style.display = 'none';
      }

      function handleApproveCertFromModal(certId) {
        const res = window.guidiaStore.approveGuideCertificate(certId);
        if (res.success) {
          showToast(res.message);
          closeAdminUserDetailModal();
          renderAdminUsers();
          updateAdminBadges();
        }
      }

      function openBanUserModalFromModal(userId) {
        openBanUserModal(userId);
      }

      function openBanUserModal(userId) {
        const store = window.guidiaStore;
        const trips = store.getTrips();
        const modal = document.getElementById('banUserModal');
        const idInput = document.getElementById('banUserId');
        const warningEl = document.getElementById('banActiveTripsWarning');
        const reasonText = document.getElementById('banReasonText');

        if (!modal) return;
        idInput.value = userId;
        if (reasonText) reasonText.value = '';

        const activeTrips = trips.filter(t =>
          (t.guideId === userId || t.customerId === userId) &&
          ['confirmed_upcoming', 'pending_guide', 'ongoing'].includes(t.status)
        );

        if (warningEl) {
          if (activeTrips.length > 0) {
            warningEl.style.display = 'block';
            warningEl.innerHTML = `
        <strong>⚠️ CẢNH BÁO QUẢN TRỊ VIÊN:</strong> Tài khoản này hiện đang có <strong>${activeTrips.length} chuyến đi chưa hoàn tất</strong> (ví dụ: ${activeTrips.map(t => t.id).join(', ')}). Khi khóa, các đơn này sẽ được hệ thống tự động đưa vào diện hủy và hoàn tiền 100% để bảo vệ quyền lợi du khách!
      `;
          } else {
            warningEl.style.display = 'none';
          }
        }

        modal.style.display = 'flex';
      }

      function closeBanUserModal() {
        const modal = document.getElementById('banUserModal');
        if (modal) modal.style.display = 'none';
      }

      function confirmBanUser() {
        const userId = document.getElementById('banUserId').value;
        const reason = document.getElementById('banReasonText').value;

        if (!reason || !reason.trim()) {
          showToast('Bắt buộc phải nhập lý do khóa tài khoản!', 'error');
          return;
        }

        const res = window.guidiaStore.banUser(userId, reason);
        if (res.success) {
          closeBanUserModal();
          closeAdminUserDetailModal();
          showToast(res.message, 'success');
          renderAdminUsers();
          handleGenerateReport();
        } else {
          showToast(res.message, 'error');
        }
      }

      function handleUnbanUserFromModal(userId) {
        const res = window.guidiaStore.unbanUser(userId);
        if (res.success) {
          showToast(res.message);
          closeAdminUserDetailModal();
          renderAdminUsers();
        }
      }

      // =========================================================================
      // 3. TRUNG TÂM XỬ LÝ KHIẾU NẠI (HIỆN DANH SÁCH - BẤM VÀO MỚI XEM CHI TIẾT & THAO TÁC)
      // =========================================================================
      function renderAdminDisputes() {
        const store = window.guidiaStore;
        const disputes = store.getDisputes();
        const tbody = document.getElementById('admDisputesTableBody');
        if (!tbody) return;

        if (disputes.length === 0) {
          tbody.innerHTML = `<tr><td colspan="7" class="adm-134">Không có vụ việc khiếu nại nào cần xử lý.</td></tr>`;
          return;
        }

        tbody.innerHTML = disputes.map(d => `
    <tr>
      <td><strong>${d.id}</strong></td>
      <td>
        <strong class="adm-108">${d.complainantName}</strong>
        <div class="adm-76">${d.complainantRole === 'customer' ? 'Du khách' : 'HDV'}</div>
      </td>
      <td><strong>${d.defendantName}</strong></td>
      <td><span class="adm-93">${d.createdAt}</span></td>
      <td><strong class="adm-36">${d.amount.toLocaleString('vi-VN')}₫</strong></td>
      <td>${getDisputeStatusBadge(d.status)}</td>
      <td>
        <button class="btn-sm-action btn-approve adm-135" onclick="openDisputeDetailModal('${d.id}')">
          <i data-lucide="eye" class="icon-xs"></i> Xem Chi Tiết & Xử Lý
        </button>
      </td>
    </tr>
  `).join('');

        if (window.lucide) window.lucide.createIcons();
      }

      function getDisputeStatusBadge(status) {
        const st = (status || '').toLowerCase().trim();
        if (st === 'pending' || st === 'chờ_xử_lý' || st === 'chờ xử lý') {
          return `<span class="status-badge adm-136"><i data-lucide="clock" class="icon-xs"></i> Chờ Xử Lý</span>`;
        }
        if (st === 'need_more_info' || st === 'chờ_bổ_sung' || st === 'chờ bổ sung') {
          return `<span class="status-badge adm-137"><i data-lucide="help-circle" class="icon-xs"></i> Chờ Bổ Sung</span>`;
        }
        if (st === 'resolved_refund' || st === 'approved_refund' || st.includes('hoàn_tiền') || st.includes('hoàn tiền') || st === 'duyệt' || st === 'đã_duyệt' || st === 'đã duyệt') {
          return `<span class="status-badge adm-138"><i data-lucide="check-circle" class="icon-xs"></i> Đã Duyệt (Hoàn Tiền)</span>`;
        }
        if (st === 'resolved_release' || st === 'resolved_rejected' || st === 'rejected' || st.includes('bác_bỏ') || st.includes('bác bỏ') || st === 'tu_choi' || st === 'từ_chối' || st === 'không duyệt') {
          return `<span class="status-badge adm-139"><i data-lucide="x-circle" class="icon-xs"></i> Không Duyệt (Tất Toán HDV)</span>`;
        }
        return `<span class="status-badge status-active"><i data-lucide="check" class="icon-xs"></i> ${status || 'Đã Xử Lý'}</span>`;
      }

      // Bấm vào mới hiển thị chi tiết nội dung khiếu nại (xuống dòng từng mục riêng biệt) và các thao tác
      function openDisputeDetailModal(disputeId) {
        const store = window.guidiaStore;
        const disputes = store.getDisputes();
        const d = disputes.find(item => item.id === disputeId || String(item.dbDisputeId) === String(disputeId) || item.disputeCode === disputeId);
        if (!d) {
          showToast('Không tìm thấy thông tin đơn khiếu nại!', 'error');
          return;
        }

        const modal = document.getElementById('disputeDetailModal');
        const titleEl = document.getElementById('disputeDetailModalTitle');
        const subtitleEl = document.getElementById('disputeDetailModalSubtitle');
        const contentEl = document.getElementById('disputeDetailModalContent');
        const actionsEl = document.getElementById('disputeDetailModalActions');

        if (!modal || !contentEl || !actionsEl) return;

        let statusText = 'Chờ Xử Lý';
        const st = (d.status || '').toLowerCase().trim();
        if (st === 'resolved_refund' || st === 'approved_refund') statusText = 'Đã Duyệt (Hoàn Tiền)';
        else if (st === 'resolved_release' || st === 'resolved_rejected' || st === 'rejected' || st === 'tu_choi') statusText = 'Không Duyệt (Tất Toán HDV)';
        else if (st === 'need_more_info') statusText = 'Chờ Bổ Sung';

        titleEl.textContent = `Hồ Sơ Khiếu Nại: ${d.id}`;
        subtitleEl.textContent = `Ngày gửi: ${d.createdAt || 'Hôm nay'} • Trạng thái: ${statusText}`;

        const evidenceText = d.evidenceText || d.reason || 'Biên bản ghi nhận sự việc và bằng chứng vi phạm do khách cung cấp.';
        const evidenceUrl = d.evidenceUrl || d.evidence_image_url || 'img/bang-chung-tre.jpg';

        // NỘI DUNG XUỐNG DÒNG RÕ RÀNG, TỪNG DÒNG MỘT CHO THOÁNG ĐÃNG
        contentEl.innerHTML = `
    <div class="adm-140">
      
      <div>
        <span class="adm-141">Bên khiếu nại:</span>
        <div class="adm-142">
          ${d.complainantName} <span class="adm-143">(${d.complainantRole === 'customer' ? 'Khách du lịch' : 'Hướng dẫn viên'} • SĐT: ${d.complainantPhone || '0988776655'})</span>
        </div>
      </div>

      <div>
        <span class="adm-141">Bên bị khiếu nại:</span>
        <div class="adm-142">
          ${d.defendantName}
        </div>
      </div>

      <div>
        <span class="adm-141">Thời gian gửi khiếu nại:</span>
        <div class="adm-144">
          <i data-lucide="clock" class="icon-xs adm-145"></i> ${d.createdAt}
        </div>
      </div>

      <div>
        <span class="adm-141">Mã chuyến đi & Tuyến du lịch:</span>
        <div class="adm-146">
          <i data-lucide="map-pin" class="icon-xs adm-145"></i> Mã tour: <strong>${d.tripId || d.bookingId || '---'}</strong> — ${d.tourLocation || d.location || 'Việt Nam'}
        </div>
      </div>

      <div>
        <span class="adm-141">Số tiền tranh chấp:</span>
        <div class="adm-147">
          ${(d.amount || 0).toLocaleString('vi-VN')}₫
        </div>
      </div>

      <div>
        <span class="adm-148">Lý do khiếu nại:</span>
        <div class="adm-149">
          ${d.reason || d.disputeType || 'Sự cố dịch vụ'}
        </div>
      </div>

      <div>
        <span class="adm-148">Bằng chứng & Biên bản đính kèm:</span>
        <div class="adm-150">
          <div style="margin-bottom:8px; line-height:1.5;">${evidenceText}</div>
          <div class="adm-151">
            <img src="${evidenceUrl}" alt="Bằng chứng khiếu nại" class="adm-152" onclick="window.open(this.src, '_blank')" title="Bấm xem ảnh kích thước lớn" onerror="this.onerror=null; this.src='img/bang-chung-tre.jpg';">
            <div class="adm-153">🔍 Bấm vào ảnh để xem kích thước lớn</div>
          </div>
        </div>
      </div>

      ${d.adminDecision ? `
        <div>
          <span class="adm-154">Phán quyết của Quản trị viên:</span>
          <div class="adm-155">
            ⚖️ ${d.adminDecision}
          </div>
        </div>
      ` : ''}
    </div>
  `;

        // CÁC THAO TÁC ĐI KÈM TRONG MODAL: DUYỆT, KHÔNG DUYỆT, YÊU CẦU BỔ SUNG
        if (d.status === 'pending' || d.status === 'need_more_info') {
          actionsEl.innerHTML = `
      <div class="adm-156">
        <div class="adm-157">
          <button class="btn-primary adm-132" onclick="openDisputeDecisionModal('${d.id}', 'accept_refund', 'Duyệt Khiếu Nại (Hoàn Tiền Cho Du Khách)')">
            <i data-lucide="check-circle"></i> Chấp nhận (Hoàn Tiền)
          </button>
          <button class="btn-primary adm-86" onclick="openDisputeDecisionModal('${d.id}', 'reject', 'Không Duyệt Khiếu Nại (Tất Toán Cho HDV)')">
            <i data-lucide="x-circle"></i> Bác bỏ (Tất Toán HDV)
          </button>
          <button class="btn-outline adm-158" onclick="openDisputeDecisionModal('${d.id}', 'need_more_info', 'Yêu Cầu Bổ Sung Thông Tin / Chứng Cứ')">
            <i data-lucide="help-circle"></i> Yêu Cầu Bổ Sung
          </button>
        </div>
        <button class="btn-outline" onclick="closeDisputeDetailModal()">Đóng</button>
      </div>
    `;
        } else {
          actionsEl.innerHTML = `
      <div class="adm-159">
        <span class="adm-160">Đơn khiếu nại này đã hoàn tất giải quyết</span>
        <button class="btn-primary" onclick="closeDisputeDetailModal()">Đã Hiểu & Đóng</button>
      </div>
    `;
        }

        modal.style.display = 'flex';
        if (window.lucide) window.lucide.createIcons();
      }

      function closeDisputeDetailModal() {
        const modal = document.getElementById('disputeDetailModal');
        if (modal) modal.style.display = 'none';
      }

      function openDisputeDecisionModal(disputeId, decisionType, title) {
        const modal = document.getElementById('disputeDecisionModal');
        const titleEl = document.getElementById('modalDisputeTitle');
        const idInput = document.getElementById('modalDisputeId');
        const typeInput = document.getElementById('modalDisputeDecisionType');
        const reasonText = document.getElementById('modalDisputeReasonText');

        if (!modal) return;
        idInput.value = disputeId;
        typeInput.value = decisionType;
        titleEl.textContent = title;
        if (reasonText) reasonText.value = '';

        modal.style.display = 'flex';
      }

      function closeDisputeDecisionModal() {
        const modal = document.getElementById('disputeDecisionModal');
        if (modal) modal.style.display = 'none';
      }

      function confirmDisputeDecision() {
        const disputeId = document.getElementById('modalDisputeId').value;
        const decisionType = document.getElementById('modalDisputeDecisionType').value;
        const reason = document.getElementById('modalDisputeReasonText').value;

        if (!reason || !reason.trim()) {
          showToast('Vui lòng nhập lý do và căn cứ cho phán quyết của Quản trị viên!', 'error');
          return;
        }

        try {
          const res = window.guidiaStore.resolveDispute(disputeId, decisionType, reason);
          if (res && res.success) {
            closeDisputeDecisionModal();
            showToast(res.message, 'success');
            renderAdminDisputes();
            if (typeof handleGenerateReport === 'function') handleGenerateReport();
            if (typeof updateAdminBadges === 'function') updateAdminBadges();
            // Mở lại hoặc cập nhật modal chi tiết
            openDisputeDetailModal(disputeId);
          } else {
            showToast(res ? res.message : 'Có lỗi khi ban hành quyết định', 'error');
          }
        } catch (err) {
          console.error('Error confirming dispute decision:', err);
          showToast('Lỗi: ' + (err.message || err), 'error');
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
          } else if (type === 'warning') {
            icon.setAttribute('data-lucide', 'alert-triangle');
            icon.style.color = '#f59e0b';
          } else {
            icon.setAttribute('data-lucide', 'check-circle');
            icon.style.color = '#34d399';
          }
          if (window.lucide) window.lucide.createIcons();
        }

        toast.classList.add('show');
        if (window._toastTimer) clearTimeout(window._toastTimer);
        window._toastTimer = setTimeout(() => {
          toast.classList.remove('show');
        }, 4200);
      }

      function handleAdminLogout() {
        localStorage.removeItem('guidia_active_user');
        localStorage.removeItem('guidia_current_user');
        localStorage.removeItem('guidia_current_customer_id_v2');
        localStorage.removeItem('guidia_current_guide_id_v2');
        sessionStorage.removeItem('guidia_current_user');
        sessionStorage.clear();
        window.location.href = 'login.jsp';
      }

    </script>
  </body>

  </html>