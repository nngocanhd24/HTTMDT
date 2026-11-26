package com.ngocanh.httmdt.model;

import java.io.Serializable;

public class GuideProfile implements Serializable {
    private int profileId; // alias or same as guideId in v2
    private int guideId;
    private String bio;
    private int experienceYears;
    private String languages;
    private String region; // tinh_hoat_dong
    private String city; // alias for region
    private double pricePerHour;
    private double pricePerDay;
    private String approvalStatus; // "approved", "pending", "rejected"
    private String dbApprovalStatus; // "ĐÃ_DUYỆT", "CHỜ_DUYỆT", "TỪ_CHỐI"
    private String rejectionReason;
    private String approvedAt;
    private double averageRating;
    private int reviewCount;
    private String licenseNumber;
    private String licenseImageUrl;
    private String bankName;
    private String bankAccount;
    private String bankOwner;

    // Joined fields from Người_Dùng
    private String guideName;
    private String email;
    private String phone;
    private String avatarUrl;
    private String userStatus;
    private int violationCount;
    private int cancelCount;

    public GuideProfile() {}

    private String normalizeApproval(String st) {
        if (st == null) return "pending";
        String upper = st.trim().toUpperCase();
        if (upper.contains("ĐÃ_DUYỆT") || upper.contains("APPROVED")) return "approved";
        if (upper.contains("TỪ_CHỐI") || upper.contains("REJECTED")) return "rejected";
        return "pending";
    }

    public int getProfileId() { return profileId > 0 ? profileId : guideId; }
    public void setProfileId(int profileId) { this.profileId = profileId; }

    public int getGuideId() { return guideId; }
    public void setGuideId(int guideId) { 
        this.guideId = guideId; 
        if (this.profileId <= 0) this.profileId = guideId; 
    }

    public String getBio() { return bio; }
    public void setBio(String bio) { this.bio = bio; }

    public int getExperienceYears() { return experienceYears; }
    public void setExperienceYears(int experienceYears) { this.experienceYears = experienceYears; }

    public String getLanguages() { return languages; }
    public void setLanguages(String languages) { this.languages = languages; }

    public String getRegion() { return region; }
    public void setRegion(String region) { this.region = region; this.city = region; }

    public String getCity() { return city != null ? city : region; }
    public void setCity(String city) { this.city = city; this.region = city; }

    public double getPricePerHour() { return pricePerHour; }
    public void setPricePerHour(double pricePerHour) { this.pricePerHour = pricePerHour; }

    public double getPricePerDay() { return pricePerDay; }
    public void setPricePerDay(double pricePerDay) { this.pricePerDay = pricePerDay; }

    public String getApprovalStatus() { return approvalStatus; }
    public void setApprovalStatus(String approvalStatus) { 
        this.approvalStatus = normalizeApproval(approvalStatus); 
        this.dbApprovalStatus = approvalStatus; 
    }

    public String getDbApprovalStatus() { return dbApprovalStatus != null ? dbApprovalStatus : approvalStatus; }
    public void setDbApprovalStatus(String dbApprovalStatus) { 
        this.dbApprovalStatus = dbApprovalStatus; 
        this.approvalStatus = normalizeApproval(dbApprovalStatus); 
    }

    public String getRejectionReason() { return rejectionReason; }
    public void setRejectionReason(String rejectionReason) { this.rejectionReason = rejectionReason; }

    public String getApprovedAt() { return approvedAt; }
    public void setApprovedAt(String approvedAt) { this.approvedAt = approvedAt; }

    public double getAverageRating() { return averageRating; }
    public void setAverageRating(double averageRating) { this.averageRating = averageRating; }

    public int getReviewCount() { return reviewCount; }
    public void setReviewCount(int reviewCount) { this.reviewCount = reviewCount; }

    public String getLicenseNumber() { return licenseNumber; }
    public void setLicenseNumber(String licenseNumber) { this.licenseNumber = licenseNumber; }

    public String getLicenseImageUrl() { return licenseImageUrl; }
    public void setLicenseImageUrl(String licenseImageUrl) { this.licenseImageUrl = licenseImageUrl; }

    public String getBankName() { return bankName; }
    public void setBankName(String bankName) { this.bankName = bankName; }

    public String getBankAccount() { return bankAccount; }
    public void setBankAccount(String bankAccount) { this.bankAccount = bankAccount; }

    public String getBankOwner() { return bankOwner; }
    public void setBankOwner(String bankOwner) { this.bankOwner = bankOwner; }

    public String getGuideName() { return guideName; }
    public void setGuideName(String guideName) { this.guideName = guideName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAvatarUrl() { return avatarUrl; }
    public void setAvatarUrl(String avatarUrl) { this.avatarUrl = avatarUrl; }

    public String getUserStatus() { return userStatus; }
    public void setUserStatus(String userStatus) { this.userStatus = userStatus; }

    public int getViolationCount() { return violationCount; }
    public void setViolationCount(int violationCount) { this.violationCount = violationCount; }

    public int getCancelCount() { return cancelCount; }
    public void setCancelCount(int cancelCount) { this.cancelCount = cancelCount; }
}
