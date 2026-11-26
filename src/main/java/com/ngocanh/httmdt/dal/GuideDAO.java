package com.ngocanh.httmdt.dal;

import com.ngocanh.httmdt.model.GuideProfile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class GuideDAO {

    public GuideProfile getGuideProfile(int guideId) {
        String sql = "SELECT gp.ma_HDV, gp.gioi_thieu, gp.so_nam_kinh_nghiem, gp.ngon_ngu, gp.tinh_hoat_dong, "
                   + "gp.gia_theo_gio, gp.gia_theo_ngay, gp.trang_thai_duyet, gp.ly_do_tu_choi, "
                   + "gp.so_the_hdv, gp.anh_the_hdv, gp.ten_ngan_hang, gp.so_tai_khoan, gp.chu_tai_khoan, "
                   + "gp.diem_trung_binh, gp.so_luot_danh_gia, "
                   + "u.ho_ten, u.email, u.so_dien_thoai, u.anh_dai_dien, u.trang_thai, u.so_lan_vi_pham, u.so_lan_huy "
                   + "FROM [Hồ_Sơ_HDV] gp "
                   + "JOIN [Người_Dùng] u ON gp.ma_HDV = u.ma_ND "
                   + "WHERE gp.ma_HDV = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, guideId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    GuideProfile gp = new GuideProfile();
                    int gid = rs.getInt("ma_HDV");
                    gp.setProfileId(gid);
                    gp.setGuideId(gid);
                    gp.setBio(rs.getString("gioi_thieu"));
                    gp.setExperienceYears(rs.getInt("so_nam_kinh_nghiem"));
                    gp.setLanguages(rs.getString("ngon_ngu"));
                    gp.setRegion(rs.getString("tinh_hoat_dong"));
                    gp.setCity(rs.getString("tinh_hoat_dong"));
                    gp.setPricePerHour(rs.getDouble("gia_theo_gio"));
                    gp.setPricePerDay(rs.getDouble("gia_theo_ngay"));
                    gp.setDbApprovalStatus(rs.getString("trang_thai_duyet"));
                    gp.setRejectionReason(rs.getString("ly_do_tu_choi"));
                    gp.setLicenseNumber(rs.getString("so_the_hdv"));
                    gp.setLicenseImageUrl(rs.getString("anh_the_hdv"));
                    gp.setBankName(rs.getString("ten_ngan_hang"));
                    gp.setBankAccount(rs.getString("so_tai_khoan"));
                    gp.setBankOwner(rs.getString("chu_tai_khoan"));
                    gp.setAverageRating(rs.getDouble("diem_trung_binh"));
                    gp.setReviewCount(rs.getInt("so_luot_danh_gia"));

                    gp.setGuideName(rs.getString("ho_ten"));
                    gp.setEmail(rs.getString("email"));
                    gp.setPhone(rs.getString("so_dien_thoai"));
                    gp.setAvatarUrl(rs.getString("anh_dai_dien"));
                    gp.setUserStatus(rs.getString("trang_thai"));
                    gp.setViolationCount(rs.getInt("so_lan_vi_pham"));
                    gp.setCancelCount(rs.getInt("so_lan_huy"));
                    return gp;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateProfile(int guideId, String bio, String languages, String region, double hourlyPrice, double dailyPrice) {
        String sql = "UPDATE [Hồ_Sơ_HDV] SET gioi_thieu = ?, ngon_ngu = ?, tinh_hoat_dong = ?, gia_theo_gio = ?, gia_theo_ngay = ? "
                   + "WHERE ma_HDV = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bio);
            ps.setString(2, languages);
            ps.setString(3, region);
            ps.setDouble(4, hourlyPrice);
            ps.setDouble(5, dailyPrice);
            ps.setInt(6, guideId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean confirmBooking(String bookingIdOrCode, int guideId) {
        int bookingId = 0;
        try { bookingId = Integer.parseInt(bookingIdOrCode.replaceAll("\\D+", "")); } catch (Exception ignored) {}

        String sql = "UPDATE [Đơn_Đặt_Lịch] SET trang_thai = N'ĐÃ_XÁC_NHẬN', hdv_chap_nhan_luc = SYSDATETIME(), ngay_cap_nhat = SYSDATETIME() "
                   + "WHERE (ma_don = ? OR ? = 0) AND (ma_HDV = ? OR ? = 0)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setInt(2, bookingId);
            ps.setInt(3, guideId);
            ps.setInt(4, guideId);
            int aff = ps.executeUpdate();
            if (aff > 0) {
                // Khóa thời gian đó trong lịch làm việc của HDV
                String schedSql = "SELECT ma_HDV, CONVERT(VARCHAR(10), ngay_bat_dau, 120) AS sdate FROM [Đơn_Đặt_Lịch] WHERE ma_don = ?";
                try (PreparedStatement psS = conn.prepareStatement(schedSql)) {
                    psS.setInt(1, bookingId);
                    try (ResultSet rs = psS.executeQuery()) {
                        if (rs.next()) {
                            int gId = rs.getInt("ma_HDV");
                            String sDate = rs.getString("sdate");
                            if (sDate != null && !sDate.trim().isEmpty()) {
                                lockScheduleForBooking(conn, gId, sDate, bookingId);
                            }
                        }
                    }
                }
            }
            return aff > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean confirmBooking(int bookingId, int guideId) {
        return confirmBooking(String.valueOf(bookingId), guideId);
    }

    private void lockScheduleForBooking(Connection conn, int guideId, String workDate, int bookingId) {
        String sql = "IF EXISTS (SELECT 1 FROM [Lịch_Hướng_Dẫn_Viên] WHERE ma_HDV = ? AND ngay_lam_viec = ?) "
                   + "UPDATE [Lịch_Hướng_Dẫn_Viên] SET trang_thai = N'ĐÃ_CÓ_CHUYẾN', ma_don = ? WHERE ma_HDV = ? AND ngay_lam_viec = ? "
                   + "ELSE INSERT INTO [Lịch_Hướng_Dẫn_Viên] (ma_HDV, ngay_lam_viec, gio_bat_dau, gio_ket_thuc, trang_thai, ma_don) "
                   + "VALUES (?, CAST(? AS DATE), '00:00', '23:59', N'ĐÃ_CÓ_CHUYẾN', ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, guideId);
            ps.setString(2, workDate);
            ps.setInt(3, bookingId);
            ps.setInt(4, guideId);
            ps.setString(5, workDate);

            ps.setInt(6, guideId);
            ps.setString(7, workDate);
            ps.setInt(8, bookingId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean completeBookingByGuide(int bookingId, int guideId) {
        String sql = "UPDATE [Đơn_Đặt_Lịch] SET hdv_xac_nhan_ket_thuc_luc = SYSDATETIME(), "
                   + "trang_thai = CASE WHEN khach_xac_nhan_ket_thuc_luc IS NOT NULL THEN N'ĐÃ_HOÀN_THÀNH' ELSE trang_thai END, "
                   + "hoan_thanh_luc = CASE WHEN khach_xac_nhan_ket_thuc_luc IS NOT NULL THEN SYSDATETIME() ELSE hoan_thanh_luc END, "
                   + "ngay_cap_nhat = SYSDATETIME() "
                   + "WHERE ma_don = ? AND (ma_HDV = ? OR ? = 0)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setInt(2, guideId);
            ps.setInt(3, guideId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean cancelBooking(int bookingId, int guideId, String reason) {
        String sql = "UPDATE [Đơn_Đặt_Lịch] SET trang_thai = N'ĐÃ_HỦY', ly_do_huy = ?, ngay_huy = SYSDATETIME(), ma_nguoi_huy = ?, ngay_cap_nhat = SYSDATETIME() "
                   + "WHERE ma_don = ? AND (ma_HDV = ? OR ? = 0)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, (reason != null && !reason.trim().isEmpty()) ? reason : "HDV hủy yêu cầu");
            ps.setInt(2, guideId > 0 ? guideId : 1);
            ps.setInt(3, bookingId);
            ps.setInt(4, guideId);
            ps.setInt(5, guideId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateSchedule(int guideId, String workDate, String status) {
        String dbStatus = ("AVAILABLE".equalsIgnoreCase(status) || "RẢNH".equalsIgnoreCase(status) || "MỞ_LỊCH".equalsIgnoreCase(status))
                        ? "RẢNH" : "BẬN";
        String sql = "IF EXISTS (SELECT 1 FROM [Lịch_Hướng_Dẫn_Viên] WHERE ma_HDV = ? AND ngay_lam_viec = ?) "
                   + "UPDATE [Lịch_Hướng_Dẫn_Viên] SET trang_thai = ?, ma_don = NULL WHERE ma_HDV = ? AND ngay_lam_viec = ? "
                   + "ELSE INSERT INTO [Lịch_Hướng_Dẫn_Viên] (ma_HDV, ngay_lam_viec, gio_bat_dau, gio_ket_thuc, trang_thai, ma_don) "
                   + "VALUES (?, CAST(? AS DATE), '00:00', '23:59', ?, NULL)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, guideId);
            ps.setString(2, workDate);
            ps.setString(3, dbStatus);
            ps.setInt(4, guideId);
            ps.setString(5, workDate);

            ps.setInt(6, guideId);
            ps.setString(7, workDate);
            ps.setString(8, dbStatus);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateGuideBank(int guideId, String bankName, String bankAccount, String bankOwner) {
        String sql = "UPDATE [Hồ_Sơ_HDV] SET ten_ngan_hang = ?, so_tai_khoan = ?, chu_tai_khoan = ? WHERE ma_HDV = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bankName);
            ps.setString(2, bankAccount);
            ps.setString(3, bankOwner);
            ps.setInt(4, guideId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
