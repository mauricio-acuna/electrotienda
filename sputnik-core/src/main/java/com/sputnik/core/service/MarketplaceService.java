package com.sputnik.core.service;

import com.sputnik.core.entity.MarketplaceListing;
import com.sputnik.core.repository.MarketplaceListingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MarketplaceService {

    @Autowired
    private MarketplaceListingRepository marketplaceListingRepository;

    public List<MarketplaceListing> getAllListings() {
        return marketplaceListingRepository.findAll();
    }

    public MarketplaceListing createListing(MarketplaceListing listing) {
        return marketplaceListingRepository.save(listing);
    }

    public MarketplaceListing getListingById(Long id) {
        return marketplaceListingRepository.findById(id).orElse(null);
    }

    public void deleteListing(Long id) {
        marketplaceListingRepository.deleteById(id);
    }

    public MarketplaceListing updateListing(Long id, MarketplaceListing updatedListing) {
        if (marketplaceListingRepository.existsById(id)) {
            updatedListing.setId(id);
            return marketplaceListingRepository.save(updatedListing);
        }
        return null;
    }
}