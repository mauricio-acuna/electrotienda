package com.sputnik.core.service;

import com.sputnik.core.dto.RegisterRequest;
import com.sputnik.core.entity.User;
import com.sputnik.core.entity.UserProfile;
import com.sputnik.core.entity.enums.UserRole;
import com.sputnik.core.entity.enums.UserStatus;
import com.sputnik.core.exception.CustomExceptions;
import com.sputnik.core.repository.UserRepository;
import com.sputnik.core.repository.UserProfileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private UserProfileRepository userProfileRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Transactional
    public User registerUser(RegisterRequest registerRequest) {
        if (userRepository.existsByEmail(registerRequest.getEmail())) {
            throw new CustomExceptions("Email already in use");
        }
        
        // Create User entity
        User user = new User();
        user.setId(UUID.randomUUID());
        user.setEmail(registerRequest.getEmail());
        user.setPasswordHash(passwordEncoder.encode(registerRequest.getPassword()));
        user.setRole(registerRequest.getRole());
        user.setStatus(UserStatus.ACTIVE);
        user.setEmailVerified(false);
        user.setFailedLoginAttempts(0);
        user.setCreatedAt(LocalDateTime.now());
        user.setUpdatedAt(LocalDateTime.now());
        
        User savedUser = userRepository.save(user);
        
        // Create UserProfile entity
        UserProfile userProfile = new UserProfile();
        userProfile.setId(UUID.randomUUID());
        userProfile.setUser(savedUser);
        userProfile.setFirstName(registerRequest.getFirstName());
        userProfile.setLastName(registerRequest.getLastName());
        userProfile.setPhone(registerRequest.getPhone());
        userProfile.setCreatedAt(LocalDateTime.now());
        userProfile.setUpdatedAt(LocalDateTime.now());
        
        userProfileRepository.save(userProfile);
        
        return savedUser;
    }
    
    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    public Optional<User> findById(UUID id) {
        return userRepository.findById(id);
    }
    
    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public void deleteUser(UUID id) {
        userRepository.deleteById(id);
    }
}