package com.example.internalauthzserver.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ResourceController {

    @GetMapping("/messages")
    public String[] getMessages() {
        return new String[]{"Message 1", "Message 2", "Message 3"};
    }

    @GetMapping("/public/hello")
    public String getPublicHello() {
        return "Hello from public endpoint!";
    }
}
