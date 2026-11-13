package com.ygyong.task_manager.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/hello")
    public String hello() {
        return "Hello, World!";
    }

    @GetMapping("/hello/name")
    public String helloName(@RequestParam(name = "name", defaultValue = "访客") String userName) {
        return "Hello, " + userName + "!";
    }
}
