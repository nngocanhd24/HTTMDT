<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="true" %>
  <!DOCTYPE html>
  <html lang="vi">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Guidia | Kết Nối Hướng Dẫn Viên Bản Địa Sang Trọng & Độc Bản</title>
    <meta name="description"
      content="Nền tảng kết nối du khách với đội ngũ hướng dẫn viên bản địa cao cấp hàng đầu Việt Nam. Trải nghiệm du lịch may đo riêng biệt, tinh tế và trọn vẹn.">

    <!-- Google Fonts: Cormorant Garamond & Plus Jakarta Sans -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
      href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,500;0,600;0,700;1,400&family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap"
      rel="stylesheet">

    <!-- Lucide Icons CDN -->
    <script src="https://unpkg.com/lucide@latest"></script>

    <link rel="stylesheet" href="css/style.css?v=20261110_04">

    <style>
      /* CẤU HÌNH KHUNG MODAL CHI TIẾT HDV TO RỘNG BỀ NGANG - DUY NHẤT 1 THANH CUỘN DỌC PHÍA NGOÀI */
      #guideModal .modal-container,
      .modal-container.idx-38 {
        max-width: 1040px !important;
        width: 94vw !important;
        max-height: 90vh !important;
        overflow-y: auto !important;
        /* DUY NHẤT 1 THANH CUỘN DỌC PHÍA NGOÀI */
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
        /* TRIỆT TIÊU THANH CUỘN DỌC BÊN TRONG */
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

  <body>

    <!-- ========================================================================= -->
    <!-- 1. HEADER KHÁCH VÃNG LAI (MỤC 1 vang lai.md)                              -->
    <!-- Góc trái: Logo Guidia (PRIVATE LOCAL GUIDES)                               -->
    <!-- Menu giữa: Đúng 2 chức năng cạnh nhau: [Trang Chủ] & [Tra cứu hướng dẫn viên] -->
    <!-- Góc phải: Đúng 2 nút: [Đăng nhập] (btn-outline-mint) & [Đăng ký] (btn-primary) -->
    <!-- ========================================================================= -->
    <header class="navbar" id="navbar">
      <div class="container nav-container">

        <!-- 1. Góc trái: Logo Guidia -->
        <a href="index.jsp" class="brand-logo" onclick="showHomeView(event)">
          <div class="logo-icon">
            <i data-lucide="compass"></i>
          </div>
          <div class="logo-text">
            <span class="logo-title">Guidia</span>
            <span class="logo-sub">Private Local Guides</span>
          </div>
        </a>

        <!-- 2. Menu giữa: Đúng 2 chức năng Trang Chủ & Tra Cứu Hướng Dẫn Viên -->
        <nav class="nav-menu">
          <a href="index.jsp" class="nav-item active" id="navHome">Trang Chủ</a>
          <a href="search.jsp" class="nav-item idx-1" id="navSearch">
            <i data-lucide="search" class="idx-2"></i>Tra cứu hướng dẫn viên
          </a>
        </nav>

        <!-- 3. Góc phải: Đúng 2 nút Đăng nhập & Đăng ký khi chưa đăng nhập (Chuyển trực tiếp sang trang login.jsp) -->
        <div class="nav-actions" id="mainNavActions">
          <a href="login.jsp" class="header-btn-login">
            <i data-lucide="log-in" class="icon-sm"></i>
            Đăng nhập
          </a>
          <a href="login.jsp?action=register" class="header-btn-register">
            <i data-lucide="user-plus" class="icon-sm"></i>
            Đăng ký
          </a>
          <button class="menu-toggle" id="menuToggle" aria-label="Toggle menu" onclick="openMobileDrawer()">
            <i data-lucide="menu"></i>
          </button>
        </div>

      </div>
    </header>

    <!-- Mobile Menu Drawer -->
    <div class="mobile-drawer" id="mobileDrawer">
      <div class="drawer-header">
        <span class="logo-title">Guidia</span>
        <button class="drawer-close" id="drawerClose" onclick="closeMobileDrawer()"><i data-lucide="x"></i></button>
      </div>
      <div class="drawer-nav">
        <a href="index.jsp" class="drawer-link" onclick="closeMobileDrawer();">Trang Chủ</a>
        <a href="search.jsp" class="drawer-link idx-3" onclick="closeMobileDrawer();">
          <i data-lucide="search" class="idx-2"></i>Tra cứu hướng dẫn viên
        </a>
        <div class="idx-4"></div>
        <a href="login.jsp" class="drawer-link idx-5">
          <i data-lucide="log-in" class="idx-2"></i>Đăng nhập
        </a>
        <a href="login.jsp?action=register" class="drawer-link idx-3">
          <i data-lucide="user-plus" class="idx-2"></i>Đăng ký tài khoản
        </a>
      </div>
      <div class="drawer-footer">
        <a href="search.jsp" class="btn-primary w-full" style="display:block; text-align:center;">Khám Phá Hướng Dẫn
          Viên</a>
      </div>
    </div>

    <main>
      <!-- ========================================================================= -->
      <!-- 2.1 PHẦN PHÍA TRÊN TRANG CHỦ: KHUNG TÌM KIẾM (MỤC 2.1 vang lai.md)        -->
      <!-- ========================================================================= -->
      <section class="hero-section" id="heroSection">
        <div class="hero-bg-overlay"></div>
        <div class="hero-glow-bubble glow-1"></div>
        <div class="hero-glow-bubble glow-2"></div>

        <div class="container hero-content">
          <h1 class="hero-title idx-6">
            Chạm Vào Linh Hồn Điểm Đến <br>
            Cùng <span class="highlight-serif">Hướng Dẫn Viên Tinh Hoa</span>
          </h1>

          <p class="hero-desc">
            Tạm biệt những tour du lịch gò bó đại trà. Kết nối riêng 1:1 với người bản địa am hiểu sâu sắc về văn hóa,
            ẩm thực, lịch sử – mang lại hành trình đậm chất riêng và sang trọng bậc nhất.
          </p>

          <!-- Nút chuyển sang Trang Tra Cứu Hướng Dẫn Viên Chuyên Biệt -->
          <div class="idx-7">
            <a href="search.jsp" class="btn-primary idx-8">
              <i data-lucide="search" class="idx-9"></i>
              Tra Cứu Hướng Dẫn Viên Bản Địa
            </a>
          </div>

          <!-- 4 Trust Metric Bar -->
          <div class="hero-metrics">
            <div class="metric-item">
              <div class="metric-val" id="heroGuidesCount">13+</div>
              <div class="metric-lbl">HDV Thẻ Xanh Quốc Gia</div>
            </div>
            <div class="metric-sep"></div>
            <div class="metric-item">
              <div class="metric-val" id="heroTripsCount">49+</div>
              <div class="metric-lbl">Chuyến đi đã thực hiện</div>
            </div>
            <div class="metric-sep"></div>
            <div class="metric-item">
              <div class="metric-val">100%</div>
              <div class="metric-lbl">Hành trình may đo cá nhân hóa</div>
            </div>
            <div class="metric-sep"></div>
            <div class="metric-item">
              <div class="metric-val">24/7</div>
              <div class="metric-lbl">Hỗ trợ Concierge VIP</div>
            </div>
          </div>
        </div>
      </section>

      <!-- ========================================================================= -->
      <!-- 2.2 PHẦN PHÍA DƯỚI TRANG CHỦ: 2 KHỐI NỘI DUNG NỔI BẬT (MỤC 2.2 vang lai.md) -->
      <!-- Khối 1: 01 Địa danh nhiều khách đi nhất (Top 1 từ SQL Server)              -->
      <!-- Khối 2: Top 3-5 HDV nhiều chuyến đi nhất & đánh giá cao nhất               -->
      <!-- ========================================================================= -->

      <!-- KHỐI 1: 01 Địa danh du lịch được khách hàng đi nhiều nhất (Top 1) -->
      <section class="section destination-spotlight-section idx-10" id="topDestinationSection">
        <div class="container">
          <div id="topDestinationBanner">
            <!-- Rendered dynamically via JS from store.getTopDestination() -->
          </div>
        </div>
      </section>

      <!-- KHỐI 2: Top 3 đến 5 Hướng dẫn viên tiêu biểu nhất (ORDER BY SoChuyenDi DESC, DiemTrungBinh DESC) -->
      <section class="section guides-section idx-11" id="topGuidesSection">
        <div class="container">
          <div class="section-header-row">
            <div class="section-title-wrap">
              <div class="sub-badge">ELITE LOCAL AMBASSADORS</div>
              <h2 class="section-title">Hướng Dẫn Viên Tiêu Biểu</h2>
              <p class="section-subtitle">Top các hướng dẫn viên dẫn đầu về số chuyến
                đi thành công và điểm số hài lòng từ du khách.</p>
            </div>
            <div class="header-action-wrap">
              <a href="search.jsp" class="btn-outline-mint idx-12">
                <i data-lucide="search" class="icon-xs"></i> Xem Toàn Bộ Hướng Dẫn Viên
              </a>
            </div>
          </div>

          <!-- Top 3-5 Guides Grid (Only approved guides) -->
          <div class="guides-grid" id="topGuidesGrid">
            <!-- Rendered dynamically via JS from store.getTopGuides(4) -->
          </div>
        </div>
      </section>

      <!-- ========================================================================= -->
      <!-- 3. KHỐI ĐIỀU HƯỚNG SANG TRANG TRA CỨU HDV CHUYÊN BIỆT (search.jsp)        -->
      <!-- ========================================================================= -->
      <section class="section search-cta-section" id="search-section"
        style="background: linear-gradient(135deg, #f0fdf4 0%, #ecfdf5 100%); border-top: 1px solid #d1fae5; border-bottom: 1px solid #d1fae5; padding: 56px 0;">
        <div class="container text-center" style="max-width: 820px; margin: 0 auto;">
          <div class="sub-badge"
            style="display: inline-block; margin-bottom: 12px; background: #d1fae5; color: #065f46; padding: 4px 14px; border-radius: 99px; font-weight: 700; font-size: 0.75rem; letter-spacing: 0.05em;">
            TÌM KIẾM THEO YÊU CẦU</div>
          <h2 class="section-title" style="font-size: 2.1rem; color: #064e3b; margin-bottom: 14px;">Tra Cứu Hướng Dẫn
            Viên Toàn Quốc</h2>
          <p style="font-size: 1rem; color: #475569; margin-bottom: 28px; line-height: 1.6;">
            Khám phá danh sách đầy đủ hơn 1.200+ Hướng dẫn viên bản địa tinh hoa tại Hà Nội, Hội An, Đà Nẵng, Ninh Bình,
            Sapa, Huế... Với đầy đủ 4 bộ lọc chuyên sâu về khu vực, mức giá, ngoại ngữ và lịch rảnh.
          </p>
          <a href="search.jsp" class="btn-primary"
            style="display: inline-flex; align-items: center; gap: 8px; padding: 14px 32px; font-size: 1rem; border-radius: 12px; font-weight: 700; box-shadow: 0 8px 20px rgba(5, 150, 105, 0.25);">
            <i data-lucide="search" style="width: 18px; height: 18px;"></i> Đến Trang Tra Cứu Hướng Dẫn Viên
            <i data-lucide="arrow-right" style="width: 18px; height: 18px;"></i>
          </a>
        </div>
      </section>

      <!-- Trải Nghiệm Độc Bản May Đo (Bespoke Showcase) -->
      <section class="section experiences-section" id="experiences">
        <div class="container">
          <div class="section-title-center">
            <div class="sub-badge">CURATED PRIVATE EXPERIENCES</div>
            <h2 class="section-title">Những Chuyến Đi May Đo Không Thể Tìm Thấy Ở Bất Kỳ Đâu</h2>
            <p class="section-subtitle">Được thiết kế riêng bởi chính các hướng dẫn viên bản địa theo sở thích và nhịp
              điệu của bạn.</p>
          </div>

          <div class="experience-showcase-grid">
            <!-- Big Feature Card -->
            <div class="exp-card exp-card-hero">
              <div class="exp-img-bg idx-35">
              </div>
              <div class="exp-gradient-overlay"></div>
              <div class="exp-content">
                <span class="exp-tag">⭐ Độc Quyền Bản Địa</span>
                <h3 class="exp-title">Trà Chiều Hoàng Hôn & Thuyền Buồm Riêng Biệt Vịnh Lan Hạ</h3>
                <p class="exp-desc">Cùng chuyên gia bản xứ Cát Bà chèo kayak vào hang sáng tối bí mật, thưởng thức tiệc
                  trà hải sản tinh tế giữa lòng di sản biển vắng lặng.</p>
                <div class="exp-meta">
                  <span><i data-lucide="clock"></i> 6 giờ</span>
                  <span><i data-lucide="user"></i> Tối đa 6 khách</span>
                  <span><i data-lucide="map-pin"></i> Vịnh Lan Hạ</span>
                  <span class="exp-price">3.200.000₫ / khách</span>
                </div>
                <button class="btn-primary mt-1rem" onclick="bookExperience('Lan Ha')">Khám Phá Lộ Trình Này</button>
              </div>
            </div>

            <!-- Secondary Card 1 -->
            <div class="exp-card">
              <div class="exp-img-bg idx-36">
              </div>
              <div class="exp-gradient-overlay"></div>
              <div class="exp-content">
                <span class="exp-tag">Hà Nội Về Đêm</span>
                <h3 class="exp-title">Bản Hòa Âm Ẩm Thực Ngõ Nhỏ & Jazz Thầm Kín</h3>
                <p class="exp-desc">Theo chân nghệ sĩ Saxophone địa phương nếm vị rượu mơ thủ công và lắng nghe ký ức Hà
                  Nội xưa.</p>
                <div class="exp-meta">
                  <span><i data-lucide="clock"></i> 4 giờ</span>
                  <span><i data-lucide="map-pin"></i> Phố Cổ</span>
                </div>
                <div class="exp-price-row">
                  <span class="exp-price">1.800.000₫</span>
                  <button class="btn-icon-circle" onclick="bookExperience('Hanoi Jazz')"><i
                      data-lucide="arrow-up-right"></i></button>
                </div>
              </div>
            </div>

            <!-- Secondary Card 2 -->
            <div class="exp-card">
              <div class="exp-img-bg idx-37">
              </div>
              <div class="exp-gradient-overlay"></div>
              <div class="exp-content">
                <span class="exp-tag">Sinh Thái Bản Địa</span>
                <h3 class="exp-title">Trekking Đỉnh Mây & Liệu Pháp Thảo Dược Sapa</h3>
                <p class="exp-desc">Băng qua ruộng bậc thang không dấu chân du khách, tắm lá thuốc người Dao Đỏ cổ
                  truyền.</p>
                <div class="exp-meta">
                  <span><i data-lucide="clock"></i> 1 ngày</span>
                  <span><i data-lucide="map-pin"></i> Tả Phìn</span>
                </div>
                <div class="exp-price-row">
                  <span class="exp-price">2.200.000₫</span>
                  <button class="btn-icon-circle" onclick="bookExperience('Sapa Trek')"><i
                      data-lucide="arrow-up-right"></i></button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <!-- Tiêu chuẩn Sang Trọng & Ký Quỹ Escrow -->
      <section class="section why-section" id="why-us">
        <div class="container">
          <div class="why-grid">
            <div class="why-left">
              <div class="sub-badge">TIÊU CHUẨN ĐẲNG CẤP</div>
              <h2 class="section-title">Tại Sao Du Khách Tinh Tế Chọn Guidia?</h2>
              <p class="why-desc">Guidia là cầu nối trực tiếp loại bỏ mọi phiền toái từ các khâu trung gian, mang đến
                trải nghiệm minh bạch, an toàn tuyệt đối và đậm chất chiều chuộng bản thân.</p>

              <div class="value-propositions">
                <div class="value-item">
                  <div class="value-icon"><i data-lucide="badge-check"></i></div>
                  <div>
                    <h4>100% HDV Thẩm Định Nghiêm Ngặt</h4>
                    <p>Mỗi hướng dẫn viên đều được phỏng vấn trực tiếp, xác thực giấy phép hành nghề quốc tế/nội địa và
                      kiểm tra lý lịch.</p>
                  </div>
                </div>

                <div class="value-item">
                  <div class="value-icon"><i data-lucide="sliders"></i></div>
                  <div>
                    <h4>Hoàn Toàn Linh Hoạt & Cá Nhân Hóa</h4>
                    <p>Bạn tự do điều chỉnh lịch trình theo ý muốn, dừng lại lâu hơn ở nơi bạn thích, không vội vã,
                      không áp lực điểm mua sắm.</p>
                  </div>
                </div>

                <div class="value-item">
                  <div class="value-icon"><i data-lucide="shield-alert"></i></div>
                  <div>
                    <h4>Ký Quỹ Escrow An Toàn 100%</h4>
                    <p>Tiền thanh toán được giữ an toàn tại tài khoản trung gian Escrow và chỉ giải ngân cho HDV sau khi
                      bạn xác nhận hoàn thành tour.</p>
                  </div>
                </div>
              </div>
            </div>

            <div class="why-right">
              <div class="interactive-preview-card">
                <div class="card-glass-top">
                  <div class="status-indicator">
                    <span class="live-pulse"></span>
                    <span>Trực Tiếp: Đang kết nối 84 HDV rảnh lịch</span>
                  </div>
                  <div class="quote-text">“Chuyến đi cùng bạn Yến ở Hội An là trải nghiệm tuyệt vời nhất gia đình tôi
                    từng có. Tinh tế, không xô bồ, các con tôi được học gốm và làm đèn lồng từ nghệ nhân thực thụ!”
                  </div>

                  <div class="client-info">
                    <img src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=200&q=80"
                      alt="Ms. Thảo Linh" class="client-avatar">
                    <div>
                      <div class="client-name">Doanh nhân Thảo Linh & Gia đình</div>
                      <div class="client-sub">Hành trình Hội An Tinh Hoa • Tháng 10/2026</div>
                    </div>
                  </div>
                </div>

                <div class="luxury-badge-stamp">
                  <i data-lucide="award"></i>
                  <span>Certified Excellence</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </main>

    <!-- ========================================================================= -->
    <!-- FOOTER                                                                    -->
    <!-- ========================================================================= -->
    <footer class="footer">
      <div class="container footer-content">
        <div class="footer-col footer-brand">
          <div class="brand-logo footer-logo">
            <div class="logo-icon"><i data-lucide="compass"></i></div>
            <div class="logo-text">
              <span class="logo-title text-white">Guidia</span>
              <span class="logo-sub text-mint">Bespoke Local Journeys</span>
            </div>
          </div>
          <p class="footer-desc">Nền tảng công nghệ du lịch kết nối du khách với những người dẫn đường bản địa đẳng cấp
            nhất Việt Nam.</p>
          <div class="social-links">
            <a href="#" class="social-icon"><i data-lucide="instagram"></i></a>
            <a href="#" class="social-icon"><i data-lucide="facebook"></i></a>
            <a href="#" class="social-icon"><i data-lucide="linkedin"></i></a>
          </div>
        </div>

        <div class="footer-col">
          <h4 class="footer-head">Điểm Đến Độc Bản</h4>
          <ul class="footer-links">
            <li><a href="javascript:void(0)" onclick="quickFilterCity('Hà Nội'); goToGuideSearch();">Hà Nội Ngàn Năm</a>
            </li>
            <li><a href="javascript:void(0)" onclick="quickFilterCity('Hội An'); goToGuideSearch();">Phố Cổ Hội An</a>
            </li>
            <li><a href="javascript:void(0)" onclick="quickFilterCity('Sapa'); goToGuideSearch();">Đại Ngàn Sapa</a>
            </li>
            <li><a href="javascript:void(0)" onclick="quickFilterCity('Huế'); goToGuideSearch();">Cố Đô Huế Thơ Mộng</a>
            </li>
            <li><a href="javascript:void(0)" onclick="quickFilterCity('Hồ Chí Minh'); goToGuideSearch();">TP. Hồ Chí
                Minh</a></li>
          </ul>
        </div>

        <div class="footer-col">
          <h4 class="footer-head">Dành Cho Du Khách</h4>
          <ul class="footer-links">
            <li><a href="javascript:void(0)" onclick="goToGuideSearch()">Tìm Hướng Dẫn Viên</a></li>
            <li><a href="login.jsp?action=register">Đăng Ký Tài Khoản</a></li>
            <li><a href="login.jsp">Đăng Nhập Khách Hàng</a></li>
            <li><a href="#why-us">Chính Sách Ký Quỹ Escrow</a></li>
          </ul>
        </div>

        <div class="footer-col">
          <h4 class="footer-head">Dành Cho Hướng Dẫn Viên</h4>
          <ul class="footer-links">
            <li><a href="login.jsp?action=register&role=guide">Đăng Ký Gia Nhập Mạng Lưới HDV</a></li>
            <li><a href="login.jsp">Cổng Đăng Nhập HDV</a></li>
            <li><a href="#why-us">Quy Chuẩn Đạo Đức HDV</a></li>
            <li><a href="#">Điều Khoản Dịch Vụ</a></li>
            <li><a href="#">Chính Sách Bảo Mật</a></li>
          </ul>
        </div>
      </div>

      <div class="container footer-bottom">
        <p>© 2026 Guidia Co., Ltd. Tất cả quyền được bảo lưu. Thiết kế sang trọng tông Xanh Mint Pastel tự nhiên.</p>
        <div class="footer-payment-badges">
          <span>Bảo mật thanh toán quốc tế</span>
          <span class="badge-lock"><i data-lucide="lock" class="icon-xs"></i> 256-bit SSL</span>
        </div>
      </div>
    </footer>

    <!-- ========================================================================= -->
    <!-- MODAL: HỒ SƠ CHI TIẾT HDV (MỤC 3.2 vang lai.md - Bước 5-7 & Luồng phụ A2)   -->
    <!-- Hiển thị đầy đủ 6 thông tin bắt buộc:                                     -->
    <!-- 1. Giới thiệu  2. Thẻ hành nghề  3. Kinh nghiệm & Ngoại ngữ               -->
    <!-- 4. Bảng giá    5. Lịch rảnh (xanh rảnh/đỏ bận)  6. Đánh giá của khách     -->
    <!-- 2 Nút: "Nhắn tin" & "Đặt lịch". Khách chưa login -> A2 chặn, lưu session,  -->
    <!-- mở Login (UC03); login xong tự động quay lại đúng hồ sơ này.              -->
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

    <!-- Xác thực tài khoản (Đăng nhập UC03 & Đăng ký UC01): Được dẫn trực tiếp tới trang chuyên biệt login.jsp -->

    <!-- ========================================================================= -->
    <!-- MODAL: ĐẶT LỊCH TOUR RIÊNG & KÝ QUỸ ESCROW                                -->
    <!-- ========================================================================= -->
    <div class="modal-overlay" id="bookingModal">
      <div class="modal-container modal-booking">
        <button class="modal-close-btn" onclick="closeModal('bookingModal')"><i data-lucide="x"></i></button>
        <div class="booking-modal-head">
          <div class="sub-badge">RESERVATION REQUEST</div>
          <h3 class="modal-title">Đặt Lịch Với Hướng Dẫn Viên Bản Địa</h3>
          <p class="modal-sub">Trợ lý Guidia Concierge sẽ liên hệ hỗ trợ bạn sắp xếp lịch trình trong vòng 15 phút.</p>
        </div>

        <form class="booking-form" onsubmit="event.preventDefault(); submitBooking();">
          <input type="hidden" id="bookingModalGuideId" value="2">
          <input type="hidden" id="bookingModalGuideName" value="Võ Quốc Minh">
          <input type="hidden" id="bookingLocationInput" value="Đà Nẵng & Hội An">
          <input type="hidden" id="bookingPriceInput" value="1250000">

          <div class="form-row">
            <div class="form-group">
              <label>Họ và tên của bạn</label>
              <input type="text" id="bookingNameInput" required placeholder="Ví dụ: Nguyễn Minh Anh" class="form-input"
                value="Phạm Minh Dũng">
            </div>
            <div class="form-group">
              <label>Số điện thoại / Zalo</label>
              <input type="tel" id="bookingPhoneInput" required placeholder="0912 xxx xxx" class="form-input"
                value="0980000001">
            </div>
          </div>

          <div class="form-row">
            <div class="form-group">
              <label>Ngày & Giờ khởi hành <span class="idx-40">*</span></label>
              <div class="idx-41">
                <input type="date" id="bookingStartDateInput" required class="form-input" value="2026-11-20"
                  onchange="handleStartDateChange()">
                <input type="time" id="bookingStartTimeInput" required class="form-input" value="08:00">
              </div>
              <small class="idx-42">* Hệ thống tự động kiểm tra lịch rảnh của
                HDV</small>
            </div>
            <div class="form-group">
              <label>Ngày & Giờ kết thúc <span class="idx-40">*</span></label>
              <div class="idx-41">
                <input type="date" id="bookingEndDateInput" required class="form-input" value="2026-11-20">
                <input type="time" id="bookingEndTimeInput" required class="form-input" value="17:30">
              </div>
              <small class="idx-42">* Dự kiến thời gian hoàn tất tour</small>
            </div>
          </div>

          <div class="form-group">
            <label>Quy mô số lượng khách <span class="idx-40">*</span></label>
            <select class="form-input" id="bookingGuestsInput" required>
              <option value="1">1 Khách (Cá nhân / Riêng tư)</option>
              <option value="2" selected>2 Khách (Cặp đôi / Bạn bè)</option>
              <option value="3">3 Khách (Gia đình nhỏ)</option>
              <option value="4">4 Khách (Gia đình)</option>
              <option value="6">6 Khách (Nhóm bạn)</option>
              <option value="8">8 Khách (Đoàn du lịch VIP)</option>
            </select>
          </div>

          <div class="form-group">
            <label>Yêu cầu hoặc sở thích đặc biệt</label>
            <textarea rows="3" id="bookingNotesInput" class="form-input"
              placeholder="Ví dụ: Cần người am hiểu món chay, chụp ảnh đẹp, có người cao tuổi đi cùng...">Muốn tìm hiểu sâu về phố cổ và thưởng trà đạo.</textarea>
          </div>

          <div class="idx-43">
            <div class="idx-44">
              <span>Tạm tính chi phí tour:</span>
              <strong id="bookingEstimatedPriceText">1.250.000₫</strong>
            </div>
            <div class="idx-45">
              <span>Chính sách ký quỹ Escrow:</span>
              <span>Tạm giữ an toàn 100% đến khi tour xong</span>
            </div>
          </div>

          <button type="submit" class="btn-mint-solid w-full">
            <i data-lucide="shield-check"></i> Xác Nhận Đặt Tour & Ký Quỹ Escrow
          </button>
        </form>
      </div>
    </div>

    <!-- ========================================================================= -->
    <!-- MODAL: LIVE CHAT VỚI HƯỚNG DẪN VIÊN                                       -->
    <!-- ========================================================================= -->
    <div class="modal-overlay" id="customerChatModal">
      <div class="modal-container idx-46">
        <div class="idx-47">
          <div class="idx-48">
            <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150" id="custChatGuideAvatar"
              class="idx-49">
            <div>
              <div class="idx-50" id="custChatGuideName">Võ Quốc Minh</div>
              <div class="idx-51">● Đang trực tuyến (Sẵn sàng trao đổi)</div>
            </div>
          </div>
          <button class="modal-close-btn idx-52" onclick="closeModal('customerChatModal')"><i
              data-lucide="x"></i></button>
        </div>

        <div id="custChatMessagesBox" class="idx-53">
          <!-- Render messages -->
        </div>

        <form id="custChatForm" onsubmit="event.preventDefault(); handleCustomerSendMessage();" class="idx-54">
          <input type="text" id="custChatInput" placeholder="Nhập tin nhắn trao đổi với HDV..."
            class="form-input idx-55" required>
          <button type="submit" class="btn-primary idx-56"><i data-lucide="send" class="icon-sm"></i></button>
        </form>
      </div>
    </div>

    <!-- Toast Notification -->
    <div class="toast-notification" id="toastNotification">
      <i data-lucide="check-circle" class="toast-icon"></i>
      <span id="toastMessage">Yêu cầu đã được gửi thành công!</span>
    </div>

    <!-- Guidia Core Store -->
    <script src="js/store.js"></script>

    <script>
      /* ==========================================================================
         GUIDIA - KHÁCH VÃNG LAI & USE CASE SCRIPT (vang lai.md)
         ========================================================================== */

      let currentViewingGuideId = null;
      let currentChatGuideId = 2;

      // 1. Kiểm tra xác thực người dùng trên Header
      function checkUserAuth() {
        const curUserStr = sessionStorage.getItem('guidia_current_user') || localStorage.getItem('guidia_current_user');
        const navContainer = document.getElementById('mainNavActions');

        if (curUserStr) {
          try {
            const user = JSON.parse(curUserStr);
            const roleMap = {
              'admin': { label: 'Ban Quản Trị', link: 'admin.jsp', icon: 'shield' },
              'guide': { label: 'Cổng HDV', link: 'guide.jsp', icon: 'compass' },
              'customer': { label: 'Khách Du Lịch', link: 'customer.jsp', icon: 'user' }
            };
            const r = roleMap[user.role] || roleMap['customer'];

            if (navContainer) {
              navContainer.innerHTML = `
          <div class="idx-57">
            <a href="${r.link}" class="idx-58" title="Đi tới trang làm việc">
              <img src="${user.avatar || 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=120'}" 
                   class="idx-59">
              <div class="idx-60">
                <div class="idx-61">${user.name}</div>
                <div class="idx-62">${r.label}</div>
              </div>
            </a>
            <button onclick="handleLogout()" class="header-btn-login idx-65">
              <i data-lucide="log-out" class="idx-64"></i> Đăng Xuất
            </button>
          </div>
        `;
            }
            if (window.lucide) window.lucide.createIcons();
            return;
          } catch (e) { }
        }

        // Khách vãng lai: Đúng 2 nút Đăng nhập & Đăng ký (Liên kết trực tiếp đến trang login.jsp)
        if (navContainer) {
          navContainer.innerHTML = `
      <a href="login.jsp" class="header-btn-login idx-66">
        <i data-lucide="log-in" class="icon-sm"></i>
        Đăng nhập
      </a>
      <a href="login.jsp?action=register" class="header-btn-register idx-66">
        <i data-lucide="user-plus" class="icon-sm"></i>
        Đăng ký
      </a>
      <button class="menu-toggle" id="menuToggle" aria-label="Toggle menu" onclick="openMobileDrawer()">
        <i data-lucide="menu"></i>
      </button>
    `;
        }
        if (window.lucide) window.lucide.createIcons();
      }

      function handleLogout() {
        sessionStorage.removeItem('guidia_current_user');
        localStorage.removeItem('guidia_current_user');
        localStorage.removeItem('guidia_current_customer_id_v2');
        localStorage.removeItem('guidia_current_guide_id_v2');
        sessionStorage.clear();
        checkUserAuth();
        showToast('Đã đăng xuất tài khoản thành công!');
      }

      // 2. Chuyển đổi qua lại giữa Trang Chủ và Tra cứu HDV
      function showHomeView(e) {
        if (e) e.preventDefault();
        document.getElementById('navHome').classList.add('active');
        document.getElementById('navSearch').classList.remove('active');
        window.scrollTo({ top: 0, behavior: 'smooth' });
      }

      function goToGuideSearch(e) {
        if (e) e.preventDefault();
        window.location.href = 'search.jsp';
      }

      function goToGuideSearchWithCity(cityName) {
        window.location.href = 'search.jsp?city=' + encodeURIComponent(cityName || '');
      }

      function quickFilterCity(cityName) {
        window.location.href = 'search.jsp?city=' + encodeURIComponent(cityName || '');
      }

      // 2.2 Khối 1: Hiển thị 01 Địa danh nhiều khách đi nhất (Top 1)
      function renderTopDestinationBlock() {
        const container = document.getElementById('topDestinationBanner');
        if (!container || !window.guidiaStore) return;

        const dest = window.guidiaStore.getTopDestination ? window.guidiaStore.getTopDestination() : {
          name: 'Hội An, Quảng Nam',
          keyword: 'Hội An',
          tripsCount: 85,
          image: 'https://images.unsplash.com/photo-1559592413-7cec4d0cae2b?auto=format&fit=crop&w=1400&q=80',
          description: 'Đô thị cổ nghìn năm với những dãy phố vàng rêu phong bên dòng sông Hoài thơ mộng, lễ hội đèn lồng lung linh huyền ảo và nền ẩm thực Phố Hội trứ danh được bảo tồn nguyên vẹn qua nhiều thế hệ.'
        };

        container.innerHTML = `
    <div class="dest-spotlight-card">
      <div class="dest-spotlight-bg" style="background-image: url('${dest.image}');"></div>
      <div class="dest-spotlight-overlay"></div>
      <div class="dest-spotlight-content">
        <div class="idx-67">
          <div class="dest-badge-flame">
            <i data-lucide="flame" class="idx-68"></i>
            <span>ĐỊA DANH ĐƯỢC DU KHÁCH LỰA CHỌN NHIỀU NHẤT</span>
          </div>
          <h2 class="idx-69">
            ${dest.name}
          </h2>
          <div class="idx-70">
            <span class="idx-71">
              🏆 ${dest.tripsCount}+ chuyến đi đã thực hiện
            </span>
          </div>
          <p class="idx-73">
            ${dest.description}
          </p>
        </div>
        <div>
          <button onclick="goToGuideSearchWithCity('${dest.keyword || dest.name}')" class="btn-primary idx-74">
            Xem các Hướng dẫn viên tại đây
            <i data-lucide="arrow-right" class="idx-75"></i>
          </button>
        </div>
      </div>
    </div>
  `;
        if (window.lucide) window.lucide.createIcons();
      }

      // 2.2 Khối 2: Top 3 đến 5 Hướng dẫn viên tiêu biểu nhất (ORDER BY SoChuyenDi DESC, DiemTrungBinh DESC)
      function renderTopEliteGuides() {
        const grid = document.getElementById('topGuidesGrid');
        if (!grid || !window.guidiaStore) return;

        const topGuides = window.guidiaStore.getTopGuides ? window.guidiaStore.getTopGuides(4) : window.guidiaStore.getApprovedGuides().slice(0, 4);

        grid.innerHTML = topGuides.map(g => {
          const dailyPriceFormatted = (g.dailyPrice || 1500000).toLocaleString('vi-VN') + '₫';
          const langTags = Array.isArray(g.languages)
            ? g.languages.map(l => `<span class="tag-pill">${l}</span>`).join('')
            : (g.languages || 'Tiếng Việt, Tiếng Anh').split(',').map(l => `<span class="tag-pill">${l.trim()}</span>`).join('');

          const certBadge = `<span class="badge-verified"><i data-lucide="shield-check"></i> ${g.certType ? (g.certType.includes('Quốc Tế') ? 'Thẻ Quốc Tế' : 'Thẻ Nội Địa') : 'Thẻ Đã Duyệt'}</span>`;
          const completedTrips = g.completedTrips !== undefined ? g.completedTrips : (g.completedCount || 0);
          const reviewsCount = g.reviewCount !== undefined ? g.reviewCount : 0;

          return `
      <div class="guide-card" data-guide-id="${g.id}">
        <div class="guide-card-top">
          <div class="guide-photo-wrap">
            <img src="${g.avatar || 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500'}" alt="${g.name}" class="guide-photo" onerror="this.src='https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500'">
            ${certBadge}
            <span class="badge-rating"><i data-lucide="star"></i> ${g.rating ? Number(g.rating).toFixed(1) : '5.0'} (${reviewsCount})</span>
          </div>
        </div>
        <div class="guide-card-body">
          <div class="idx-76">
            <div class="guide-location idx-77"><i data-lucide="map-pin"></i> ${g.city || g.region || 'Việt Nam'}</div>
            <span class="trip-count-badge idx-78"><i data-lucide="award" class="idx-79"></i> ${completedTrips} chuyến</span>
          </div>
          <h3 class="guide-name idx-80">${g.name}</h3>
          <p class="guide-title-role idx-80">${g.experienceYears || '5 năm kinh nghiệm'} • ${g.certType || 'HDV Bản Địa'}</p>
          <p class="guide-bio">${g.bio || 'Hướng dẫn viên bản địa giàu kinh nghiệm, am hiểu sâu sắc văn hóa địa phương.'}</p>
          
          <div class="guide-tags">
            ${langTags}
          </div>

          <div class="guide-footer">
            <div class="guide-price-box">
              <span class="price-lbl">Chi phí từ</span>
              <div class="price-val">${dailyPriceFormatted} <small>/ ngày</small></div>
            </div>
            <button class="btn-card-action" onclick="openGuideDetail('${g.id}')">
              Xem chi tiết <i data-lucide="arrow-right"></i>
            </button>
          </div>
        </div>
      </div>
    `;
        }).join('');

        if (window.lucide) window.lucide.createIcons();
      }

      // 3. Tra cứu Hướng dẫn viên (UC02) - Đổ danh sách HDV & Bộ lọc
      function handleGuestFilterSearch() {
        renderGuestGuidesGrid();
      }

      // Danh mục Tỉnh thành / Địa danh trực thuộc từng Vùng miền
      const regionCitiesMap = {
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

      function handleRegionChange() {
        const regSelect = document.getElementById('guestFilterRegion');
        const citySelect = document.getElementById('guestFilterCity');
        if (!regSelect || !citySelect) return;

        const curReg = regSelect.value;
        const list = regionCitiesMap[curReg] || regionCitiesMap.all;
        citySelect.innerHTML = list.map(item => `<option value="${item.value}">${item.label}</option>`).join('');
        citySelect.value = 'all';
        renderGuestGuidesGrid();
      }

      function resetGuestFilters() {
        if (document.getElementById('guestSearchKeyword')) document.getElementById('guestSearchKeyword').value = '';
        if (document.getElementById('guestFilterRegion')) {
          document.getElementById('guestFilterRegion').value = 'all';
          handleRegionChange();
        }
        if (document.getElementById('guestFilterCity')) document.getElementById('guestFilterCity').value = 'all';
        if (document.getElementById('guestFilterPrice')) document.getElementById('guestFilterPrice').value = 'all';
        if (document.getElementById('guestFilterLanguage')) document.getElementById('guestFilterLanguage').value = 'all';
        if (document.getElementById('guestFilterDate')) document.getElementById('guestFilterDate').value = '';
        if (document.getElementById('guestSortBy')) document.getElementById('guestSortBy').value = 'rating_desc';

        renderGuestGuidesGrid();
        showToast('Đã đặt lại toàn bộ bộ lọc về mặc định!');
      }

      function renderGuestGuidesGrid() {
        const grid = document.getElementById('guestAllGuidesGrid');
        const emptyBox = document.getElementById('guestSearchEmpty');
        const countLabel = document.getElementById('guestSearchCount');
        if (!grid || !window.guidiaStore) return;

        // Chỉ lấy Hướng dẫn viên đã được duyệt và hoạt động hợp lệ
        let guides = window.guidiaStore.getApprovedGuides ? window.guidiaStore.getApprovedGuides() : [];

        const keyword = (document.getElementById('guestSearchKeyword') ? document.getElementById('guestSearchKeyword').value : '').toLowerCase().trim();
        const region = document.getElementById('guestFilterRegion') ? document.getElementById('guestFilterRegion').value : 'all';
        const city = document.getElementById('guestFilterCity') ? document.getElementById('guestFilterCity').value : 'all';
        const price = document.getElementById('guestFilterPrice') ? document.getElementById('guestFilterPrice').value : 'all';
        const language = document.getElementById('guestFilterLanguage') ? document.getElementById('guestFilterLanguage').value : 'all';
        const travelDate = document.getElementById('guestFilterDate') ? document.getElementById('guestFilterDate').value : '';
        const sortBy = document.getElementById('guestSortBy') ? document.getElementById('guestSortBy').value : 'rating_desc';

        // Lọc theo từ khóa
        if (keyword) {
          guides = guides.filter(g => {
            const name = (g.name || '').toLowerCase();
            const bio = (g.bio || '').toLowerCase();
            const city = (g.city || '').toLowerCase();
            const reg = (g.region || '').toLowerCase();
            const langs = (Array.isArray(g.languages) ? g.languages.join(' ') : (g.languages || '')).toLowerCase();
            return name.includes(keyword) || bio.includes(keyword) || city.includes(keyword) || reg.includes(keyword) || langs.includes(keyword);
          });
        }

        // Lọc theo vùng miền
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

        // Lọc theo tỉnh thành / địa danh
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

        // Lọc theo mức giá
        if (price !== 'all') {
          guides = guides.filter(g => {
            const p = g.dailyPrice || 1500000;
            if (price === 'under_1m') return p < 1000000;
            if (price === '1m_to_2m') return p >= 1000000 && p <= 2000000;
            if (price === 'over_2m') return p > 2000000;
            return true;
          });
        }

        // Lọc theo ngoại ngữ
        if (language !== 'all') {
          guides = guides.filter(g => {
            const langs = Array.isArray(g.languages) ? g.languages.join(' ') : (g.languages || '');
            return langs.toLowerCase().includes(language.toLowerCase());
          });
        }

        // Lọc theo ngày cần đi (loại bỏ HDV đã bận vào ngày đó)
        if (travelDate) {
          const trips = window.guidiaStore.getTrips ? window.guidiaStore.getTrips() : [];
          const busyGuideIds = new Set(
            trips
              .filter(t => t.startDate === travelDate && t.status !== 'cancelled' && t.status !== 'cancelled_refunded')
              .map(t => String(t.guideId))
          );
          guides = guides.filter(g => !busyGuideIds.has(String(g.id)));
        }

        // Sắp xếp
        if (sortBy === 'rating_desc') {
          guides.sort((a, b) => (b.rating || 5.0) - (a.rating || 5.0));
        } else if (sortBy === 'price_asc') {
          guides.sort((a, b) => (a.dailyPrice || 1500000) - (b.dailyPrice || 1500000));
        } else if (sortBy === 'price_desc') {
          guides.sort((a, b) => (b.dailyPrice || 1500000) - (a.dailyPrice || 1500000));
        } else if (sortBy === 'trips_desc') {
          guides.sort((a, b) => (b.completedTrips || b.completedCount || 0) - (a.completedTrips || a.completedCount || 0));
        }

        if (countLabel) countLabel.textContent = guides.length;

        // Luồng phụ A1: Không có kết quả phù hợp
        if (guides.length === 0) {
          grid.style.display = 'none';
          if (emptyBox) emptyBox.style.display = 'block';
          return;
        }

        if (emptyBox) emptyBox.style.display = 'none';
        grid.style.display = 'grid';

        grid.innerHTML = guides.map(g => {
          const dailyPriceFormatted = (g.dailyPrice || 1500000).toLocaleString('vi-VN') + '₫';
          const langTags = Array.isArray(g.languages)
            ? g.languages.map(l => `<span class="tag-pill">${l}</span>`).join('')
            : (g.languages || 'Tiếng Việt, Tiếng Anh').split(',').map(l => `<span class="tag-pill">${l.trim()}</span>`).join('');

          const certBadge = `<span class="badge-verified"><i data-lucide="shield-check"></i> ${g.certType ? (g.certType.includes('Quốc Tế') ? 'Thẻ Quốc Tế' : 'Thẻ Nội Địa') : 'Thẻ Đã Duyệt'}</span>`;

          return `
      <div class="guide-card" data-guide-id="${g.id}">
        <div class="guide-card-top">
          <div class="guide-photo-wrap">
            <img src="${g.avatar || 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500'}" alt="${g.name}" class="guide-photo" onerror="this.src='https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500'">
            ${certBadge}
            <span class="badge-rating"><i data-lucide="star"></i> ${g.rating || 5.0} (${g.reviewCount || 20})</span>
          </div>
        </div>
        <div class="guide-card-body">
          <div class="guide-location idx-80"><i data-lucide="map-pin"></i> ${g.city || g.region || 'Việt Nam'}</div>
          <h3 class="guide-name idx-80">${g.name}</h3>
          <p class="guide-title-role idx-80">${g.experienceYears || '5 năm kinh nghiệm'} • ${g.certType || 'HDV Bản Địa'}</p>
          <p class="guide-bio">${g.bio || 'Hướng dẫn viên bản địa am hiểu sâu sắc văn hóa, lịch sử và ẩm thực địa phương.'}</p>
          
          <div class="guide-tags">
            ${langTags}
          </div>

          <div class="guide-footer">
            <div class="guide-price-box">
              <span class="price-lbl">Chi phí từ</span>
              <div class="price-val">${dailyPriceFormatted} <small>/ ngày</small></div>
            </div>
            <button class="btn-card-action" onclick="openGuideDetail('${g.id}')">
              Xem chi tiết <i data-lucide="arrow-right"></i>
            </button>
          </div>
        </div>
      </div>
    `;
        }).join('');

        if (window.lucide) window.lucide.createIcons();
      }

      // 3.2 Mở Hồ sơ chi tiết HDV (Gồm 6 mục thông tin bắt buộc theo Bước 6 của UC02)
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

        // Mock lịch rảnh 7 ngày tới (Lịch rảnh HDV - Mục 5)
        const today = new Date();
        const scheduleDays = [];
        for (let i = 0; i < 7; i++) {
          const d = new Date(today);
          d.setDate(today.getDate() + i);
          const dayStr = d.toLocaleDateString('vi-VN', { weekday: 'short', day: '2-digit', month: '2-digit' });
          const isBusy = (i === 2 || i === 5); // Ngày bận mô phỏng
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

        // Render 6 thông tin chi tiết:
        // 1. Giới thiệu bản thân
        // 2. Thẻ hành nghề (số thẻ, xác thực)
        // 3. Kinh nghiệm & Ngoại ngữ
        // 4. Bảng giá
        // 5. Lịch rảnh (xanh rảnh / đỏ bận)
        // 6. Đánh giá của khách trước đó
        contentBox.innerHTML = `
    <div class="idx-81" style="display: grid !important; grid-template-columns: 290px 1fr !important; gap: 36px !important; align-items: start !important; width: 100% !important; box-sizing: border-box !important; overflow-x: hidden !important;">
      
      <!-- Cột Trái: Ảnh & Nút Hành Động (Sticky theo thanh cuộn ngoài) -->
      <div class="idx-82" style="position: sticky !important; top: 0 !important; text-align: center !important; border-right: 1px solid #e2e8f0 !important; padding-right: 28px !important; width: 290px !important; box-sizing: border-box !important;">
        <img src="${guide.avatar || 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500'}" 
             alt="${guide.name}" 
             class="idx-83">
        <h3 class="idx-84">${guide.name}</h3>
        <div class="idx-85">
          <i data-lucide="shield-check" class="idx-86"></i>
          ${guide.certType || 'Thẻ Hướng Dẫn Viên Quốc Tế'}
        </div>
        <div class="idx-87">
          ★ <strong>${guide.rating || 5.0}</strong> (${guide.reviewCount || 0} đánh giá thực tế)
        </div>

        <!-- 4. Bảng giá dịch vụ -->
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

        <!-- 2 Nút hành động () -->
        <div class="idx-93">
          <button class="btn-primary w-full idx-94" onclick="bookGuideDirectly('${guide.id}')">
            <i data-lucide="calendar-check" class="icon-xs"></i> Đặt Lịch
          </button>
          <button class="btn-outline-mint w-full idx-94" onclick="openChatFromProfile('${guide.id}')">
            <i data-lucide="message-circle" class="icon-xs"></i> Nhắn Tin
          </button>
        </div>
      </div>

      <!-- Cột Phải: Cuộn tự nhiên cùng thanh cuộn ngoài (KHÔNG CÓ THANH CUỘN BÊN TRONG) -->
      <div class="idx-95" style="max-height: none !important; overflow-y: visible !important; overflow-x: hidden !important; width: 100% !important; box-sizing: border-box !important; padding-right: 8px !important;">
        
        <!-- 1. Giới thiệu bản thân -->
        <div class="idx-96">
          <h4 class="idx-97">
            <i data-lucide="user" class="idx-98"></i> 1. Giới Thiệu Bản Thân
          </h4>
          <p class="idx-99" style="line-height: 1.7 !important; font-size: 0.92rem !important; color: #475569 !important;">
            ${guide.bio || 'Chào mừng quý khách đến với hành trình khám phá di sản và bản sắc bản địa. Tôi cam kết mang đến góc nhìn sâu sắc, chân thực và thoải mái nhất.'}
          </p>
        </div>

        <!-- 2. Thẻ hành nghề -->
        <div class="idx-100" style="width: 100% !important; box-sizing: border-box !important; overflow-x: hidden !important; background: #f8fafc !important; border: 1px solid #e2e8f0 !important; border-radius: 12px !important; padding: 16px 20px !important; margin-bottom: 20px !important;">
          <h4 class="idx-101">
            <i data-lucide="award" class="idx-98"></i> 2. Giấy Phép & Thẻ Hành Nghề
          </h4>
          <div class="idx-102" style="display: grid !important; grid-template-columns: 1fr 1fr !important; gap: 12px 24px !important; font-size: 0.9rem !important; width: 100% !important; box-sizing: border-box !important; overflow-x: hidden !important;">
            <div style="white-space: normal !important; word-break: break-word !important; line-height: 1.6 !important;">Số thẻ hành nghề: <strong class="idx-103">${guide.certNumber || 'VN-HDV-' + guide.id}</strong></div>
            <div style="white-space: normal !important; word-break: break-word !important; line-height: 1.6 !important;">Loại thẻ: <strong class="idx-104">${guide.certType || 'Thẻ Quốc Tế'}</strong></div>
            <div style="white-space: normal !important; word-break: break-word !important; line-height: 1.6 !important;">Khu vực đăng ký: <strong class="idx-103">${guide.region || guide.city || 'Việt Nam'}</strong></div>
            <div style="white-space: normal !important; word-break: break-word !important; line-height: 1.6 !important;">Chứng thực: <span class="idx-3">● Đã Quản Trị Viên Phê Duyệt 100%</span></div>
          </div>
        </div>

        <!-- 3. Kinh nghiệm & Ngoại ngữ -->
        <div class="idx-96">
          <h4 class="idx-97">
            <i data-lucide="briefcase" class="idx-98"></i> 3. Kinh Nghiệm & Ngoại Ngữ
          </h4>
          <p class="idx-105">
            Thời gian hoạt động chuyên nghiệp: <strong>${guide.experienceYears || '5+ năm kinh nghiệm'}</strong>
          </p>
          <div class="idx-106">
            ${langs.map(l => `<span class="tag-pill idx-107">${l.trim()}</span>`).join('')}
          </div>
        </div>

        <!-- 5. Lịch rảnh của HDV (xanh rảnh / đỏ bận) -->
        <div class="idx-108">
          <div class="idx-109">
            <h4 class="idx-110">
              <i data-lucide="calendar" class="idx-98"></i> 5. Lịch Trình Rảnh (7 Ngày Tới)
            </h4>
            <div class="idx-111">
              <span class="idx-112">● Rảnh</span>
              <span class="idx-113">● Bận</span>
            </div>
          </div>
          
          <div class="calendar-grid-week">
            ${scheduleDays.map(sd => `
              <div class="cal-day-cell ${sd.status === 'free' ? 'cal-day-free' : 'cal-day-busy'}">
                <div class="idx-114">${sd.dateStr}</div>
                <div class="idx-115">${sd.label}</div>
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

      // Xử lý khi ấn "Nhắn tin" hoặc "Đặt lịch" (Khách vãng lai không được nhắn tin/đặt lịch -> yêu cầu đăng nhập)
      function openChatFromProfile(guideId) {
        currentViewingGuideId = guideId;
        const curUserStr = sessionStorage.getItem('guidia_current_user') || localStorage.getItem('guidia_current_user');

        // Chưa đăng nhập (Khách vãng lai) -> Không được nhắn tin, yêu cầu đăng nhập
        if (!curUserStr) {
          sessionStorage.setItem('pending_guide_id', guideId);
          sessionStorage.setItem('pending_guide_action', 'chat');
          closeModal('guideModal');
          showToast('Khách vãng lai chưa thể nhắn tin trực tiếp. Vui lòng đăng nhập tài khoản Khách Du Lịch!');
          setTimeout(() => {
            window.location.href = 'login.jsp';
          }, 800);
          return;
        }

        // Đã đăng nhập Khách Hàng -> Chuyển thẳng vào Không Gian Khách Du Lịch (Tab Nhắn Tin & Tư Vấn)
        closeModal('guideModal');
        window.location.href = `customer.jsp?guideId=${guideId}#chat`;
      }

      function bookGuideDirectly(guideId) {
        currentViewingGuideId = guideId;
        const curUserStr = sessionStorage.getItem('guidia_current_user') || localStorage.getItem('guidia_current_user');

        // Chưa đăng nhập (Khách vãng lai) -> Không được đặt lịch, yêu cầu đăng nhập
        if (!curUserStr) {
          sessionStorage.setItem('pending_guide_id', guideId);
          sessionStorage.setItem('pending_guide_action', 'book');
          closeModal('guideModal');
          showToast('Khách vãng lai chưa thể đặt lịch. Vui lòng đăng nhập tài khoản Khách Du Lịch để ký quỹ Escrow an toàn!');
          setTimeout(() => {
            window.location.href = 'login.jsp';
          }, 800);
          return;
        }

        // Đã đăng nhập Khách Hàng -> Chuyển thẳng vào Không Gian Khách Du Lịch (Tab Yêu Cầu Đặt Lịch)
        closeModal('guideModal');
        window.location.href = `customer.jsp?guideId=${guideId}#bookings`;
      }

      // 4. Xác thực Tài khoản (Đăng ký UC01 & Đăng nhập UC03) -> Điều hướng trực tiếp sang trang login.jsp
      function openRegisterModal(role = 'customer') {
        window.location.href = role === 'guide' ? 'login.jsp?action=register&role=guide' : 'login.jsp?action=register';
      }

      function openLoginModal() {
        window.location.href = 'login.jsp';
      }

      function checkPendingActionAfterLogin() {
        const pendingGuideId = sessionStorage.getItem('pending_guide_id');
        const pendingAction = sessionStorage.getItem('pending_guide_action');

        if (pendingGuideId) {
          sessionStorage.removeItem('pending_guide_id');
          sessionStorage.removeItem('pending_guide_action');
          setTimeout(() => {
            openGuideDetail(pendingGuideId);
            if (pendingAction === 'chat') {
              openChatFromProfile(pendingGuideId);
            } else if (pendingAction === 'book') {
              bookGuideDirectly(pendingGuideId);
            }
          }, 400);
        }
      }

      // 5. Chat & Booking Handlers
      function handleCustomerSendMessage() {
        const curUserStr = sessionStorage.getItem('guidia_current_user') || localStorage.getItem('guidia_current_user');
        const curId = curUserStr ? JSON.parse(curUserStr).id : 17;
        const input = document.getElementById('custChatInput');
        const text = input ? input.value.trim() : '';
        if (!text) return;

        if (window.guidiaStore) {
          window.guidiaStore.sendMessage(curId, currentChatGuideId, text);
          if (input) input.value = '';
          renderCustomerChatModalMessages();
        }
      }

      function renderCustomerChatModalMessages() {
        const curUserStr = sessionStorage.getItem('guidia_current_user') || localStorage.getItem('guidia_current_user');
        const curId = curUserStr ? JSON.parse(curUserStr).id : 17;
        const box = document.getElementById('custChatMessagesBox');
        if (!box || !window.guidiaStore) return;

        const messages = window.guidiaStore.getConversation(curId, currentChatGuideId);
        box.innerHTML = messages.map(m => {
          const isMe = String(m.senderId) === String(curId);
          return `
      <div style="align-self:${isMe ? 'flex-end' : 'flex-start'}; max-width:80%; background:${isMe ? 'var(--mint-700)' : '#f1f5f9'}; color:${isMe ? '#ffffff' : '#1e293b'}; padding:8px 12px; border-radius:12px; font-size:0.85rem;">
        <div>${m.text || m.content || ''}</div>
        <div class="idx-123">${m.timestamp || m.time || ''}</div>
      </div>
    `;
        }).join('');
        box.scrollTop = box.scrollHeight;
      }

      function handleStartDateChange() {
        const sDate = document.getElementById('bookingStartDateInput');
        const eDate = document.getElementById('bookingEndDateInput');
        if (sDate && eDate) {
          if (!eDate.value || eDate.value < sDate.value) {
            eDate.value = sDate.value;
          }
        }
      }

      function submitBooking() {
        const guideId = parseInt(document.getElementById('bookingModalGuideId').value) || 2;
        const guideName = document.getElementById('bookingModalGuideName').value || 'Võ Quốc Minh';
        const location = document.getElementById('bookingLocationInput').value || 'Đà Nẵng & Hội An';
        const price = parseInt(document.getElementById('bookingPriceInput').value) || 1250000;

        const curUserStr = sessionStorage.getItem('guidia_current_user') || localStorage.getItem('guidia_current_user');
        let customerId = 17;
        let customerName = 'Phạm Minh Dũng';
        if (curUserStr) {
          try {
            const u = JSON.parse(curUserStr);
            customerId = u.id || 17;
            customerName = u.name || customerName;
          } catch (e) { }
        }

        const startDate = document.getElementById('bookingStartDateInput').value;
        const startTime = document.getElementById('bookingStartTimeInput').value;
        const endDate = document.getElementById('bookingEndDateInput').value || startDate;
        const endTime = document.getElementById('bookingEndTimeInput').value || '17:30';
        const nameInput = document.getElementById('bookingNameInput').value || customerName;
        const phoneInput = document.getElementById('bookingPhoneInput').value || '0980000001';
        const guestsInput = parseInt(document.getElementById('bookingGuestsInput').value) || 2;
        const notesInput = document.getElementById('bookingNotesInput').value || '';

        let duration = '1 ngày';
        if (startDate && endDate) {
          const d1 = new Date(startDate);
          const d2 = new Date(endDate);
          const diffDays = Math.round((d2 - d1) / (1000 * 60 * 60 * 24)) + 1;
          if (diffDays > 1) duration = `${diffDays} ngày`;
        }

        if (window.guidiaStore) {
          const result = window.guidiaStore.createTripBooking({
            guideId: guideId,
            guideName: guideName,
            customerId: customerId,
            customerName: nameInput,
            customerPhone: phoneInput,
            location: location,
            startDate: startDate,
            startTime: startTime,
            endDate: endDate,
            endTime: endTime,
            duration: duration,
            guests: guestsInput,
            totalAmount: price,
            notes: notesInput
          });

          closeModal('bookingModal');
          showToast(`Đơn tour #${result.trip.id} đã được tạo thành công & ký quỹ Escrow ${price.toLocaleString('vi-VN')}₫!`);
        }
      }

      function bookExperience(expName) {
        showToast(`Bạn đang quan tâm trải nghiệm: ${expName}`);
        const curUserStr = sessionStorage.getItem('guidia_current_user') || localStorage.getItem('guidia_current_user');
        if (!curUserStr) {
          openLoginModal();
          return;
        }
        document.getElementById('bookingModal').classList.add('open');
      }

      // 6. Modal Helpers & Lifecycle
      function closeModal(modalId) {
        const modal = document.getElementById(modalId);
        if (modal) modal.classList.remove('open');
      }

      function closeMobileDrawer() {
        const drawer = document.getElementById('mobileDrawer');
        if (drawer) drawer.classList.remove('open');
      }

      let toastTimeout;
      function showToast(message) {
        const toast = document.getElementById("toastNotification");
        const toastMsg = document.getElementById("toastMessage");
        if (!toast || !toastMsg) return;

        toastMsg.textContent = message;
        toast.classList.add("show");

        clearTimeout(toastTimeout);
        toastTimeout = setTimeout(() => {
          toast.classList.remove("show");
        }, 4000);
      }

      // Khởi tạo trang khi tải xong
      function updateHeroStats() {
        const store = window.guidiaStore;
        if (!store) return;
        const guides = store.getApprovedGuides ? store.getApprovedGuides() : [];
        const trips = store.getTrips ? store.getTrips() : [];

        const gEl = document.getElementById('heroGuidesCount');
        if (gEl && guides.length > 0) {
          gEl.textContent = guides.length + '+';
        }
        const tEl = document.getElementById('heroTripsCount');
        if (tEl && trips.length > 0) {
          tEl.textContent = trips.length + '+';
        }
      }

      document.addEventListener("DOMContentLoaded", async () => {
        // Đồng bộ CSDL SQL Server nếu có
        if (window.guidiaStore && window.guidiaStore.syncWithDatabase) {
          await window.guidiaStore.syncWithDatabase();
        }

        // Cập nhật số liệu thực tế từ CSDL trên thanh Hero
        updateHeroStats();

        // 1. Kiểm tra session đăng nhập
        checkUserAuth();

        // 2. Đổ dữ liệu Khối 1: 01 Địa danh nhiều khách đi nhất (Top 1)
        renderTopDestinationBlock();

        // 3. Đổ dữ liệu Khối 2: Top 3-5 HDV tiêu biểu nhất
        renderTopEliteGuides();

        // 4. Đổ dữ liệu Tra cứu HDV (UC02)
        renderGuestGuidesGrid();

        // Initialize Lucide Icons
        if (window.lucide) window.lucide.createIcons();

        // Sticky Navbar
        const navbar = document.getElementById("navbar");
        window.addEventListener("scroll", () => {
          if (window.scrollY > 30) {
            navbar.classList.add("scrolled");
          } else {
            navbar.classList.remove("scrolled");
          }
        });

        // Mobile Drawer toggles
        const menuToggle = document.getElementById("menuToggle");
        const mobileDrawer = document.getElementById("mobileDrawer");
        const drawerClose = document.getElementById("drawerClose");
        if (menuToggle && mobileDrawer) {
          menuToggle.addEventListener("click", () => mobileDrawer.classList.add("open"));
        }
        if (drawerClose && mobileDrawer) {
          drawerClose.addEventListener("click", () => mobileDrawer.classList.remove("open"));
        }
      });

    </script>
  </body>

  </html>