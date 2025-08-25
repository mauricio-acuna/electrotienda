package com.sputnik.core.controller;

import com.sputnik.core.dto.MarketplaceDto;
import com.sputnik.core.service.MarketplaceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/marketplace")
public class MarketplaceController {

    @Autowired
    private MarketplaceService marketplaceService;

    @GetMapping("/listings")
    public ResponseEntity<List<MarketplaceDto>> getAllListings() {
        List<MarketplaceDto> listings = marketplaceService.getAllListings();
        return ResponseEntity.ok(listings);
    }

    @PostMapping("/listings")
    public ResponseEntity<MarketplaceDto> createListing(@RequestBody MarketplaceDto marketplaceDto) {
        MarketplaceDto createdListing = marketplaceService.createListing(marketplaceDto);
        return ResponseEntity.status(201).body(createdListing);
    }

    @GetMapping("/listings/{id}")
    public ResponseEntity<MarketplaceDto> getListingById(@PathVariable Long id) {
        MarketplaceDto listing = marketplaceService.getListingById(id);
        return ResponseEntity.ok(listing);
    }

    @DeleteMapping("/listings/{id}")
    public ResponseEntity<Void> deleteListing(@PathVariable Long id) {
        marketplaceService.deleteListing(id);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/transactions")
    public ResponseEntity<Void> createTransaction(@RequestBody MarketplaceDto marketplaceDto) {
        marketplaceService.createTransaction(marketplaceDto);
        return ResponseEntity.status(201).build();
    }
}