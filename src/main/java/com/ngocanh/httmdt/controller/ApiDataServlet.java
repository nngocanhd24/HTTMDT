package com.ngocanh.httmdt.controller;

import com.google.gson.Gson;
import com.ngocanh.httmdt.dal.AdminDAO;
import com.ngocanh.httmdt.dal.AuthDAO;
import com.ngocanh.httmdt.dal.BookingDAO;
import com.ngocanh.httmdt.dal.GuideDAO;
import com.ngocanh.httmdt.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ApiDataServlet", urlPatterns = {"/api/data/*"})
public class ApiDataServlet extends HttpServlet {

    private final AdminDAO adminDAO = new AdminDAO();
    private final BookingDAO bookingDAO = new BookingDAO();
    private final GuideDAO guideDAO = new GuideDAO();
    private final AuthDAO authDAO = new AuthDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        String pathInfo = request.getPathInfo();
        Map<String, Object> result = new HashMap<>();

        if ("/bootstrap".equals(pathInfo) || pathInfo == null || "/".equals(pathInfo)) {
            // Tự động kiểm tra và hủy các đơn quá hạn 24h trong SQL Server
            adminDAO.autoExpirePendingBookings();

            List<Map<String, Object>> allUsers = adminDAO.getAllUsersWithProfiles();
            List<Map<String, Object>> allGuides = new ArrayList<>();
            for (Map<String, Object> u : allUsers) {
                if ("guide".equals(u.get("role"))) {
                    allGuides.add(u);
                }
            }
            List<Map<String, Object>> trips = adminDAO.getAllBookings();
            List<Map<String, Object>> disputes = adminDAO.getAllDisputes();
            List<Map<String, Object>> txns = adminDAO.getAllTransactions();
            Map<String, Object> finSummary = adminDAO.getFinancialSummary();
            List<Map<String, Object>> messages = adminDAO.getAllMessages();
            List<Map<String, Object>> reviews = adminDAO.getAllReviews();

            result.put("success", true);
            result.put("users", allUsers);
            result.put("guides", allGuides);
            result.put("trips", trips);
            result.put("disputes", disputes);
            result.put("transactions", txns);
            result.put("financialSummary", finSummary);
            result.put("messages", messages);
            result.put("reviews", reviews);
        } else {
            result.put("success", false);
            result.put("message", "API không tìm thấy");
        }

        try (PrintWriter out = response.getWriter()) {
            out.print(gson.toJson(result));
            out.flush();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        String pathInfo = request.getPathInfo();
        Map<String, Object> result = new HashMap<>();

        if ("/action".equals(pathInfo)) {
            String actionType = request.getParameter("action");
            boolean success = false;
            String message = "";

            try {
                if ("toggle_lock".equalsIgnoreCase(actionType)) {
                    int userId = Integer.parseInt(request.getParameter("userId"));
                    String status = request.getParameter("status");
                    String reason = request.getParameter("reason");
                    success = adminDAO.toggleUserLock(userId, status, reason);
                    message = success ? ("Đã " + (status != null && status.toUpperCase().contains("LOCK") ? "khóa" : "mở khóa") + " tài khoản trong CSDL!") : "Cập nhật thất bại";

                } else if ("approve_cert".equalsIgnoreCase(actionType)) {
                    String gIdStr = request.getParameter("guideId");
                    if (gIdStr == null || gIdStr.trim().isEmpty()) gIdStr = request.getParameter("certId");
                    if (gIdStr != null && (gIdStr.contains("_") || gIdStr.contains("-"))) {
                        gIdStr = gIdStr.replaceAll("\\D+", "");
                    }
                    int guideId = Integer.parseInt(gIdStr);
                    success = adminDAO.updateGuideApproval(guideId, "ĐÃ_DUYỆT");
                    message = success ? "Đã phê duyệt thẻ HDV thành công!" : "Cập nhật thất bại";

                } else if ("reject_cert".equalsIgnoreCase(actionType)) {
                    String gIdStr = request.getParameter("guideId");
                    if (gIdStr == null || gIdStr.trim().isEmpty()) gIdStr = request.getParameter("certId");
                    if (gIdStr != null && (gIdStr.contains("_") || gIdStr.contains("-"))) {
                        gIdStr = gIdStr.replaceAll("\\D+", "");
                    }
                    int guideId = Integer.parseInt(gIdStr);
                    success = adminDAO.updateGuideApproval(guideId, "TỪ_CHỐI");
                    message = success ? "Đã từ chối thẻ HDV!" : "Cập nhật thất bại";

                } else if ("cancel_trip".equalsIgnoreCase(actionType)) {
                    String bIdStr = request.getParameter("bookingId");
                    if (bIdStr == null || bIdStr.trim().isEmpty()) bIdStr = request.getParameter("tripId");
                    int bookingId = resolveBookingId(bIdStr);
                    String reason = request.getParameter("reason");
                    String role = request.getParameter("role");
                    if (role == null || role.trim().isEmpty()) role = "customer";
                    success = adminDAO.cancelTripWithRefund(bookingId, reason, role);
                    message = success ? "Đã hủy chuyến và hoàn 100% tiền tạm giữ trong CSDL!" : "Không thể hủy chuyến! Chuyến đi chỉ có thể hủy trước ngày khởi hành tối thiểu 2 ngày.";

                } else if ("confirm_trip".equalsIgnoreCase(actionType) || "accept_trip".equalsIgnoreCase(actionType)) {
                    String bIdStr = request.getParameter("bookingId");
                    if (bIdStr == null || bIdStr.trim().isEmpty()) bIdStr = request.getParameter("tripId");
                    int guideId = 0;
                    try { guideId = Integer.parseInt(request.getParameter("guideId")); } catch (Exception ignored) {}
                    success = guideDAO.confirmBooking(bIdStr, guideId);
                    message = success ? "HDV đã chấp nhận chuyến đi & khóa lịch thành công!" : "Chấp nhận thất bại";

                } else if ("reject_trip".equalsIgnoreCase(actionType)) {
                    String bIdStr = request.getParameter("bookingId");
                    if (bIdStr == null || bIdStr.trim().isEmpty()) bIdStr = request.getParameter("tripId");
                    int bookingId = resolveBookingId(bIdStr);
                    String reason = request.getParameter("reason");
                    success = adminDAO.cancelTripWithRefund(bookingId, (reason != null && !reason.trim().isEmpty()) ? ("HDV từ chối: " + reason) : "HDV từ chối yêu cầu", "guide");
                    message = success ? "HDV đã từ chối yêu cầu đặt lịch & tiền đã được hoàn lại cho khách!" : "Từ chối thất bại (chỉ có thể hủy trước ngày khởi hành tối thiểu 2 ngày)";

                } else if ("complete_trip".equalsIgnoreCase(actionType) || "confirm_end_trip".equalsIgnoreCase(actionType)) {
                    String bIdStr = request.getParameter("bookingId");
                    if (bIdStr == null || bIdStr.trim().isEmpty()) bIdStr = request.getParameter("tripId");
                    int bookingId = resolveBookingId(bIdStr);
                    String role = request.getParameter("role");
                    if (role == null || role.trim().isEmpty()) role = "guide";
                    success = adminDAO.confirmEndTrip(bookingId, role);
                    message = success ? "Đã xác nhận kết thúc tour trong CSDL!" : "Cập nhật thất bại";

                } else if ("submit_review".equalsIgnoreCase(actionType)) {
                    String bIdStr = request.getParameter("bookingId");
                    if (bIdStr == null || bIdStr.trim().isEmpty()) bIdStr = request.getParameter("tripId");
                    int bookingId = resolveBookingId(bIdStr);
                    int reviewerId = 0;
                    try { reviewerId = Integer.parseInt(request.getParameter("customerId") != null ? request.getParameter("customerId") : request.getParameter("reviewerId")); } catch (Exception ignored) {}
                    int guideId = 0;
                    try { guideId = Integer.parseInt(request.getParameter("guideId")); } catch (Exception ignored) {}
                    int rating = 5;
                    try { rating = Integer.parseInt(request.getParameter("stars") != null ? request.getParameter("stars") : request.getParameter("rating")); } catch (Exception ignored) {}
                    String comment = request.getParameter("comment");
                    String imageUrl = request.getParameter("imageUrl");
                    success = adminDAO.saveReview(bookingId, reviewerId, guideId, rating, comment, imageUrl);
                    message = success ? "Đã lưu đánh giá của bạn vào CSDL SQL Server!" : "Lưu đánh giá thất bại";

                } else if ("reply_review".equalsIgnoreCase(actionType)) {
                    String bIdStr = request.getParameter("bookingId");
                    if (bIdStr == null || bIdStr.trim().isEmpty()) bIdStr = request.getParameter("tripId");
                    String revIdStr = request.getParameter("reviewId");
                    int reviewId = 0;
                    try { if (revIdStr != null && !revIdStr.trim().isEmpty()) reviewId = Integer.parseInt(revIdStr.trim()); } catch (Exception ignored) {}
                    int bookingId = resolveBookingId(bIdStr);
                    String tripCode = (bIdStr != null) ? bIdStr.trim() : "";
                    String reply = request.getParameter("reply");
                    success = adminDAO.saveReviewReply(bookingId, reviewId, tripCode, reply);
                    message = success ? "Đã lưu phản hồi đánh giá vào CSDL SQL Server!" : "Lưu phản hồi thất bại";

                } else if ("create_dispute".equalsIgnoreCase(actionType) || "submit_dispute".equalsIgnoreCase(actionType)) {
                    String bIdStr = request.getParameter("bookingId");
                    if (bIdStr == null || bIdStr.trim().isEmpty()) bIdStr = request.getParameter("tripId");
                    int bookingId = resolveBookingId(bIdStr);
                    String disputeCode = request.getParameter("disputeCode");
                    int reporterId = 0;
                    try { reporterId = Integer.parseInt(request.getParameter("customerId") != null ? request.getParameter("customerId") : request.getParameter("reporterId")); } catch (Exception ignored) {}
                    int reportedUserId = 0;
                    try { reportedUserId = Integer.parseInt(request.getParameter("guideId") != null ? request.getParameter("guideId") : request.getParameter("reportedUserId")); } catch (Exception ignored) {}
                    String disputeType = request.getParameter("disputeType");
                    String reason = request.getParameter("reason");
                    String evidenceUrl = request.getParameter("evidenceUrl");
                    double amount = 0;
                    try { amount = Double.parseDouble(request.getParameter("amount")); } catch (Exception ignored) {}
                    success = adminDAO.createDispute(disputeCode, bookingId, reporterId, reportedUserId, disputeType, reason, evidenceUrl, amount);
                    message = success ? "Đã gửi khiếu nại và lưu vào CSDL SQL Server thành công!" : "Gửi khiếu nại thất bại";

                } else if ("resolve_dispute".equalsIgnoreCase(actionType)) {
                    String dIdStr = request.getParameter("disputeId");
                    String decision = request.getParameter("decision");
                    String note = request.getParameter("note");
                    if (note == null || note.trim().isEmpty()) note = request.getParameter("ruling");
                    success = adminDAO.resolveDispute(dIdStr, decision, note);
                    message = success ? "Đã giải quyết tranh chấp thành công trong CSDL!" : "Cập nhật thất bại";

                } else if ("supplement_dispute".equalsIgnoreCase(actionType) || "supplement_evidence".equalsIgnoreCase(actionType)) {
                    String dIdStr = request.getParameter("disputeId");
                    String evidenceText = request.getParameter("evidenceText");
                    if (evidenceText == null || evidenceText.trim().isEmpty()) evidenceText = request.getParameter("text");
                    String evidenceUrl = request.getParameter("evidenceUrl");
                    if (evidenceUrl == null || evidenceUrl.trim().isEmpty()) evidenceUrl = request.getParameter("url");
                    success = adminDAO.supplementDisputeEvidence(dIdStr, evidenceText, evidenceUrl);
                    message = success ? "Đã gửi bổ sung bằng chứng và lưu vào CSDL thành công!" : "Bổ sung bằng chứng thất bại";

                } else if ("create_booking".equalsIgnoreCase(actionType)) {
                    int customerId = Integer.parseInt(request.getParameter("customerId"));
                    int guideId = Integer.parseInt(request.getParameter("guideId"));
                    String destination = request.getParameter("destination");
                    String startDate = request.getParameter("startDate");
                    String startTime = request.getParameter("startTime");
                    String endDate = request.getParameter("endDate");
                    String endTime = request.getParameter("endTime");
                    int guests = Integer.parseInt(request.getParameter("guests"));
                    double totalPrice = Double.parseDouble(request.getParameter("totalPrice"));
                    String note = request.getParameter("note");

                    // Khách hàng phải đặt lịch chuyến đi trước ít nhất 2 ngày kể từ ngày đặt lịch
                    java.time.LocalDate today = java.time.LocalDate.now();
                    try {
                        java.time.LocalDate bookStart = java.time.LocalDate.parse(startDate);
                        if (java.time.temporal.ChronoUnit.DAYS.between(today, bookStart) < 2) {
                            result.put("success", false);
                            result.put("message", "Khách hàng phải đặt lịch chuyến đi trước ít nhất 2 ngày kể từ ngày đặt lịch!");
                            try (PrintWriter out = response.getWriter()) {
                                out.print(gson.toJson(result));
                                out.flush();
                            }
                            return;
                        }
                    } catch (Exception ignored) {}

                    if (!bookingDAO.isGuideAvailable(guideId, startDate)) {
                        success = false;
                        message = "Hướng dẫn viên đã có lịch hoặc bận vào ngày " + startDate + ". Vui lòng chọn ngày khác!";
                    } else {
                        int newId = bookingDAO.createBooking(customerId, guideId, destination, startDate, startTime, endDate, endTime, guests, totalPrice, note);
                        success = newId > 0;
                        message = success ? ("Tạo đơn đặt tour #" + newId + " thành công & ký quỹ Escrow!") : "Tạo đơn thất bại";
                        if (success) result.put("bookingId", newId);
                    }
                } else if ("update_profile".equalsIgnoreCase(actionType)) {
                    int userId = Integer.parseInt(request.getParameter("userId"));
                    String fullName = request.getParameter("name") != null ? request.getParameter("name") : request.getParameter("fullName");
                    String phone = request.getParameter("phone");
                    String email = request.getParameter("email");
                    String avatarUrl = request.getParameter("avatar") != null ? request.getParameter("avatar") : request.getParameter("avatarUrl");
                    String bio = request.getParameter("bio");
                    String extraInfo = request.getParameter("extraInfo");
                    String password = request.getParameter("password") != null ? request.getParameter("password") : request.getParameter("newPassword");
                    String city = request.getParameter("city") != null ? request.getParameter("city") : request.getParameter("region");
                    Double hourlyPrice = null;
                    try { if (request.getParameter("hourlyPrice") != null) hourlyPrice = Double.parseDouble(request.getParameter("hourlyPrice")); } catch (Exception ignored) {}
                    Double dailyPrice = null;
                    try { if (request.getParameter("dailyPrice") != null) dailyPrice = Double.parseDouble(request.getParameter("dailyPrice")); } catch (Exception ignored) {}
                    String languages = request.getParameter("languages");
                    String bankName = request.getParameter("bankName");
                    String bankAccount = request.getParameter("bankAccount");
                    String bankOwner = request.getParameter("bankOwner");
                    String certNumber = request.getParameter("certNumber");
                    String certImage = request.getParameter("certImage");

                    success = adminDAO.updateUserProfile(userId, fullName, phone, email, avatarUrl, bio, extraInfo, password, city, hourlyPrice, dailyPrice, languages, bankName, bankAccount, bankOwner, certNumber, certImage);
                    message = success ? "Cập nhật thông tin cá nhân thành công trong CSDL!" : "Cập nhật thất bại";

                } else if ("register".equalsIgnoreCase(actionType)) {
                    String fullName = request.getParameter("name") != null ? request.getParameter("name") : request.getParameter("fullName");
                    String email = request.getParameter("email");
                    String phone = request.getParameter("phone");
                    String password = request.getParameter("password");
                    String role = request.getParameter("role") != null ? request.getParameter("role") : "KHÁCH_HÀNG";
                    String extraInfo = request.getParameter("extraInfo");
                    String city = request.getParameter("city");
                    String certType = request.getParameter("certType");
                    String certNumber = request.getParameter("certNumber");
                    String certImage = request.getParameter("certImage");

                    success = authDAO.registerUser(fullName, email, phone, password, role, extraInfo, city, certType, certNumber, certImage);
                    message = success ? "Đăng ký tài khoản thành công và lưu vào CSDL!" : "Đăng ký thất bại, email hoặc số điện thoại có thể đã tồn tại!";

                } else if ("verify_reset_password".equalsIgnoreCase(actionType)) {
                    String fullName = request.getParameter("name") != null ? request.getParameter("name") : request.getParameter("fullName");
                    String email = request.getParameter("email");
                    String phone = request.getParameter("phone");
                    String extraInfo = request.getParameter("extraInfo");

                    User verifiedUser = authDAO.verifyResetPassword(fullName, email, phone, extraInfo);
                    success = verifiedUser != null;
                    if (success) {
                        message = "Xác minh thông tin chính xác! Vui lòng nhập mật khẩu mới.";
                        result.put("userId", verifiedUser.getUserId());
                        result.put("user", verifiedUser);
                    } else {
                        message = "Lỗi xác minh: Thông tin không trùng khớp với dữ liệu đã đăng ký!";
                    }

                } else if ("reset_password".equalsIgnoreCase(actionType)) {
                    int userId = Integer.parseInt(request.getParameter("userId"));
                    String newPassword = request.getParameter("newPassword") != null ? request.getParameter("newPassword") : request.getParameter("password");
                    success = authDAO.resetPassword(userId, newPassword);
                    message = success ? "Cập nhật mật khẩu mới thành công trong CSDL!" : "Cập nhật mật khẩu thất bại";

                } else if ("auto_expire".equalsIgnoreCase(actionType)) {
                    int expiredCount = adminDAO.autoExpirePendingBookings();
                    success = true;
                    message = "Đã hủy " + expiredCount + " đơn quá hạn 24h và hoàn tiền cho du khách!";
                    result.put("expiredCount", expiredCount);
                } else if ("update_schedule".equalsIgnoreCase(actionType)) {
                    int guideId = Integer.parseInt(request.getParameter("guideId"));
                    String workDate = request.getParameter("workDate");
                    String status = request.getParameter("status");
                    success = guideDAO.updateSchedule(guideId, workDate, status);
                    message = success ? "Cập nhật lịch làm việc thành công trong CSDL!" : "Cập nhật thất bại";
                } else if ("send_message".equalsIgnoreCase(actionType)) {
                    int senderId = Integer.parseInt(request.getParameter("senderId"));
                    int receiverId = Integer.parseInt(request.getParameter("receiverId"));
                    String content = request.getParameter("content");
                    String imageUrl = request.getParameter("imageUrl");
                    success = adminDAO.saveMessage(senderId, receiverId, content, imageUrl);
                    message = success ? "Đã gửi tin nhắn và lưu vào CSDL!" : "Gửi tin nhắn thất bại";
                } else if ("mark_read".equalsIgnoreCase(actionType) || "mark_messages_read".equalsIgnoreCase(actionType)) {
                    int receiverId = Integer.parseInt(request.getParameter("receiverId"));
                    String sIdParam = request.getParameter("senderId");
                    int senderId = (sIdParam != null && !sIdParam.isEmpty()) ? Integer.parseInt(sIdParam) : 0;
                    success = adminDAO.markMessagesAsRead(receiverId, senderId);
                    message = success ? "Đã cập nhật trạng thái đã đọc vào CSDL!" : "Cập nhật trạng thái đọc thất bại";
                } else if ("update_bank".equalsIgnoreCase(actionType)) {
                    int guideId = Integer.parseInt(request.getParameter("guideId"));
                    String bankName = request.getParameter("bankName");
                    String bankAccount = request.getParameter("bankAccount");
                    String bankOwner = request.getParameter("bankOwner");
                    success = guideDAO.updateGuideBank(guideId, bankName, bankAccount, bankOwner);
                    message = success ? "Đã cập nhật thông tin tài khoản ngân hàng thành công!" : "Cập nhật tài khoản thất bại";
                } else {
                    message = "Hành động không hợp lệ";
                }
            } catch (Exception e) {
                success = false;
                message = "Lỗi xử lý: " + e.getMessage();
                e.printStackTrace();
            }

            result.put("success", success);
            result.put("message", message);
        } else {
            result.put("success", false);
            result.put("message", "API action không hợp lệ");
        }

        try (PrintWriter out = response.getWriter()) {
            out.print(gson.toJson(result));
            out.flush();
        }
    }

    private int resolveBookingId(String bIdStr) {
        if (bIdStr == null || bIdStr.trim().isEmpty()) return 0;
        bIdStr = bIdStr.trim();
        try {
            return Integer.parseInt(bIdStr.replaceAll("\\D+", ""));
        } catch (Exception ignored) {}
        return 0;
    }
}
