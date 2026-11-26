package com.ngocanh.httmdt.dal;

import com.ngocanh.httmdt.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AuthDAO {

    public User checkLogin(String emailOrPhone, String password) {
        String sql = "SELECT ma_ND, ho_ten, email, so_dien_thoai, mat_khau, vai_tro, trang_thai, "
                   + "so_lan_vi_pham, so_lan_huy, anh_dai_dien, cccd, dia_chi, thong_tin_phu, dong_y_dieu_khoan, "
                   + "CONVERT(VARCHAR(19), ngay_tao, 120) AS created_at "
                   + "FROM [Người_Dùng] WHERE (email = ? OR so_dien_thoai = ?) AND mat_khau = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, emailOrPhone.trim());
            ps.setString(2, emailOrPhone.trim());
            ps.setString(3, password.trim());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getInt("ma_ND"),
                        rs.getString("ho_ten"),
                        rs.getString("email"),
                        rs.getString("so_dien_thoai"),
                        rs.getString("mat_khau"),
                        rs.getString("vai_tro"),
                        rs.getString("trang_thai"),
                        rs.getInt("so_lan_vi_pham"),
                        rs.getInt("so_lan_huy"),
                        rs.getString("anh_dai_dien"),
                        rs.getString("cccd"),
                        rs.getString("dia_chi"),
                        rs.getString("thong_tin_phu"),
                        rs.getBoolean("dong_y_dieu_khoan"),
                        rs.getString("created_at")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String getGuideApprovalStatus(int guideId) {
        String sql = "SELECT trang_thai_duyet FROM [Hồ_Sơ_HDV] WHERE ma_HDV = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, guideId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("trang_thai_duyet");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "ĐÃ_DUYỆT";
    }

    public boolean registerCustomer(String fullName, String email, String phone, String password) {
        return registerUser(fullName, email, phone, password, "KHÁCH_HÀNG", "Thông tin bảo mật mặc định", "", "", "", "");
    }

    public boolean registerUser(String fullName, String email, String phone, String password, String role, String extraInfo, String city, String certType, String certNumber, String certImage) {
        String dbRole = "KHÁCH_HÀNG";
        if (role != null) {
            String u = role.trim().toUpperCase();
            if (u.contains("GUIDE") || u.contains("HƯỚNG_DẪN_VIÊN")) dbRole = "HƯỚNG_DẪN_VIÊN";
            else if (u.contains("ADMIN") || u.contains("QUẢN_TRỊ")) dbRole = "QUẢN_TRỊ";
        }

        String userSql = "INSERT INTO [Người_Dùng] (ho_ten, email, so_dien_thoai, mat_khau, thong_tin_phu, vai_tro, trang_thai, anh_dai_dien, dong_y_dieu_khoan, ngay_tao) "
                       + "VALUES (?, ?, ?, ?, ?, ?, N'HOẠT_ĐỘNG', ?, 1, SYSDATETIME())";
        String avatar = "KHÁCH_HÀNG".equals(dbRole)
                ? "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150"
                : "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(userSql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, fullName != null ? fullName.trim() : "");
            ps.setString(2, email != null ? email.trim().toLowerCase() : "");
            ps.setString(3, phone != null ? phone.trim() : "");
            ps.setString(4, password != null ? password.trim() : "123456");
            ps.setString(5, (extraInfo != null && !extraInfo.trim().isEmpty()) ? extraInfo.trim() : "Mặc định");
            ps.setString(6, dbRole);
            ps.setString(7, avatar);

            int affected = ps.executeUpdate();
            if (affected > 0) {
                int newUserId = 0;
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        newUserId = rs.getInt(1);
                    }
                }

                if ("HƯỚNG_DẪN_VIÊN".equals(dbRole) && newUserId > 0) {
                    String profileSql = "INSERT INTO [Hồ_Sơ_HDV] (ma_HDV, gioi_thieu, so_nam_kinh_nghiem, ngon_ngu, tinh_hoat_dong, gia_theo_gio, gia_theo_ngay, so_the_hdv, anh_the_hdv, trang_thai_duyet) "
                                      + "VALUES (?, ?, 3, N'Tiếng Việt, Tiếng Anh', ?, 350000, 1200000, ?, ?, N'CHỜ_DUYỆT')";
                    try (PreparedStatement psProf = conn.prepareStatement(profileSql)) {
                        psProf.setInt(1, newUserId);
                        psProf.setString(2, "Hướng dẫn viên bản địa chuyên tuyến " + (city != null ? city : "Việt Nam") + ". Nhiệt tình, chu đáo.");
                        psProf.setString(3, (city != null && !city.trim().isEmpty()) ? city : "Hà Nội");
                        psProf.setString(4, (certNumber != null && !certNumber.trim().isEmpty()) ? certNumber : ("HDV-" + newUserId));
                        psProf.setString(5, (certImage != null && !certImage.trim().isEmpty()) ? certImage : "img/the-hdv-1.jpg");
                        psProf.executeUpdate();
                    }
                }
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public User verifyResetPassword(String fullName, String email, String phone, String extraInfo) {
        String sql = "SELECT ma_ND, ho_ten, email, so_dien_thoai, mat_khau, vai_tro, trang_thai, "
                   + "so_lan_vi_pham, so_lan_huy, anh_dai_dien, cccd, dia_chi, thong_tin_phu, dong_y_dieu_khoan, "
                   + "CONVERT(VARCHAR(19), ngay_tao, 120) AS created_at "
                   + "FROM [Người_Dùng] WHERE LOWER(ho_ten) = LOWER(?) AND LOWER(email) = LOWER(?) AND REPLACE(so_dien_thoai, ' ', '') = REPLACE(?, ' ', '')";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName != null ? fullName.trim() : "");
            ps.setString(2, email != null ? email.trim() : "");
            ps.setString(3, phone != null ? phone.trim() : "");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String dbExtra = rs.getString("thong_tin_phu");
                    if (extraInfo != null && !extraInfo.trim().isEmpty() && dbExtra != null && !dbExtra.trim().isEmpty()) {
                        String cleanInput = extraInfo.trim().toLowerCase();
                        String cleanDb = dbExtra.trim().toLowerCase();
                        if (!cleanInput.contains(cleanDb) && !cleanDb.contains(cleanInput)) {
                            return null;
                        }
                    }
                    return new User(
                        rs.getInt("ma_ND"),
                        rs.getString("ho_ten"),
                        rs.getString("email"),
                        rs.getString("so_dien_thoai"),
                        rs.getString("mat_khau"),
                        rs.getString("vai_tro"),
                        rs.getString("trang_thai"),
                        rs.getInt("so_lan_vi_pham"),
                        rs.getInt("so_lan_huy"),
                        rs.getString("anh_dai_dien"),
                        rs.getString("cccd"),
                        rs.getString("dia_chi"),
                        rs.getString("thong_tin_phu"),
                        rs.getBoolean("dong_y_dieu_khoan"),
                        rs.getString("created_at")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean resetPassword(int userId, String newPassword) {
        String sql = "UPDATE [Người_Dùng] SET mat_khau = ?, ngay_cap_nhat = SYSDATETIME() WHERE ma_ND = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword.trim());
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
