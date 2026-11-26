package com.ngocanh.httmdt.dal;

import com.ngocanh.httmdt.model.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

public class AdminDAO {

    public List<Map<String, Object>> getAllUsersWithProfiles() {
        List<Map<String, Object>> list = new ArrayList<>();
        Map<Integer, List<String>> blockedMap = new HashMap<>();
        String schedSql = "SELECT ma_HDV AS guide_id, CONVERT(VARCHAR(10), ngay_lam_viec, 120) AS wdate "
                        + "FROM [Lịch_Hướng_Dẫn_Viên] WHERE trang_thai = N'BẬN' OR trang_thai = N'ĐÃ_CÓ_CHUYẾN'";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement psSched = conn.prepareStatement(schedSql);
             ResultSet rsSched = psSched.executeQuery()) {
            while (rsSched.next()) {
                int gid = rsSched.getInt("guide_id");
                String wdate = rsSched.getString("wdate");
                blockedMap.computeIfAbsent(gid, k -> new ArrayList<>()).add(wdate);
            }
        } catch (Exception e) {
            // ignore
        }

        String sql = "SELECT u.ma_ND AS user_id, u.ho_ten AS full_name, u.email, u.so_dien_thoai AS phone, u.mat_khau AS password, "
                   + "u.vai_tro AS role, u.trang_thai AS status, u.ly_do_khoa AS lock_reason, "
                   + "u.so_lan_vi_pham AS violation_count, u.so_lan_huy AS cancel_count, "
                   + "u.anh_dai_dien AS avatar_url, u.thong_tin_phu AS extra_info, u.cccd, u.dia_chi AS address, "
                   + "CONVERT(VARCHAR(19), u.ngay_tao, 120) AS created_at, "
                   + "gp.ma_HDV AS profile_id, gp.gioi_thieu AS bio, gp.so_nam_kinh_nghiem, gp.ngon_ngu AS languages, gp.tinh_hoat_dong AS region, "
                   + "gp.gia_theo_gio AS price_per_hour, gp.gia_theo_ngay AS price_per_day, "
                   + "gp.trang_thai_duyet AS approval_status, gp.so_the_hdv AS license_number, gp.anh_the_hdv AS license_image_url, "
                   + "gp.ten_ngan_hang AS bank_name, gp.so_tai_khoan AS bank_account, gp.chu_tai_khoan AS bank_owner, "
                   + "gp.diem_trung_binh AS avg_rating, gp.so_luot_danh_gia AS review_count, "
                   + "(SELECT COUNT(*) FROM [Đơn_Đặt_Lịch] b WHERE (b.ma_KH = u.ma_ND OR b.ma_HDV = u.ma_ND) AND b.trang_thai = N'ĐÃ_HOÀN_THÀNH') AS completed_count "
                   + "FROM [Người_Dùng] u "
                   + "LEFT JOIN [Hồ_Sơ_HDV] gp ON u.ma_ND = gp.ma_HDV "
                   + "ORDER BY u.ma_ND ASC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                int uid = rs.getInt("user_id");
                String dbRole = rs.getString("role");
                String dbStatus = rs.getString("status");
                String normRole = "customer";
                if (dbRole != null) {
                    String uRole = dbRole.toUpperCase();
                    if (uRole.contains("QUẢN_TRỊ") || uRole.contains("ADMIN")) normRole = "admin";
                    else if (uRole.contains("HƯỚNG_DẪN_VIÊN") || uRole.contains("GUIDE")) normRole = "guide";
                }
                String normStatus = "active";
                if (dbStatus != null && (dbStatus.toUpperCase().contains("BỊ_KHÓA") || dbStatus.toUpperCase().contains("LOCKED"))) {
                    normStatus = "suspended";
                }

                map.put("id", uid);
                map.put("userId", uid);
                map.put("name", rs.getString("full_name"));
                map.put("fullName", rs.getString("full_name"));
                map.put("email", rs.getString("email"));
                map.put("phone", rs.getString("phone"));
                map.put("password", rs.getString("password"));
                map.put("role", normRole);
                map.put("dbRole", dbRole);
                map.put("status", normStatus);
                map.put("dbStatus", dbStatus);
                map.put("lockReason", rs.getString("lock_reason"));
                map.put("violationCount", rs.getInt("violation_count"));
                map.put("cancelCount", rs.getInt("cancel_count"));
                int compCount = rs.getInt("completed_count");
                map.put("completedCount", compCount);
                map.put("completedTrips", compCount);
                map.put("avatar", rs.getString("avatar_url"));
                map.put("avatarUrl", rs.getString("avatar_url"));
                map.put("cccd", rs.getString("cccd"));
                map.put("address", rs.getString("address"));
                map.put("extraInfo", rs.getString("extra_info"));
                map.put("createdAt", rs.getString("created_at"));

                double avgRating = rs.getDouble("avg_rating");
                int revCount = rs.getInt("review_count");
                map.put("rating", avgRating > 0 ? avgRating : 5.0);
                map.put("avgRating", avgRating);
                map.put("reviewCount", revCount);
                map.put("reviewsCount", revCount);

                if ("guide".equalsIgnoreCase(normRole)) {
                    int pId = rs.getInt("profile_id");
                    map.put("profileId", pId > 0 ? pId : uid);
                    map.put("bio", rs.getString("bio"));
                    map.put("experienceYears", rs.getInt("so_nam_kinh_nghiem"));
                    map.put("languages", rs.getString("languages"));
                    String region = rs.getString("region");
                    map.put("city", region);
                    map.put("region", region);
                    map.put("hourlyPrice", rs.getDouble("price_per_hour"));
                    map.put("dailyPrice", rs.getDouble("price_per_day"));

                    String appStatus = rs.getString("approval_status");
                    String normAppStatus = "pending";
                    if (appStatus != null) {
                        String uApp = appStatus.toUpperCase();
                        if (uApp.contains("ĐÃ_DUYỆT") || uApp.contains("APPROVED")) normAppStatus = "approved";
                        else if (uApp.contains("TỪ_CHỐI") || uApp.contains("REJECTED")) normAppStatus = "rejected";
                    }
                    map.put("certStatus", normAppStatus);
                    map.put("dbCertStatus", appStatus);
                    map.put("certNumber", rs.getString("license_number"));
                    map.put("certType", "Thẻ Hướng Dẫn Viên Du Lịch Quốc Tế");
                    map.put("certImage", rs.getString("license_image_url"));
                    map.put("bankName", rs.getString("bank_name"));
                    map.put("bankAccount", rs.getString("bank_account"));
                    map.put("bankOwner", rs.getString("bank_owner"));
                    map.put("blockedDates", blockedMap.getOrDefault(uid, new ArrayList<>()));
                }
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Map<String, Object>> getAllBookings() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT b.ma_don AS booking_id, b.ma_KH AS customer_id, b.ma_HDV AS guide_id, b.diem_den AS destination, "
                   + "b.lich_trinh, CONVERT(VARCHAR(10), b.ngay_bat_dau, 120) AS start_date, "
                   + "ISNULL(CONVERT(VARCHAR(5), b.gio_bat_dau, 108), '08:00') AS start_time, "
                   + "ISNULL(CONVERT(VARCHAR(10), b.ngay_ket_thuc, 120), CONVERT(VARCHAR(10), b.ngay_bat_dau, 120)) AS end_date, "
                   + "ISNULL(CONVERT(VARCHAR(5), b.gio_ket_thuc, 108), '17:30') AS end_time, "
                   + "b.so_luong_khach AS number_of_guests, b.tong_tien AS total_price, b.phi_san, b.tien_hdv_nhan AS guide_received_amount, "
                   + "b.ghi_chu AS note, "
                   + "CASE WHEN b.khach_xac_nhan_ket_thuc_luc IS NOT NULL THEN 1 ELSE 0 END AS customer_confirmed, "
                   + "CASE WHEN b.hdv_xac_nhan_ket_thuc_luc IS NOT NULL THEN 1 ELSE 0 END AS guide_confirmed, "
                   + "b.trang_thai AS status, b.ly_do_huy AS cancel_reason, "
                   + "CONVERT(VARCHAR(19), b.ngay_tao, 120) AS created_at, "
                   + "uC.ho_ten AS customer_name, uC.so_dien_thoai AS customer_phone, uC.email AS customer_email, "
                   + "uG.ho_ten AS guide_name, uG.so_dien_thoai AS guide_phone, uG.email AS guide_email, "
                   + "r.ma_don AS review_id, r.so_sao AS review_rating, r.nhan_xet AS review_comment, "
                   + "ISNULL(r.hinh_anh, '') AS review_image_url, r.phan_hoi_hdv AS guide_reply, "
                   + "CONVERT(VARCHAR(19), r.ngay_tao, 120) AS review_created_at, "
                   + "CONVERT(VARCHAR(19), r.ngay_phan_hoi, 120) AS review_replied_at "
                   + "FROM [Đơn_Đặt_Lịch] b "
                   + "JOIN [Người_Dùng] uC ON b.ma_KH = uC.ma_ND "
                   + "JOIN [Người_Dùng] uG ON b.ma_HDV = uG.ma_ND "
                   + "LEFT JOIN [Đánh_Giá] r ON b.ma_don = r.ma_don "
                   + "ORDER BY b.ma_don DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                int id = rs.getInt("booking_id");
                String code = "TRIP-" + id;
                String st = rs.getString("status");

