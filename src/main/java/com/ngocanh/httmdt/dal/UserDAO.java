package com.ngocanh.httmdt.dal;

import com.ngocanh.httmdt.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    public User getUserById(int userId) {
        String sql = "SELECT ma_ND, ho_ten, email, so_dien_thoai, mat_khau, vai_tro, trang_thai, "
                   + "so_lan_vi_pham, so_lan_huy, anh_dai_dien, cccd, dia_chi, thong_tin_phu, dong_y_dieu_khoan, "
                   + "CONVERT(VARCHAR(19), ngay_tao, 120) AS created_at "
                   + "FROM [Người_Dùng] WHERE ma_ND = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
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

    public boolean updatePassword(int userId, String newPassword) {
        String sql = "UPDATE [Người_Dùng] SET mat_khau = ?, ngay_cap_nhat = SYSDATETIME() WHERE ma_ND = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateProfile(int userId, String fullName, String phone, String address) {
        String sql = "UPDATE [Người_Dùng] SET ho_ten = ?, so_dien_thoai = ?, dia_chi = ?, ngay_cap_nhat = SYSDATETIME() WHERE ma_ND = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setString(3, address);
            ps.setInt(4, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
