package com.sputnik.core.repository;

import com.sputnik.core.entity.UserProfile;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserProfileRepository extends JpaRepository<UserProfile, UUID> {
    
    Optional<UserProfile> findByUserId(UUID userId);
    
    boolean existsByUserId(UUID userId);
    
    void deleteByUserId(UUID userId);
}
