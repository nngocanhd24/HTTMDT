package com.ngocanh.httmdt.model;

import java.io.Serializable;

public class Booking implements Serializable {
    private int bookingId; // ma_don
    private int id; // alias
    private String bookingCode; // "TRIP-" + ma_don
    private int customerId; // ma_KH
    private int guideId; // ma_HDV
    private String destination; // diem_den
    private String itinerary; // lich_trinh
    private String startDate; // ngay_bat_dau
    private String startTime; // gio_bat_dau
    private String endDate; // ngay_ket_thuc
    private String endTime; // gio_ket_thuc
    private int numberOfGuests; // so_luong_khach
    private int guests; // alias
    private String rentalType; // hinh_thuc_thue (THEO_GIỜ, THEO_NGÀY)
    private double unitPrice; // don_gia
    private int units; // so_don_vi
    private double totalPrice; // tong_tien
    private double platformFeeRate; // ty_le_phi
    private double platformFee; // phi_san
    private double guideReceivedAmount; // tien_hdv_nhan
    private String note; // ghi_chu
    private String notes; // alias
    private String confirmDeadline; // han_chot_xac_nhan
    private String guideAcceptedAt; // hdv_chap_nhan_luc
    private String rejectionReason; // ly_do_tu_choi
    private boolean customerConfirmed; // khach_xac_nhan_ket_thuc_luc != null
    private String customerConfirmedAt;
    private boolean guideConfirmed; // hdv_xac_nhan_ket_thuc_luc != null
    private String guideConfirmedAt;
    private String completedAt; // hoan_thanh_luc
    private String settlementDeadline; // han_tat_toan
    private Integer cancelledById; // ma_nguoi_huy
    private String cancelledAt; // ngay_huy
    private String cancelReason; // ly_do_huy
    private String status; // normalized: pending_guide, confirmed_upcoming, finished_paid, cancelled_refunded, disputed
    private String dbStatus; // "CHỜ_XÁC_NHẬN", "ĐÃ_XÁC_NHẬN", "BỊ_TỪ_CHỐI", "ĐÃ_HỦY", "ĐÃ_HOÀN_THÀNH", "ĐANG_KHIẾU_NẠI"
    private String createdAt;
    private String updatedAt;

    // Joined fields
    private String customerName;
    private String customerPhone;
    private String customerEmail;
    private String guideName;
    private String guidePhone;
    private String guideEmail;

    public Booking() {}

    private String normalizeStatus(String st) {
        if (st == null) return "pending_guide";
        String upper = st.trim().toUpperCase();
        if (upper.contains("ĐANG_KHIẾU_NẠI") || upper.contains("DISPUTED")) return "disputed";
        if (upper.contains("ĐÃ_HOÀN_THÀNH") || upper.contains("COMPLETED")) return "finished_paid";
        if (upper.contains("ĐÃ_HỦY") || upper.contains("BỊ_TỪ_CHỐI") || upper.contains("CANCELLED") || upper.contains("REJECTED")) return "cancelled_refunded";
        if (upper.contains("ĐÃ_XÁC_NHẬN") || upper.contains("CONFIRMED")) return "confirmed_upcoming";
        return "pending_guide";
    }

    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { 
        this.bookingId = bookingId; 
        this.id = bookingId;
        if (this.bookingCode == null || this.bookingCode.isEmpty()) {
            this.bookingCode = "TRIP-" + bookingId;
        }
    }

    public int getId() { return id > 0 ? id : bookingId; }
    public void setId(int id) { this.id = id; this.bookingId = id; }

    public String getBookingCode() { 
        return (bookingCode != null && !bookingCode.isEmpty()) ? bookingCode : ("TRIP-" + bookingId); 
    }
    public void setBookingCode(String bookingCode) { this.bookingCode = bookingCode; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public int getGuideId() { return guideId; }
    public void setGuideId(int guideId) { this.guideId = guideId; }

    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }

    public String getItinerary() { return itinerary; }
    public void setItinerary(String itinerary) { this.itinerary = itinerary; }

    public String getStartDate() { return startDate; }
    public void setStartDate(String startDate) { this.startDate = startDate; }

    public String getStartTime() { return startTime != null ? startTime : "08:00"; }
    public void setStartTime(String startTime) { this.startTime = startTime; }

    public String getEndDate() { return endDate != null ? endDate : startDate; }
    public void setEndDate(String endDate) { this.endDate = endDate; }

