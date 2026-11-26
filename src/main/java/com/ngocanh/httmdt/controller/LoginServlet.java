package com.ngocanh.httmdt.controller;

import com.google.gson.Gson;
import com.ngocanh.httmdt.dal.AuthDAO;
import com.ngocanh.httmdt.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "LoginServlet", urlPatterns = {"/api/login", "/dang-nhap"})
public class LoginServlet extends HttpServlet {

    private final AuthDAO authDAO = new AuthDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        String email = request.getParameter("email");
        if (email == null || email.trim().isEmpty()) {
            email = request.getParameter("username");
        }
        String matKhau = request.getParameter("password");
        if (matKhau == null) {
            matKhau = request.getParameter("matKhau");
        }

        Map<String, Object> result = new HashMap<>();

        if (email == null || matKhau == null || email.trim().isEmpty() || matKhau.trim().isEmpty()) {
            result.put("success", false);
            result.put("message", "Vui lòng nhập đầy đủ tên đăng nhập (email hoặc số điện thoại) và mật khẩu.");
            sendJsonResponse(response, result);
            return;
        }

        User user = authDAO.checkLogin(email.trim(), matKhau.trim());

        if (user != null) {
            if (user.isLocked()) {
                result.put("success", false);
                result.put("message", "Tài khoản của bạn đã bị khóa (" + (user.getLockReason() != null ? user.getLockReason() : "do vi phạm") + "). Vui lòng liên hệ Quản trị viên (Email: admin@guidia.vn - Hotline: 0999.999.999) để được hỗ trợ mở khóa.");
            } else {
                HttpSession session = request.getSession(true);
                session.setAttribute("user", user);

                result.put("success", true);
                result.put("message", "Đăng nhập thành công!");
                result.put("user", user);

                String redirectUrl = "customer.jsp";
                if (user.isAdmin()) {
                    redirectUrl = "admin.jsp";
                } else if (user.isGuide()) {
                    redirectUrl = "guide.jsp";
                } else {
                    redirectUrl = "customer.jsp";
                }
                result.put("redirectUrl", redirectUrl);
            }
        } else {
            result.put("success", false);
            result.put("message", "Email/Số điện thoại hoặc mật khẩu không chính xác. Vui lòng thử lại!");
        }

        sendJsonResponse(response, result);
    }

    private void sendJsonResponse(HttpServletResponse response, Map<String, Object> data) throws IOException {
        try (PrintWriter out = response.getWriter()) {
            out.print(gson.toJson(data));
            out.flush();
        }
    }
}
