package com.sputnik.core.dto;

import java.math.BigDecimal;

public class MarketplaceDto {
    private Long id;
    private Long sellerId;
    private Long productId;
    private String condition;
    private BigDecimal price;

    public MarketplaceDto() {
    }

    public MarketplaceDto(Long id, Long sellerId, Long productId, String condition, BigDecimal price) {
        this.id = id;
        this.sellerId = sellerId;
        this.productId = productId;
        this.condition = condition;
        this.price = price;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getSellerId() {
        return sellerId;
    }

    public void setSellerId(Long sellerId) {
        this.sellerId = sellerId;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }
}