package com.sputnik.core.dto;

import lombok.Data;

@Data
public class ProductDto {
    private Long id;
    private String name;
    private String description;
    private Long categoryId;
    private String brand;
    private String model;
    private Double price;
    private String[] images; // URLs of product images
}