    public String getEndTime() { return endTime != null ? endTime : "17:30"; }
    public void setEndTime(String endTime) { this.endTime = endTime; }

    public int getNumberOfGuests() { return numberOfGuests > 0 ? numberOfGuests : (guests > 0 ? guests : 1); }
    public void setNumberOfGuests(int numberOfGuests) { this.numberOfGuests = numberOfGuests; this.guests = numberOfGuests; }

    public int getGuests() { return getNumberOfGuests(); }
    public void setGuests(int guests) { this.guests = guests; this.numberOfGuests = guests; }

    public String getRentalType() { return rentalType; }
    public void setRentalType(String rentalType) { this.rentalType = rentalType; }

    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; }

    public int getUnits() { return units; }
    public void setUnits(int units) { this.units = units; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }

    public double getPlatformFeeRate() { return platformFeeRate; }
    public void setPlatformFeeRate(double platformFeeRate) { this.platformFeeRate = platformFeeRate; }

    public double getPlatformFee() { return platformFee; }
    public void setPlatformFee(double platformFee) { this.platformFee = platformFee; }

    public double getGuideReceivedAmount() { return guideReceivedAmount; }
    public void setGuideReceivedAmount(double guideReceivedAmount) { this.guideReceivedAmount = guideReceivedAmount; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; this.notes = note; }

    public String getNotes() { return note != null ? note : notes; }
    public void setNotes(String notes) { this.notes = notes; this.note = notes; }

    public String getConfirmDeadline() { return confirmDeadline; }
    public void setConfirmDeadline(String confirmDeadline) { this.confirmDeadline = confirmDeadline; }

    public String getGuideAcceptedAt() { return guideAcceptedAt; }
    public void setGuideAcceptedAt(String guideAcceptedAt) { this.guideAcceptedAt = guideAcceptedAt; }

    public String getRejectionReason() { return rejectionReason; }
    public void setRejectionReason(String rejectionReason) { this.rejectionReason = rejectionReason; }

    public boolean isCustomerConfirmed() { return customerConfirmed; }
    public void setCustomerConfirmed(boolean customerConfirmed) { this.customerConfirmed = customerConfirmed; }

    public String getCustomerConfirmedAt() { return customerConfirmedAt; }
    public void setCustomerConfirmedAt(String customerConfirmedAt) { 
        this.customerConfirmedAt = customerConfirmedAt;
        if (customerConfirmedAt != null && !customerConfirmedAt.isEmpty()) this.customerConfirmed = true;
    }

    public boolean isGuideConfirmed() { return guideConfirmed; }
    public void setGuideConfirmed(boolean guideConfirmed) { this.guideConfirmed = guideConfirmed; }

    public String getGuideConfirmedAt() { return guideConfirmedAt; }
    public void setGuideConfirmedAt(String guideConfirmedAt) { 
        this.guideConfirmedAt = guideConfirmedAt;
        if (guideConfirmedAt != null && !guideConfirmedAt.isEmpty()) this.guideConfirmed = true;
    }

    public String getCompletedAt() { return completedAt; }
    public void setCompletedAt(String completedAt) { this.completedAt = completedAt; }

    public String getSettlementDeadline() { return settlementDeadline; }
    public void setSettlementDeadline(String settlementDeadline) { this.settlementDeadline = settlementDeadline; }

    public Integer getCancelledById() { return cancelledById; }
    public void setCancelledById(Integer cancelledById) { this.cancelledById = cancelledById; }

    public String getCancelledAt() { return cancelledAt; }
    public void setCancelledAt(String cancelledAt) { this.cancelledAt = cancelledAt; }

    public String getCancelReason() { return cancelReason; }
    public void setCancelReason(String cancelReason) { this.cancelReason = cancelReason; }

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

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }

    public String getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(String updatedAt) { this.updatedAt = updatedAt; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getCustomerPhone() { return customerPhone; }
    public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }

    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }

    public String getGuideName() { return guideName; }
    public void setGuideName(String guideName) { this.guideName = guideName; }

    public String getGuidePhone() { return guidePhone; }
    public void setGuidePhone(String guidePhone) { this.guidePhone = guidePhone; }

    public String getGuideEmail() { return guideEmail; }
    public void setGuideEmail(String guideEmail) { this.guideEmail = guideEmail; }
}