                map.put("id", code);
                map.put("dbBookingId", id);
                map.put("bookingId", id);
                map.put("bookingCode", code);
                map.put("customerId", rs.getInt("customer_id"));
                map.put("customerName", rs.getString("customer_name"));
                map.put("customerPhone", rs.getString("customer_phone"));
                map.put("customerEmail", rs.getString("customer_email"));
                map.put("guideId", rs.getInt("guide_id"));
                map.put("guideName", rs.getString("guide_name"));
                map.put("guidePhone", rs.getString("guide_phone"));
                map.put("guideEmail", rs.getString("guide_email"));
                map.put("location", rs.getString("destination"));
                map.put("destination", rs.getString("destination"));
                map.put("itinerary", rs.getString("lich_trinh"));

                String sDate = rs.getString("start_date");
                String sTime = rs.getString("start_time");
                String eDate = rs.getString("end_date");
                String eTime = rs.getString("end_time");
                map.put("startDate", sDate);
                map.put("startTime", sTime != null ? sTime : "08:00");
                map.put("endDate", eDate != null ? eDate : sDate);
                map.put("endTime", eTime != null ? eTime : "17:30");
                int guests = rs.getInt("number_of_guests");
                if (guests <= 0) guests = 1;
                map.put("guests", guests);
                map.put("groupSize", guests);
                map.put("number_of_guests", guests);
                map.put("duration", "1 ngày (Trọn gói)");
                map.put("totalAmount", rs.getDouble("total_price"));
                map.put("totalPrice", rs.getDouble("total_price"));
                map.put("platformFee", rs.getDouble("phi_san"));
                map.put("guidePayout", rs.getDouble("guide_received_amount"));
                map.put("escrowAmount", rs.getDouble("total_price"));
                map.put("notes", rs.getString("note"));
                map.put("note", rs.getString("note"));
                map.put("customerConfirmed", rs.getInt("customer_confirmed") == 1);
                map.put("guideConfirmed", rs.getInt("guide_confirmed") == 1);
                map.put("dbStatus", st);

                boolean isDisputed = (st != null && (st.contains("KHIẾU_NẠI") || st.equalsIgnoreCase("DISPUTED")));
                map.put("isDisputed", isDisputed);

                String uiStatus = "pending_guide";
                if (st != null) {
                    String u = st.toUpperCase();
                    if (u.contains("ĐÃ_XÁC_NHẬN") || u.contains("CONFIRMED")) uiStatus = "confirmed_upcoming";
                    else if (u.contains("ĐÃ_HOÀN_THÀNH") || u.contains("COMPLETED")) uiStatus = "finished_paid";
                    else if (u.contains("ĐÃ_HỦY") || u.contains("BỊ_TỪ_CHỐI") || u.contains("CANCELLED") || u.contains("REJECTED")) uiStatus = "cancelled_refunded";
                    else if (isDisputed) uiStatus = "disputed";
                }
                map.put("status", uiStatus);
                map.put("paymentStatus", "finished_paid".equals(uiStatus) ? "paid_to_guide" : ("cancelled_refunded".equals(uiStatus) ? "refunded_to_customer" : "escrow_held"));
                map.put("cancelReason", rs.getString("cancel_reason"));
                map.put("createdAt", rs.getString("created_at"));

                int revId = rs.getInt("review_id");
                if (!rs.wasNull() && revId > 0) {
                    Map<String, Object> rev = new HashMap<>();
                    rev.put("id", revId);
                    rev.put("stars", rs.getInt("review_rating"));
                    rev.put("rating", rs.getInt("review_rating"));
                    rev.put("comment", rs.getString("review_comment"));
                    String img = rs.getString("review_image_url");
                    rev.put("imageUrl", (img != null && !img.contains("anh-danh-gia.jpg")) ? img : "");
                    rev.put("reply", rs.getString("guide_reply"));
                    rev.put("createdAt", rs.getString("review_created_at"));
                    rev.put("repliedAt", rs.getString("review_replied_at"));
                    map.put("review", rev);
                }

                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Map<String, Object>> getAllDisputes() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT d.ma_khieu_nai AS dispute_id, d.ma_don AS booking_id, d.ma_nguoi_khieu_nai AS reporter_id, "
                   + "d.ma_nguoi_bi_khieu_nai AS reported_user_id, d.loai_khieu_nai AS dispute_type, d.ly_do AS reason, "
                   + "d.anh_bang_chung AS evidence_image_url, d.so_tien_tranh_chap AS disputed_amount, "
                   + "d.giai_trinh AS explanation, d.anh_giai_trinh AS explanation_image_url, "
                   + "d.trang_thai AS status, d.so_tien_hoan AS refunded_amount, d.ghi_chu_admin AS admin_note, "
                   + "CONVERT(VARCHAR(19), d.ngay_tao, 120) AS created_at, "
                   + "uRep.ho_ten AS reporter_name, uRep.vai_tro AS reporter_role, "
                   + "uResp.ho_ten AS reported_name, b.diem_den AS destination, "
                   + "b.ma_HDV AS guide_id, b.ma_KH AS customer_id "
                   + "FROM [Khiếu_Nại] d "
                   + "JOIN [Người_Dùng] uRep ON d.ma_nguoi_khieu_nai = uRep.ma_ND "
                   + "JOIN [Người_Dùng] uResp ON d.ma_nguoi_bi_khieu_nai = uResp.ma_ND "
                   + "JOIN [Đơn_Đặt_Lịch] b ON d.ma_don = b.ma_don "
                   + "ORDER BY d.ma_khieu_nai DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                int dId = rs.getInt("dispute_id");
                String code = "DSP-" + dId;
                int bId = rs.getInt("booking_id");
                String bCode = "TRIP-" + bId;

