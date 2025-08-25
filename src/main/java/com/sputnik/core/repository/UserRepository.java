package com.sputnik.core.repository;

import com.sputnik.core.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserRepository extends JpaRepository<User, UUID> {
    
    /**
     * Find user by email
     */
    Optional<User> findByEmail(String email);
    
    /**
     * Check if email exists
     */
    Boolean existsByEmail(String email);
    
    /**
     * Find users by role
     */
    List<User> findByRole(User.UserRole role);
    
    /**
     * Find users by status
     */
    List<User> findByStatus(User.UserStatus status);
    
    /**
     * Find active users
     */
    @Query("SELECT u FROM User u WHERE u.status = 'ACTIVE' AND (u.lockedUntil IS NULL OR u.lockedUntil < :now)")
    List<User> findActiveUsers(@Param("now") LocalDateTime now);
    
    /**
     * Find users created between dates
     */
    List<User> findByCreatedAtBetween(LocalDateTime startDate, LocalDateTime endDate);
    
    /**
     * Find users with failed login attempts
     */
    @Query("SELECT u FROM User u WHERE u.failedLoginAttempts >= :maxAttempts")
    List<User> findUsersWithFailedAttempts(@Param("maxAttempts") Integer maxAttempts);
    
    /**
     * Find locked users
     */
    @Query("SELECT u FROM User u WHERE u.lockedUntil IS NOT NULL AND u.lockedUntil > :now")
    List<User> findLockedUsers(@Param("now") LocalDateTime now);
    
    /**
     * Count users by role
     */
    @Query("SELECT COUNT(u) FROM User u WHERE u.role = :role")
    Long countByRole(@Param("role") User.UserRole role);
    
    /**
     * Find users who haven't verified their email
     */
    List<User> findByEmailVerifiedFalse();
    
    /**
     * Find users by email containing (for search)
     */
    List<User> findByEmailContainingIgnoreCase(String email);
}
