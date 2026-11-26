<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
  <!DOCTYPE html>
  <html lang="vi">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Guidia - Cổng Khách Vãng Lai | Tra Cứu Hướng Dẫn Viên, Đăng Ký & Đăng Nhập</title>

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

    <!-- ========================================================================= -->
    <!-- 0. THANH ĐIỀU HƯỚNG CHUNG (Header khi chưa đăng nhập)                     -->
    <!-- Logo, menu Tra cứu hướng dẫn viên, Nút Đăng nhập, Nút Đăng ký.           -->
    <!-- Ẩn hoàn toàn các mục Chuyến đi của tôi, Icon Tin nhắn, Chuông thông báo,  -->
    <!-- Ảnh đại diện khi duyệt với tư cách Khách vãng lai.                         -->
    <!-- ========================================================================= -->
    <header class="guest-global-navbar" id="guestGlobalHeader">
      <div class="gst-1">
        <button type="button"
          onclick="if (window.history.length > 1) { window.history.back(); } else { window.location.href = 'index.jsp'; }"
          class="btn-portal-back" title="Quay lại">
          <i data-lucide="arrow-left"></i>
        </button>
        <!-- • Logo / Trang chủ: Về trang chủ giới thiệu và tìm kiếm nhanh -->
        <a href="index.jsp" class="gst-2">
          <div class="gst-3">
            <i data-lucide="compass" class="gst-4"></i>
          </div>
          <div>
            <div class="gst-5">Guidia</div>
            <div class="gst-6">Private Local Guides Vietnam</div>
          </div>
        </a>

        <!-- • Menu: Trang chủ & Tra cứu hướng dẫn viên (UC02) -->
        <div class="gst-7">
          <a href="index.jsp" class="gst-8">
            <i data-lucide="home" class="gst-9"></i> Trang Chủ
          </a>
          <a href="#search" onclick="switchGuestTab('tab-search')" id="headerLinkSearch" class="gst-10">
            <i data-lucide="search" class="gst-9"></i> Tra Cứu Hướng Dẫn Viên
          </a>
          <a href="#workflow" onclick="switchGuestTab('tab-workflow')" class="gst-8">
            <i data-lucide="shield-check" class="gst-9"></i> Quy Trình & Ký Quỹ
          </a>
        </div>

        <!-- • Nút "Đăng ký" (UC01) & Nút "Đăng nhập" (UC03) -->
        <!-- (Ẩn hoàn toàn: Chuyến đi của tôi, Icon Tin nhắn, Chuông thông báo, Ảnh đại diện) -->
        <div class="gst-11">
          <button onclick="switchGuestTab('tab-register')" class="btn-outline gst-12">
            <i data-lucide="user-plus" class="icon-xs"></i> Đăng Ký
          </button>
          <button onclick="switchGuestTab('tab-auth')" class="btn-primary gst-13">
            <i data-lucide="log-in" class="icon-xs"></i> Đăng Nhập
          </button>
        </div>
    </header>

    <!-- Sidebar: Portal Navigation cho Khách Vãng Lai -->
    <aside class="portal-sidebar">
      <div class="sidebar-brand">
        <div class="logo-icon gst-14">
          <i data-lucide="compass"></i>
        </div>
        <div class="logo-text">
          <span class="logo-title gst-15">Guidia</span>
        </div>
        <span class="portal-badge gst-16">Khách Vãng Lai</span>
      </div>

      <nav class="sidebar-nav">
        <!-- 1. Tra cứu hướng dẫn viên (UC02) -->
        <a href="#search" class="nav-link-item active" data-tab="tab-search">
          <i data-lucide="search"></i>
          <span>Tra Cứu HDV</span>
          <span class="tab-badge-pill gst-17">UC02</span>
        </a>

        <!-- 2. Đăng ký tài khoản (UC01) -->
        <a href="#register" class="nav-link-item" data-tab="tab-register">
          <i data-lucide="user-plus"></i>
          <span>Đăng Ký</span>
          <span class="tab-badge-pill gst-18">UC01</span>
        </a>

        <!-- 3. Đăng nhập & Quên mật khẩu (UC03) -->
        <a href="#auth" class="nav-link-item" data-tab="tab-auth">
          <i data-lucide="log-in"></i>
          <span>Đăng Nhập / Quên MK</span>
          <span class="tab-badge-pill gst-19">UC03</span>
        </a>

        <!-- 4. Quy trình & Giới thiệu Ký quỹ Escrow -->
        <a href="#workflow" class="nav-link-item" data-tab="tab-workflow">
          <i data-lucide="shield-check"></i>
          <span>Quy Trình & Ký Quỹ</span>
        </a>
      </nav>

      <!-- Sidebar Footer: Khối trợ giúp & Đăng nhập -->
      <div class="sidebar-footer gst-20">
        <div class="gst-21">
          <i data-lucide="sparkles" class="gst-22"></i>
          <div class="gst-23">Bạn đã có tài khoản?</div>
          <div class="gst-24">
            Đăng nhập ngay để mở khóa tính năng Nhắn tin và Đặt lịch riêng với HDV.
          </div>
          <button onclick="switchGuestTab('tab-auth')" class="btn-primary gst-25">
            <i data-lucide="log-in" class="gst-26"></i> Đăng Nhập Ngay (UC03)
          </button>
        </div>
      </div>
    </aside>

    <!-- Main Content Area -->
    <main class="portal-main">

      <!-- Portal Topbar -->
      <header class="portal-topbar">
        <div class="topbar-left">
          <h1 id="guestPageTitle">Tra Cứu Hướng Dẫn Viên Du Lịch Bản Địa (UC02)</h1>
        </div>
        <div class="topbar-right">
          <div class="gst-7">
            <!-- Bộ chuyển đổi vai trò Demo giữa 4 phân hệ -->
            <div class="gst-27">
              <span class="gst-28">Chuyển Phân Hệ:</span>
              <select id="rolePortalSwitcher" class="form-control gst-29" onchange="switchPortalRole(this.value)">
                <option value="guest" selected>Khách Vãng Lai (guest.jsp)</option>
                <option value="customer">Khách Du Lịch (customer.jsp)</option>
                <option value="guide">Hướng Dẫn Viên (guide.jsp)</option>
                <option value="admin">Quản Trị Viên (admin.jsp)</option>
              </select>
            </div>

            <button onclick="switchGuestTab('tab-register')" class="btn-outline gst-30">
              <i data-lucide="user-plus" class="icon-xs"></i> Đăng Ký
            </button>
            <button onclick="switchGuestTab('tab-auth')" class="btn-primary gst-31">
              <i data-lucide="log-in" class="icon-xs"></i> Đăng Nhập
            </button>
            <a href="index.jsp" class="btn-outline gst-32">
              <i data-lucide="home" class="icon-xs"></i> Trang Chủ
            </a>
          </div>
        </div>
      </header>

      <div class="portal-content">

        <!-- ========================================================================= -->
        <!-- TAB 1: USE CASE 02 • TRA CỨU HƯỚNG DẪN VIÊN                              -->
        <!-- Điều kiện: Chỉ hiện HDV đã hoàn tất hồ sơ và được duyệt thẻ.              -->
        <!-- Khách vãng lai xem thông tin, bảng giá, lịch rảnh, đánh giá thoải mái.     -->
        <!-- Nhấn "Nhắn tin" hoặc "Đặt lịch" -> yêu cầu đăng nhập (Luồng phụ A2).     -->
        <!-- ========================================================================= -->
        <section class="tab-content-panel active" id="tab-search">

          <!-- Header giới thiệu & đặc tả UC02 -->
          <div class="card-table-wrapper gst-33">
            <div class="gst-34">
              <div>
                <div class="gst-35">
                  <i data-lucide="search" class="gst-36"></i> • TRA CỨU HƯỚNG DẪN VIÊN
                </div>
                <h2 class="gst-37">
                  Khám Phá & Lọc Đội Ngũ Hướng Dẫn Viên Bản Địa Tiêu Biểu
                </h2>
                <p class="gst-38">
                  Cho phép tìm kiếm, lọc theo 4 tiêu chí: <strong>vùng</strong>, <strong>mức giá</strong>, <strong>ngoại
                    ngữ</strong>, <strong>ngày cần đi</strong> và sắp xếp (theo đánh giá hoặc giá).
                  <strong>Xem hồ sơ chi tiết không cần đăng nhập</strong>; khi chọn <em>"Nhắn tin"</em> hoặc <em>"Đặt
                    lịch"</em>, hệ thống sẽ yêu cầu đăng nhập tài khoản Khách du lịch (UC03).
                </p>
              </div>
              <div class="gst-39">
                <button onclick="switchGuestTab('tab-register')" class="btn-primary gst-40">
                  <i data-lucide="user-plus" class="icon-xs"></i> Đăng Ký
                </button>
              </div>
            </div>
          </div>

          <!-- Thanh Tìm Kiếm & 4 Bộ Lọc Đa Tiêu Chí (UC02 - Bước 3 & 4) -->
          <div class="card-table-wrapper gst-41">
            <form id="guestSearchForm" onsubmit="handleGuestSearch(event)">
              <div class="gst-42">

                <!-- Ô Từ khóa -->
                <div>
                  <label class="gst-43">
                    <i data-lucide="search" class="gst-44"></i> Từ khóa / Điểm đến
                  </label>
                  <input type="text" id="guestSearchKeyword" class="form-control"
                    placeholder="Tên HDV, Hà Nội, Hội An, Sapa, Huế..." value="">
                </div>

                <!-- 1. Bộ lọc Vùng miền -->
                <div>
                  <label class="gst-43">
                    <i data-lucide="map-pin" class="gst-44"></i> Vùng miền
                  </label>
                  <select id="guestFilterRegion" class="form-control">
                    <option value="all">Tất cả vùng miền</option>
                    <option value="north">Miền Bắc (Hà Nội, Sapa, Ninh Bình...)</option>
                    <option value="central">Miền Trung (Đà Nẵng, Hội An, Huế...)</option>
                    <option value="south">Miền Nam (TP.HCM, Miền Tây, Phú Quốc...)</option>
                  </select>
                </div>

                <!-- 2. Bộ lọc Mức giá -->
                <div>
                  <label class="gst-43">
                    <i data-lucide="banknote" class="gst-44"></i> Mức giá / ngày
                  </label>
                  <select id="guestFilterPrice" class="form-control">
                    <option value="all">Tất cả mức giá</option>
                    <option value="under_1m">Dưới 1.000.000 đ</option>
                    <option value="1m_to_2m">1.000.000 đ - 2.000.000 đ</option>
                    <option value="over_2m">Trên 2.000.000 đ</option>
                  </select>
                </div>

                <!-- 3. Bộ lọc Ngoại ngữ -->
                <div>
                  <label class="gst-43">
                    <i data-lucide="languages" class="gst-44"></i> Ngoại ngữ
                  </label>
                  <select id="guestFilterLanguage" class="form-control">
                    <option value="all">Tất cả ngôn ngữ</option>
                    <option value="Tiếng Anh">Tiếng Anh</option>
                    <option value="Tiếng Pháp">Tiếng Pháp</option>
                    <option value="Tiếng Hàn">Tiếng Hàn</option>
                    <option value="Tiếng Nhật">Tiếng Nhật</option>
                    <option value="Tiếng Trung">Tiếng Trung</option>
                  </select>
                </div>

                <!-- 4. Bộ lọc Ngày cần đi (kiểm tra lịch rảnh) -->
                <div>
                  <label class="gst-43">
                    <i data-lucide="calendar" class="gst-44"></i> Ngày cần đi
                  </label>
                  <input type="date" id="guestFilterDate" class="form-control">
                </div>

                <!-- Nút Lọc / Tra cứu & Đặt lại -->
                <div class="gst-45">
                  <button type="submit" class="btn-primary gst-46">
                    <i data-lucide="filter" class="icon-xs"></i> Lọc
                  </button>
                  <button type="button" onclick="resetGuestFilters()" class="btn-outline gst-47"
                    title="Xóa toàn bộ bộ lọc">
                    <i data-lucide="rotate-ccw" class="icon-xs"></i>
                  </button>
                </div>

              </div>

              <!-- Dòng bộ lọc phụ: Sắp xếp kết quả (theo đánh giá hoặc giá) -->
              <div class="gst-48">
                <div class="gst-49">
                  Hiển thị <strong id="guestSearchCount" class="gst-50">0</strong> hướng dẫn viên đã hoàn tất hồ sơ &
                  thẻ hành nghề hợp lệ
                </div>

                <div class="gst-51">
                  <label class="gst-52">
                    <i data-lucide="arrow-up-down" class="gst-53"></i> Sắp xếp theo:
                  </label>
                  <select id="guestSortBy" class="form-control gst-54" onchange="renderGuestGuidesGrid()">
                    <option value="rating_desc">Đánh giá cao nhất (5.0 ★)</option>
                    <option value="price_asc">Mức giá: Thấp đến Cao</option>
                    <option value="price_desc">Mức giá: Cao đến Thấp</option>
                    <option value="reviews_desc">Số lượt đánh giá nhiều nhất</option>
                  </select>
                </div>
              </div>
            </form>
          </div>

          <!-- Quick Filter Tags -->
          <div class="gst-55">
            <button type="button" onclick="quickFilterCity('all')" class="tag-pill gst-56">Tất cả điểm đến</button>
            <button type="button" onclick="quickFilterCity('Hà Nội')" class="tag-pill gst-57">Hà Nội & 36 Phố
              Phường</button>
            <button type="button" onclick="quickFilterCity('Hội An')" class="tag-pill gst-57">Phố Cổ Hội An</button>
            <button type="button" onclick="quickFilterCity('Đà Nẵng')" class="tag-pill gst-57">Đà Nẵng & Bà Nà</button>
            <button type="button" onclick="quickFilterCity('Huế')" class="tag-pill gst-57">Cố Đô Huế & Sông
              Hương</button>
            <button type="button" onclick="quickFilterCity('Sapa')" class="tag-pill gst-57">Sapa & Fansipan</button>
            <button type="button" onclick="quickFilterCity('Hồ Chí Minh')" class="tag-pill gst-57">TP. Hồ Chí
              Minh</button>
          </div>

          <!-- Danh sách thẻ Hướng Dẫn Viên (UC02 - Bước 2, 4) - Chỉ hiện người đã duyệt thẻ -->
          <div id="guestGuidesGrid" class="gst-58">
            <!-- Render dynamic approved guide cards -->
          </div>

          <!-- Khung báo không có kết quả (Luồng phụ A1 - UC02) -->
          <div id="guestSearchEmpty" class="gst-59">
            <div class="gst-60">
              <i data-lucide="search-x" class="gst-61"></i>
            </div>
            <h3 class="gst-62">Không có kết quả phù hợp</h3>
            <p class="gst-63">
              Hệ thống không tìm thấy hướng dẫn viên nào khớp hoàn toàn với các tiêu chí tìm kiếm vừa chọn.
              Bạn có thể nới lỏng bộ lọc hoặc xóa điều kiện ngày/mức giá để xem thêm các HDV khác.
            </p>
            <button onclick="resetGuestFilters()" class="btn-primary gst-64">
              <i data-lucide="rotate-ccw" class="icon-xs"></i> Đặt Lại & Nới Lỏng Bộ Lọc (A1)
            </button>
          </div>
        </section>

        <!-- ========================================================================= -->
        <!-- TAB 2: USE CASE 01 • ĐĂNG KÝ TÀI KHOẢN (UC01)                             -->
        <!-- Nút chọn vai trò: Khách du lịch hoặc Hướng dẫn viên.                       -->
        <!-- Ô nhập chung: Họ tên, Email, SĐT, Mật khẩu, Thông tin phụ.                -->
        <!-- Ô nhập thêm (chỉ khi chọn HDV): Số thẻ, Ngoại ngữ, Khu vực, Kinh nghiệm,  -->
        <!-- nút tải Giấy tờ đính kèm. Checkbox điều khoản. Nút Hủy (A1), Đăng ký.     -->
        <!-- ========================================================================= -->
        <section class="tab-content-panel" id="tab-register">

          <!-- Header giới thiệu UC01 -->
          <div class="card-table-wrapper gst-65">
            <div class="gst-66">
              <i data-lucide="user-plus" class="gst-36"></i> ĐĂNG KÝ TÀI KHOẢN NGƯỜI DÙNG
            </div>
            <h2 class="gst-37">
              Tạo Tài Khoản Mới: Khách Du Lịch Hoặc Hướng Dẫn Viên Bản Địa
            </h2>
            <p class="gst-38">
              Tài khoản <strong>Khách du lịch</strong> được kích hoạt và sử dụng ngay lập tức.
              Tài khoản <strong>Hướng dẫn viên</strong> sẽ chuyển sang trạng thái <em>"Chờ duyệt"</em> để Quản trị viên
              thẩm định thẻ hành nghề trước khi mở hoạt động công khai.
            </p>
          </div>

          <div class="card-table-wrapper gst-67">

            <!-- Bước 2: Chọn vai trò người dùng -->
            <div class="gst-68">
              <label class="gst-69">
                1. Bạn muốn đăng ký tài khoản với vai trò nào? <span class="gst-70">*</span>
              </label>
              <div class="gst-71">
                <!-- Option Khách du lịch -->
                <div id="roleCardCustomer" onclick="selectRegisterRole('customer')" class="gst-72">
                  <div class="gst-73">
                    <div class="gst-74">
                      <i data-lucide="user" class="gst-75"></i>
                    </div>
                    <div>
                      <h4 class="gst-76">Khách Du Lịch</h4>
                      <span class="gst-77">● Kích hoạt & sử dụng ngay</span>
                    </div>
                  </div>
                  <p class="gst-78">
                    Đặt lịch, liên hệ hướng dẫn viên bản địa, thanh toán ký quỹ an toàn và quản lý các chuyến đi.
                  </p>
                  <div id="checkIconCustomer" class="gst-79">
                    <i data-lucide="check-circle-2" class="gst-75"></i>
                  </div>
                </div>

                <!-- Option Hướng dẫn viên -->
                <div id="roleCardGuide" onclick="selectRegisterRole('guide')" class="gst-80">
                  <div class="gst-73">
                    <div class="gst-81">
                      <i data-lucide="compass" class="gst-75"></i>
                    </div>
                    <div>
                      <h4 class="gst-82">Hướng Dẫn Viên</h4>
                      <span class="gst-83">● Chờ Admin xét duyệt hồ sơ</span>
                    </div>
                  </div>
                  <p class="gst-78">
                    Tiếp cận du khách, thiết lập bảng giá, quản lý lịch làm việc và nhận thanh toán sau khi hoàn tất
                    tour.
                  </p>
                  <div id="checkIconGuide" class="gst-84">
                    <i data-lucide="check-circle-2" class="gst-75"></i>
                  </div>
                </div>
              </div>
            </div>

            <!-- Bước 3: Form nhập thông tin cá nhân & Ô nhập thêm của HDV -->
            <form id="guestRegisterForm" onsubmit="handleGuestRegisterSubmit(event)">
              <input type="hidden" id="regSelectedRole" value="customer">

              <div class="gst-85">
                <h3 class="gst-86">
                  2. Thông tin hồ sơ cá nhân:
                </h3>

                <!-- Alert Thông Báo Lỗi / Trùng Lặp chung (Luồng phụ A2) -->
                <div id="regErrorAlert" class="gst-87">
                  <div class="gst-51">
                    <i data-lucide="alert-circle" class="gst-88"></i>
                    <span id="regErrorMessage">Vui lòng kiểm tra lại thông tin nhập!</span>
                  </div>
                </div>

                <!-- Họ và tên & Số điện thoại -->
                <div class="gst-89">
                  <div>
                    <label class="gst-43">
                      Họ và tên đầy đủ <span class="gst-70">*</span>
                    </label>
                    <input type="text" id="regFullName" class="form-control" placeholder="Ví dụ: Nguyễn Văn An"
                      required>
                    <div id="regFullNameError" class="field-error-msg"></div>
                  </div>

                  <div>
                    <label class="gst-43">
                      Số điện thoại <span class="gst-70">*</span>
                    </label>
                    <input type="tel" id="regPhone" class="form-control" placeholder="10 chữ số, ví dụ: 0981234567"
                      required>
                    <div id="regPhoneError" class="field-error-msg"></div>
                  </div>
                </div>

                <!-- Địa chỉ Email & Tỉnh / Thành phố cư trú -->
                <div class="gst-89">
                  <div>
                    <label class="gst-43">
                      Địa chỉ Email <span class="gst-70">*</span>
                    </label>
                    <input type="email" id="regEmail" class="form-control" placeholder="name@domain.com" required>
                    <div id="regEmailError" class="field-error-msg"></div>
                  </div>

                  <div>
                    <label class="gst-43">
                      Tỉnh / Thành phố cư trú <span class="gst-70">*</span>
                    </label>
                    <select id="regCity" class="form-control">
                      <option value="Hà Nội">Hà Nội</option>
                      <option value="Đà Nẵng">Đà Nẵng</option>
                      <option value="Quảng Nam">Quảng Nam (Hội An)</option>
                      <option value="Thừa Thiên Huế">Thừa Thiên Huế</option>
                      <option value="Lào Cai">Lào Cai (Sapa)</option>
                      <option value="TP. Hồ Chí Minh">TP. Hồ Chí Minh</option>
                      <option value="Khánh Hòa">Khánh Hòa (Nha Trang)</option>
                      <option value="Kiên Giang">Kiên Giang (Phú Quốc)</option>
                      <option value="Lâm Đồng">Lâm Đồng (Đà Lạt)</option>
                      <option value="Ninh Bình">Ninh Bình</option>
                    </select>
                  </div>
                </div>

                <!-- Mật khẩu khởi tạo & Xác nhận mật khẩu -->
                <div class="gst-89">
                  <div>
                    <label class="gst-43">
                      Mật khẩu khởi tạo <span class="gst-70">*</span>
                    </label>
                    <input type="password" id="regPassword" class="form-control" placeholder="Tối thiểu 6 ký tự"
                      minlength="6" required>
                    <div id="regPasswordError" class="field-error-msg"></div>
                  </div>

                  <div>
                    <label class="gst-43">
                      Xác nhận lại mật khẩu <span class="gst-70">*</span>
                    </label>
                    <input type="password" id="regPasswordConfirm" class="form-control"
                      placeholder="Nhập lại mật khẩu vừa gõ" minlength="6" required>
                    <div id="regPasswordConfirmError" class="field-error-msg"></div>
                  </div>
                </div>

                <!-- Thông tin phụ (sở thích, trường học...) để đối chiếu quên mật khẩu (A4) -->
                <div class="gst-90">
                  <label class="gst-43">
                    Thông tin phụ (sở thích, trường học, phong cách du lịch) <span class="gst-70">*</span>
                  </label>
                  <textarea id="regExtraInfo" class="form-control" rows="2"
                    placeholder="Ví dụ: Đam mê ẩm thực đường phố, tốt nghiệp ĐH Du Lịch, thích chụp ảnh phố cổ..."
                    required></textarea>
                  <div id="regExtraInfoError" class="field-error-msg"></div>
                  <span class="gst-91">
                    Thông tin phụ này sẽ được sử dụng để xác minh danh tính khi bạn quên mật khẩu (Use Case 03 - Luồng
                    phụ A4).
                  </span>
                </div>

                <!-- ======================================================== -->
                <!-- Ô NHẬP THÊM (CHỈ HIỆN KHI CHỌN VAI TRÒ HƯỚNG DẪN VIÊN)   -->
                <!-- Số thẻ hành nghề, Ngoại ngữ, Khu vực, Kinh nghiệm,       -->
                <!-- nút tải Giấy tờ đính kèm.                                -->
                <!-- ======================================================== -->
                <div id="guideSpecificFields" class="gst-92">
                  <h4 class="gst-93">
                    <i data-lucide="shield-check" class="gst-9"></i> Hồ Sơ Năng Lực & Thẻ Hành Nghề Hướng Dẫn Viên (Bắt
                    buộc)
                  </h4>

                  <!-- 1. Số thẻ hành nghề & Loại thẻ -->
                  <div class="gst-94">
                    <div>
                      <label class="gst-95">
                        Số Thẻ Hành Nghề Du Lịch <span class="gst-70">*</span>
                      </label>
                      <input type="text" id="regCertNumber" class="form-control"
                        placeholder="Ví dụ: 10118/2022/TCDL-HDVQT">
                    </div>

                    <div>
                      <label class="gst-95">
                        Loại Thẻ Hành Nghề <span class="gst-70">*</span>
                      </label>
                      <select id="regCertType" class="form-control">
                        <option value="Thẻ Hướng Dẫn Viên Du Lịch Quốc Tế">Thẻ Hướng Dẫn Viên Du Lịch Quốc Tế</option>
                        <option value="Thẻ Hướng Dẫn Viên Du Lịch Nội Địa">Thẻ Hướng Dẫn Viên Du Lịch Nội Địa</option>
                        <option value="Thẻ Hướng Dẫn Viên Tại Điểm">Thẻ Hướng Dẫn Viên Tại Điểm</option>
                      </select>
                    </div>
                  </div>

                  <!-- 2. Ngoại ngữ & Khu vực -->
                  <div class="gst-94">
                    <div>
                      <label class="gst-95">
                        Ngoại ngữ thành thạo <span class="gst-70">*</span>
                      </label>
                      <input type="text" id="regLanguages" class="form-control"
                        placeholder="Ví dụ: Tiếng Việt, Tiếng Anh C1, Tiếng Pháp">
                    </div>

                    <div>
                      <label class="gst-95">
                        Khu vực hoạt động thế mạnh <span class="gst-70">*</span>
                      </label>
                      <select id="regGuideRegion" class="form-control">
                        <option value="Hà Nội & Miền Bắc">Hà Nội & Miền Bắc</option>
                        <option value="Đà Nẵng & Hội An">Đà Nẵng & Hội An (Miền Trung)</option>
                        <option value="Thừa Thiên Huế & Cố Đô">Thừa Thiên Huế & Cố Đô</option>
                        <option value="TP. Hồ Chí Minh & Miền Nam">TP. Hồ Chí Minh & Miền Nam</option>
                        <option value="Sapa & Tây Bắc">Sapa & Tây Bắc</option>
                        <option value="Đồng Bằng Sông Cửu Long">Đồng Bằng Sông Cửu Long</option>
                      </select>
                    </div>
                  </div>

                  <!-- 3. Kinh nghiệm & Mức giá đề xuất -->
                  <div class="gst-94">
                    <div>
                      <label class="gst-95">
                        Kinh nghiệm hướng dẫn <span class="gst-70">*</span>
                      </label>
                      <input type="text" id="regExperienceYears" class="form-control"
                        placeholder="Ví dụ: 5 năm kinh nghiệm dẫn đoàn quốc tế">
                    </div>

                    <div>
                      <label class="gst-95">
                        Mức giá tour đề xuất / ngày (VND)
                      </label>
                      <input type="number" id="regDailyPrice" class="form-control" value="1200000" step="50000">
                    </div>
                  </div>

                  <!-- 4. Nút tải Giấy tờ đính kèm / Ảnh thẻ -->
                  <div>
                    <label class="gst-95">
                      Tải giấy tờ đính kèm (Ảnh chụp Thẻ hành nghề du lịch) <span class="gst-70">*</span>
                    </label>
                    <input type="file" id="regCertFile" class="form-control" accept="image/*"
                      onchange="previewCertUpload(event)">
                    <div id="certPreviewContainer" class="gst-96">
                      <img id="certPreviewImg" src="" class="gst-97">
                    </div>
                  </div>
                </div>

                <!-- Bước 3: Đồng ý điều khoản dịch vụ -->
                <div class="gst-98">
                  <label class="gst-99">
                    <input type="checkbox" id="regTermsAgreed" required class="gst-100">
                    <span>
                      Tôi đã đọc và đồng ý với <strong>Điều khoản dịch vụ</strong>, <strong>Chính sách bảo vệ thông
                        tin</strong>,
                      và quy định ký quỹ đảm bảo quyền lợi của Guidia Concierge.
                    </span>
                  </label>
                </div>

                <!-- Bước 4 & Luồng phụ A1: Nhấn Đăng ký hoặc Hủy đăng ký -->
                <div class="gst-101">
                  <!-- Nút "Hủy / Thoát" (A1): Đóng form tại bước 2–4, không lưu dữ liệu -->
                  <button type="button" onclick="cancelRegistration()" class="btn-outline gst-102">
                    <i data-lucide="x" class="icon-xs"></i> Hủy / Thoát (A1)
                  </button>

                  <!-- Nút "Đăng ký": Kiểm tra hợp lệ & trùng Email/SĐT -->
                  <button type="submit" id="btnSubmitRegister" class="btn-primary gst-103">
                    <i data-lucide="check" class="icon-xs"></i> Đăng Ký
                  </button>
                </div>

              </div>
            </form>
          </div>

        </section>

        <!-- ========================================================================= -->
        <!-- TAB 3: USE CASE 03 • ĐĂNG NHẬP & QUÊN MẬT KHẨU (UC03)                    -->
        <!-- Form Đăng nhập: Email hoặc SĐT, Mật khẩu.                                 -->
        <!-- Đối chiếu: Sai (A1) -> "Thông tin không đúng"                             -->
        <!-- Bị khóa (A2) -> "Tài khoản đã bị khóa do vi phạm. Vui lòng liên hệ..."    -->
        <!-- Chờ duyệt (A3) -> "Hồ sơ hướng dẫn viên đang chờ duyệt"                   -->
        <!-- Quên mật khẩu (A4): 4 ô xác minh. Sai (A4.1) -> "Lỗi xác minh"            -->
        <!-- Đúng (A4.2) -> hiện ô nhập mật khẩu mới, cập nhật thành công.             -->
        <!-- ========================================================================= -->
        <section class="tab-content-panel" id="tab-auth">

          <!-- Header giới thiệu UC03 -->
          <div class="card-table-wrapper gst-104">
            <div class="gst-105">
              <i data-lucide="log-in" class="gst-36"></i> USE CASE 03 • ĐĂNG NHẬP & QUÊN MẬT KHẨU
            </div>
            <h2 class="gst-37">
              Xác Thực Danh Tính Người Dùng & Phục Hồi Tài Khoản
            </h2>
            <p class="gst-38">
              Đăng nhập nhanh bằng Email hoặc Số điện thoại. Hệ thống tự động phân quyền theo vai trò (Khách du lịch,
              Hướng dẫn viên, Quản trị viên)
              hoặc khôi phục mật khẩu thông qua 4 trường xác minh đối chiếu.
            </p>
          </div>

          <div class="gst-106">

            <!-- Tab con chuyển đổi Đăng Nhập vs Quên Mật Khẩu -->
            <div class="gst-107">
              <button type="button" id="subTabLoginBtn" onclick="switchAuthSubView('login')" class="gst-108">
                <i data-lucide="log-in" class="gst-26"></i> Đăng Nhập
              </button>
              <button type="button" id="subTabForgotBtn" onclick="switchAuthSubView('forgot')" class="gst-109">
                <i data-lucide="key-round" class="gst-26"></i> Quên Mật Khẩu (A4)
              </button>
            </div>

            <!-- Alert trạng thái UC03 -->
            <div id="guestLoginAlert" class="gst-110"></div>

            <!-- 1. FORM ĐĂNG NHẬP CHÍNH (UC03) -->
            <div id="subViewLogin" class="card-table-wrapper gst-111">
              <h3 class="gst-112">
                Đăng Nhập Tài Khoản
              </h3>

              <form onsubmit="handleGuestPortalLogin(event)">
                <!-- Ô nhập Email hoặc SĐT -->
                <div class="gst-113">
                  <label class="gst-114">
                    Email hoặc Số điện thoại <span class="gst-70">*</span>
                  </label>
                  <div class="gst-115">
                    <i data-lucide="user" class="gst-116"></i>
                    <input type="text" id="guestLoginUsername" class="form-control gst-117"
                      placeholder="VD: phamminhdung1@gmail.com hoặc 0980000001" required>
                  </div>
                </div>

                <!-- Ô Mật khẩu -->
                <div class="gst-90">
                  <label class="gst-114">
                    Mật khẩu <span class="gst-70">*</span>
                  </label>
                  <div class="gst-115">
                    <i data-lucide="lock" class="gst-116"></i>
                    <input type="password" id="guestLoginPassword" class="form-control gst-117"
                      placeholder="Nhập mật khẩu của bạn" required>
                  </div>
                </div>

                <!-- Ghi nhớ & Quên mật khẩu link -->
                <div class="gst-118">
                  <label class="gst-119">
                    <input type="checkbox" checked class="gst-120"> Ghi nhớ tài khoản
                  </label>
                  <a href="javascript:void(0)" onclick="switchAuthSubView('forgot')" class="gst-121">
                    Quên mật khẩu? (A4)
                  </a>
                </div>

                <!-- Nút Đăng nhập -->
                <button type="submit" class="btn-primary gst-122">
                  <i data-lucide="log-in" class="icon-xs"></i> Đăng Nhập
                </button>
              </form>

              <div class="gst-123">
                Chưa có tài khoản?
                <a href="javascript:void(0)" onclick="switchGuestTab('tab-register')" class="gst-124">
                  Đăng Ký Tài Khoản Mới (UC01)
                </a>
              </div>
            </div>

            <!-- 2. FORM QUÊN MẬT KHẨU (UC03 - Luồng phụ A4) -->
            <div id="subViewForgot" class="card-table-wrapper gst-125">
              <h3 class="gst-126">
                Khôi Phục Mật Khẩu (A4)
              </h3>
              <p class="gst-127">
                Nhập 4 thông tin xác minh hồ sơ đã đăng ký để hệ thống đối chiếu và cấp quyền đặt lại mật khẩu mới.
              </p>

              <!-- Form Bước 1: 4 ô xác minh -->
              <form id="formGuestForgotVerify" onsubmit="handleGuestForgotVerify(event)">
                <div class="gst-128">
                  <label class="gst-129">
                    1. Họ và tên đầy đủ <span class="gst-70">*</span>
                  </label>
                  <input type="text" id="guestForgotName" class="form-control" placeholder="Nhập chính xác họ tên"
                    required>
                </div>

                <div class="gst-130">
                  <div>
                    <label class="gst-129">
                      2. Số điện thoại <span class="gst-70">*</span>
                    </label>
                    <input type="tel" id="guestForgotPhone" class="form-control" placeholder="098..." required>
                  </div>

                  <div>
                    <label class="gst-129">
                      3. Địa chỉ Email <span class="gst-70">*</span>
                    </label>
                    <input type="email" id="guestForgotEmail" class="form-control" placeholder="name@domain.com"
                      required>
                  </div>
                </div>

                <div class="gst-90">
                  <label class="gst-129">
                    4. Thông tin phụ (sở thích / trường học đã lưu) <span class="gst-70">*</span>
                  </label>
                  <input type="text" id="guestForgotExtraInfo" class="form-control"
                    placeholder="VD: Ẩm thực, nhiếp ảnh, du lịch văn hóa..." required>
                </div>

                <!-- Nút "Đặt lại" -->
                <button type="submit" class="btn-primary gst-131">
                  <i data-lucide="key-round" class="icon-xs"></i> Đặt Lại Mật Khẩu
                </button>
              </form>

              <!-- Form Bước 2: Nhập mật khẩu mới (Hiện khi A4.2 đúng thông tin) -->
              <form id="formGuestForgotNewPwd" onsubmit="handleGuestSaveNewPassword(event)" class="gst-132">
                <input type="hidden" id="guestForgotUserId">

                <div class="gst-133">
                  <strong>✔ Xác minh danh tính thành công!</strong>
                  <div id="guestForgotGreeting" class="gst-134">Vui lòng thiết lập mật khẩu mới cho tài khoản.</div>
                </div>

                <div class="gst-135">
                  <label class="gst-129">
                    Mật khẩu mới (tối thiểu 6 ký tự) <span class="gst-70">*</span>
                  </label>
                  <input type="password" id="guestNewPwdInput" class="form-control" placeholder="Nhập mật khẩu mới"
                    minlength="6" required>
                </div>

                <div class="gst-90">
                  <label class="gst-129">
                    Xác nhận lại mật khẩu mới <span class="gst-70">*</span>
                  </label>
                  <input type="password" id="guestNewPwdConfirmInput" class="form-control"
                    placeholder="Gõ lại mật khẩu mới" minlength="6" required>
                </div>

                <button type="submit" class="btn-primary gst-131">
                  <i data-lucide="check" class="icon-xs"></i> Lưu Mật Khẩu Mới & Cập Nhật CSDL
                </button>
              </form>

              <div class="gst-136">
                <a href="javascript:void(0)" onclick="switchAuthSubView('login')" class="gst-137">
                  <i data-lucide="arrow-left" class="gst-53"></i> Quay lại form Đăng nhập
                </a>
              </div>
            </div>

          </div>

        </section>

        <!-- ========================================================================= -->
        <!-- TAB 4: QUY TRÌNH & KÝ QUỸ (ABOUT / WORKFLOW)                              -->
        <!-- ========================================================================= -->
        <section class="tab-content-panel" id="tab-workflow">

          <div class="card-table-wrapper gst-138">
            <h2 class="gst-139">
              Quy Trình Hoạt Động & Cơ Chế Ký Quỹ Đảm Bảo An Toàn Tuyệt Đối
            </h2>
            <p class="gst-140">
              Guidia hoạt động theo mô hình <strong>Bảo Vệ Ký Quỹ (Escrow Protection)</strong> nhằm loại bỏ hoàn toàn
              các rủi ro lừa đảo, HDV bỏ tour hoặc khách hủy giờ chót không hoàn tiền.
            </p>

            <!-- 5 Bước quy trình -->
            <div class="gst-141">
              <div class="gst-142">
                <div class="gst-143">1</div>
                <h4 class="gst-144">Tra cứu & Xem hồ sơ</h4>
                <p class="gst-145">Khách vãng lai xem thông tin, bảng giá, thẻ nghề và đánh giá hoàn toàn miễn phí.</p>
              </div>

              <div class="gst-142">
                <div class="gst-143">2</div>
                <h4 class="gst-144">Đăng ký / Đăng nhập</h4>
                <p class="gst-145">Tạo tài khoản KDL chỉ mất 30 giây để bắt đầu nhắn tin và gửi yêu cầu đặt lịch.</p>
              </div>

              <div class="gst-142">
                <div class="gst-143">3</div>
                <h4 class="gst-144">Thanh toán tạm giữ</h4>
                <p class="gst-145">100% tiền tour được hệ thống tạm giữ an toàn qua cổng Escrow. HDV chưa được nhận
                  tiền.</p>
              </div>

              <div class="gst-142">
                <div class="gst-143">4</div>
                <h4 class="gst-144">Trải nghiệm tour</h4>
                <p class="gst-145">HDV đồng hành cùng du khách theo đúng lịch trình và thỏa thuận đã cam kết.</p>
              </div>

              <div class="gst-142">
                <div class="gst-143">5</div>
                <h4 class="gst-144">Tất toán & Đánh giá</h4>
                <p class="gst-145">Khi cả 2 bên xác nhận hoàn thành, tiền mới được giải ngân trừ 10% phí sàn.</p>
              </div>
            </div>

            <!-- Bảng so sánh quyền lợi -->
            <h3 class="gst-146">
              Bảng Quyền Lợi: Khách Vãng Lai vs Khách Du Lịch Đã Đăng Ký
            </h3>
            <div class="gst-147">
              <table class="portal-table gst-148">
                <thead>
                  <tr class="gst-149">
                    <th class="gst-150">Tính năng nền tảng</th>
                    <th class="gst-151">Khách Vãng Lai</th>
                    <th class="gst-151">Khách Du Lịch (Đã đăng ký)</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td class="gst-152">Tra cứu danh sách & lọc Hướng dẫn viên (UC02)</td>
                    <td class="gst-153">✔ Đầy đủ</td>
                    <td class="gst-153">✔ Đầy đủ</td>
                  </tr>
                  <tr>
                    <td class="gst-152">Xem chi tiết hồ sơ, thẻ hành nghề & bảng giá (UC02)</td>
                    <td class="gst-153">✔ Miễn phí</td>
                    <td class="gst-153">✔ Miễn phí</td>
                  </tr>
                  <tr>
                    <td class="gst-152">Nhắn tin trực tiếp với HDV (Live Chat - UC05)</td>
                    <td class="gst-154">✖ Yêu cầu đăng nhập (A2)</td>
                    <td class="gst-153">✔ Mở khóa</td>
                  </tr>
                  <tr>
                    <td class="gst-152">Đặt lịch riêng & Ký quỹ thanh toán an toàn (UC06)</td>
                    <td class="gst-154">✖ Yêu cầu đăng nhập (A2)</td>
                    <td class="gst-153">✔ Mở khóa</td>
                  </tr>
                  <tr>
                    <td class="gst-152">Quản lý chuyến đi, hủy chuyến hoàn tiền 100% (UC07)</td>
                    <td class="gst-154">✖ Yêu cầu đăng nhập</td>
                    <td class="gst-153">✔ Mở khóa</td>
                  </tr>
                  <tr>
                    <td class="gst-152">Đánh giá dịch vụ 1–5 sao & Khiếu nại đền bù (UC08, UC10)</td>
                    <td class="gst-154">✖ Yêu cầu đăng nhập</td>
                    <td class="gst-153">✔ Mở khóa</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

        </section>

      </div>
    </main>

    <!-- ========================================================================= -->
    <!-- MODAL: HỒ SƠ CHI TIẾT HƯỚNG DẪN VIÊN (UC02 - Bước 6 & 7)                  -->
    <!-- ========================================================================= -->
    <div class="modal-overlay gst-155" id="guestGuideDetailModal">
      <div class="gst-156">

        <!-- Modal Close Button -->
        <button onclick="closeGuestGuideDetailModal()" class="gst-157">
          <i data-lucide="x" class="gst-158"></i>
        </button>

        <!-- Modal Hero Header -->
        <div class="gst-159">
          <img id="modalGuideAvatar" src="" alt="Avatar" class="gst-160">
          <div class="gst-161">
            <div class="gst-162">
              <h2 id="modalGuideName" class="gst-163">Nguyễn Văn An</h2>
              <span id="modalGuideCertBadge" class="gst-164">Thẻ Quốc Tế</span>
            </div>
            <div id="modalGuideCity" class="gst-165">
              <i data-lucide="map-pin" class="gst-26"></i> Phố Cổ Hội An & Đà Nẵng
            </div>
            <div class="gst-166">
              <span id="modalGuideRating"><i data-lucide="star" class="gst-167"></i> <strong>4.95</strong> (128 đánh
                giá)</span>
              <span><i data-lucide="clock" class="gst-26"></i> Kinh nghiệm: <strong id="modalGuideExp">6
                  năm</strong></span>
            </div>
          </div>
        </div>

        <!-- Modal Body -->
        <div class="gst-168">

          <!-- Bảng Giá & Nút Hành Động (UC02 - Bước 7 & A2) -->
          <div class="gst-169">
            <div>
              <div class="gst-170">Bảng Giá Dịch Vụ Niêm Yết</div>
              <div class="gst-171">
                <span id="modalGuideDailyPrice" class="gst-172">1.200.000 đ</span>
                <span class="gst-49">/ ngày trọn gói</span>
                <span class="gst-173">(Khoảng <strong id="modalGuideHourlyPrice">350.000 đ</strong>/giờ)</span>
              </div>
            </div>

            <!-- 2 Nút hành động kiểm tra đăng nhập (UC02 - Bước 7 & A2) -->
            <div class="gst-174">
              <button onclick="handleGuestChatAction()" class="btn-outline gst-175">
                <i data-lucide="message-square" class="icon-xs"></i> Nhắn Tin Trao Đổi
              </button>
              <button onclick="handleGuestBookAction()" class="btn-primary gst-176">
                <i data-lucide="calendar-check" class="icon-xs"></i> Đặt Lịch Tour Này
              </button>
            </div>
          </div>

          <!-- 3 Cột chi tiết: Thẻ nghề, Giới thiệu, Lịch làm việc -->
          <div class="gst-177">

            <!-- Cột 1: Thông tin pháp lý Thẻ hành nghề -->
            <div class="gst-178">
              <h4 class="gst-179">
                <i data-lucide="badge-check" class="gst-180"></i> Thẻ Hành Nghề Du Lịch Đã Xác Thực
              </h4>
              <div class="gst-181">
                <div>Số thẻ: <strong id="modalCertNumber">10118/2022/TCDL-HDVQT</strong></div>
                <div>Loại thẻ: <span id="modalCertType" class="gst-182">Thẻ Quốc Tế</span></div>
                <div>Cơ quan cấp: <strong>Tổng Cục Du Lịch Việt Nam</strong></div>
                <div>Trạng thái: <span class="gst-183">● Đã hoàn tất hồ sơ & Phê duyệt</span></div>
              </div>

              <div class="gst-184">
                <div class="gst-185">Ngoại ngữ thành thạo:</div>
                <div id="modalGuideLanguages" class="gst-186">
                  <span class="tag-pill">Tiếng Anh C2</span>
                  <span class="tag-pill">Tiếng Pháp</span>
                </div>
              </div>
            </div>

            <!-- Cột 2: Lịch rảnh / bận của HDV -->
            <div class="gst-178">
              <h4 class="gst-179">
                <i data-lucide="calendar" class="gst-180"></i> Lịch Trình Hoạt Động Tháng Này
              </h4>
              <p class="gst-187">
                HDV chủ động cập nhật lịch bận/rảnh. Những ngày có màu xanh là ngày sẵn sàng nhận tour.
              </p>
              <div id="modalGuideScheduleBox" class="gst-188">
                <!-- Dynamic schedule pills -->
              </div>
            </div>
          </div>

          <!-- Giới thiệu bản thân & Tuyến tour thế mạnh -->
          <div class="gst-189">
            <h4 class="gst-190">Giới Thiệu & Triết Lý Dẫn Tour</h4>
            <p id="modalGuideBio" class="gst-191">
              Sinh ra và lớn lên tại phố cổ Hội An trong gia đình 4 đời làm nghề thủ công truyền thống...
            </p>
            <div class="gst-192">
              <strong>Tuyến tour thế mạnh:</strong> <span id="modalGuideSpecialties">Hội An Di Sản, Thánh Địa Mỹ Sơn,
                Chợ Đêm & Ẩm Thực Phố Hội</span>
            </div>
          </div>

          <!-- Đánh giá thực tế từ Khách du lịch trước đó -->
          <div class="gst-178">
            <h4 class="gst-193">
              <span>Đánh Giá Từ Khách Du Lịch Thực Tế</span>
              <span class="gst-194" id="modalReviewCountBadge">128 nhận xét</span>
            </h4>

            <div id="modalGuideReviewsList" class="gst-195">
              <!-- Render sample real reviews -->
            </div>
          </div>

        </div>

        <!-- Modal Footer -->
        <div class="gst-196">
          <span class="gst-197">
            <i data-lucide="info" class="gst-53"></i> Nhấn "Đặt lịch" hoặc "Nhắn tin" sẽ đưa bạn tới bước đăng nhập nếu
            chưa có phiên làm việc.
          </span>
          <button onclick="closeGuestGuideDetailModal()" class="btn-outline gst-198">
            Đóng
          </button>
        </div>

      </div>
    </div>

    <!-- ========================================================================= -->
    <!-- MODAL: YÊU CẦU ĐĂNG NHẬP (UC02 - Luồng phụ A2)                            -->
    <!-- ========================================================================= -->
    <div class="modal-overlay gst-199" id="guestAuthPromptModal">
      <div class="gst-200">
        <div class="gst-201">
          <i data-lucide="lock" class="gst-202"></i>
        </div>
        <h3 class="gst-203">Yêu Cầu Đăng Nhập Tài Khoản</h3>
        <p id="guestAuthPromptMsg" class="gst-204">
          Bạn đang xem với tư cách <strong>Khách vãng lai</strong>. Chức năng này yêu cầu đăng nhập tài khoản Khách du
          lịch để đảm bảo tính bảo mật và ký quỹ an toàn.
        </p>

        <div class="gst-205">
          <button onclick="proceedToLoginFromPrompt()" class="btn-primary gst-206">
            <i data-lucide="log-in" class="icon-xs"></i> Đăng Nhập Ngay & Quay Lại HDV Này
          </button>
          <button onclick="switchGuestTab('tab-register'); closeAuthPromptModal();" class="btn-outline gst-207">
            <i data-lucide="user-plus" class="icon-xs"></i> Chưa có tài khoản? Đăng Ký Mới (UC01)
          </button>
          <button onclick="closeAuthPromptModal()" class="btn-ghost gst-208">
            Để sau, tôi muốn tiếp tục xem hồ sơ
          </button>
        </div>
      </div>
    </div>

    <!-- Toast Notification Container -->
    <div id="portalToast" class="gst-209">
      <i id="portalToastIcon" data-lucide="check-circle" class="gst-158"></i>
      <span id="portalToastMsg">Thông báo</span>
    </div>

    <!-- ========================================================================= -->
    <!-- JAVASCRIPT LOGIC CHO KHÁCH VÃNG LAI (UC01, UC02, UC03)                    -->
    <!-- ========================================================================= -->
    <script src="js/store.js"></script>
    <script>
      // Trạng thái cục bộ của giao diện Khách vãng lai
      let currentActiveGuideDetail = null;
      let pendingActionType = 'book'; // 'book' hoặc 'chat'

      // ==========================================
      // 1. KHỞI TẠO & CHUYỂN TAB TRONG PORTAL
      // ==========================================
      document.addEventListener('DOMContentLoaded', async function () {
        // Tự động đồng bộ với CSDL SQL Server nếu có kết nối
        if (window.guidiaStore && window.guidiaStore.syncWithDatabase) {
          try { await window.guidiaStore.syncWithDatabase(); } catch (e) { }
        }

        // Khởi tạo icons Lucide
        if (window.lucide) window.lucide.createIcons();

        // Kiểm tra URL hash (ví dụ: guest.jsp#register hoặc #auth)
        const hash = window.location.hash.replace('#', '');
        if (hash === 'register') {
          switchGuestTab('tab-register');
        } else if (hash === 'auth' || hash === 'login') {
          switchGuestTab('tab-auth');
        } else if (hash === 'workflow') {
          switchGuestTab('tab-workflow');
        } else {
          switchGuestTab('tab-search');
        }

        // Đăng ký sự kiện click các tab sidebar
        const navLinks = document.querySelectorAll('.portal-sidebar .nav-link-item');
        navLinks.forEach(link => {
          link.addEventListener('click', function (e) {
            e.preventDefault();
            const targetTab = this.getAttribute('data-tab');
            if (targetTab) switchGuestTab(targetTab);
          });
        });

        // Tải danh sách Hướng dẫn viên cho Tab 1 (UC02)
        renderGuestGuidesGrid();
      });

      function switchGuestTab(tabId) {
        // Ẩn tất cả panels
        document.querySelectorAll('.tab-content-panel').forEach(panel => {
          panel.classList.remove('active');
          panel.style.display = 'none';
        });

        // Bỏ active sidebar
        document.querySelectorAll('.portal-sidebar .nav-link-item').forEach(link => {
          link.classList.remove('active');
        });

        // Kích hoạt panel được chọn
        const targetPanel = document.getElementById(tabId);
        if (targetPanel) {
          targetPanel.classList.add('active');
          targetPanel.style.display = 'block';
        }

        // Kích hoạt link tương ứng
        const activeLink = document.querySelector(`.portal-sidebar .nav-link-item[data-tab="${tabId}"]`);
        if (activeLink) activeLink.classList.add('active');

        // Cập nhật tiêu đề Topbar
        const titleEl = document.getElementById('guestPageTitle');
        if (titleEl) {
          if (tabId === 'tab-search') titleEl.textContent = 'Tra Cứu Hướng Dẫn Viên Du Lịch Bản Địa ';
          if (tabId === 'tab-register') titleEl.textContent = 'Đăng Ký Tài Khoản Người Dùng Mới ';
          if (tabId === 'tab-auth') titleEl.textContent = 'Đăng Nhập & Quên Mật Khẩu Hệ Thống ';
          if (tabId === 'tab-workflow') titleEl.textContent = 'Quy Trình Dịch Vụ & Cơ Chế Ký Quỹ Đảm Bảo';
        }

        if (window.lucide) window.lucide.createIcons();
        window.scrollTo({ top: 0, behavior: 'smooth' });
      }

      // Chuyển nhanh giữa 4 phân hệ
      function switchPortalRole(role) {
        if (role === 'customer') window.location.href = 'customer.jsp';
        else if (role === 'guide') window.location.href = 'guide.jsp';
        else if (role === 'admin') window.location.href = 'admin.jsp';
        else if (role === 'guest') window.location.href = 'guest.jsp';
      }

      // ==========================================
      // 2. USE CASE 02: TRA CỨU HƯỚNG DẪN VIÊN
      // Điều kiện: CHỈ HIỂN THỊ HDV ĐÃ DUYỆT THẺ & HOÀN TẤT HỒ SƠ
      // ==========================================
      function renderGuestGuidesGrid() {
        const store = window.guidiaStore;
        if (!store) return;

        // Tuyệt đối không hiển thị người đang chờ duyệt thẻ hoặc chưa xong hồ sơ
        const guides = store.getApprovedGuides ? store.getApprovedGuides() : (store.getGuides() || []).filter(g => (g.certStatus === 'approved' || g.dbCertStatus === 'APPROVED') && g.status === 'active');

        const keyword = (document.getElementById('guestSearchKeyword')?.value || '').toLowerCase().trim();
        const region = document.getElementById('guestFilterRegion')?.value || 'all';
        const priceFilter = document.getElementById('guestFilterPrice')?.value || 'all';
        const langFilter = document.getElementById('guestFilterLanguage')?.value || 'all';
        const dateFilter = document.getElementById('guestFilterDate')?.value || '';
        const sortBy = document.getElementById('guestSortBy')?.value || 'rating_desc';

        // Lọc danh sách HDV
        let filtered = guides.filter(g => {
          // 1. Lọc theo từ khóa
          if (keyword) {
            const matchName = (g.name || '').toLowerCase().includes(keyword);
            const matchCity = (g.city || '').toLowerCase().includes(keyword);
            const matchBio = (g.bio || '').toLowerCase().includes(keyword);
            const matchSpec = (g.specialties || '').toLowerCase().includes(keyword);
            if (!matchName && !matchCity && !matchBio && !matchSpec) return false;
          }

          // 2. Lọc theo vùng miền
          if (region !== 'all') {
            if (region === 'north' && !['Hà Nội', 'Sapa', 'Lào Cai', 'Ninh Bình', 'Hải Phòng', 'Miền Bắc'].some(c => (g.city || g.region || '').includes(c))) return false;
            if (region === 'central' && !['Đà Nẵng', 'Hội An', 'Quảng Nam', 'Huế', 'Nha Trang', 'Khánh Hòa', 'Đà Lạt', 'Miền Trung'].some(c => (g.city || g.region || '').includes(c))) return false;
            if (region === 'south' && !['Hồ Chí Minh', 'TP.HCM', 'Cần Thơ', 'Phú Quốc', 'Kiên Giang', 'Miền Tây', 'Miền Nam'].some(c => (g.city || g.region || '').includes(c))) return false;
          }

          // 3. Lọc theo mức giá
          const price = g.dailyPrice || 1200000;
          if (priceFilter === 'under_1m' && price >= 1000000) return false;
          if (priceFilter === '1m_to_2m' && (price < 1000000 || price > 2000000)) return false;
          if (priceFilter === 'over_2m' && price <= 2000000) return false;

          // 4. Lọc theo ngoại ngữ
          if (langFilter !== 'all') {
            const langStr = g.languages || '';
            if (!langStr.toLowerCase().includes(langFilter.toLowerCase())) return false;
          }

          // 5. Lọc theo ngày cần đi (kiểm tra lịch rảnh)
          if (dateFilter && Array.isArray(g.blockedDates)) {
            if (g.blockedDates.includes(dateFilter)) return false;
          }

          return true;
        });

        // Sắp xếp kết quả (UC02 - Bước 4)
        if (sortBy === 'rating_desc') {
          filtered.sort((a, b) => (b.rating || 5.0) - (a.rating || 5.0));
        } else if (sortBy === 'price_asc') {
          filtered.sort((a, b) => (a.dailyPrice || 1200000) - (b.dailyPrice || 1200000));
        } else if (sortBy === 'price_desc') {
          filtered.sort((a, b) => (b.dailyPrice || 1200000) - (a.dailyPrice || 1200000));
        } else if (sortBy === 'reviews_desc') {
          filtered.sort((a, b) => (b.reviewCount || 0) - (a.reviewCount || 0));
        }

        // Cập nhật số lượng
        const countEl = document.getElementById('guestSearchCount');
        if (countEl) countEl.textContent = filtered.length;

        const gridEl = document.getElementById('guestGuidesGrid');
        const emptyEl = document.getElementById('guestSearchEmpty');

        // Luồng phụ A1: Không có kết quả -> hiển thị thông báo và gợi ý nới lỏng bộ lọc
        if (filtered.length === 0) {
          if (gridEl) gridEl.innerHTML = '';
          if (emptyEl) emptyEl.style.display = 'block';
          return;
        }

        if (emptyEl) emptyEl.style.display = 'none';

        // Render danh sách Card HDV đã duyệt (UC02 - Bước 2 & 4)
        gridEl.innerHTML = filtered.map(g => {
          const ratingVal = (g.rating || 5.0).toFixed(1);
          const reviewCnt = g.reviewCount || 20;
          const dailyPriceFmt = (g.dailyPrice || 1200000).toLocaleString('vi-VN');
          const certBadge = g.certType?.includes('Quốc Tế') ? 'Thẻ Quốc Tế' : 'Thẻ Nội Địa';
          const certBg = g.certType?.includes('Quốc Tế')
            ? 'background:#ecfdf5; color:#065f46; border:1px solid #a7f3d0;'
            : 'background:#eff6ff; color:#1e40af; border:1px solid #bfdbfe;';

          const langs = (g.languages || 'Tiếng Việt, Tiếng Anh').split(',').map(l => `<span class="gst-210">${l.trim()}</span>`).join('');

          return `
          <div class="card-table-wrapper gst-211">
            <!-- Ảnh đại diện & Badge thẻ đã duyệt -->
            <div class="gst-212">
              <img src="${g.avatar || 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500'}" alt="${g.name}" class="gst-213" onerror="this.src='https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500'">
              <span style="position:absolute; top:12px; left:12px; font-size:0.75rem; font-weight:700; padding:3px 10px; border-radius:999px; ${certBg}">
                <i data-lucide="shield-check" class="gst-214"></i> ${certBadge}
              </span>
              <span class="gst-215">
                ★ ${ratingVal} (${reviewCnt})
              </span>
            </div>

            <!-- Nội dung tóm tắt HDV -->
            <div class="gst-216">
              <div class="gst-217">
                <i data-lucide="map-pin" class="gst-36"></i> ${g.city || 'Việt Nam'}
              </div>
              <h3 class="gst-218">
                ${g.name}
              </h3>
              <p class="gst-219">
                ${g.experienceYears || '5 năm kinh nghiệm'} • ${g.certType || 'HDV Bản Địa'}
              </p>
              <p class="gst-220">
                ${g.bio || 'Hướng dẫn viên am hiểu sâu sắc về văn hóa, lịch sử và ẩm thực bản địa.'}
              </p>

              <!-- Ngôn ngữ thành thạo -->
              <div class="gst-221">
                ${langs}
              </div>

              <!-- Giá niêm yết -->
              <div class="gst-222">
                <span class="gst-223">Giá trọn gói:</span>
                <div>
                  <span class="gst-224">${dailyPriceFmt} đ</span>
                  <span class="gst-223">/ ngày</span>
                </div>
              </div>
            </div>

            <!-- Nút Xem Hồ Sơ & Đặt Lịch -->
            <div class="gst-225">
              <button onclick="openGuestGuideDetailModal('${g.id}')" class="btn-outline gst-226">
                <i data-lucide="user" class="icon-xs"></i> Xem Hồ Sơ
              </button>
              <button onclick="triggerGuestBook('${g.id}')" class="btn-primary gst-227">
                <i data-lucide="calendar-check" class="icon-xs"></i> Đặt Lịch
              </button>
            </div>
          </div>
        `;
        }).join('');

        if (window.lucide) window.lucide.createIcons();
      }

      function handleGuestSearch(e) {
        if (e) e.preventDefault();
        renderGuestGuidesGrid();
      }

      function resetGuestFilters() {
        const kw = document.getElementById('guestSearchKeyword');
        const reg = document.getElementById('guestFilterRegion');
        const prc = document.getElementById('guestFilterPrice');
        const lng = document.getElementById('guestFilterLanguage');
        const dt = document.getElementById('guestFilterDate');
        const srt = document.getElementById('guestSortBy');

        if (kw) kw.value = '';
        if (reg) reg.value = 'all';
        if (prc) prc.value = 'all';
        if (lng) lng.value = 'all';
        if (dt) dt.value = '';
        if (srt) srt.value = 'rating_desc';

        renderGuestGuidesGrid();
        showToast('Đã đặt lại toàn bộ bộ lọc và hiển thị tất cả HDV đã duyệt!', 'info');
      }

      function quickFilterCity(cityName) {
        const kw = document.getElementById('guestSearchKeyword');
        if (kw) {
          kw.value = (cityName === 'all') ? '' : cityName;
          renderGuestGuidesGrid();
        }
      }

      // ==========================================
      // 3. XEM CHI TIẾT HỒ SƠ HDV (UC02 - Bước 5 & 6)
      // Giới thiệu, thẻ hành nghề, kinh nghiệm, bảng giá, lịch rảnh, đánh giá
      // ==========================================
      function openGuestGuideDetailModal(guideId) {
        const store = window.guidiaStore;
        if (!store) return;

        const guide = store.getGuides().find(g => String(g.id) === String(guideId));
        if (!guide) {
          showToast('Không tìm thấy thông tin hướng dẫn viên!', 'error');
          return;
        }

        currentActiveGuideDetail = guide;

        // Đổ dữ liệu vào Modal
        document.getElementById('modalGuideAvatar').src = guide.avatar || 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500';
        document.getElementById('modalGuideName').textContent = guide.name;
        document.getElementById('modalGuideCity').innerHTML = `<i data-lucide="map-pin" class="gst-26"></i> Tuyến hoạt động: <strong>${guide.city || 'Việt Nam'}</strong>`;

        const rating = (guide.rating || 5.0).toFixed(1);
        const reviews = guide.reviewCount || 20;
        document.getElementById('modalGuideRating').innerHTML = `<i data-lucide="star" class="gst-167"></i> <strong>${rating}</strong> (${reviews} đánh giá)`;
        document.getElementById('modalGuideExp').textContent = guide.experienceYears || '5 năm';

        const certBadgeEl = document.getElementById('modalGuideCertBadge');
        if (certBadgeEl) {
          certBadgeEl.textContent = guide.certType?.includes('Quốc Tế') ? 'Thẻ Hướng Dẫn Viên Quốc Tế' : 'Thẻ Hướng Dẫn Viên Nội Địa';
        }

        document.getElementById('modalGuideDailyPrice').textContent = (guide.dailyPrice || 1200000).toLocaleString('vi-VN') + ' đ';
        document.getElementById('modalGuideHourlyPrice').textContent = (guide.hourlyPrice || 350000).toLocaleString('vi-VN') + ' đ';

        document.getElementById('modalCertNumber').textContent = guide.certNumber || '10118/2022/TCDL-HDVQT';
        document.getElementById('modalCertType').textContent = guide.certType || 'Thẻ Hướng Dẫn Viên Quốc Tế';

        // Ngôn ngữ
        const langsEl = document.getElementById('modalGuideLanguages');
        if (langsEl) {
          langsEl.innerHTML = (guide.languages || 'Tiếng Việt, Tiếng Anh').split(',').map(l => `<span class="tag-pill">${l.trim()}</span>`).join('');
        }

        // Giới thiệu & Thế mạnh
        document.getElementById('modalGuideBio').textContent = guide.bio || 'Hướng dẫn viên am hiểu sâu sắc về lịch sử, văn hóa và ẩm thực bản địa.';
        document.getElementById('modalGuideSpecialties').textContent = guide.specialties || `Tuyến tour ${guide.city} và các di tích văn hóa lịch sử lân cận.`;

        // Lịch làm việc
        const schedBox = document.getElementById('modalGuideScheduleBox');
        if (schedBox) {
          const today = new Date();
          const pills = [];
          for (let i = 1; i <= 6; i++) {
            const d = new Date(today);
            d.setDate(today.getDate() + i);
            const dStr = d.toISOString().slice(0, 10);
            const isBlocked = Array.isArray(guide.blockedDates) && guide.blockedDates.includes(dStr);
            const colorBg = isBlocked ? '#fee2e2' : '#ecfdf5';
            const colorText = isBlocked ? '#b91c1c' : '#047857';
            const label = isBlocked ? 'Bận' : 'Rảnh';
            pills.push(`
            <span style="font-size:0.75rem; background:${colorBg}; color:${colorText}; padding:3px 8px; border-radius:6px; font-weight:700;">
              ${d.getDate()}/${d.getMonth() + 1}: ${label}
            </span>
          `);
          }
          schedBox.innerHTML = pills.join('');
        }

        // Đánh giá từ khách du lịch
        const reviewList = document.getElementById('modalGuideReviewsList');
        if (reviewList) {
          reviewList.innerHTML = `
          <div class="gst-228">
            <div class="gst-229">
              <span class="gst-230">Trần Hoàng Nam • Du khách Hà Nội</span>
              <span class="gst-231">★★★★★</span>
            </div>
            <p class="gst-232">
              HDV cực kỳ am hiểu văn hóa và các ngóc ngách ẩm thực truyền thống. Cả gia đình tôi rất hài lòng!
            </p>
            <div class="gst-233">Đã trải nghiệm tour • Đánh giá đã xác thực</div>
          </div>
          <div class="gst-228">
            <div class="gst-229">
              <span class="gst-230">Jessica Miller • Du khách Australia</span>
              <span class="gst-231">★★★★★</span>
            </div>
            <p class="gst-232">
              Excellent English fluency, great historical storytelling and very punctual! Highly recommended.
            </p>
            <div class="gst-233">Đã trải nghiệm tour • Đánh giá đã xác thực</div>
          </div>
        `;
        }

        // Mở modal
        const modal = document.getElementById('guestGuideDetailModal');
        if (modal) {
          modal.style.display = 'flex';
          if (window.lucide) window.lucide.createIcons();
        }
      }

      function closeGuestGuideDetailModal() {
        const modal = document.getElementById('guestGuideDetailModal');
        if (modal) modal.style.display = 'none';
        currentActiveGuideDetail = null;
      }

      // ==========================================
      // 4. KIỂM TRA ĐĂNG NHẬP KHI BẤM CHAT / ĐẶT LỊCH (UC02 - Luồng phụ A2)
      // ==========================================
      function triggerGuestBook(guideId) {
        openGuestGuideDetailModal(guideId);
        setTimeout(() => {
          handleGuestBookAction();
        }, 250);
      }

      function handleGuestChatAction() {
        pendingActionType = 'chat';
        promptGuestLogin('nhắn tin trực tiếp với HDV');
      }

      function handleGuestBookAction() {
        pendingActionType = 'book';
        promptGuestLogin('đặt lịch riêng và thanh toán ký quỹ an toàn');
      }

      function promptGuestLogin(actionDescription) {
        // Kiểm tra xem hiện tại đã có phiên đăng nhập chưa
        const curUserStr = sessionStorage.getItem('guidia_current_user') || localStorage.getItem('guidia_current_user');
        if (curUserStr) {
          // Đã đăng nhập -> Cho phép tiếp tục sang customer.jsp
          if (currentActiveGuideDetail) {
            if (pendingActionType === 'chat') {
              window.location.href = `customer.jsp#chat`;
            } else {
              window.location.href = `customer.jsp#bookings`;
            }
          }
          return;
        }

        // Chưa đăng nhập (Luồng phụ A2 - Bước 7 UC02)
        const promptModal = document.getElementById('guestAuthPromptModal');
        const msgEl = document.getElementById('guestAuthPromptMsg');
        if (msgEl) {
          msgEl.innerHTML = `
          Bạn đang xem với tư cách <strong>Khách vãng lai</strong>. Chức năng <strong>${actionDescription}</strong> 
          yêu cầu đăng nhập tài khoản Khách du lịch để đảm bảo tính an toàn giao dịch và lưu trữ lịch sử chuyến đi.
        `;
        }

        if (promptModal) {
          promptModal.style.display = 'flex';
          if (window.lucide) window.lucide.createIcons();
        }
      }

      function closeAuthPromptModal() {
        const promptModal = document.getElementById('guestAuthPromptModal');
        if (promptModal) promptModal.style.display = 'none';
      }

      function proceedToLoginFromPrompt() {
        // Lưu lại thông tin HDV đang xem và đường dẫn chuyển hướng sau khi đăng nhập (A2 - UC02)
        if (currentActiveGuideDetail) {
          sessionStorage.setItem('pending_guide_id', currentActiveGuideDetail.id);
          sessionStorage.setItem('pending_guide_name', currentActiveGuideDetail.name);
          sessionStorage.setItem('customer_pending_redirect', pendingActionType === 'chat' ? 'customer.jsp#chat' : 'customer.jsp#bookings');
        }

        showToast('Đang chuyển sang trang Đăng nhập...', 'info');
        setTimeout(() => {
          switchGuestTab('tab-auth');
          closeAuthPromptModal();
        }, 350);
      }

      // ==========================================
      // 5. USE CASE 01: ĐĂNG KÝ TÀI KHOẢN (UC01)
      // ==========================================
      function selectRegisterRole(role) {
        const selectedInput = document.getElementById('regSelectedRole');
        const cardCustomer = document.getElementById('roleCardCustomer');
        const cardGuide = document.getElementById('roleCardGuide');
        const checkCust = document.getElementById('checkIconCustomer');
        const checkGuide = document.getElementById('checkIconGuide');
        const guideFields = document.getElementById('guideSpecificFields');

        if (selectedInput) selectedInput.value = role;

        if (role === 'customer') {
          if (cardCustomer) {
            cardCustomer.style.borderColor = '#059669';
            cardCustomer.style.background = '#ecfdf5';
          }
          if (cardGuide) {
            cardGuide.style.borderColor = '#e2e8f0';
            cardGuide.style.background = '#ffffff';
          }
          if (checkCust) checkCust.style.display = 'block';
          if (checkGuide) checkGuide.style.display = 'none';
          if (guideFields) guideFields.style.display = 'none';
        } else {
          if (cardCustomer) {
            cardCustomer.style.borderColor = '#e2e8f0';
            cardCustomer.style.background = '#ffffff';
          }
          if (cardGuide) {
            cardGuide.style.borderColor = '#d97706';
            cardGuide.style.background = '#fffbeb';
          }
          if (checkCust) checkCust.style.display = 'none';
          if (checkGuide) checkGuide.style.display = 'block';
          if (guideFields) {
            guideFields.style.display = 'block';
            if (window.lucide) window.lucide.createIcons();
          }
        }
      }

      let uploadedCertImageData = null;
      function previewCertUpload(e) {
        const file = e.target.files[0];
        if (file) {
          const reader = new FileReader();
          reader.onload = function (evt) {
            uploadedCertImageData = evt.target.result;
            const container = document.getElementById('certPreviewContainer');
            const img = document.getElementById('certPreviewImg');
            if (container && img) {
              img.src = evt.target.result;
              container.style.display = 'block';
            }
          };
          reader.readAsDataURL(file);
        }
      }

      // Luồng phụ A1: Hủy đăng ký - Đóng form tại bước 2-4, không lưu dữ liệu
      function cancelRegistration() {
        const form = document.getElementById('guestRegisterForm');
        if (form) form.reset();

        const errBox = document.getElementById('regErrorAlert');
        if (errBox) errBox.style.display = 'none';

        clearRegistrationErrors();
        uploadedCertImageData = null;
        const certPreview = document.getElementById('certPreviewContainer');
        if (certPreview) certPreview.style.display = 'none';

        selectRegisterRole('customer');
        showToast('Đã hủy thao tác đăng ký và xóa trắng biểu mẫu.', 'info');
        switchGuestTab('tab-search');
      }

      function clearRegistrationErrors() {
        const fields = ['regFullName', 'regPhone', 'regEmail', 'regPassword', 'regPasswordConfirm', 'regExtraInfo'];
        fields.forEach(id => {
          const el = document.getElementById(id);
          const err = document.getElementById(id + 'Error');
          if (el) el.classList.remove('input-has-error');
          if (err) {
            err.style.display = 'none';
            err.textContent = '';
          }
        });
      }

      function highlightRegistrationError(fieldId, errorMsg) {
        const el = document.getElementById(fieldId);
        const err = document.getElementById(fieldId + 'Error');
        if (el) {
          el.classList.add('input-has-error');
          el.scrollIntoView({ behavior: 'smooth', block: 'center' });
          el.focus();
        }
        if (err) {
          err.textContent = errorMsg;
          err.style.display = 'block';
        }
      }

      // Luồng chính UC01: Bước 4, 5, 6, 7 & Luồng phụ A2
      function handleGuestRegisterSubmit(e) {
        e.preventDefault();
        clearRegistrationErrors();

        const store = window.guidiaStore;
        if (!store) return;

        const role = document.getElementById('regSelectedRole')?.value || 'customer';
        const fullName = (document.getElementById('regFullName')?.value || '').trim();
        const phone = (document.getElementById('regPhone')?.value || '').trim();
        const email = (document.getElementById('regEmail')?.value || '').trim();
        const city = document.getElementById('regCity')?.value || 'Hà Nội';
        const password = document.getElementById('regPassword')?.value || '';
        const passwordConfirm = document.getElementById('regPasswordConfirm')?.value || '';
        const extraInfo = (document.getElementById('regExtraInfo')?.value || '').trim();
        const termsAgreed = document.getElementById('regTermsAgreed')?.checked;

        const errBox = document.getElementById('regErrorAlert');
        const errMsg = document.getElementById('regErrorMessage');

        const showErrorBanner = (msg) => {
          if (errBox && errMsg) {
            errMsg.textContent = msg;
            errBox.style.display = 'block';
            errBox.scrollIntoView({ behavior: 'smooth', block: 'center' });
          }
          showToast(msg, 'error');
        };

        // 5. Kiểm tra tính hợp lệ dữ liệu (Bước 5 & Luồng phụ A2)
        if (!fullName) {
          highlightRegistrationError('regFullName', 'Vui lòng nhập họ và tên đầy đủ!');
          return showErrorBanner('Vui lòng nhập họ và tên đầy đủ!');
        }
        if (!phone || phone.replace(/\D/g, '').length < 10) {
          highlightRegistrationError('regPhone', 'Số điện thoại không hợp lệ (phải có ít nhất 10 số)!');
          return showErrorBanner('Số điện thoại không hợp lệ (phải có ít nhất 10 số)!');
        }
        if (!email || !email.includes('@')) {
          highlightRegistrationError('regEmail', 'Địa chỉ Email không đúng định dạng!');
          return showErrorBanner('Địa chỉ Email không đúng định dạng!');
        }
        if (password.length < 6) {
          highlightRegistrationError('regPassword', 'Mật khẩu phải có tối thiểu 6 ký tự!');
          return showErrorBanner('Mật khẩu phải có tối thiểu 6 ký tự!');
        }
        if (password !== passwordConfirm) {
          highlightRegistrationError('regPasswordConfirm', 'Mật khẩu xác nhận không khớp!');
          return showErrorBanner('Mật khẩu xác nhận không khớp với mật khẩu đã nhập!');
        }
        if (!extraInfo) {
          highlightRegistrationError('regExtraInfo', 'Vui lòng nhập thông tin phụ để phục vụ xác minh quên mật khẩu!');
          return showErrorBanner('Vui lòng nhập thông tin phụ (sở thích / trường học) để phục vụ khôi phục tài khoản!');
        }
        if (!termsAgreed) {
          return showErrorBanner('Bạn cần đồng ý với Điều khoản dịch vụ và Chính sách bảo mật!');
        }

        if (errBox) errBox.style.display = 'none';

        // 6. Thực hiện đăng ký tài khoản (Bước 6)
        if (role === 'customer') {
          const res = store.registerCustomer({
            name: fullName,
            phone: phone,
            email: email,
            password: password,
            extraInfo: extraInfo
          });

          // Xử lý luồng phụ A2: Dữ liệu không hợp lệ hoặc trùng lặp Email/SĐT
          if (!res.success) {
            if (res.code === 'A2_DUPLICATE_EMAIL') {
              highlightRegistrationError('regEmail', res.message);
            } else if (res.code === 'A2_DUPLICATE_PHONE') {
              highlightRegistrationError('regPhone', res.message);
            }
            return showErrorBanner(res.message);
          }

          // 7. Hệ thống kích hoạt tài khoản và thông báo đăng ký thành công (Bước 7)
          showToast('Đăng ký tài khoản Khách du lịch thành công! Đang chuyển hướng...', 'success');
          setTimeout(() => {
            // KDL sử dụng được ngay -> Chuyển sang customer.jsp
            window.location.href = 'customer.jsp';
          }, 1200);

        } else {
          // Vai trò Hướng Dẫn Viên
          const certNumber = (document.getElementById('regCertNumber')?.value || '').trim();
          const certType = document.getElementById('regCertType')?.value || 'Thẻ Hướng Dẫn Viên Du Lịch Nội Địa';
          const languages = (document.getElementById('regLanguages')?.value || '').trim();
          const guideRegion = document.getElementById('regGuideRegion')?.value || city;
          const experienceYears = (document.getElementById('regExperienceYears')?.value || '').trim();
          const dailyPrice = parseInt(document.getElementById('regDailyPrice')?.value) || 1200000;

          if (!certNumber) {
            return showErrorBanner('Hướng dẫn viên bắt buộc phải cung cấp Số thẻ hành nghề du lịch!');
          }

          const res = store.registerGuide({
            name: fullName,
            phone: phone,
            email: email,
            password: password,
            extraInfo: extraInfo,
            city: guideRegion.split('&')[0].trim() || city,
            certType: certType,
            certNumber: certNumber,
            certImage: uploadedCertImageData || 'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=600',
            specialties: `${languages || 'Tiếng Việt'} - Khu vực: ${guideRegion} - ${experienceYears || 'Kinh nghiệm bản địa'}`
          });

          // Xử lý luồng phụ A2: Dữ liệu không hợp lệ hoặc trùng lặp Email/SĐT
          if (!res.success) {
            if (res.code === 'A2_DUPLICATE_EMAIL') {
              highlightRegistrationError('regEmail', res.message);
            } else if (res.code === 'A2_DUPLICATE_PHONE') {
              highlightRegistrationError('regPhone', res.message);
            }
            return showErrorBanner(res.message);
          }

          // 7. Với vai trò HDV, hồ sơ chuyển sang "Chờ duyệt" để QTV xét duyệt (Bước 7)
          showToast('Đăng ký thành công! Hồ sơ HDV đã chuyển sang "Chờ duyệt" để QTV xét duyệt.', 'success');

          setTimeout(() => {
            alert('Chúc mừng bạn đã hoàn tất đăng ký tài khoản Hướng Dẫn Viên!\n\nHồ sơ thẻ hành nghề của bạn đã được chuyển sang trạng thái "Chờ duyệt" để Quản trị viên thẩm định thẻ hành nghề ở Use Case 13.\n\nSau khi được duyệt, hồ sơ của bạn mới bắt đầu hiển thị công khai.');
            switchGuestTab('tab-auth');
          }, 1200);
        }
      }

      // ==========================================
      // 6. USE CASE 03: ĐĂNG NHẬP & QUÊN MẬT KHẨU (UC03)
      // ==========================================
      function switchAuthSubView(mode) {
        const subLogin = document.getElementById('subViewLogin');
        const subForgot = document.getElementById('subViewForgot');
        const btnLog = document.getElementById('subTabLoginBtn');
        const btnForg = document.getElementById('subTabForgotBtn');
        const alertBox = document.getElementById('guestLoginAlert');

        if (alertBox) alertBox.style.display = 'none';

        if (mode === 'login') {
          if (subLogin) subLogin.style.display = 'block';
          if (subForgot) subForgot.style.display = 'none';
          if (btnLog) {
            btnLog.style.background = '#ffffff';
            btnLog.style.color = '#0f172a';
            btnLog.style.boxShadow = '0 1px 3px rgba(0,0,0,0.08)';
          }
          if (btnForg) {
            btnForg.style.background = 'transparent';
            btnForg.style.color = '#64748b';
            btnForg.style.boxShadow = 'none';
          }
        } else {
          if (subLogin) subLogin.style.display = 'none';
          if (subForgot) subForgot.style.display = 'block';
          if (btnForg) {
            btnForg.style.background = '#ffffff';
            btnForg.style.color = '#0f172a';
            btnForg.style.boxShadow = '0 1px 3px rgba(0,0,0,0.08)';
          }
          if (btnLog) {
            btnLog.style.background = 'transparent';
            btnLog.style.color = '#64748b';
            btnLog.style.boxShadow = 'none';
          }
        }
        if (window.lucide) window.lucide.createIcons();
      }

      function showGuestLoginAlert(msg, type = 'error') {
        const alertBox = document.getElementById('guestLoginAlert');
        if (!alertBox) return;
        alertBox.textContent = msg;
        alertBox.style.display = 'block';

        if (type === 'error') {
          alertBox.style.background = '#fef2f2';
          alertBox.style.color = '#be123c';
          alertBox.style.border = '1px solid #fecdd3';
        } else if (type === 'warning') {
          alertBox.style.background = '#fffbeb';
          alertBox.style.color = '#92400e';
          alertBox.style.border = '1px solid #fde68a';
        } else {
          alertBox.style.background = '#ecfdf5';
          alertBox.style.color = '#065f46';
          alertBox.style.border = '1px solid #a7f3d0';
        }
      }

      // Nút "Đăng nhập" (UC03)
      function handleGuestPortalLogin(e) {
        e.preventDefault();
        const store = window.guidiaStore;
        if (!store) return;

        const identifier = (document.getElementById('guestLoginUsername')?.value || '').trim();
        const password = document.getElementById('guestLoginPassword')?.value || '';

        const res = store.login(identifier, password);

        if (res.success) {
          showGuestLoginAlert('Đăng nhập thành công! Đang chuyển hướng...', 'success');
          showToast('Đăng nhập thành công!', 'success');

          setTimeout(() => {
            // Kiểm tra nếu có chuyển hướng chờ từ UC02 - A2
            const pending = sessionStorage.getItem('customer_pending_redirect');
            if (pending) {
              sessionStorage.removeItem('customer_pending_redirect');
              window.location.href = pending;
            } else {
              window.location.href = res.redirectUrl || 'customer.jsp';
            }
          }, 800);

        } else {
          // Xử lý các luồng ngoại lệ UC03: A1, A2, A3
          if (res.code === 'A1_INVALID_CREDENTIALS') {
            // Sai thông tin (A1) -> báo "Thông tin không đúng", quay lại bước 3
            showGuestLoginAlert('Thông tin không đúng', 'error');
            showToast('Thông tin không đúng', 'error');
            const pwdEl = document.getElementById('guestLoginPassword');
            if (pwdEl) {
              pwdEl.value = '';
              pwdEl.focus();
            }
          } else if (res.code === 'A2_LOCKED') {
            // Tài khoản bị khóa (A2) -> báo "Tài khoản đã bị khóa do vi phạm. Vui lòng liên hệ bộ phận hỗ trợ"
            showGuestLoginAlert('Tài khoản đã bị khóa do vi phạm. Vui lòng liên hệ bộ phận hỗ trợ', 'error');
            showToast('Tài khoản đã bị khóa do vi phạm. Vui lòng liên hệ bộ phận hỗ trợ', 'error');
          } else if (res.code === 'A3_PENDING_GUIDE') {
            // Tài khoản HDV chưa duyệt (A3) -> báo "Hồ sơ hướng dẫn viên đang chờ duyệt"
            showGuestLoginAlert('Hồ sơ hướng dẫn viên đang chờ duyệt', 'warning');
            showToast('Hồ sơ hướng dẫn viên đang chờ duyệt', 'warning');
          } else {
            showGuestLoginAlert(res.message || 'Đăng nhập không thành công!', 'error');
          }
        }
      }

      // Nút "Quên mật khẩu?" -> Nút "Đặt lại" (UC03 - Luồng phụ A4)
      function handleGuestForgotVerify(e) {
        e.preventDefault();
        const store = window.guidiaStore;
        if (!store) return;

        const name = (document.getElementById('guestForgotName')?.value || '').trim();
        const phone = (document.getElementById('guestForgotPhone')?.value || '').trim();
        const email = (document.getElementById('guestForgotEmail')?.value || '').trim();
        const extraInfo = (document.getElementById('guestForgotExtraInfo')?.value || '').trim();

        const res = store.verifyResetPasswordInfo({ name, phone, email, extraInfo });

        if (res.success) {
          // Đúng thông tin (A4.2) -> hiện ô nhập mật khẩu mới
          document.getElementById('formGuestForgotVerify').style.display = 'none';
          document.getElementById('formGuestForgotNewPwd').style.display = 'block';
          document.getElementById('guestForgotUserId').value = res.userId;
          document.getElementById('guestForgotGreeting').textContent = `Tài khoản: ${res.user.name} (${res.user.email}). Vui lòng nhập mật khẩu mới.`;
          showGuestLoginAlert('Xác minh thành công! Vui lòng nhập mật khẩu mới.', 'success');
          showToast('Xác minh thành công! Vui lòng nhập mật khẩu mới.', 'success');
        } else {
          // Sai thông tin xác minh (A4.1) -> báo "Lỗi xác minh"
          showGuestLoginAlert('Lỗi xác minh', 'error');
          showToast('Lỗi xác minh', 'error');
        }
      }

      function handleGuestSaveNewPassword(e) {
        e.preventDefault();
        const store = window.guidiaStore;
        if (!store) return;

        const userId = document.getElementById('guestForgotUserId')?.value;
        const newPwd = document.getElementById('guestNewPwdInput')?.value;
        const newPwdConf = document.getElementById('guestNewPwdConfirmInput')?.value;

        if (!newPwd || newPwd.length < 6) {
          return showGuestLoginAlert('Mật khẩu mới phải có ít nhất 6 ký tự!', 'error');
        }
        if (newPwd !== newPwdConf) {
          return showGuestLoginAlert('Mật khẩu xác nhận không khớp!', 'error');
        }

        const res = store.resetPassword(userId, newPwd);
        if (res.success) {
          showGuestLoginAlert('Cập nhật mật khẩu mới vào hệ thống thành công!', 'success');
          showToast('Đổi mật khẩu thành công! Bạn có thể đăng nhập ngay.', 'success');

          setTimeout(() => {
            document.getElementById('formGuestForgotNewPwd').reset();
            document.getElementById('formGuestForgotNewPwd').style.display = 'none';
            document.getElementById('formGuestForgotVerify').style.display = 'block';
            switchAuthSubView('login');
            document.getElementById('guestLoginPassword').value = newPwd;
          }, 1200);
        } else {
          showGuestLoginAlert(res.message, 'error');
        }
      }

      // ==========================================
      // 7. TIỆN ÍCH THÔNG BÁO TOAST
      // ==========================================
      function showToast(message, type = 'success') {
        const toast = document.getElementById('portalToast');
        const msgEl = document.getElementById('portalToastMsg');
        const iconEl = document.getElementById('portalToastIcon');
        if (!toast || !msgEl) return;

        msgEl.textContent = message;
        toast.style.display = 'flex';

        if (type === 'error') {
          toast.style.background = '#ef4444';
          toast.style.color = '#ffffff';
          if (iconEl) iconEl.setAttribute('data-lucide', 'alert-circle');
        } else if (type === 'info') {
          toast.style.background = '#0284c7';
          toast.style.color = '#ffffff';
          if (iconEl) iconEl.setAttribute('data-lucide', 'info');
        } else if (type === 'warning') {
          toast.style.background = '#d97706';
          toast.style.color = '#ffffff';
          if (iconEl) iconEl.setAttribute('data-lucide', 'alert-triangle');
        } else {
          toast.style.background = '#059669';
          toast.style.color = '#ffffff';
          if (iconEl) iconEl.setAttribute('data-lucide', 'check-circle');
        }

        if (window.lucide) window.lucide.createIcons();

        setTimeout(() => {
          toast.style.display = 'none';
        }, 3500);
      }
    </script>
  </body>

  </html>