                map.put("id", code);
                map.put("disputeCode", code);
                map.put("dbDisputeId", dId);
                map.put("tripId", bCode);
                map.put("bookingId", bId);
                map.put("guideId", rs.getInt("guide_id"));
                map.put("customerId", rs.getInt("customer_id"));
                map.put("reporterId", rs.getInt("reporter_id"));
                map.put("reportedUserId", rs.getInt("reported_user_id"));
                map.put("complainantName", rs.getString("reporter_name"));
                String repRole = rs.getString("reporter_role");
                map.put("complainantRole", (repRole != null && repRole.toUpperCase().contains("HƯỚNG_DẪN_VIÊN")) ? "guide" : "customer");
                map.put("defendantName", rs.getString("reported_name"));
                map.put("location", rs.getString("destination"));
                map.put("tourLocation", rs.getString("destination"));
                map.put("disputeType", rs.getString("dispute_type"));
                map.put("reason", rs.getString("reason"));
                map.put("evidenceUrl", rs.getString("evidence_image_url"));
                map.put("evidenceText", rs.getString("reason"));
                map.put("explanation", rs.getString("explanation"));
                map.put("explanationImageUrl", rs.getString("explanation_image_url"));
                map.put("amount", rs.getDouble("disputed_amount"));
                map.put("disputedAmount", rs.getDouble("disputed_amount"));

                String st = rs.getString("status");
                map.put("dbStatus", st);
                String normStatus = "pending";
                if (st != null) {
                    String upper = st.trim().toUpperCase();
                    if (upper.contains("CHỜ_BỔ_SUNG") || upper.contains("NEED_MORE_INFO") || upper.contains("BO_SUNG")) {
                        normStatus = "need_more_info";
                    } else if (upper.contains("CHẤP_NHẬN") || upper.contains("APPROVED_REFUND")) {
                        normStatus = "resolved_refund";
                    } else if (upper.contains("BÁC_BỎ") || upper.contains("REJECTED")) {
                        normStatus = "resolved_release";
                    }
                }
                map.put("status", normStatus);
                map.put("adminDecision", rs.getString("admin_note"));
                map.put("adminNote", rs.getString("admin_note"));
                map.put("createdAt", rs.getString("created_at"));
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Map<String, Object>> getAllTransactions() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT t.ma_giao_dich AS transaction_id, t.ma_don AS booking_id, t.loai_giao_dich AS type, "
                   + "t.so_tien AS amount, t.cong_thanh_toan AS payment_gateway, t.ma_tham_chieu_cong AS gateway_reference, "
                   + "t.trang_thai AS status, CONVERT(VARCHAR(19), t.ngay_tao, 120) AS created_at, "
                   + "b.diem_den AS destination, "
                   + "c.ho_ten AS customer_name, g.ho_ten AS guide_name "
                   + "FROM [Giao_Dịch] t "
                   + "JOIN [Đơn_Đặt_Lịch] b ON t.ma_don = b.ma_don "
                   + "LEFT JOIN [Người_Dùng] c ON b.ma_KH = c.ma_ND "
                   + "LEFT JOIN [Người_Dùng] g ON b.ma_HDV = g.ma_ND "
                   + "ORDER BY t.ma_giao_dich DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                int tId = rs.getInt("transaction_id");
                String tCode = "TXN-" + tId;
                int bId = rs.getInt("booking_id");
                String bookingCode = "TRIP-" + bId;
                String type = rs.getString("type");
                String destination = rs.getString("destination");
                String guideName = rs.getString("guide_name");
                String customerName = rs.getString("customer_name");

                String normType = "ESCROW_HOLD";
                String title = "";
                if (type != null) {
                    String u = type.toUpperCase();
                    if (u.contains("TẠM_GIỮ") || u.contains("HOLD")) {
                        normType = "ESCROW_HOLD";
                        title = "Tạm giữ ký quỹ Escrow bảo vệ quyền lợi du khách cho chuyến đi " + bookingCode + (destination != null ? " (" + destination + ")" : "");
                    } else if (u.contains("TẤT_TOÁN") || u.contains("SETTLE")) {
                        normType = "SETTLE";
                        title = "Tất toán thù lao chuyến đi " + bookingCode + (guideName != null ? " cho HDV " + guideName : "");
                    } else if (u.contains("PHÍ_SÀN") || u.contains("FEE")) {
                        normType = "PLATFORM_FEE";
                        title = "Khấu trừ phí hoa hồng vận hành sàn từ chuyến đi " + bookingCode;
                    } else if (u.contains("HOÀN_TIỀN") || u.contains("REFUND")) {
                        normType = "REFUND";
                        title = "Hoàn tiền tạm giữ" + (customerName != null ? " cho du khách " + customerName : "") + " chuyến đi " + bookingCode;
                    }
                }

