package com.ngocanh.httmdt.model;

import java.io.Serializable;

public class Dispute implements Serializable {
    private int disputeId; // ma_khieu_nai
    private int id; // alias
    private String disputeCode; // "DSP-" + ma_khieu_nai
    private int bookingId; // ma_don
    private int reporterId; // ma_nguoi_khieu_nai
    private int reportedUserId; // ma_nguoi_bi_khieu_nai
    private String disputeType; // loai_khieu_nai
    private String reason; // ly_do
    private String evidenceImageUrl; // anh_bang_chung
    private double disputedAmount; // so_tien_tranh_chap
    private String explanation; // giai_trinh
    private String explanationImageUrl; // anh_giai_trinh
    private String status; // normalized: pending, need_more_info, resolved_refund, resolved_release
    private String dbStatus; // "CHỜ_XỬ_LÝ", "CHỜ_BỔ_SUNG", "CHẤP_NHẬN", "BÁC_BỎ"
    private Double refundedAmount; // so_tien_hoan
    private String adminNote; // ghi_chu_admin
    private String createdAt; // ngay_tao
    private String resolvedAt; // ngay_xu_ly
    private String resolutionDeadline; // han_giai_quyet

    // Joined fields
    private String bookingCode;
    private String reporterName;
    private String reporterPhone;
    private String reporterRole;
    private String reportedName;
    private String reportedPhone;
    private String destination;

    public Dispute() {}

    private String normalizeStatus(String st) {
        if (st == null) return "pending";
        String upper = st.trim().toUpperCase();
        if (upper.contains("CHẤP_NHẬN") || upper.contains("APPROVED_REFUND")) return "resolved_refund";
        if (upper.contains("BÁC_BỎ") || upper.contains("REJECTED")) return "resolved_release";
        if (upper.contains("CHỜ_BỔ_SUNG") || upper.contains("NEED_MORE_INFO") || upper.contains("BO_SUNG")) return "need_more_info";
        return "pending";
    }

    public int getDisputeId() { return disputeId; }
    public void setDisputeId(int disputeId) { 
        this.disputeId = disputeId; 
        this.id = disputeId;
        if (this.disputeCode == null || this.disputeCode.isEmpty()) {
            this.disputeCode = "DSP-" + disputeId;
        }
    }

    public int getId() { return id > 0 ? id : disputeId; }
    public void setId(int id) { this.id = id; this.disputeId = id; }

    public String getDisputeCode() { 
        return (disputeCode != null && !disputeCode.isEmpty()) ? disputeCode : ("DSP-" + disputeId); 
    }
    public void setDisputeCode(String disputeCode) { this.disputeCode = disputeCode; }

    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public int getReporterId() { return reporterId; }
    public void setReporterId(int reporterId) { this.reporterId = reporterId; }

    public int getReportedUserId() { return reportedUserId; }
    public void setReportedUserId(int reportedUserId) { this.reportedUserId = reportedUserId; }

    public String getDisputeType() { return disputeType; }
    public void setDisputeType(String disputeType) { this.disputeType = disputeType; }

    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }

    public String getEvidenceImageUrl() { return evidenceImageUrl; }
    public void setEvidenceImageUrl(String evidenceImageUrl) { this.evidenceImageUrl = evidenceImageUrl; }

    public double getDisputedAmount() { return disputedAmount; }
    public void setDisputedAmount(double disputedAmount) { this.disputedAmount = disputedAmount; }

    public String getExplanation() { return explanation; }
    public void setExplanation(String explanation) { this.explanation = explanation; }

    public String getExplanationImageUrl() { return explanationImageUrl; }
    public void setExplanationImageUrl(String explanationImageUrl) { this.explanationImageUrl = explanationImageUrl; }

    public String getStatus() { return status; }
    public void setStatus(String status) { 
        this.status = normalizeStatus(status); 
        this.dbStatus = status; 
    }

    public String getDbStatus() { return dbStatus != null ? dbStatus : status; }
    public void setDbStatus(String dbStatus) { 
        this.dbStatus = dbStatus; 
        this.status = normalizeStatus(dbStatus); 
    }

    public Double getRefundedAmount() { return refundedAmount; }
    public void setRefundedAmount(Double refundedAmount) { this.refundedAmount = refundedAmount; }

    public String getAdminNote() { return adminNote; }
    public void setAdminNote(String adminNote) { this.adminNote = adminNote; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }

    public String getResolvedAt() { return resolvedAt; }
    public void setResolvedAt(String resolvedAt) { this.resolvedAt = resolvedAt; }

    public String getResolutionDeadline() { return resolutionDeadline; }
    public void setResolutionDeadline(String resolutionDeadline) { this.resolutionDeadline = resolutionDeadline; }

    public String getBookingCode() { return bookingCode; }
    public void setBookingCode(String bookingCode) { this.bookingCode = bookingCode; }

    public String getReporterName() { return reporterName; }
    public void setReporterName(String reporterName) { this.reporterName = reporterName; }

    public String getReporterPhone() { return reporterPhone; }
    public void setReporterPhone(String reporterPhone) { this.reporterPhone = reporterPhone; }

    public String getReporterRole() { return reporterRole; }
    public void setReporterRole(String reporterRole) { this.reporterRole = reporterRole; }

    public String getReportedName() { return reportedName; }
    public void setReportedName(String reportedName) { this.reportedName = reportedName; }

    public String getReportedPhone() { return reportedPhone; }
    public void setReportedPhone(String reportedPhone) { this.reportedPhone = reportedPhone; }

    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }
}
