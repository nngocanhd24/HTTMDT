<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html lang="vi">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Guidia | Khám Phá Hướng Dẫn Viên Bản Địa & Đặt Tour</title>

    <link rel="stylesheet" href="css/style.css?v=20261110_05">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
      href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&family=Playfair+Display:ital,wght@0,600;0,700;1,600&display=swap"
      rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="js/store.js?v=20261110_05"></script>

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

      /* Đảm bảo trang hiển thị thoáng đẹp */
      body.search-portal-page {
        background: #f8fafc;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
      }

      .search-main-container {
        flex: 1;
        width: 100%;
        max-width: 1440px;
        margin: 0 auto;
        padding: 24px 32px 48px;
        box-sizing: border-box;
      }

      @media (max-width: 768px) {
        .search-main-container {
          padding: 16px;
        }
      }
    </style>
  </head>

  <body class="search-portal-page">

    <!-- ========================================================================= -->
    <!-- 1. HEADER CHUNG (Logo, Menu: Trang Chủ & Tra Cứu HDV, Đăng Nhập & Đăng Ký) -->
    <!-- ========================================================================= -->
    <header class="navbar" id="navbar">
      <div class="container nav-container">

        <!-- 1. Góc trái: Logo Guidia -->
        <a href="index.jsp" class="brand-logo">
          <div class="logo-icon">
            <i data-lucide="compass"></i>
          </div>
          <div class="logo-text">
            <span class="logo-title">Guidia</span>
            <span class="logo-sub">Private Local Guides</span>
          </div>
        </a>

        <!-- 2. Menu giữa: Đúng 2 chức năng: [Trang Chủ] & [Tra cứu hướng dẫn viên (Active)] -->
        <nav class="nav-menu">
          <a href="index.jsp" class="nav-item" id="navHome">Trang Chủ</a>
          <a href="search.jsp" class="nav-item active idx-1" id="navSearch">
            <i data-lucide="search" class="idx-2"></i>Tra cứu hướng dẫn viên
          </a>
        </nav>

        <!-- 3. Góc phải: Đúng 2 nút Đăng nhập & Đăng ký khi chưa đăng nhập (hoặc thông tin User nếu đã login) -->
        <div class="nav-actions" id="mainNavActions">
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
        <a href="search.jsp" class="drawer-link active idx-3" onclick="closeMobileDrawer();">
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

    <!-- ========================================================================= -->
    <!-- 2. PHẦN TRA CỨU CỦA VÃNG LAI: Y CHANG CẤU TRÚC BÊN KHÁCH HÀNG              -->
    <!-- ========================================================================= -->
    <main class="search-main-container">
      <section class="tab-content-panel active" id="tab-search">

        <!-- Bộ lọc và tìm kiếm HDV (Thẻ màu trắng cst-26) -->
        <div class="cst-26">
          <div class="cst-27">
            <div>
              <h3 class="cst-28">Tra Cứu &amp; Tìm Kiếm Hướng Dẫn Viên Tinh Hoa</h3>
              <p class="cst-29">
                Chọn người đồng hành bản địa am hiểu văn hóa và phong vị ẩm thực. Bấm <strong>"Nhắn tin"</strong> để
                trao đổi trực tiếp hoặc <strong>"Đặt lịch"</strong> để ký quỹ an toàn.
              </p>
            </div>
            <div class="cst-30">
              <span class="cst-31">
                <i data-lucide="shield-check" class="icon-xs cst-32"></i> 100% HDV Có Thẻ Hành Nghề Được Duyệt
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
                <option value="Đà Nẵng">Đà Nẵng &amp; Bà Nà</option>
                <option value="Hà Nội">Hà Nội 36 Phố</option>
                <option value="Huế">Cố Đô Huế</option>
                <option value="Sapa">Sapa &amp; Fansipan</option>
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

        <!-- Danh sách thẻ Hướng dẫn viên (Lưới 4 cột đồng bộ hoàn toàn với customer.jsp) -->
        <div id="guidesGridContainer" class="guides-grid">
          <!-- Render động từ CSDL SQL Server qua store.js -->
        </div>
      </section>
    </main>

    <!-- ========================================================================= -->
    <!-- MODAL: HỒ SƠ CHI TIẾT HDV (To rộng 1040px, Không có thanh kéo ngang)     -->
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

    <!-- Toast Notification Box -->
    <div class="toast-box" id="toastBox"></div>

    <!-- Footer tinh gọn -->
    <footer class="footer" style="background:#ffffff; border-top:1px solid #e2e8f0; padding:24px 0; margin-top:auto;">
      <div
        style="max-width: 1440px; margin: 0 auto; padding: 0 32px; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 12px; font-size: 0.85rem; color: #64748b;">
        <div>© 2026 Guidia - Private Local Guides Platform. Bảo lưu mọi quyền.</div>
        <div style="display: flex; gap: 20px;">
          <a href="index.jsp" style="color: #64748b; text-decoration: none;">Trang Chủ</a>
          <a href="login.jsp" style="color: #64748b; text-decoration: none;">Đăng Nhập Khách Hàng</a>
          <a href="login.jsp?action=register&role=guide" style="color: #64748b; text-decoration: none;">Gia Nhập Đội Ngũ
            HDV</a>
        </div>
      </div>
    </footer>

    <!-- ========================================================================= -->
    <!-- JAVASCRIPT: LOGIC TRA CỨU KẾ THỪA TRỰC TIẾP TỪ KHÁCH HÀNG                  -->
    <!-- ========================================================================= -->
    <script>
      let currentViewingGuideId = null;

      // 1. Ánh xạ địa danh theo từng Vùng / Miền (y chang bên customer.jsp)
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
          { value: 'Hạ Long', label: 'Vịnh Hạ Long (Quảng Ninh)' }
        ],
        central: [
          { value: 'all', label: 'Tất cả Miền Trung' },
          { value: 'Huế', label: 'Cố Đô Huế (Di Sản Cố Đô)' },
          { value: 'Đà Nẵng', label: 'Đà Nẵng (Bà Nà & Bán Đảo)' },
          { value: 'Hội An', label: 'Phố Cổ Hội An (Quảng Nam)' },
          { value: 'Đà Lạt', label: 'Đà Lạt (Xứ Sở Ngàn Hoa)' }
        ],
        south: [
          { value: 'all', label: 'Tất cả Miền Nam' },
          { value: 'Hồ Chí Minh', label: 'TP. Hồ Chí Minh (Sài Gòn)' },
          { value: 'Phú Quốc', label: 'Đảo Ngọc Phú Quốc (Kiên Giang)' },
          { value: 'Miền Tây', label: 'Miền Tây Sông Nước Đồng Bằng' }
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

      // 2. Render danh sách thẻ HDV (Cấu trúc thẻ y chang customer.jsp)
      function renderGuidesSearchTab() {
        const store = window.guidiaStore;
        if (!store) return;

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
          <div class="cst-146" style="grid-column: 1 / -1; text-align: center; padding: 60px 20px; background: #ffffff; border-radius: 16px; border: 1px dashed #cbd5e1;">
            <i data-lucide="user-x" class="cst-147" style="width: 48px; height: 48px; color: #94a3b8; margin-bottom: 12px;"></i>
            <h4 class="cst-148" style="font-size: 1.15rem; color: #1e293b; margin-bottom: 6px;">Không tìm thấy Hướng dẫn viên phù hợp</h4>
            <p class="cst-149" style="font-size: 0.9rem; color: #64748b; margin-bottom: 16px;">Vui lòng thử điều chỉnh lại bộ lọc địa điểm, ngoại ngữ hoặc khoảng giá.</p>
            <button class="btn-outline" onclick="resetGuideSearch()" style="padding: 8px 20px; border-radius: 8px; font-weight: 600; cursor: pointer;">Đặt Lại Bộ Lọc</button>
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
            <div class="guide-card-top cst-150" onclick="openGuideDetail('${g.id}')" style="cursor: pointer;">
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
                <h3 class="guide-name cst-156" onclick="openGuideDetail('${g.id}')" style="cursor: pointer;">${g.name}</h3>
                <p class="guide-title-role cst-157">${g.experienceYears || '5 năm kinh nghiệm'} • ${g.certType || 'HDV Bản Địa'}</p>
                <p class="guide-bio cst-158">
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
                  <!-- Dòng 2: Nhắn tin và Đặt lịch song song -->
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

      // 3. Phân quyền Vãng lai: Nhấn Nhắn Tin hoặc Đặt Lịch sẽ lưu ý định & chuyển sang Login
      function openChatWithGuide(guideId) {
        const curUserStr = sessionStorage.getItem('guidia_current_user') || localStorage.getItem('guidia_current_user');
        if (curUserStr) {
          window.location.href = `customer.jsp?guideId=${guideId}#chat`;
          return;
        }
        sessionStorage.setItem('pending_guide_id', guideId);
        sessionStorage.setItem('pending_guide_action', 'chat');
        showToast('Khách vãng lai chưa thể nhắn tin trực tiếp. Vui lòng đăng nhập tài khoản Khách Du Lịch!');
        setTimeout(() => {
          window.location.href = 'login.jsp';
        }, 800);
      }

      function openBookingForGuide(guideId) {
        const curUserStr = sessionStorage.getItem('guidia_current_user') || localStorage.getItem('guidia_current_user');
        if (curUserStr) {
          window.location.href = `customer.jsp?guideId=${guideId}#bookings`;
          return;
        }
        sessionStorage.setItem('pending_guide_id', guideId);
        sessionStorage.setItem('pending_guide_action', 'book');
        showToast('Khách vãng lai chưa thể đặt lịch. Vui lòng đăng nhập tài khoản Khách Du Lịch để ký quỹ Escrow an toàn!');
        setTimeout(() => {
          window.location.href = 'login.jsp';
        }, 800);
      }

      // 4. Mở Modal Chi Tiết HDV (Bề ngang to rộng 1040px, Không có thanh kéo ngang)
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
              <button class="btn-primary w-full idx-94" onclick="openBookingForGuide('${guide.id}')">
                <i data-lucide="calendar-check" class="icon-xs"></i> Đặt Lịch Riêng
              </button>
              <button class="btn-outline-mint w-full idx-94" onclick="openChatWithGuide('${guide.id}')">
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

      // 5. Toast thông báo
      function showToast(message) {
        const toastBox = document.getElementById('toastBox');
        if (!toastBox) return;
        const t = document.createElement('div');
        t.className = 'toast-item';
        t.textContent = message;
        toastBox.appendChild(t);
        setTimeout(() => {
          t.style.opacity = '0';
          setTimeout(() => t.remove(), 400);
        }, 3000);
      }

      // 6. Quản lý trạng thái xác thực người dùng trên Header (giữ nguyên logic chuẩn từ header cũ)
      function openMobileDrawer() {
        const d = document.getElementById('mobileDrawer');
        if (d) d.classList.add('open');
      }

      function closeMobileDrawer() {
        const d = document.getElementById('mobileDrawer');
        if (d) d.classList.remove('open');
      }

      function checkUserAuth() {
        const curUserStr = sessionStorage.getItem('guidia_current_user') || localStorage.getItem('guidia_current_user');
        const navContainer = document.getElementById('mainNavActions');

        if (curUserStr) {
          try {
            const user = JSON.parse(curUserStr);
            const role = user.role || 'customer';
            const portalUrl = role === 'admin' ? 'admin.jsp' : (role === 'guide' ? 'guide.jsp' : 'customer.jsp');
            const roleLabel = role === 'admin' ? 'Ban Quản Trị' : (role === 'guide' ? 'Hướng Dẫn Viên' : 'Khách Du Lịch');

            if (navContainer) {
              navContainer.innerHTML = `
              <div class="user-nav-profile idx-57">
                <a href="${portalUrl}" class="idx-58" title="Vào không gian làm việc">
                  <img src="${user.avatar || 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=120'}" class="idx-59">
                  <div class="idx-60">
                    <span class="idx-61">${user.name || 'Người dùng'}</span>
                    <span class="idx-62">${roleLabel}</span>
                  </div>
                </a>
                <button onclick="handleLogout()" class="btn-outline-mint idx-63" title="Đăng xuất">
                  <i data-lucide="log-out" class="idx-64"></i> Đăng Xuất
                </button>
              </div>
            `;
            }
            if (window.lucide) window.lucide.createIcons();
            return;
          } catch (e) { }
        }

        // Khách vãng lai: Đúng 2 nút Đăng nhập & Đăng ký
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

      // 7. Nhận tham số từ URL (city, keyword, region)
      function parseUrlParameters() {
        const urlParams = new URLSearchParams(window.location.search);
        const cityParam = urlParams.get('city');
        const kwParam = urlParams.get('keyword');
        const regParam = urlParams.get('region');

        if (regParam) {
          const regSelect = document.getElementById('guideSearchRegion');
          if (regSelect) {
            regSelect.value = regParam;
            handleCustRegionChange();
          }
        }

        if (cityParam) {
          const regSelect = document.getElementById('guideSearchRegion');
          const cityLower = cityParam.toLowerCase();
          if (cityLower.includes('huế') || cityLower.includes('hội an') || cityLower.includes('đà nẵng') || cityLower.includes('đà lạt')) {
            if (regSelect) regSelect.value = 'central';
            handleCustRegionChange();
          } else if (cityLower.includes('hà nội') || cityLower.includes('sapa') || cityLower.includes('ninh bình') || cityLower.includes('hạ long')) {
            if (regSelect) regSelect.value = 'north';
            handleCustRegionChange();
          } else if (cityLower.includes('hồ chí minh') || cityLower.includes('phú quốc') || cityLower.includes('miền tây')) {
            if (regSelect) regSelect.value = 'south';
            handleCustRegionChange();
          }
          const citySelect = document.getElementById('guideSearchCity');
          if (citySelect) {
            for (let opt of citySelect.options) {
              if (opt.value !== 'all' && (opt.value.toLowerCase().includes(cityLower) || cityLower.includes(opt.value.toLowerCase()))) {
                citySelect.value = opt.value;
                break;
              }
            }
          }
        }

        if (kwParam) {
          const kwInput = document.getElementById('guideSearchKeyword');
          if (kwInput) kwInput.value = kwParam;
        }
      }

      // Khởi tạo trang khi tải xong
      document.addEventListener('DOMContentLoaded', () => {
        if (window.guidiaStore && window.guidiaStore.init) {
          window.guidiaStore.init();
        }
        checkUserAuth();
        parseUrlParameters();
        renderGuidesSearchTab();
        if (window.lucide) window.lucide.createIcons();
      });
    </script>
  </body>

  </html>