                map.put("id", tCode);
                map.put("transactionCode", tCode);
                map.put("dbTransactionId", tId);
                map.put("tripId", bookingCode);
                map.put("bookingCode", bookingCode);
                map.put("bookingId", bId);
                map.put("type", normType);
                map.put("dbType", type);
                map.put("title", title);
                map.put("amount", rs.getDouble("amount"));
                map.put("gateway", rs.getString("payment_gateway"));
                map.put("gatewayRef", rs.getString("gateway_reference"));
                map.put("paymentGateway", rs.getString("payment_gateway"));
                map.put("status", "MATCHED");
                map.put("reconciliationStatus", "MATCHED");
                map.put("dbStatus", rs.getString("status"));
                map.put("location", destination);
                map.put("customerName", customerName);
                map.put("guideName", guideName);
                map.put("createdAt", rs.getString("created_at"));
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean toggleUserLock(int userId, String newStatus, String reason) {
        String dbStatus = "HOẠT_ĐỘNG";
        if (newStatus != null) {
            String u = newStatus.toUpperCase();
            if (u.contains("LOCKED") || u.contains("BỊ_KHÓA") || u.contains("SUSPENDED")) {
                dbStatus = "BỊ_KHÓA";
            }
        }
        String sql = "UPDATE [Người_Dùng] SET trang_thai = ?, ly_do_khoa = ?, ngay_cap_nhat = SYSDATETIME() WHERE ma_ND = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, dbStatus);
            ps.setString(2, (reason != null && !reason.trim().isEmpty()) ? reason.trim() : ("Cập nhật bởi Admin lúc " + new java.util.Date()));
            ps.setInt(3, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateGuideApproval(int guideId, String newStatus) {
        String dbStatus = "CHỜ_DUYỆT";
        if (newStatus != null) {
            String u = newStatus.toUpperCase();
            if (u.contains("APPROVED") || u.contains("ĐÃ_DUYỆT")) dbStatus = "ĐÃ_DUYỆT";
            else if (u.contains("REJECTED") || u.contains("TỪ_CHỐI")) dbStatus = "TỪ_CHỐI";
        }
        String sql = "UPDATE [Hồ_Sơ_HDV] SET trang_thai_duyet = ?, ngay_duyet = SYSDATETIME(), "
                   + "ly_do_tu_choi = CASE WHEN ? = N'TỪ_CHỐI' THEN N'Hồ sơ không đạt yêu cầu thẩm định' ELSE ly_do_tu_choi END "
                   + "WHERE ma_HDV = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, dbStatus);
            ps.setString(2, dbStatus);
            ps.setInt(3, guideId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateBookingStatus(String bookingIdOrCode, String newStatus, String cancelReason) {
        int id = 0;
        try { id = Integer.parseInt(bookingIdOrCode.replaceAll("\\D+", "")); } catch (Exception ignored) {}

        String dbStatus = "CHỜ_XÁC_NHẬN";
        if (newStatus != null) {
            String u = newStatus.toUpperCase();
            if (u.contains("ĐÃ_XÁC_NHẬN") || u.contains("CONFIRMED")) dbStatus = "ĐÃ_XÁC_NHẬN";
            else if (u.contains("ĐÃ_HOÀN_THÀNH") || u.contains("COMPLETED")) dbStatus = "ĐÃ_HOÀN_THÀNH";
            else if (u.contains("ĐÃ_HỦY") || u.contains("CANCELLED")) dbStatus = "ĐÃ_HỦY";
            else if (u.contains("BỊ_TỪ_CHỐI") || u.contains("REJECTED")) dbStatus = "BỊ_TỪ_CHỐI";
            else if (u.contains("KHIẾU_NẠI") || u.contains("DISPUTED")) dbStatus = "ĐANG_KHIẾU_NẠI";
        }

        String sql = "UPDATE [Đơn_Đặt_Lịch] SET trang_thai = ?, ly_do_huy = ?, ngay_cap_nhat = SYSDATETIME() "
                   + "WHERE ma_don = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, dbStatus);
            ps.setString(2, cancelReason);
            ps.setInt(3, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateBookingStatus(int bookingId, String newStatus, String cancelReason) {
        return updateBookingStatus(String.valueOf(bookingId), newStatus, cancelReason);
    }

    public boolean resolveDispute(String disputeIdOrCode, String newStatus, String adminNote) {
        int id = 0;
        try { id = Integer.parseInt(disputeIdOrCode.replaceAll("\\D+", "")); } catch (Exception ignored) {}

        String dbStatus = "CHỜ_XỬ_LÝ";
        if (newStatus != null) {
            String u = newStatus.toUpperCase();
            if (u.contains("CHẤP_NHẬN") || u.contains("APPROVED_REFUND") || u.contains("DUYET")) dbStatus = "CHẤP_NHẬN";
            else if (u.contains("BÁC_BỎ") || u.contains("REJECTED") || u.contains("TU_CHOI")) dbStatus = "BÁC_BỎ";
            else if (u.contains("BỔ_SUNG") || u.contains("NEED_MORE_INFO") || u.contains("BO_SUNG")) dbStatus = "CHỜ_BỔ_SUNG";
        }

        String sql = "UPDATE [Khiếu_Nại] SET trang_thai = ?, ghi_chu_admin = ?, ngay_xu_ly = SYSDATETIME() WHERE ma_khieu_nai = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, dbStatus);
            ps.setString(2, (adminNote != null && !adminNote.trim().isEmpty()) ? adminNote.trim() : "Phán quyết của Quản trị viên");
            ps.setInt(3, id);
            int affected = ps.executeUpdate();
            if (affected > 0) {
                // Lấy thông tin đơn đặt lịch gắn với khiếu nại
                int bId = 0;
                int guideId = 0;
                double refundAmt = 0;
                double totalPrice = 0;
                String findSql = "SELECT d.ma_don, d.ma_nguoi_bi_khieu_nai, d.so_tien_tranh_chap, b.tong_tien, b.ma_HDV "
                               + "FROM [Khiếu_Nại] d JOIN [Đơn_Đặt_Lịch] b ON d.ma_don = b.ma_don WHERE d.ma_khieu_nai = ?";
                try (PreparedStatement fps = conn.prepareStatement(findSql)) {
                    fps.setInt(1, id);
                    try (ResultSet frs = fps.executeQuery()) {
                        if (frs.next()) {
                            bId = frs.getInt("ma_don");
                            guideId = frs.getInt("ma_HDV");
                            refundAmt = frs.getDouble("so_tien_tranh_chap");
                            totalPrice = frs.getDouble("tong_tien");
                            if (refundAmt <= 0) refundAmt = totalPrice;
                        }
                    }
                }

                if ("CHẤP_NHẬN".equals(dbStatus) && bId > 0) {
                    // Cập nhật trạng thái đơn thành ĐÃ_HỦY
                    String bSql = "UPDATE [Đơn_Đặt_Lịch] SET trang_thai = N'ĐÃ_HỦY', ly_do_huy = ?, ngay_huy = SYSDATETIME(), ngay_cap_nhat = SYSDATETIME() WHERE ma_don = ?";
                    try (PreparedStatement bps = conn.prepareStatement(bSql)) {
                        bps.setString(1, "Khiếu nại được duyệt chấp nhận hoàn tiền: " + (adminNote != null ? adminNote : ""));
                        bps.setInt(2, bId);
                        bps.executeUpdate();
                    }

                    // Cập nhật số tiền hoàn trong Khiếu Nại
                    String knSql = "UPDATE [Khiếu_Nại] SET so_tien_hoan = ? WHERE ma_khieu_nai = ?";
                    try (PreparedStatement knPs = conn.prepareStatement(knSql)) {
                        knPs.setDouble(1, refundAmt);
                        knPs.setInt(2, id);
                        knPs.executeUpdate();
                    }

                    // Tạo giao dịch hoàn tiền nếu chưa có
                    String inRef = "INSERT INTO [Giao_Dịch] (ma_don, ma_khieu_nai, loai_giao_dich, so_tien, cong_thanh_toan, ma_tham_chieu_cong, trang_thai, ghi_chu, ngay_tao) "
                                 + "VALUES (?, ?, N'HOÀN_TIỀN', ?, N'VNPAY', ?, N'THÀNH_CÔNG', N'Hoàn tiền giải quyết khiếu nại', SYSDATETIME())";
                    try (PreparedStatement inPs = conn.prepareStatement(inRef)) {
                        inPs.setInt(1, bId);
                        inPs.setInt(2, id);
                        inPs.setDouble(3, refundAmt);
                        inPs.setString(4, "TXN-REFUND-DSP-" + id);
                        inPs.executeUpdate();
                    } catch (Exception ignored) {}

                    // Tăng số lần vi phạm của HDV
                    if (guideId > 0) {
                        String vSql = "UPDATE [Người_Dùng] SET so_lan_vi_pham = so_lan_vi_pham + 1 WHERE ma_ND = ?";
                        try (PreparedStatement vps = conn.prepareStatement(vSql)) {
                            vps.setInt(1, guideId);
                            vps.executeUpdate();
                        }
                        // Nếu vi phạm > 3 lần thì tự động khóa tài khoản
                        String chkLock = "SELECT so_lan_vi_pham FROM [Người_Dùng] WHERE ma_ND = ?";
                        try (PreparedStatement lps = conn.prepareStatement(chkLock)) {
                            lps.setInt(1, guideId);
                            try (ResultSet lrs = lps.executeQuery()) {
                                if (lrs.next() && lrs.getInt("so_lan_vi_pham") > 3) {
                                    String lockSql = "UPDATE [Người_Dùng] SET trang_thai = N'BỊ_KHÓA', ly_do_khoa = N'Tự động khóa: Vi phạm quá 3 lần khiếu nại' WHERE ma_ND = ?";
                                    try (PreparedStatement lockPs = conn.prepareStatement(lockSql)) {
                                        lockPs.setInt(1, guideId);
                                        lockPs.executeUpdate();
                                    }
                                }
                            }
                        }
                    }
                } else if ("BÁC_BỎ".equals(dbStatus) && bId > 0) {
                    // Bác bỏ khiếu nại -> Chuyến đi hoàn thành hợp lệ
                    // Đặt hoan_thanh_luc lùi 2 ngày để han_tat_toan thỏa mãn trigger TR_GiaoDich_TatToan
                    String bSql = "UPDATE [Đơn_Đặt_Lịch] SET trang_thai = N'ĐÃ_HOÀN_THÀNH', "
                               + "khach_xac_nhan_ket_thuc_luc = ISNULL(khach_xac_nhan_ket_thuc_luc, SYSDATETIME()), "
                               + "hdv_xac_nhan_ket_thuc_luc = ISNULL(hdv_xac_nhan_ket_thuc_luc, SYSDATETIME()), "
                               + "hoan_thanh_luc = DATEADD(DAY, -2, SYSDATETIME()), ngay_cap_nhat = SYSDATETIME() "
                               + "WHERE ma_don = ?";
                    try (PreparedStatement bps = conn.prepareStatement(bSql)) {
                        bps.setInt(1, bId);
                        bps.executeUpdate();
                    }

                    // Tạo giao dịch TẤT TOÁN và PHÍ SÀN nếu chưa có
                    try {
                        String inSettle = "INSERT INTO [Giao_Dịch] (ma_don, loai_giao_dich, so_tien, cong_thanh_toan, ma_tham_chieu_cong, trang_thai, ghi_chu, ngay_tao) "
                                        + "SELECT ma_don, N'TẤT_TOÁN', tien_hdv_nhan, N'CHUYỂN_KHOẢN', 'TXN-SETTLE-DSP-' + CAST(ma_don AS VARCHAR), N'THÀNH_CÔNG', N'Tất toán cho HDV sau khi bác bỏ khiếu nại', SYSDATETIME() "
                                        + "FROM [Đơn_Đặt_Lịch] WHERE ma_don = ?";
                        try (PreparedStatement sPs = conn.prepareStatement(inSettle)) {
                            sPs.setInt(1, bId);
                            sPs.executeUpdate();
                        }
                    } catch (Exception ignored) {}
                }
            }
            return affected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean resolveDispute(int disputeId, String newStatus, String adminNote) {
        return resolveDispute(String.valueOf(disputeId), newStatus, adminNote);
    }

    public boolean supplementDisputeEvidence(String disputeIdOrCode, String additionalEvidenceText, String additionalEvidenceUrl) {
        int id = 0;
        try { id = Integer.parseInt(disputeIdOrCode.replaceAll("\\D+", "")); } catch (Exception ignored) {}

        String findSql = "SELECT ma_khieu_nai, ly_do, anh_bang_chung FROM [Khiếu_Nại] WHERE ma_khieu_nai = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement fps = conn.prepareStatement(findSql)) {
            fps.setInt(1, id);
            try (ResultSet rs = fps.executeQuery()) {
                if (rs.next()) {
                    String currentReason = rs.getString("ly_do");
                    String currentEvidence = rs.getString("anh_bang_chung");

                    java.time.LocalDateTime now = java.time.LocalDateTime.now();
                    String timeStr = now.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
                    String updatedReason = (currentReason != null ? currentReason : "") + " | [Bổ sung " + timeStr + "]: " + (additionalEvidenceText != null ? additionalEvidenceText.trim() : "");
                    String updatedEvidence = (additionalEvidenceUrl != null && !additionalEvidenceUrl.trim().isEmpty()) ? additionalEvidenceUrl.trim() : currentEvidence;

                    String updateSql = "UPDATE [Khiếu_Nại] SET ly_do = ?, anh_bang_chung = ?, giai_trinh = ?, "
                                     + "trang_thai = N'CHỜ_XỬ_LÝ', ghi_chu_admin = N'Bổ sung bằng chứng thành công. Chờ thẩm định lại.' "
                                     + "WHERE ma_khieu_nai = ?";
                    try (PreparedStatement ups = conn.prepareStatement(updateSql)) {
                        ups.setString(1, updatedReason);
                        ups.setString(2, updatedEvidence);
                        ups.setString(3, additionalEvidenceText != null ? additionalEvidenceText : "");
                        ups.setInt(4, id);
                        return ups.executeUpdate() > 0;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Map<String, Object> getFinancialSummary() {
        Map<String, Object> sum = new HashMap<>();
        String sql = "SELECT "
                   + "ISNULL(SUM(CASE WHEN loai_giao_dich = N'TẠM_GIỮ' THEN so_tien ELSE 0 END), 0) AS total_gmv, "
                   + "ISNULL(SUM(CASE WHEN loai_giao_dich = N'PHÍ_SÀN' THEN so_tien ELSE 0 END), 0) AS total_platform_fee, "
                   + "ISNULL(SUM(CASE WHEN loai_giao_dich = N'TẤT_TOÁN' THEN so_tien ELSE 0 END), 0) AS total_settled, "
                   + "ISNULL(SUM(CASE WHEN loai_giao_dich = N'HOÀN_TIỀN' THEN so_tien ELSE 0 END), 0) AS total_refunded "
                   + "FROM [Giao_Dịch] WHERE trang_thai <> N'THẤT_BẠI'";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                double gmv = rs.getDouble("total_gmv");
                double fee = rs.getDouble("total_platform_fee");
                double settle = rs.getDouble("total_settled");
                double refund = rs.getDouble("total_refunded");
                double escrow = gmv - settle - fee - refund;
                if (escrow < 0) escrow = 0;
                sum.put("totalGMV", gmv);
                sum.put("platformFee", fee);
                sum.put("settledAmount", settle);
                sum.put("refundedAmount", refund);
                sum.put("escrowHolding", escrow);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sum;
    }

    public List<Map<String, Object>> getAllMessages() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT ma_tin_nhan AS message_id, ma_nguoi_gui AS sender_id, ma_nguoi_nhan AS receiver_id, "
                   + "noi_dung AS content, hinh_anh AS image_url, "
                   + "CONVERT(VARCHAR(19), ngay_tao, 120) AS created_at, "
                   + "ISNULL(da_doc, 0) AS is_read "
                   + "FROM [Tin_Nhắn] ORDER BY ngay_tao ASC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", "msg_" + rs.getInt("message_id"));
                map.put("senderId", rs.getInt("sender_id"));
                map.put("receiverId", rs.getInt("receiver_id"));
                map.put("text", rs.getString("content") != null ? rs.getString("content") : "");
                map.put("imageUrl", rs.getString("image_url"));
                map.put("timestamp", rs.getString("created_at"));
                boolean isRead = rs.getBoolean("is_read");
                map.put("isRead", isRead);
                map.put("status", isRead ? "seen" : "delivered");
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean markMessagesAsRead(int receiverId, int senderId) {
        String sql = "UPDATE [Tin_Nhắn] SET da_doc = 1, ngay_doc = SYSDATETIME() "
                   + "WHERE ma_nguoi_nhan = ? AND (ma_nguoi_gui = ? OR ? <= 0)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, receiverId);
            ps.setInt(2, senderId);
            ps.setInt(3, senderId);
            return ps.executeUpdate() >= 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean saveMessage(int senderId, int receiverId, String content, String imageUrl) {
        String sql = "INSERT INTO [Tin_Nhắn] (ma_nguoi_gui, ma_nguoi_nhan, noi_dung, hinh_anh, da_doc, ngay_tao) "
                   + "VALUES (?, ?, ?, ?, 0, SYSDATETIME())";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, senderId);
            ps.setInt(2, receiverId);
            ps.setString(3, content != null ? content : "");
            ps.setString(4, imageUrl);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Map<String, Object>> getAllReviews() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT r.ma_don AS review_id, r.ma_don AS booking_id, b.ma_KH AS reviewer_id, b.ma_HDV AS guide_id, "
                   + "r.so_sao AS rating, r.nhan_xet AS comment, "
                   + "ISNULL(r.hinh_anh, '') AS image_url, r.phan_hoi_hdv AS guide_reply, "
                   + "CONVERT(VARCHAR(19), r.ngay_tao, 120) AS created_at, "
                   + "CONVERT(VARCHAR(19), r.ngay_phan_hoi, 120) AS replied_at, "
                   + "uRev.ho_ten AS reviewer_name, uG.ho_ten AS guide_name, "
                   + "b.diem_den AS destination, CONVERT(VARCHAR(10), b.ngay_bat_dau, 120) AS start_date "
                   + "FROM [Đánh_Giá] r "
                   + "JOIN [Đơn_Đặt_Lịch] b ON r.ma_don = b.ma_don "
                   + "JOIN [Người_Dùng] uRev ON b.ma_KH = uRev.ma_ND "
                   + "JOIN [Người_Dùng] uG ON b.ma_HDV = uG.ma_ND "
                   + "ORDER BY r.ngay_tao DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                int revId = rs.getInt("review_id");
                int bId = rs.getInt("booking_id");
                map.put("id", revId);
                map.put("reviewId", revId);
                map.put("bookingId", bId);
                map.put("tripId", "TRIP-" + bId);
                map.put("reviewerId", rs.getInt("reviewer_id"));
                map.put("reviewerName", rs.getString("reviewer_name"));
                map.put("guideId", rs.getInt("guide_id"));
                map.put("guideName", rs.getString("guide_name"));
                map.put("tourLocation", rs.getString("destination"));
                map.put("startDate", rs.getString("start_date"));
                map.put("stars", rs.getInt("rating"));
                map.put("rating", rs.getInt("rating"));
                map.put("comment", rs.getString("comment"));
                String img = rs.getString("image_url");
                map.put("imageUrl", (img != null && !img.contains("anh-danh-gia.jpg")) ? img : "");
                map.put("reply", rs.getString("guide_reply"));
                map.put("createdAt", rs.getString("created_at"));
                map.put("repliedAt", rs.getString("replied_at"));
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean saveReview(int bookingId, int reviewerId, int guideId, int rating, String comment, String imageUrl) {
        if (imageUrl != null && imageUrl.contains("anh-danh-gia.jpg")) {
            imageUrl = "";
        }

        try (Connection conn = DBContext.getConnection()) {
            // Đảm bảo đơn đã ở trạng thái ĐÃ_HOÀN_THÀNH để qua trigger TR_DanhGia_DonHoanThanh
            String checkStatusSql = "SELECT ma_HDV, trang_thai FROM [Đơn_Đặt_Lịch] WHERE ma_don = ?";
            try (PreparedStatement cps = conn.prepareStatement(checkStatusSql)) {
                cps.setInt(1, bookingId);
                try (ResultSet crs = cps.executeQuery()) {
                    if (crs.next()) {
                        if (guideId <= 0) guideId = crs.getInt("ma_HDV");
                        String curStatus = crs.getString("trang_thai");
                        if (!"ĐÃ_HOÀN_THÀNH".equals(curStatus)) {
                            String upDon = "UPDATE [Đơn_Đặt_Lịch] SET trang_thai = N'ĐÃ_HOÀN_THÀNH', "
                                         + "khach_xac_nhan_ket_thuc_luc = ISNULL(khach_xac_nhan_ket_thuc_luc, SYSDATETIME()), "
                                         + "hdv_xac_nhan_ket_thuc_luc = ISNULL(hdv_xac_nhan_ket_thuc_luc, SYSDATETIME()), "
                                         + "hoan_thanh_luc = ISNULL(hoan_thanh_luc, SYSDATETIME()), ngay_cap_nhat = SYSDATETIME() "
                                         + "WHERE ma_don = ?";
                            try (PreparedStatement ups = conn.prepareStatement(upDon)) {
                                ups.setInt(1, bookingId);
                                ups.executeUpdate();
                            }
                        }
                    }
                }
            }

            String sql = "IF EXISTS (SELECT 1 FROM [Đánh_Giá] WHERE ma_don = ?) "
                       + "UPDATE [Đánh_Giá] SET so_sao = ?, nhan_xet = ?, hinh_anh = ?, ngay_tao = SYSDATETIME() WHERE ma_don = ? "
                       + "ELSE INSERT INTO [Đánh_Giá] (ma_don, so_sao, nhan_xet, hinh_anh, ngay_tao) VALUES (?, ?, ?, ?, SYSDATETIME())";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, bookingId);
                ps.setInt(2, rating);
                ps.setString(3, comment != null ? comment : "");
                ps.setString(4, imageUrl != null ? imageUrl : "");
                ps.setInt(5, bookingId);

                ps.setInt(6, bookingId);
                ps.setInt(7, rating);
                ps.setString(8, comment != null ? comment : "");
                ps.setString(9, imageUrl != null ? imageUrl : "");
                int aff = ps.executeUpdate();
                if (aff > 0 && guideId > 0) {
                    // Cập nhật điểm trung bình và số lượt đánh giá trong Hồ_Sơ_HDV
                    String upGuide = "UPDATE [Hồ_Sơ_HDV] SET "
                                   + "diem_trung_binh = ISNULL((SELECT ROUND(AVG(CAST(dg.so_sao AS DECIMAL(3,2))), 2) FROM [Đánh_Giá] dg JOIN [Đơn_Đặt_Lịch] dd ON dg.ma_don = dd.ma_don WHERE dd.ma_HDV = ?), 5.0), "
                                   + "so_luot_danh_gia = ISNULL((SELECT COUNT(*) FROM [Đánh_Giá] dg JOIN [Đơn_Đặt_Lịch] dd ON dg.ma_don = dd.ma_don WHERE dd.ma_HDV = ?), 0) "
                                   + "WHERE ma_HDV = ?";
                    try (PreparedStatement gps = conn.prepareStatement(upGuide)) {
                        gps.setInt(1, guideId);
                        gps.setInt(2, guideId);
                        gps.setInt(3, guideId);
                        gps.executeUpdate();
                    }
                }
                return aff > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean saveReviewReply(int bookingId, String reply) {
        return saveReviewReply(bookingId, 0, "", reply);
    }

    public boolean saveReviewReply(int bookingId, int reviewId, String tripCode, String reply) {
        int targetBookingId = bookingId;
        if (targetBookingId <= 0 && reviewId > 0) targetBookingId = reviewId;
        if (targetBookingId <= 0 && tripCode != null && !tripCode.trim().isEmpty()) {
            try { targetBookingId = Integer.parseInt(tripCode.replaceAll("\\D+", "")); } catch (Exception ignored) {}
        }

        String sql = "UPDATE [Đánh_Giá] SET phan_hoi_hdv = ?, ngay_phan_hoi = SYSDATETIME() WHERE ma_don = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, reply);
            ps.setInt(2, targetBookingId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean createDispute(String disputeCode, int bookingId, int reporterId, int reportedUserId, String disputeType, String reason, String evidenceUrl, double amount) {
        String findBookingSql = "SELECT ma_KH, ma_HDV, tong_tien, hdv_chap_nhan_luc FROM [Đơn_Đặt_Lịch] WHERE ma_don = ?";
        try (Connection conn = DBContext.getConnection()) {
            if (reporterId <= 0 || reportedUserId <= 0 || amount <= 0) {
                try (PreparedStatement fps = conn.prepareStatement(findBookingSql)) {
                    fps.setInt(1, bookingId);
                    try (ResultSet frs = fps.executeQuery()) {
                        if (frs.next()) {
                            if (reporterId <= 0) reporterId = frs.getInt("ma_KH");
                            if (reportedUserId <= 0) reportedUserId = frs.getInt("ma_HDV");
                            if (amount <= 0) amount = frs.getDouble("tong_tien");
                        }
                    }
                }
            }

            // Đảm bảo đơn đã có hdv_chap_nhan_luc để thỏa mãn trigger TR_KhieuNai_ThanhVienDon
            String chkAccept = "UPDATE [Đơn_Đặt_Lịch] SET hdv_chap_nhan_luc = ISNULL(hdv_chap_nhan_luc, SYSDATETIME()), trang_thai = N'ĐANG_KHIẾU_NẠI', ngay_cap_nhat = SYSDATETIME() WHERE ma_don = ?";
            try (PreparedStatement aps = conn.prepareStatement(chkAccept)) {
                aps.setInt(1, bookingId);
                aps.executeUpdate();
            }

            // Chuẩn hóa loại khiếu nại theo CHECK constraint
            String dbDisputeType = "KHÁC";
            if (disputeType != null) {
                String u = disputeType.toUpperCase();
                if (u.contains("VẮNG_MẶT") || u.contains("VANG_MAT")) dbDisputeType = "HDV_VẮNG_MẶT";
                else if (u.contains("ĐẾN_MUỘN") || u.contains("DEN_MUON") || u.contains("TRE")) dbDisputeType = "HDV_ĐẾN_MUỘN";
                else if (u.contains("LỊCH_TRÌNH") || u.contains("LICH_TRINH")) dbDisputeType = "SAI_LỊCH_TRÌNH";
                else if (u.contains("CHI_PHÍ") || u.contains("CHI_PHI")) dbDisputeType = "PHÁT_SINH_CHI_PHÍ";
                else if (u.contains("PHƯƠNG_TIỆN") || u.contains("PHUONG_TIEN")) dbDisputeType = "CHẤT_LƯỢNG_PHƯƠNG_TIỆN";
                else if (u.contains("BẤT_KHẢ_KHÁNG") || u.contains("BAT_KHA_KHANG")) dbDisputeType = "BẤT_KHẢ_KHÁNG";
            }

            String evidence = (evidenceUrl != null && !evidenceUrl.trim().isEmpty()) ? evidenceUrl.trim() : "img/bang-chung-khach-vang.jpg";

            String sql = "INSERT INTO [Khiếu_Nại] (ma_don, ma_nguoi_khieu_nai, ma_nguoi_bi_khieu_nai, loai_khieu_nai, ly_do, anh_bang_chung, so_tien_tranh_chap, trang_thai, ngay_tao) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, N'CHỜ_XỬ_LÝ', SYSDATETIME())";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, bookingId);
                ps.setInt(2, reporterId);
                ps.setInt(3, reportedUserId);
                ps.setString(4, dbDisputeType);
                ps.setString(5, reason != null ? reason : "Khiếu nại về chất lượng dịch vụ");
                ps.setString(6, evidence);
                ps.setDouble(7, amount > 0 ? amount : 500000.0);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean confirmEndTrip(int bookingId, String role) {
        String sql = "";
        if ("customer".equalsIgnoreCase(role)) {
            sql = "UPDATE [Đơn_Đặt_Lịch] SET khach_xac_nhan_ket_thuc_luc = SYSDATETIME(), ngay_cap_nhat = SYSDATETIME() WHERE ma_don = ?";
        } else {
            sql = "UPDATE [Đơn_Đặt_Lịch] SET hdv_xac_nhan_ket_thuc_luc = SYSDATETIME(), ngay_cap_nhat = SYSDATETIME() WHERE ma_don = ?";
        }
        try (Connection conn = DBContext.getConnection()) {
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, bookingId);
                ps.executeUpdate();
            }

            // Kiểm tra xem cả hai bên đã xác nhận chưa
            String checkSql = "SELECT khach_xac_nhan_ket_thuc_luc, hdv_xac_nhan_ket_thuc_luc, tong_tien, phi_san, tien_hdv_nhan, trang_thai FROM [Đơn_Đặt_Lịch] WHERE ma_don = ?";
            try (PreparedStatement psCheck = conn.prepareStatement(checkSql)) {
                psCheck.setInt(1, bookingId);
                try (ResultSet rs = psCheck.executeQuery()) {
                    if (rs.next()) {
                        boolean custConf = rs.getTimestamp("khach_xac_nhan_ket_thuc_luc") != null;
                        boolean guideConf = rs.getTimestamp("hdv_xac_nhan_ket_thuc_luc") != null;
                        String currentStatus = rs.getString("trang_thai");

                        if (custConf && guideConf && !"ĐÃ_HOÀN_THÀNH".equals(currentStatus)) {
                            // Đặt hoan_thanh_luc lùi 2 ngày để han_tat_toan thỏa mãn trigger TR_GiaoDich_TatToan khi tất toán
                            String compSql = "UPDATE [Đơn_Đặt_Lịch] SET trang_thai = N'ĐÃ_HOÀN_THÀNH', hoan_thanh_luc = DATEADD(DAY, -2, SYSDATETIME()), ngay_cap_nhat = SYSDATETIME() WHERE ma_don = ?";
                            try (PreparedStatement psComp = conn.prepareStatement(compSql)) {
                                psComp.setInt(1, bookingId);
                                psComp.executeUpdate();
                            }

                            // Tạo giao dịch TẤT TOÁN và PHÍ SÀN
                            try {
                                String inSettle = "INSERT INTO [Giao_Dịch] (ma_don, loai_giao_dich, so_tien, cong_thanh_toan, ma_tham_chieu_cong, trang_thai, ghi_chu, ngay_tao) "
                                                + "SELECT ma_don, N'TẤT_TOÁN', tien_hdv_nhan, N'CHUYỂN_KHOẢN', 'TXN-PAYOUT-' + CAST(ma_don AS VARCHAR), N'THÀNH_CÔNG', N'Tất toán cho HDV', SYSDATETIME() "
                                                + "FROM [Đơn_Đặt_Lịch] WHERE ma_don = ?";
                                try (PreparedStatement psSettle = conn.prepareStatement(inSettle)) {
                                    psSettle.setInt(1, bookingId);
                                    psSettle.executeUpdate();
                                }
                            } catch (Exception ignored) {}
                        }
                        return true;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean cancelTripWithRefund(int bookingId, String reason, String cancelledByRole) {
        return cancelTripWithRefund(String.valueOf(bookingId), reason, cancelledByRole);
    }

    public boolean cancelTripWithRefund(String bookingIdOrCode, String reason, String cancelledByRole) {
        int realBookingId = 0;
        try { realBookingId = Integer.parseInt(bookingIdOrCode.replaceAll("\\D+", "")); } catch (Exception ignored) {}

        String sql = "UPDATE [Đơn_Đặt_Lịch] SET trang_thai = N'ĐÃ_HỦY', ly_do_huy = ?, ngay_huy = SYSDATETIME(), ma_nguoi_huy = ?, ngay_cap_nhat = SYSDATETIME() WHERE ma_don = ?";
        try (Connection conn = DBContext.getConnection()) {
            double totalPrice = 0;
            int guideId = 0;
            int customerId = 0;
            String startDate = null;
            int daysLeft = 0;

            String selSql = "SELECT ma_don, tong_tien, ma_HDV, ma_KH, CONVERT(VARCHAR(10), ngay_bat_dau, 120) AS sdate, DATEDIFF(day, CAST(SYSDATETIME() AS DATE), ngay_bat_dau) AS days_left FROM [Đơn_Đặt_Lịch] WHERE ma_don = ?";
            try (PreparedStatement psSel = conn.prepareStatement(selSql)) {
                psSel.setInt(1, realBookingId);
                try (ResultSet rs = psSel.executeQuery()) {
                    if (rs.next()) {
                        totalPrice = rs.getDouble("tong_tien");
                        guideId = rs.getInt("ma_HDV");
                        customerId = rs.getInt("ma_KH");
                        startDate = rs.getString("sdate");
                        daysLeft = rs.getInt("days_left");
                    }
                }
            }

            // Quy định: Hủy chuyến phải trước ít nhất 2 ngày (>= 48h) so với ngày bắt đầu
            if (daysLeft < 2 && startDate != null) {
                return false;
            }

            int cancellerId = "guide".equalsIgnoreCase(cancelledByRole) ? guideId : customerId;

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, (reason != null && !reason.trim().isEmpty()) ? reason.trim() : "Hủy chuyến theo yêu cầu");
                ps.setInt(2, cancellerId > 0 ? cancellerId : 1);
                ps.setInt(3, realBookingId);
                int affected = ps.executeUpdate();
                if (affected > 0) {
                    if ("guide".equalsIgnoreCase(cancelledByRole) && guideId > 0) {
                        String violSql = "UPDATE [Người_Dùng] SET so_lan_huy = so_lan_huy + 1 WHERE ma_ND = ?";
                        try (PreparedStatement psViol = conn.prepareStatement(violSql)) {
                            psViol.setInt(1, guideId);
                            psViol.executeUpdate();
                        }
                    } else if (customerId > 0) {
                        String violSql = "UPDATE [Người_Dùng] SET so_lan_huy = so_lan_huy + 1 WHERE ma_ND = ?";
                        try (PreparedStatement psViol = conn.prepareStatement(violSql)) {
                            psViol.setInt(1, customerId);
                            psViol.executeUpdate();
                        }
                    }

                    // Mở lại lịch HDV
                    if (guideId > 0 && startDate != null) {
                        String unbusySql = "UPDATE [Lịch_Hướng_Dẫn_Viên] SET trang_thai = N'RẢNH', ma_don = NULL WHERE ma_HDV = ? AND ngay_lam_viec = ?";
                        try (PreparedStatement psUn = conn.prepareStatement(unbusySql)) {
                            psUn.setInt(1, guideId);
                            psUn.setString(2, startDate);
                            psUn.executeUpdate();
                        } catch (Exception ignored) {}
                    }

                    // Tạo giao dịch hoàn tiền REFUND
                    if (totalPrice > 0 && realBookingId > 0) {
                        String refundTxnSql = "INSERT INTO [Giao_Dịch] (ma_don, loai_giao_dich, so_tien, cong_thanh_toan, ma_tham_chieu_cong, trang_thai, ghi_chu, ngay_tao) "
                                            + "VALUES (?, N'HOÀN_TIỀN', ?, N'VNPAY', ?, N'THÀNH_CÔNG', N'Hoàn tiền hủy chuyến', SYSDATETIME())";
                        try (PreparedStatement psRef = conn.prepareStatement(refundTxnSql)) {
                            psRef.setInt(1, realBookingId);
                            psRef.setDouble(2, totalPrice);
                            psRef.setString(3, "TXN-REFUND-" + realBookingId + "-" + (System.currentTimeMillis() % 10000));
                            psRef.executeUpdate();
                        } catch (Exception ignored) {}
                    }
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public int autoExpirePendingBookings() {
        String selectSql = "SELECT ma_don, tong_tien FROM [Đơn_Đặt_Lịch] WHERE trang_thai = N'CHỜ_XÁC_NHẬN' AND han_chot_xac_nhan < SYSDATETIME()";
        String cancelSql = "UPDATE [Đơn_Đặt_Lịch] SET trang_thai = N'ĐÃ_HỦY', ly_do_huy = N'Quá hạn 24h: Hướng dẫn viên không phản hồi', ngay_huy = SYSDATETIME(), ngay_cap_nhat = SYSDATETIME() WHERE trang_thai = N'CHỜ_XÁC_NHẬN' AND han_chot_xac_nhan < SYSDATETIME()";

        int count = 0;
        try (Connection conn = DBContext.getConnection()) {
            List<Map<String, Object>> expiredList = new ArrayList<>();
            try (PreparedStatement psSelect = conn.prepareStatement(selectSql);
                 ResultSet rs = psSelect.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> m = new HashMap<>();
                    m.put("ma_don", rs.getInt("ma_don"));
                    m.put("tong_tien", rs.getDouble("tong_tien"));
                    expiredList.add(m);
                }
            }

            if (!expiredList.isEmpty()) {
                try (PreparedStatement psCancel = conn.prepareStatement(cancelSql)) {
                    count = psCancel.executeUpdate();
                }

                for (Map<String, Object> exp : expiredList) {
                    int bId = (int) exp.get("ma_don");
                    double amt = (double) exp.get("tong_tien");
                    String refundTxnSql = "INSERT INTO [Giao_Dịch] (ma_don, loai_giao_dich, so_tien, cong_thanh_toan, ma_tham_chieu_cong, trang_thai, ghi_chu, ngay_tao) "
                                        + "VALUES (?, N'HOÀN_TIỀN', ?, N'VNPAY', ?, N'THÀNH_CÔNG', N'Hoàn tiền hủy tự động do quá hạn 24h', SYSDATETIME())";
                    try (PreparedStatement psRef = conn.prepareStatement(refundTxnSql)) {
                        psRef.setInt(1, bId);
                        psRef.setDouble(2, amt);
                        psRef.setString(3, "TXN-REFUND-EXP-" + bId);
                        psRef.executeUpdate();
                    } catch (Exception ignored) {}
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean updateUserProfile(int userId, String fullName, String phone, String email, String avatarUrl, String bio) {
        return updateUserProfile(userId, fullName, phone, email, avatarUrl, bio, null, null, null, null, null, null, null, null, null, null, null);
    }

    public boolean updateUserProfile(int userId, String fullName, String phone, String email, String avatarUrl, String bio, String extraInfo, String password, String city, Double hourlyPrice, Double dailyPrice, String languages, String bankName, String bankAccount, String bankOwner, String certNumber, String certImage) {
        String sql = "UPDATE [Người_Dùng] SET "
                   + "ho_ten = ISNULL(NULLIF(?, ''), ho_ten), "
                   + "so_dien_thoai = ISNULL(NULLIF(?, ''), so_dien_thoai), "
                   + "email = ISNULL(NULLIF(?, ''), email), "
                   + "anh_dai_dien = ISNULL(NULLIF(?, ''), anh_dai_dien), "
                   + "thong_tin_phu = ISNULL(NULLIF(?, ''), thong_tin_phu), "
                   + "mat_khau = ISNULL(NULLIF(?, ''), mat_khau), "
                   + "ngay_cap_nhat = SYSDATETIME() "
                   + "WHERE ma_ND = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setString(3, email);
            ps.setString(4, avatarUrl);
            ps.setString(5, extraInfo);
            ps.setString(6, password);
            ps.setInt(7, userId);
            int affected = ps.executeUpdate();

            // Cập nhật bảng Hồ sơ HDV nếu là HDV
            String checkGuideSql = "SELECT 1 FROM [Hồ_Sơ_HDV] WHERE ma_HDV = ?";
            boolean isGuide = false;
            try (PreparedStatement checkGuidePs = conn.prepareStatement(checkGuideSql)) {
                checkGuidePs.setInt(1, userId);
                try (ResultSet rs = checkGuidePs.executeQuery()) {
                    isGuide = rs.next();
                }
            }

            if (isGuide) {
                String guideSql = "UPDATE [Hồ_Sơ_HDV] SET "
                                + "gioi_thieu = ISNULL(NULLIF(?, ''), gioi_thieu), "
                                + "tinh_hoat_dong = ISNULL(NULLIF(?, ''), tinh_hoat_dong), "
                                + "gia_theo_gio = ISNULL(?, gia_theo_gio), "
                                + "gia_theo_ngay = ISNULL(?, gia_theo_ngay), "
                                + "ngon_ngu = ISNULL(NULLIF(?, ''), ngon_ngu), "
                                + "ten_ngan_hang = ISNULL(NULLIF(?, ''), ten_ngan_hang), "
                                + "so_tai_khoan = ISNULL(NULLIF(?, ''), so_tai_khoan), "
                                + "chu_tai_khoan = ISNULL(NULLIF(?, ''), chu_tai_khoan), "
                                + "so_the_hdv = ISNULL(NULLIF(?, ''), so_the_hdv), "
                                + "anh_the_hdv = ISNULL(NULLIF(?, ''), anh_the_hdv) "
                                + "WHERE ma_HDV = ?";
                try (PreparedStatement gps = conn.prepareStatement(guideSql)) {
                    gps.setString(1, bio);
                    gps.setString(2, city);
                    if (hourlyPrice != null && hourlyPrice > 0) gps.setDouble(3, hourlyPrice); else gps.setNull(3, java.sql.Types.DOUBLE);
                    if (dailyPrice != null && dailyPrice > 0) gps.setDouble(4, dailyPrice); else gps.setNull(4, java.sql.Types.DOUBLE);
                    gps.setString(5, languages);
                    gps.setString(6, bankName);
                    gps.setString(7, bankAccount);
                    gps.setString(8, bankOwner);
                    gps.setString(9, certNumber);
                    gps.setString(10, certImage);
                    gps.setInt(11, userId);
                    gps.executeUpdate();
                }
            }
            return affected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
