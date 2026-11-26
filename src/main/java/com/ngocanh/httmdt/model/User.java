package com.ngocanh.httmdt.model;

import java.io.Serializable;

public class User implements Serializable {
    private int userId;
    private int id; // alias for JSON/frontend
    private String fullName;
    private String name; // alias
    private String email;
    private String phone;
    private String password;
    private String role; // "admin", "guide", "customer" or "QUẢN_TRỊ", "HƯỚNG_DẪN_VIÊN", "KHÁCH_HÀNG"
    private String dbRole;
    private String status; // "active", "suspended"
    private String dbStatus; // "HOẠT_ĐỘNG", "BỊ_KHÓA"
    private String lockReason;
    private int violationCount;
    private int cancelCount;
    private String avatarUrl;
    private String avatar;
    private String cccd;
    private String address;
    private String extraInfo;
    private boolean agreedTerms;
    private String createdAt;
    private String updatedAt;

    public User() {}

    public User(int userId, String fullName, String email, String phone, String password, String role, String status, int violationCount, int cancelCount, String avatarUrl, String cccd, String address, String extraInfo, boolean agreedTerms, String createdAt) {
        this.userId = userId;
        this.id = userId;
        this.fullName = fullName;
        this.name = fullName;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.dbRole = role;
        this.role = normalizeRole(role);
        this.dbStatus = status;
        this.status = normalizeStatus(status);
        this.violationCount = violationCount;
        this.cancelCount = cancelCount;
        this.avatarUrl = avatarUrl;
        this.avatar = avatarUrl;
        this.cccd = cccd;
        this.address = address;
        this.extraInfo = extraInfo;
        this.agreedTerms = agreedTerms;
        this.createdAt = createdAt;
    }

    public User(int userId, String fullName, String email, String phone, String password, String role, String status, int violationCount, String avatarUrl, String cccd, String address, String extraInfo, boolean agreedTerms, String createdAt) {
        this(userId, fullName, email, phone, password, role, status, violationCount, 0, avatarUrl, cccd, address, extraInfo, agreedTerms, createdAt);
    }

    public User(int userId, String fullName, String email, String phone, String password, String role, String status, int violationCount, String avatarUrl, String cccd, String address, boolean agreedTerms, String createdAt) {
        this(userId, fullName, email, phone, password, role, status, violationCount, 0, avatarUrl, cccd, address, "", agreedTerms, createdAt);
    }

    private String normalizeRole(String r) {
        if (r == null) return "customer";
        String upper = r.trim().toUpperCase();
        if (upper.contains("QUẢN_TRỊ") || upper.contains("ADMIN")) return "admin";
        if (upper.contains("HƯỚNG_DẪN_VIÊN") || upper.contains("GUIDE")) return "guide";
        return "customer";
    }

    private String normalizeStatus(String s) {
        if (s == null) return "active";
        String upper = s.trim().toUpperCase();
        if (upper.contains("BỊ_KHÓA") || upper.contains("LOCKED") || upper.contains("SUSPENDED")) return "suspended";
        return "active";
    }

    public boolean isAdmin() {
        return "admin".equalsIgnoreCase(this.role) || "QUẢN_TRỊ".equalsIgnoreCase(this.dbRole);
    }

    public boolean isGuide() {
        return "guide".equalsIgnoreCase(this.role) || "HƯỚNG_DẪN_VIÊN".equalsIgnoreCase(this.dbRole);
    }

    public boolean isCustomer() {
        return "customer".equalsIgnoreCase(this.role) || "KHÁCH_HÀNG".equalsIgnoreCase(this.dbRole);
    }

    public boolean isLocked() {
        return "suspended".equalsIgnoreCase(this.status) || "BỊ_KHÓA".equalsIgnoreCase(this.dbStatus);
    }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; this.id = userId; }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; this.userId = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; this.name = fullName; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; this.fullName = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = normalizeRole(role); this.dbRole = role; }

    public String getDbRole() { return dbRole != null ? dbRole : role; }
    public void setDbRole(String dbRole) { this.dbRole = dbRole; this.role = normalizeRole(dbRole); }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = normalizeStatus(status); this.dbStatus = status; }

    public String getDbStatus() { return dbStatus != null ? dbStatus : status; }
    public void setDbStatus(String dbStatus) { this.dbStatus = dbStatus; this.status = normalizeStatus(dbStatus); }

    public String getLockReason() { return lockReason; }
    public void setLockReason(String lockReason) { this.lockReason = lockReason; }

    public int getViolationCount() { return violationCount; }
    public void setViolationCount(int violationCount) { this.violationCount = violationCount; }

    public int getCancelCount() { return cancelCount; }
    public void setCancelCount(int cancelCount) { this.cancelCount = cancelCount; }

    public String getAvatarUrl() { return avatarUrl; }
    public void setAvatarUrl(String avatarUrl) { this.avatarUrl = avatarUrl; this.avatar = avatarUrl; }

    public String getAvatar() { return avatar; }
    public void setAvatar(String avatar) { this.avatar = avatar; this.avatarUrl = avatar; }

    public String getCccd() { return cccd; }
    public void setCccd(String cccd) { this.cccd = cccd; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getExtraInfo() { return extraInfo; }
    public void setExtraInfo(String extraInfo) { this.extraInfo = extraInfo; }

    public boolean isAgreedTerms() { return agreedTerms; }
    public void setAgreedTerms(boolean agreedTerms) { this.agreedTerms = agreedTerms; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }

    public String getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(String updatedAt) { this.updatedAt = updatedAt; }
}
