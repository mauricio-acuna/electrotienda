package com.sputnik.core.repository;

import com.sputnik.core.entity.Store;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StoreRepository extends JpaRepository<Store, Long> {
    // Additional query methods can be defined here if needed
}