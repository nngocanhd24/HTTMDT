package com.ngocanh.httmdt.model;

import java.io.Serializable;

public class Transaction implements Serializable {
    private int transactionId; // ma_giao_dich
    private int id; // alias
    private String transactionCode; // "TXN-" + ma_giao_dich
    private int bookingId; // ma_don
    private Integer disputeId; // ma_khieu_nai
    private String type; // normalized: ESCROW_HOLD, REFUND, SETTLE, PLATFORM_FEE
    private String dbType; // "TẠM_GIỮ", "TẤT_TOÁN", "HOÀN_TIỀN", "PHÍ_SÀN"
    private double amount; // so_tien
    private String paymentGateway; // cong_thanh_toan (VNPAY, MOMO, CHUYỂN_KHOẢN)
    private String gatewayReference; // ma_tham_chieu_cong
    private String status; // trang_thai (CHỜ_XỬ_LÝ, THÀNH_CÔNG, THẤT_BẠI)
    private String note; // ghi_chu
    private String createdAt; // ngay_tao
    private String updatedAt; // ngay_cap_nhat

    // Joined fields
    private String bookingCode;
    private String destination;
    private String customerName;
    private String guideName;

    public Transaction() {}

    private String normalizeType(String t) {
        if (t == null) return "ESCROW_HOLD";
        String upper = t.trim().toUpperCase();
        if (upper.contains("TẠM_GIỮ") || upper.contains("HOLD") || upper.contains("ESCROW")) return "ESCROW_HOLD";
        if (upper.contains("TẤT_TOÁN") || upper.contains("SETTLE") || upper.contains("PAYOUT")) return "SETTLE";
        if (upper.contains("PHÍ_SÀN") || upper.contains("FEE")) return "PLATFORM_FEE";
        if (upper.contains("HOÀN_TIỀN") || upper.contains("REFUND")) return "REFUND";
        return t;
    }

    public int getTransactionId() { return transactionId; }
    public void setTransactionId(int transactionId) { 
        this.transactionId = transactionId; 
        this.id = transactionId;
        if (this.transactionCode == null || this.transactionCode.isEmpty()) {
            this.transactionCode = "TXN-" + transactionId;
        }
    }

    public int getId() { return id > 0 ? id : transactionId; }
    public void setId(int id) { this.id = id; this.transactionId = id; }

    public String getTransactionCode() { 
        return (transactionCode != null && !transactionCode.isEmpty()) ? transactionCode : ("TXN-" + transactionId); 
    }
    public void setTransactionCode(String transactionCode) { this.transactionCode = transactionCode; }

    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public Integer getDisputeId() { return disputeId; }
    public void setDisputeId(Integer disputeId) { this.disputeId = disputeId; }

    public String getType() { return type; }
    public void setType(String type) { 
        this.type = normalizeType(type); 
        this.dbType = type; 
    }

    public String getDbType() { return dbType != null ? dbType : type; }
    public void setDbType(String dbType) { 
        this.dbType = dbType; 
        this.type = normalizeType(dbType); 
    }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getPaymentGateway() { return paymentGateway; }
    public void setPaymentGateway(String paymentGateway) { this.paymentGateway = paymentGateway; }

    public String getGatewayReference() { return gatewayReference; }
    public void setGatewayReference(String gatewayReference) { this.gatewayReference = gatewayReference; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }

    public String getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(String updatedAt) { this.updatedAt = updatedAt; }

    public String getBookingCode() { return bookingCode; }
    public void setBookingCode(String bookingCode) { this.bookingCode = bookingCode; }

    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getGuideName() { return guideName; }
    public void setGuideName(String guideName) { this.guideName = guideName; }
}
