package com.sputnik.core.controller;

import com.sputnik.core.dto.LoginRequest;
import com.sputnik.core.dto.RegisterRequest;
import com.sputnik.core.dto.JwtResponse;
import com.sputnik.core.entity.User;
import com.sputnik.core.service.UserService;
import com.sputnik.core.security.JwtUtils;
import com.sputnik.core.security.UserDetailsImpl;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private UserService userService;

    @Autowired
    private JwtUtils jwtUtils;

    @PostMapping("/login")
    public ResponseEntity<?> login(@Valid @RequestBody LoginRequest loginRequest) {
        try {
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(
                            loginRequest.getEmail(), 
                            loginRequest.getPassword()
                    )
            );
            
            UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();
            String jwt = jwtUtils.generateToken(userDetails);
            
            JwtResponse jwtResponse = new JwtResponse(
                    jwt,
                    userDetails.getUsername(),
                    userDetails.getAuthorities().iterator().next().getAuthority(),
                    userDetails.getId()
            );
            
            return ResponseEntity.ok(jwtResponse);
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                    .body("Error: Invalid email or password. " + e.getMessage());
        }
    }

    @PostMapping("/register")
    public ResponseEntity<?> register(@Valid @RequestBody RegisterRequest registerRequest) {
        try {
            // Check if email already exists
            if (userService.existsByEmail(registerRequest.getEmail())) {
                return ResponseEntity.badRequest()
                        .body("Error: Email is already in use!");
            }
            
            User user = userService.registerUser(registerRequest);
            return ResponseEntity.ok("User registered successfully with ID: " + user.getId());
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                    .body("Error: Could not register user. " + e.getMessage());
        }
    }
}