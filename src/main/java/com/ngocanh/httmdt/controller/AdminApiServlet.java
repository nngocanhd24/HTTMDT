package com.ngocanh.httmdt.controller;

import com.google.gson.Gson;
import com.ngocanh.httmdt.dal.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "AdminApiServlet", urlPatterns = {"/api/admin/*"})
public class AdminApiServlet extends HttpServlet {

    private final AdminDAO adminDAO = new AdminDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        String pathInfo = request.getPathInfo();
        Map<String, Object> result = new HashMap<>();

        if ("/users".equals(pathInfo)) {
            result.put("success", true);
            result.put("data", adminDAO.getAllUsersWithProfiles());
        } else if ("/reports".equals(pathInfo)) {
            result.put("success", true);
            result.put("data", adminDAO.getAllTransactions());
            result.put("summary", adminDAO.getFinancialSummary());
        } else {
            result.put("success", false);
            result.put("message", "API không tồn tại");
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

        if ("/toggle-lock".equals(pathInfo)) {
            int userId = Integer.parseInt(request.getParameter("userId") != null ? request.getParameter("userId") : request.getParameter("maTaiKhoan"));
            String status = request.getParameter("status") != null ? request.getParameter("status") : request.getParameter("trangThai");
            String reason = request.getParameter("reason");
            boolean updated = adminDAO.toggleUserLock(userId, status, reason);
            result.put("success", updated);
            result.put("message", updated ? "Cập nhật trạng thái thành công" : "Cập nhật thất bại");
        } else {
            result.put("success", false);
            result.put("message", "Hành động không hỗ trợ");
        }

        try (PrintWriter out = response.getWriter()) {
            out.print(gson.toJson(result));
            out.flush();
        }
    }
}
