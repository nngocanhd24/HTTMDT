package com.ngocanh.httmdt.dal;

import com.ngocanh.httmdt.model.Booking;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BookingDAO {

    public int createBooking(int customerId, int guideId, String destination, 
                             String startDate, String startTime, String endDate, String endTime, 
                             int guests, double totalPrice, String note) {
        // Quy định: Đặt tour phải trước ít nhất 2 ngày
        try {
            java.time.LocalDate today = java.time.LocalDate.now();
            java.time.LocalDate bookStart = java.time.LocalDate.parse(startDate);
            if (java.time.temporal.ChronoUnit.DAYS.between(today, bookStart) < 2) {
                return -1;
            }
        } catch (Exception ignored) {}

        String sql = "INSERT INTO [Đơn_Đặt_Lịch] (ma_KH, ma_HDV, diem_den, lich_trinh, "
                   + "ngay_bat_dau, gio_bat_dau, ngay_ket_thuc, gio_ket_thuc, so_luong_khach, "
                   + "hinh_thuc_thue, don_gia, so_don_vi, tong_tien, ty_le_phi, ghi_chu, "
                   + "trang_thai, han_chot_xac_nhan, ngay_tao) "
                   + "VALUES (?, ?, ?, ?, CAST(? AS DATE), CAST(? AS TIME(0)), CAST(? AS DATE), CAST(? AS TIME(0)), ?, "
                   + "N'THEO_NGÀY', ?, 1, ?, 10, ?, N'CHỜ_XÁC_NHẬN', DATEADD(HOUR, 24, SYSDATETIME()), SYSDATETIME())";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, customerId);
            ps.setInt(2, guideId);
            ps.setString(3, destination);
            ps.setString(4, note != null ? note : destination);
            ps.setString(5, startDate);
            ps.setString(6, (startTime != null && !startTime.trim().isEmpty()) ? startTime : "08:00");
            ps.setString(7, (endDate != null && !endDate.trim().isEmpty()) ? endDate : startDate);
            ps.setString(8, (endTime != null && !endTime.trim().isEmpty()) ? endTime : "17:30");
            ps.setInt(9, guests > 0 ? guests : 1);
            ps.setDouble(10, totalPrice);
            ps.setDouble(11, totalPrice);
            ps.setString(12, note);

            int affected = ps.executeUpdate();
            if (affected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        int bookingId = rs.getInt(1);
                        // Tự động tạo giao dịch TẠM_GIỮ (Escrow Hold) vào Giao_Dịch
                        createTransaction(conn, bookingId, "TXN-HOLD-" + bookingId, "TẠM_GIỮ", totalPrice, "VNPAY");
                        return bookingId;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int createBooking(int customerId, int guideId, String destination, String startDate, int guests, double totalPrice, String note) {
        return createBooking(customerId, guideId, destination, startDate, "08:00", startDate, "17:30", guests, totalPrice, note);
    }

    private void createTransaction(Connection conn, int bookingId, String code, String type, double amount, String gateway) {
        String sql = "INSERT INTO [Giao_Dịch] (ma_don, loai_giao_dich, so_tien, cong_thanh_toan, ma_tham_chieu_cong, trang_thai, ghi_chu, ngay_tao) "
                   + "VALUES (?, ?, ?, ?, ?, N'THÀNH_CÔNG', N'Tạm giữ ký quỹ bảo đảm', SYSDATETIME())";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setString(2, type);
            ps.setDouble(3, amount);
            ps.setString(4, gateway != null ? gateway : "VNPAY");
            ps.setString(5, code);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean customerConfirmComplete(int bookingId, int customerId) {
        String sql = "UPDATE [Đơn_Đặt_Lịch] SET khach_xac_nhan_ket_thuc_luc = SYSDATETIME(), "
                   + "trang_thai = CASE WHEN hdv_xac_nhan_ket_thuc_luc IS NOT NULL THEN N'ĐÃ_HOÀN_THÀNH' ELSE trang_thai END, "
                   + "hoan_thanh_luc = CASE WHEN hdv_xac_nhan_ket_thuc_luc IS NOT NULL THEN SYSDATETIME() ELSE hoan_thanh_luc END, "
                   + "ngay_cap_nhat = SYSDATETIME() "
                   + "WHERE ma_don = ? AND (ma_KH = ? OR ? = 0)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setInt(2, customerId);
            ps.setInt(3, customerId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isGuideAvailable(int guideId, String startDate) {
        String sql = "SELECT 1 FROM [Lịch_Hướng_Dẫn_Viên] WHERE ma_HDV = ? AND ngay_lam_viec = ? AND (trang_thai = N'BẬN' OR trang_thai = N'ĐÃ_CÓ_CHUYẾN') "
                   + "UNION "
                   + "SELECT 1 FROM [Đơn_Đặt_Lịch] WHERE ma_HDV = ? AND ngay_bat_dau = ? AND (trang_thai = N'ĐÃ_XÁC_NHẬN' OR trang_thai = N'CHỜ_XÁC_NHẬN')";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, guideId);
            ps.setString(2, startDate);
            ps.setInt(3, guideId);
            ps.setString(4, startDate);
            try (ResultSet rs = ps.executeQuery()) {
                return !rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;
    }
}
