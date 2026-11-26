<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
  <!DOCTYPE html>
  <html lang="vi">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập & Đăng Ký | Guidia - Nền Tảng Hướng Dẫn Viên Du Lịch Bản Địa Việt Nam</title>
    <meta name="description"
      content="Hệ thống xác thực và đăng ký tài khoản Khách du lịch & Hướng dẫn viên bản địa trên nền tảng du lịch Guidia Việt Nam.">

    <!-- Fonts & Icons -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
      href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap"
      rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>

    <link rel="stylesheet" href="css/style.css">


  </head>

  <body class="auth-page">

    <!-- Stunning ambient travel background -->
    <div class="auth-bg-layer"></div>
    <div class="glow-orb-1"></div>
    <div class="glow-orb-2"></div>

    <!-- Top Header Navigation -->
    <header class="auth-page-header">
      <a href="index.jsp" class="auth-brand">
        <div class="logo-icon">
          <i data-lucide="compass" class="icon-sm"></i>
        </div>
        <div>
          <span class="brand-name">Guidia</span>
          <span class="brand-sub">Private Local Guides Vietnam</span>
        </div>
      </a>
      <div class="log-1">
        <button type="button"
          onclick="if (window.history.length > 1) { window.history.back(); } else { window.location.href = 'index.jsp'; }"
          class="btn-portal-back" title="Quay lại">
          <i data-lucide="arrow-left" class="log-2"></i>
        </button>
        <a href="index.jsp" class="auth-back-link log-3">
          <span>Trang Chủ Guidia</span>
        </a>
      </div>
    </header>

    <!-- Main Showcase & Form Layout -->
    <main class="auth-main-layout">

      <!-- Left Inspiring Showcase (Desktop) -->
      <section class="auth-hero-banner">
        <div class="hero-badge-pill">
          <i data-lucide="sparkles" class="log-4"></i>
          Du Lịch Trải Nghiệm Chuẩn Bản Địa
        </div>
        <h1 class="hero-headline">
          Chạm Vào Hồn Việt Cùng <span class="accent">Chuyên Gia Bản Địa</span>
        </h1>
        <p class="hero-description">
          Khám phá từng con ngõ cổ Hà Nội, chèo kayak xuyên hang động Ninh Bình hay thưởng thức ẩm thực Cố Đô Huế cùng
          những hướng dẫn viên tâm huyết và am tường văn hóa.
        </p>

        <div class="hero-features-list">
          <div class="hero-feature-item">
            <i data-lucide="shield-check"></i>
            <div class="hero-feature-text">
              <strong>100% HDV Thẩm Định Thẻ Hành Nghề</strong>
              <span>Hồ sơ được Ban Quản Trị đối chiếu trực tiếp với dữ liệu Sở Du Lịch trước khi hoạt động.</span>
            </div>
          </div>

          <div class="hero-feature-item">
            <i data-lucide="lock"></i>
            <div class="hero-feature-text">
              <strong>Thanh Toán Ký Quỹ Escrow An Toàn</strong>
              <span>Tiền tour được sàn tạm giữ an toàn và chỉ tất toán cho HDV khi chuyến đi hoàn thành trọn vẹn.</span>
            </div>
          </div>

          <div class="hero-feature-item">
            <i data-lucide="heart-handshake"></i>
            <div class="hero-feature-text">
              <strong>Lộ Trình Cá Nhân Hóa Theo Sở Thích</strong>
              <span>Tự do tùy chỉnh lịch trình theo đúng sở thích, phong cách và nhịp độ chuyến đi của riêng bạn.</span>
            </div>
          </div>
        </div>

        <div class="hero-stats-row">
          <div class="hero-stat-box">
            <h4>1,200+</h4>
            <p>Chuyến Đi Hoàn Hảo</p>
          </div>
          <div class="hero-stat-box">
            <h4>99.4%</h4>
            <p>Đánh Giá 5 Sao</p>
          </div>
          <div class="hero-stat-box">
            <h4>63</h4>
            <p>Tỉnh Thành Kết Nối</p>
          </div>
        </div>
      </section>

      <!-- Right Glassmorphism Auth Card -->
      <section class="auth-card-wrapper">
        <div class="auth-glass-card">

          <!-- Tab Chuyển Đổi Chính: Đăng Nhập / Đăng Ký -->
          <div class="primary-mode-switcher" id="mainTabSwitcher">
            <button type="button" class="mode-switch-btn active" id="tabBtnLogin" onclick="switchAuthView('login')">
              <i data-lucide="log-in" class="log-5"></i>
              Đăng Nhập
            </button>
            <button type="button" class="mode-switch-btn" id="tabBtnRegister" onclick="switchAuthView('register')">
              <i data-lucide="user-plus" class="log-5"></i>
              Đăng Ký
            </button>
          </div>

          <!-- Khung Thông Báo Trạng Thái Linh Hoạt  -->
          <div id="authStatusAlert" class="auth-status-alert">
            <i data-lucide="alert-circle" id="alertIcon"></i>
            <div id="alertMessage">Thông báo trạng thái</div>
          </div>


          <!-- ======================================================== -->
          <!-- VIEW 1: FORM ĐĂNG NHẬP (Chỉ gồm Username, Password, Quên MK) -->
          <!-- Không chia role ở giao diện - Hệ thống tự động phân quyền   -->
          <!-- ======================================================== -->
          <div id="authViewLogin">
            <div class="auth-header-area">
              <h2 class="auth-title">Chào Mừng Trở Lại</h2>
              <p class="auth-subtitle">Nhập thông tin tài khoản của bạn để truy cập không gian làm việc hoặc quản lý
                lịch trình.</p>
            </div>

            <form id="formUnifiedLogin" onsubmit="handleUnifiedLogin(event)">
              <!-- Tên đăng nhập -->
              <div class="form-group">
                <label class="form-label">Tên đăng nhập (Email hoặc Số điện thoại) <span class="req">*</span></label>
                <div class="input-field-wrapper">
                  <i data-lucide="user" class="input-icon-left"></i>
                  <input type="text" id="loginUsername" class="auth-input-control"
                    placeholder="VD: minh.nguyen@gmail.com hoặc 0912345678" required autocomplete="username">
                </div>
              </div>

              <!-- Mật khẩu -->
              <div class="form-group">
                <label class="form-label">Mật khẩu <span class="req">*</span></label>
                <div class="input-field-wrapper">
                  <i data-lucide="lock" class="input-icon-left"></i>
                  <input type="password" id="loginPassword" class="auth-input-control"
                    placeholder="Nhập mật khẩu của bạn" required autocomplete="current-password">
                  <button type="button" class="password-toggle-btn"
                    onclick="togglePasswordVisibility('loginPassword', this)" title="Ẩn/hiện mật khẩu">
                    <i data-lucide="eye" class="log-2"></i>
                  </button>
                </div>
              </div>

              <!-- Ghi nhớ & Quên mật khẩu  -->
              <div class="log-6">
                <label class="log-7">
                  <input type="checkbox" id="rememberMeCheckbox" checked class="log-8">
                  <span>Ghi nhớ đăng nhập</span>
                </label>
                <a href="#" class="log-9" onclick="openForgotPasswordFlow(event)">
                  Quên mật khẩu?
                </a>
              </div>

              <!-- Nút Đăng Nhập -->
              <button type="submit" class="btn-submit-main" id="btnLoginSubmit">
                <i data-lucide="log-in" class="log-2"></i>
                Đăng Nhập
              </button>

              <!-- THÔNG TIN HỖ TRỢ DÀNH CHO TÀI KHOẢN BỊ KHÓA / CẦN TRỢ GIÚP -->
              <div class="log-10">
                <div class="log-11">
                  <i data-lucide="help-circle" class="log-12"></i>
                  <span class="log-13">
                    Hỗ Trợ Mở Khóa Tài Khoản & Khiếu Nại
                  </span>
                </div>
                <p class="log-14">
                  Nếu tài khoản của bạn bị tạm khóa hoặc cần trợ giúp mở khóa, vui lòng liên hệ Ban Quản Trị Hệ Thống:
                </p>
                <div class="log-15">
                  <div>📧 <strong>Email hỗ trợ:</strong> <a href="mailto:admin@guidia.vn"
                      class="log-9">admin@guidia.vn</a></div>
                  <div>📱 <strong>Hotline / Zalo:</strong> <a href="tel:0999999999" class="log-9">0999.999.999</a> (Hỗ
                    trợ 8:00 - 22:00)</div>
                </div>
              </div>
            </form>
          </div>

          <!-- ======================================================== -->
          <!-- VIEW 2: FORM ĐĂNG KÝ (Chọn vai trò, sở thích, , )       -->
          <!-- ======================================================== -->
          <div id="authViewRegister" class="log-16">
            <div class="auth-header-area">
              <h2 class="auth-title">Tạo Tài Khoản Mới</h2>
              <p class="auth-subtitle">Chọn vai trò tham gia hệ thống và hoàn thiện hồ sơ để bắt đầu hành trình cùng
                Guidia.</p>
            </div>

            <form id="formRegister" onsubmit="handleRegistrationSubmit(event)">

              <!-- 2. Cho chọn vai trò (Khách du lịch hoặc Hướng dẫn viên) -->
              <div class="role-selector-container">
                <label class="form-label">Chọn vai trò của bạn <span class="req">*</span></label>
                <div class="role-options-grid">
                  <!-- Vai trò Khách Du Lịch -->
                  <div class="role-option-card selected" id="cardRoleCustomer" onclick="selectRole('customer')">
                    <input type="radio" name="regRole" id="radioCustomer" value="customer" checked>
                    <div class="role-icon-box">
                      <i data-lucide="user" class="log-17"></i>
                    </div>
                    <div class="role-title">Khách Du Lịch</div>
                    <div class="role-tagline">Đặt tour, tìm HDV bản địa & khám phá Việt Nam</div>
                  </div>

                  <!-- Vai trò Hướng Dẫn Viên -->
                  <div class="role-option-card" id="cardRoleGuide" onclick="selectRole('guide')">
                    <input type="radio" name="regRole" id="radioGuide" value="guide">
                    <div class="role-icon-box">
                      <i data-lucide="compass" class="log-17"></i>
                    </div>
                    <div class="role-title">Hướng Dẫn Viên</div>
                    <div class="role-tagline">Nhận lịch tour, phát triển thu nhập & quảng bá quê hương</div>
                  </div>
                </div>
              </div>

              <!-- 3. Khách vãng lai nhập thông tin hồ sơ cá nhân -->
              <!-- Họ và tên -->
              <div class="form-group">
                <label class="form-label">Họ và tên <span class="req">*</span></label>
                <div class="input-field-wrapper">
                  <i data-lucide="user" class="input-icon-left"></i>
                  <input type="text" id="regFullName" class="auth-input-control" placeholder="VD: Nguyễn Văn Minh"
                    required>
                </div>
              </div>

              <!-- Số điện thoại & Email -->
              <div class="log-18">
                <div class="form-group">
                  <label class="form-label">Số điện thoại <span class="req">*</span></label>
                  <div class="input-field-wrapper">
                    <i data-lucide="phone" class="input-icon-left"></i>
                    <input type="tel" id="regPhone" class="auth-input-control" placeholder="0912..." required>
                  </div>
                </div>

                <div class="form-group">
                  <label class="form-label">Email <span class="req">*</span></label>
                  <div class="input-field-wrapper">
                    <i data-lucide="mail" class="input-icon-left"></i>
                    <input type="email" id="regEmail" class="auth-input-control" placeholder="ten@gmail.com" required>
                  </div>
                </div>
              </div>

              <!-- Mật khẩu & Xác nhận mật khẩu -->
              <div class="log-18">
                <div class="form-group">
                  <label class="form-label">Mật khẩu <span class="req">*</span></label>
                  <div class="input-field-wrapper">
                    <i data-lucide="lock" class="input-icon-left"></i>
                    <input type="password" id="regPassword" class="auth-input-control" placeholder="Tối thiểu 6 ký tự"
                      required>
                  </div>
                </div>

                <div class="form-group">
                  <label class="form-label">Xác nhận mật khẩu <span class="req">*</span></label>
                  <div class="input-field-wrapper">
                    <i data-lucide="check-circle" class="input-icon-left"></i>
                    <input type="password" id="regPasswordConfirm" class="auth-input-control"
                      placeholder="Nhập lại mật khẩu" required>
                  </div>
                </div>
              </div>

              <!-- Thông tin phụ (Sở thích là gì?) - Bắt buộc theo yêu cầu -->
              <div class="form-group">
                <label class="form-label">
                  Thông tin phụ: Sở thích của bạn là gì? <span class="req">*</span>
                  <span class="sub-note">(Dùng để gợi ý trải nghiệm & xác minh khôi phục mật khẩu)</span>
                </label>
                <div class="input-field-wrapper">
                  <i data-lucide="heart" class="input-icon-left"></i>
                  <input type="text" id="regExtraInfo" class="auth-input-control"
                    placeholder="VD: Ẩm thực đường phố, chụp ảnh phố cổ, trekking, cắm trại..." required>
                </div>
              </div>

              <!-- Các trường nghiệp vụ mở rộng dành riêng cho HƯỚNG DẪN VIÊN -->
              <div id="guideExtraFields" class="guide-fields-section log-16">
                <div class="log-19">
                  <i data-lucide="award" class="log-2"></i>
                  Thông Tin Chứng Chỉ Hành Nghề Hướng Dẫn Viên
                </div>

                <div class="log-20">
                  <div class="form-group log-21">
                    <label class="form-label">Địa bàn hoạt động chính <span class="req">*</span></label>
                    <select id="guideCitySelect" class="auth-input-control log-22">
                      <option value="Hà Nội - Phố Cổ & Di Sản Thăng Long">Hà Nội (Phố Cổ, Thăng Long)</option>
                      <option value="Hội An - Đà Nẵng">Hội An - Đà Nẵng</option>
                      <option value="Huế - Cố Đô Triều Nguyễn">Huế (Cố Đô Di Sản)</option>
                      <option value="Ninh Bình - Tràng An & Hoa Lư">Ninh Bình (Tràng An, Hoa Lư)</option>
                      <option value="Sa Pa - Fansipan & Tây Bắc">Sa Pa (Fansipan, Tây Bắc)</option>
                      <option value="TP. Hồ Chí Minh - Sài Gòn & Nam Bộ">TP. Hồ Chí Minh</option>
                    </select>
                  </div>

                  <div class="form-group log-21">
                    <label class="form-label">Loại thẻ HDV <span class="req">*</span></label>
                    <select id="guideCertTypeSelect" class="auth-input-control log-22">
                      <option value="Thẻ Hướng Dẫn Viên Du Lịch Quốc Tế Tại Việt Nam">Thẻ HDV Quốc Tế</option>
                      <option value="Thẻ Hướng Dẫn Viên Du Lịch Nội Địa Tại Việt Nam">Thẻ HDV Nội Địa</option>
                    </select>
                  </div>
                </div>

                <div class="form-group">
                  <label class="form-label">Số hiệu thẻ HDV (Do Cục/Sở Du Lịch cấp) <span class="req">*</span></label>
                  <div class="input-field-wrapper">
                    <i data-lucide="credit-card" class="input-icon-left"></i>
                    <input type="text" id="guideCertNumberInput" class="auth-input-control"
                      placeholder="VD: 10123/2024-HDVND hoặc VN-HDVQT-8899">
                  </div>
                </div>

                <div class="form-group log-21">
                  <label class="form-label">Ảnh chụp mặt trước Thẻ HDV (Để QTV xét duyệt) <span
                      class="req">*</span></label>
                  <div class="card-dropzone-box" onclick="document.getElementById('guideCardFileInput').click()">
                    <i data-lucide="camera" class="log-23"></i>
                    <div class="log-24">Bấm để tải ảnh chụp thẻ HDV rõ nét</div>
                    <div class="log-25">Định dạng JPG, PNG để Ban Quản Trị đối chiếu thông tin</div>
                    <input type="file" id="guideCardFileInput" accept="image/*" class="log-16"
                      onchange="handleCardImagePreview(this)">
                    <img id="guideCardThumbPreview" class="preview-thumb-img" alt="Ảnh thẻ HDV">
                  </div>
                </div>
              </div>

              <!-- Checkbox Đồng ý điều khoản -->
              <div class="log-26">
                <label class="log-27">
                  <input type="checkbox" id="regTermsAgreement" required checked class="log-28">
                  <span>
                    Tôi đã đọc và hoàn toàn đồng ý với <a href="#" class="log-29">Điều khoản dịch vụ</a> và <a href="#"
                      class="log-29">Chính sách bảo mật của Guidia</a>.
                  </span>
                </label>
              </div>

              <!-- 4. Nhấn “Đăng Ký” -->
              <button type="submit" class="btn-submit-main" id="btnRegisterSubmit">
                <i data-lucide="check" class="log-2"></i>
                Đăng Ký
              </button>


              <button type="button" class="btn-cancel-secondary" onclick="handleCancelRegistration()">
                <i data-lucide="x" class="log-5"></i>
                Hủy Đăng Ký
              </button>
            </form>
          </div>


          <!-- ======================================================== -->
          <!-- VIEW 3: QUÊN MẬT KHẨU                      -->
          <!-- ======================================================== -->
          <div id="authViewForgotPassword" class="log-16">
            <div class="auth-header-area">
              <h2 class="auth-title">Khôi Phục Mật Khẩu</h2>
              <p class="auth-subtitle" id="forgotStepSubtitle">
                Nhập các thông tin hồ sơ đã đăng ký để hệ thống tiến hành đối chiếu và cấp quyền đặt lại mật khẩu mới.
              </p>
            </div>


            <form id="formForgotVerify" onsubmit="handleForgotVerifySubmit(event)">
              <div class="form-group">
                <label class="form-label">Họ và tên <span class="req">*</span></label>
                <div class="input-field-wrapper">
                  <i data-lucide="user" class="input-icon-left"></i>
                  <input type="text" id="forgotFullName" class="auth-input-control"
                    placeholder="Nhập chính xác họ và tên" required>
                </div>
              </div>

              <div class="log-18">
                <div class="form-group">
                  <label class="form-label">Số điện thoại <span class="req">*</span></label>
                  <div class="input-field-wrapper">
                    <i data-lucide="phone" class="input-icon-left"></i>
                    <input type="tel" id="forgotPhone" class="auth-input-control" placeholder="0912..." required>
                  </div>
                </div>

                <div class="form-group">
                  <label class="form-label">Email <span class="req">*</span></label>
                  <div class="input-field-wrapper">
                    <i data-lucide="mail" class="input-icon-left"></i>
                    <input type="email" id="forgotEmail" class="auth-input-control" placeholder="email@gmail.com"
                      required>
                  </div>
                </div>
              </div>

              <div class="form-group">
                <label class="form-label">Thông tin phụ (Sở thích đã đăng ký) <span class="req">*</span></label>
                <div class="input-field-wrapper">
                  <i data-lucide="heart" class="input-icon-left"></i>
                  <input type="text" id="forgotExtraInfo" class="auth-input-control"
                    placeholder="VD: Ẩm thực, chụp ảnh phố cổ, leo núi..." required>
                </div>
              </div>

              <!-- Nút "Đặt Lại" theo đúng đặc tả  -->
              <button type="submit" class="btn-submit-main" id="btnForgotVerifySubmit">
                <i data-lucide="key-round" class="log-2"></i>
                Đặt Lại
              </button>

              <button type="button" class="btn-cancel-secondary" onclick="switchAuthView('login')">
                <i data-lucide="arrow-left" class="log-5"></i>
                Quay lại Đăng nhập
              </button>
            </form>


            <form id="formForgotNewPassword" class="log-16" onsubmit="handleUpdateNewPasswordSubmit(event)">
              <input type="hidden" id="verifiedUserId">

              <div class="log-30">
                <div class="log-31">
                  <i data-lucide="check-circle" class="log-32"></i>
                  Xác minh thông tin thành công!
                </div>
                <div class="log-33" id="verifiedUserGreeting">Vui lòng thiết lập mật khẩu mới cho tài khoản.</div>
              </div>

              <div class="form-group">
                <label class="form-label">Mật khẩu mới <span class="req">*</span></label>
                <div class="input-field-wrapper">
                  <i data-lucide="lock" class="input-icon-left"></i>
                  <input type="password" id="newPasswordInput" class="auth-input-control"
                    placeholder="Tối thiểu 6 ký tự" required>
                  <button type="button" class="password-toggle-btn"
                    onclick="togglePasswordVisibility('newPasswordInput', this)">
                    <i data-lucide="eye" class="log-2"></i>
                  </button>
                </div>
              </div>

              <div class="form-group">
                <label class="form-label">Xác nhận mật khẩu mới <span class="req">*</span></label>
                <div class="input-field-wrapper">
                  <i data-lucide="check-circle-2" class="input-icon-left"></i>
                  <input type="password" id="newPasswordConfirmInput" class="auth-input-control"
                    placeholder="Nhập lại mật khẩu mới" required>
                </div>
              </div>

              <button type="submit" class="btn-submit-main">
                <i data-lucide="save" class="log-2"></i>
                Xác Nhận & Cập Nhật Mật Khẩu
              </button>

              <button type="button" class="btn-cancel-secondary" onclick="switchAuthView('login')">
                Hủy / Về Đăng Nhập
              </button>
            </form>
          </div>

          <div class="auth-footer-note">
            Guidia Vietnam Travel Network &copy; 2026. Mọi quyền được bảo lưu.
          </div>

        </div>
      </section>

    </main>

    <!-- Toast Notification Thông Báo Toàn Cục -->
    <div id="globalAuthToast">
      <i data-lucide="info" id="globalToastIcon" class="log-17"></i>
      <span id="globalToastMsg">Thông báo</span>
    </div>

    <!-- Nạp dữ liệu Store và Logic tương tác -->
    <script src="js/store.js"></script>
    <script>
      // Khởi tạo icon Lucide
      lucide.createIcons();

      // Biến lưu trạng thái ảnh thẻ HDV và view hiện tại
      let currentAuthView = 'login';
      let currentSelectedRole = 'customer';
      let uploadedCardBase64 = null;

      // Toast helper
      function showToast(message, type = 'success') {
        const toast = document.getElementById('globalAuthToast');
        const toastMsg = document.getElementById('globalToastMsg');
        toastMsg.textContent = message;

        if (type === 'error') {
          toast.style.borderLeftColor = '#ef4444';
        } else if (type === 'warning') {
          toast.style.borderLeftColor = '#f59e0b';
        } else {
          toast.style.borderLeftColor = '#10b981';
        }

        toast.style.display = 'flex';
        setTimeout(() => {
          toast.style.display = 'none';
        }, 4000);
      }

      // Hiển thị khung thông báo trạng thái ngay trên form
      function showFormAlert(message, type = 'error') {
        const alertBox = document.getElementById('authStatusAlert');
        const alertMsg = document.getElementById('alertMessage');
        const alertIcon = document.getElementById('alertIcon');

        alertBox.className = 'auth-status-alert ' + type;
        alertMsg.textContent = message;

        // Cập nhật icon
        if (type === 'error') {
          alertIcon.setAttribute('data-lucide', 'alert-circle');
        } else if (type === 'warning') {
          alertIcon.setAttribute('data-lucide', 'alert-triangle');
        } else {
          alertIcon.setAttribute('data-lucide', 'check-circle');
        }

        alertBox.style.display = 'flex';
        lucide.createIcons();
        alertBox.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
      }

      function hideFormAlert() {
        const alertBox = document.getElementById('authStatusAlert');
        alertBox.style.display = 'none';
      }

      // Toggle hiện/ẩn mật khẩu
      function togglePasswordVisibility(inputId, btn) {
        const input = document.getElementById(inputId);
        if (input.type === 'password') {
          input.type = 'text';
          btn.innerHTML = '<i data-lucide="eye-off" class="log-2"></i>';
        } else {
          input.type = 'password';
          btn.innerHTML = '<i data-lucide="eye" class="log-2"></i>';
        }
        lucide.createIcons();
      }

      // Chuyển đổi giữa Đăng Nhập / Đăng Ký / Quên Mật Khẩu
      function switchAuthView(view) {
        currentAuthView = view;
        hideFormAlert();

        const viewLogin = document.getElementById('authViewLogin');
        const viewRegister = document.getElementById('authViewRegister');
        const viewForgot = document.getElementById('authViewForgotPassword');
        const tabLogin = document.getElementById('tabBtnLogin');
        const tabRegister = document.getElementById('tabBtnRegister');
        const tabSwitcher = document.getElementById('mainTabSwitcher');

        if (view === 'login') {
          tabSwitcher.style.display = 'grid';
          tabLogin.classList.add('active');
          tabRegister.classList.remove('active');
          viewLogin.style.display = 'block';
          viewRegister.style.display = 'none';
          viewForgot.style.display = 'none';
        } else if (view === 'register') {
          tabSwitcher.style.display = 'grid';
          tabLogin.classList.remove('active');
          tabRegister.classList.add('active');
          viewLogin.style.display = 'none';
          viewRegister.style.display = 'block';
          viewForgot.style.display = 'none';
        } else if (view === 'forgot') {
          // Quên mật khẩu: ẩn thanh tab chính để tập trung luồng xác minh
          tabSwitcher.style.display = 'none';
          viewLogin.style.display = 'none';
          viewRegister.style.display = 'none';
          viewForgot.style.display = 'block';

          // Reset về form bước 1
          document.getElementById('formForgotVerify').style.display = 'block';
          document.getElementById('formForgotNewPassword').style.display = 'none';
        }
        lucide.createIcons();
      }

      // Chọn vai trò trong form đăng ký (Khách du lịch / Hướng dẫn viên)
      function selectRole(role) {
        currentSelectedRole = role;
        const cardCust = document.getElementById('cardRoleCustomer');
        const cardGuide = document.getElementById('cardRoleGuide');
        const radioCust = document.getElementById('radioCustomer');
        const radioGuide = document.getElementById('radioGuide');
        const guideSection = document.getElementById('guideExtraFields');
        const certInput = document.getElementById('guideCertNumberInput');

        if (role === 'guide') {
          cardGuide.classList.add('selected');
          cardCust.classList.remove('selected');
          radioGuide.checked = true;
          guideSection.style.display = 'block';
          certInput.setAttribute('required', 'true');
        } else {
          cardCust.classList.add('selected');
          cardGuide.classList.remove('selected');
          radioCust.checked = true;
          guideSection.style.display = 'none';
          certInput.removeAttribute('required');
        }
        lucide.createIcons();
      }

      // Xử lý xem trước ảnh thẻ HDV
      function handleCardImagePreview(input) {
        if (input.files && input.files[0]) {
          const file = input.files[0];
          const reader = new FileReader();
          reader.onload = function (e) {
            uploadedCardBase64 = e.target.result;
            const img = document.getElementById('guideCardThumbPreview');
            img.src = e.target.result;
            img.style.display = 'inline-block';
          };
          reader.readAsDataURL(file);
        }
      }

      // ========================================================
      // XỬ LÝ ĐĂNG NHẬP (UNIFIED LOGIN - TỰ ĐỘNG PHÂN QUYỀN)



      // ========================================================
      async function handleUnifiedLogin(e) {
        e.preventDefault();
        hideFormAlert();

        const username = document.getElementById('loginUsername').value.trim();
        const password = document.getElementById('loginPassword').value;

        if (!username || !password) {
          showFormAlert('Vui lòng nhập tên đăng nhập và mật khẩu!', 'error');
          return;
        }

        // 1. Kết nối xác thực trực tiếp qua Java Servlet kết nối SQL Server QL_Du_Lich
        try {
          const params = new URLSearchParams();
          params.append('email', username);
          params.append('password', password);

          const resp = await fetch((window.location.pathname.startsWith('/HTTMDT') ? '/HTTMDT/api/login' : 'api/login'), {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: params.toString()
          });

          if (resp.ok) {
            const data = await resp.json();
            if (data.success) {
              showFormAlert(`Đăng nhập thành công! Đang chuyển hướng...`, 'success');
              showToast(data.message, 'success');
              if (data.user) {
                const u = data.user;
                const rawRole = (u.role || u.vaiTro || 'CUSTOMER').toUpperCase();
                let normalizedRole = 'customer';
                if (rawRole.includes('ADMIN') || rawRole.includes('QUAN_TRI')) normalizedRole = 'admin';
                else if (rawRole.includes('GUIDE') || rawRole.includes('HUONG_DAN')) normalizedRole = 'guide';

                const sessionUser = {
                  id: u.userId || u.maTaiKhoan || u.id,
                  name: u.fullName || u.hoTen || u.name,
                  email: u.email,
                  phone: u.phone || u.soDienThoai,
                  role: normalizedRole,
                  avatar: u.avatarUrl || u.anhDaiDien || u.avatar || 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150',
                  status: (u.status === 'LOCKED' || u.trangThai === 'KHOA') ? 'suspended' : 'active'
                };
                sessionStorage.setItem('guidia_current_user', JSON.stringify(sessionUser));
                localStorage.setItem('guidia_current_user', JSON.stringify(sessionUser));
                if (sessionUser.role === 'guide') {
                  localStorage.setItem('guidia_current_guide_id_v2', sessionUser.id);
                  if (window.guidiaStore) {
                    window.guidiaStore.setActiveGuideId(sessionUser.id);
                  }
                } else if (sessionUser.role === 'customer') {
                  localStorage.setItem('guidia_current_customer_id_v2', sessionUser.id);
                }
              }
              setTimeout(() => {
                const pending = sessionStorage.getItem('customer_pending_redirect');
                if (pending) {
                  sessionStorage.removeItem('customer_pending_redirect');
                  window.location.href = pending;
                } else {
                  window.location.href = data.redirectUrl || (sessionUser.role === 'customer' ? 'customer.jsp' : 'index.jsp');
                }
              }, 600);
              return;
            } else {
              showFormAlert(data.message, 'error');
              showToast(data.message, 'error');
              return;
            }
          }
        } catch (err) {
          console.error('Lỗi gọi API đăng nhập backend:', err);
        }

        // 2. Dự phòng qua store.js
        const res = window.guidiaStore.login(username, password);

        if (res.success) {
          const roleLabels = { customer: 'Khách du lịch', guide: 'Hướng dẫn viên', admin: 'Quản trị viên' };
          showFormAlert(`Đăng nhập thành công với vai trò ${roleLabels[res.role] || res.role}! Đang chuyển hướng...`, 'success');
          showToast(res.message, 'success');

          if (res.user) {
            if (res.user.role === 'guide') {
              localStorage.setItem('guidia_current_guide_id_v2', res.user.id);
              if (window.guidiaStore) {
                window.guidiaStore.setActiveGuideId(res.user.id);
              }
            } else if (res.user.role === 'customer') {
              localStorage.setItem('guidia_current_customer_id_v2', res.user.id);
            }
          }

          setTimeout(() => {
            const pending = sessionStorage.getItem('customer_pending_redirect');
            if (pending) {
              sessionStorage.removeItem('customer_pending_redirect');
              window.location.href = pending;
            } else {
              window.location.href = res.redirectUrl;
            }
          }, 800);
        } else {
          // Xử lý các luồng ngoại lệ , , 
          if (res.code === 'A1_INVALID_CREDENTIALS') {

            showFormAlert('Thông tin không đúng', 'error');
            showToast('Thông tin không đúng', 'error');
            document.getElementById('loginPassword').value = '';
            document.getElementById('loginPassword').focus();
          } else if (res.code === 'A2_LOCKED') {
            showFormAlert('Tài khoản đã bị khóa do vi phạm. Vui lòng liên hệ bộ phận hỗ trợ', 'error');
            showToast('Tài khoản đã bị khóa do vi phạm. Vui lòng liên hệ bộ phận hỗ trợ', 'error');
          } else if (res.code === 'A3_PENDING_GUIDE') {

            showFormAlert('Hồ sơ hướng dẫn viên đang chờ duyệt', 'warning');
            showToast('Hồ sơ hướng dẫn viên đang chờ duyệt', 'warning');
          } else {
            showFormAlert(res.message || 'Đăng nhập không thành công!', 'error');
            showToast(res.message || 'Đăng nhập không thành công!', 'error');
          }
        }
      }

      // ========================================================
      // XỬ LÝ ĐĂNG KÝ (REGISTRATION FLOW)
      // 1-4: Nhập hồ sơ, chọn vai trò, nhập thông tin phụ sở thích, đồng ý điều khoản


      // 7: Kích hoạt (Customer) hoặc Chờ duyệt (HDV)
      // ========================================================
      function handleRegistrationSubmit(e) {
        e.preventDefault();
        hideFormAlert();

        const name = document.getElementById('regFullName').value.trim();
        const phone = document.getElementById('regPhone').value.trim();
        const email = document.getElementById('regEmail').value.trim();
        const pwd = document.getElementById('regPassword').value;
        const pwdConf = document.getElementById('regPasswordConfirm').value;
        const extraInfo = document.getElementById('regExtraInfo').value.trim();
        const agreed = document.getElementById('regTermsAgreement').checked;

        // Kiểm tra tính hợp lệ cơ bản
        if (!name || !phone || !email || !pwd || !extraInfo) {
          showFormAlert('Vui lòng điền đầy đủ các thông tin bắt buộc và thông tin phụ (sở thích)!', 'error');
          return;
        }

        if (pwd.length < 6) {
          showFormAlert('Mật khẩu phải có tối thiểu 6 ký tự!', 'error');
          return;
        }


        if (pwd !== pwdConf) {
          showFormAlert('Dữ liệu không hợp lệ: Mật khẩu xác nhận không trùng khớp!', 'error');
          showToast('Mật khẩu xác nhận không khớp!', 'error');
          return;
        }

        if (!agreed) {
          showFormAlert('Vui lòng đồng ý với Điều khoản dịch vụ và Chính sách của Guidia!', 'error');
          return;
        }

        // Xử lý theo từng vai trò đã chọn
        if (currentSelectedRole === 'guide') {
          const city = document.getElementById('guideCitySelect').value;
          const certType = document.getElementById('guideCertTypeSelect').value;
          const certNumber = document.getElementById('guideCertNumberInput').value.trim();
          const cardImg = uploadedCardBase64 || 'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=600';

          if (!certNumber) {
            showFormAlert('Vui lòng nhập số hiệu thẻ HDV đã được cấp!', 'error');
            return;
          }


          const res = window.guidiaStore.registerGuide({
            name,
            phone,
            email,
            password: pwd,
            extraInfo,
            city,
            certType,
            certNumber,
            certImage: cardImg,
            specialties: `Tuyến tour ${city} - Sở thích: ${extraInfo}`
          });

          if (res.success) {

            showFormAlert('Đăng ký hồ sơ Hướng dẫn viên thành công! Hồ sơ của bạn đã được chuyển sang trạng thái "Chờ duyệt" để Ban Quản Trị xét duyệt thẻ hành nghề.', 'warning');
            showToast('Hồ sơ hướng dẫn viên đã gửi, trạng thái "Chờ duyệt"!', 'warning');

            // Reset form và chuyển về Đăng Nhập sau 2.5s
            setTimeout(() => {
              document.getElementById('formRegister').reset();
              uploadedCardBase64 = null;
              document.getElementById('guideCardThumbPreview').style.display = 'none';
              switchAuthView('login');
              document.getElementById('loginUsername').value = email;
              showFormAlert('Hồ sơ HDV của bạn đang ở trạng thái "Chờ duyệt". Bạn có thể theo dõi tiến độ hoặc liên hệ hotline 1900 6868.', 'warning');
            }, 2500);
          } else {

            showFormAlert(res.message, 'error');
            showToast(res.message, 'error');
          }

        } else {
          // Vai trò Khách du lịch

          const res = window.guidiaStore.registerCustomer({
            name,
            phone,
            email,
            password: pwd,
            extraInfo
          });

          if (res.success) {

            showFormAlert('Đăng ký tài khoản Khách du lịch thành công! Tài khoản đã được kích hoạt. Đang chuyển về màn hình đăng nhập...', 'success');
            showToast('Kích hoạt tài khoản thành công!', 'success');

            setTimeout(() => {
              document.getElementById('formRegister').reset();
              switchAuthView('login');
              document.getElementById('loginUsername').value = email;
              document.getElementById('loginPassword').value = pwd;
              showFormAlert('Đăng ký thành công! Bạn có thể nhấn "Đăng Nhập" ngay bây giờ.', 'success');
            }, 1800);
          } else {

            showFormAlert(res.message, 'error');
            showToast(res.message, 'error');
          }
        }
      }


      function handleCancelRegistration() {
        if (confirm('Bạn có chắc muốn hủy đăng ký? Toàn bộ dữ liệu vừa nhập sẽ không được lưu.')) {
          document.getElementById('formRegister').reset();
          uploadedCardBase64 = null;
          document.getElementById('guideCardThumbPreview').style.display = 'none';
          selectRole('customer');
          switchAuthView('login');
          showToast('Đã hủy đăng ký. Dữ liệu chưa lưu được hủy bỏ.');
        }
      }

      // ========================================================
      // QUÊN MẬT KHẨU 

      // Thông tin không chính xác -> Báo "Lỗi xác minh"
      // Thông tin chính xác -> Cho phép nhập mật khẩu mới & cập nhật
      // ========================================================
      function openForgotPasswordFlow(e) {
        if (e) e.preventDefault();
        switchAuthView('forgot');
        showFormAlert('Vui lòng nhập đầy đủ họ tên, SĐT, email và thông tin phụ (sở thích) để xác minh khôi phục mật khẩu.', 'warning');
      }

      async function handleForgotVerifySubmit(e) {
        e.preventDefault();
        hideFormAlert();

        const name = document.getElementById('forgotFullName').value.trim();
        const phone = document.getElementById('forgotPhone').value.trim();
        const email = document.getElementById('forgotEmail').value.trim();
        const extraInfo = document.getElementById('forgotExtraInfo').value.trim();

        // 1. Xác thực qua Backend SQL Server
        try {
          const params = new URLSearchParams();
          params.append('action', 'verify_reset_password');
          params.append('name', name);
          params.append('phone', phone);
          params.append('email', email);
          params.append('extraInfo', extraInfo);

          const resp = await fetch('api/data/action', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: params.toString()
          });
          if (resp.ok) {
            const data = await resp.json();
            if (data.success && data.user) {
              document.getElementById('formForgotVerify').style.display = 'none';
              document.getElementById('formForgotNewPassword').style.display = 'block';
              document.getElementById('verifiedUserId').value = data.userId || (data.user.userId || data.user.id);
              document.getElementById('verifiedUserGreeting').textContent = `Tài khoản xác thực: ${data.user.fullName || data.user.name} (${data.user.email}). Vui lòng nhập mật khẩu mới.`;
              showFormAlert('Xác minh danh tính chính xác từ CSDL! Vui lòng nhập mật khẩu mới.', 'success');
              showToast('Xác minh chính xác! Hãy nhập mật khẩu mới.', 'success');
              return;
            }
          }
        } catch (err) {
          console.warn('Backend verify_reset_password warning:', err);
        }

        const res = window.guidiaStore.verifyResetPasswordInfo({ name, phone, email, extraInfo });

        if (res.success) {
          // Thông tin chính xác - Chuyển sang form nhập mật khẩu mới
          document.getElementById('formForgotVerify').style.display = 'none';
          document.getElementById('formForgotNewPassword').style.display = 'block';
          document.getElementById('verifiedUserId').value = res.userId;
          document.getElementById('verifiedUserGreeting').textContent = `Tài khoản xác thực: ${res.user.name} (${res.user.email}). Vui lòng nhập mật khẩu mới.`;
          showFormAlert('Xác minh danh tính chính xác! Vui lòng nhập mật khẩu mới.', 'success');
          showToast('Xác minh chính xác! Hãy nhập mật khẩu mới.', 'success');
        } else {
          // Thông tin không chính xác (A4.1) - Hệ thống thông báo Lỗi xác minh
          showFormAlert('Lỗi xác minh: Thông tin không trùng khớp với dữ liệu đã đăng ký!', 'error');
          showToast('Lỗi xác minh', 'error');
        }
      }

      async function handleUpdateNewPasswordSubmit(e) {
        e.preventDefault();
        hideFormAlert();

        const userId = document.getElementById('verifiedUserId').value;
        const newPwd = document.getElementById('newPasswordInput').value;
        const newPwdConf = document.getElementById('newPasswordConfirmInput').value;

        if (!newPwd || newPwd.length < 6) {
          showFormAlert('Mật khẩu mới phải có tối thiểu 6 ký tự!', 'error');
          return;
        }

        if (newPwd !== newPwdConf) {
          showFormAlert('Mật khẩu xác nhận không khớp! Vui lòng nhập lại chính xác.', 'error');
          return;
        }

        // Cập nhật mật khẩu vào Backend SQL Server
        try {
          const params = new URLSearchParams();
          params.append('action', 'reset_password');
          params.append('userId', userId);
          params.append('newPassword', newPwd);

          await fetch('api/data/action', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
            body: params.toString()
          });
        } catch (err) {
          console.warn('Backend reset_password warning:', err);
        }

        const res = window.guidiaStore.resetPassword(userId, newPwd);
        if (res.success) {
          showFormAlert(res.message, 'success');
          showToast('Cập nhật mật khẩu mới thành công vào CSDL!', 'success');

          setTimeout(() => {
            switchAuthView('login');
            document.getElementById('loginPassword').value = newPwd;
            showFormAlert('Mật khẩu đã được cập nhật thành công! Bạn có thể đăng nhập ngay.', 'success');
          }, 1500);
        } else {
          showFormAlert(res.message, 'error');
        }
      }

      // Đọc URL Params khi tải trang (?action=register, ?action=forgot, ?role=guide, ?returnUrl=...)
      window.addEventListener('DOMContentLoaded', () => {
        const urlParams = new URLSearchParams(window.location.search);
        const action = urlParams.get('action');
        const role = urlParams.get('role');
        const returnUrl = urlParams.get('returnUrl');

        if (returnUrl) {
          sessionStorage.setItem('customer_pending_redirect', returnUrl);
        }

        if (action === 'register') {
          switchAuthView('register');
          if (role === 'guide' && typeof selectRole === 'function') {
            selectRole('guide');
          }
        } else if (action === 'forgot') {
          switchAuthView('forgot');
        } else {
          switchAuthView('login');
        }
      });
    </script>
  </body>

  </html>