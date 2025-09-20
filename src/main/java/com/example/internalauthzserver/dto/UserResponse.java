package com.example.internalauthzserver.dto;

import java.util.List;

public record UserResponse(String username, boolean enabled, List<String> roles) {}
