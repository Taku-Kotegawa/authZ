package com.example.internalauthzserver.controller;

import com.example.internalauthzserver.dto.UserResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api")
public class AdminController {

    private final UserDetailsManager userDetailsManager;

    public AdminController(UserDetailsManager userDetailsManager) {
        this.userDetailsManager = userDetailsManager;
    }

    @GetMapping("/users/{username}")
    public ResponseEntity<UserResponse> getUser(@PathVariable String username) {
        if (!userDetailsManager.userExists(username)) {
            return ResponseEntity.notFound().build();
        }
        UserDetails user = userDetailsManager.loadUserByUsername(username);
        List<String> roles = user.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.toList());
        UserResponse response = new UserResponse(user.getUsername(), user.isEnabled(), roles);
        return ResponseEntity.ok(response);
    }

    // POST, PUT, DELETE の実装は省略
}
