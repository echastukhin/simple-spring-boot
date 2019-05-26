package ru.example.simple;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class RequestController {

    @RequestMapping("/ping")
    public String sayPong(){
        return "pong...";
    }

    @Value("${spring.application.name}")
    private String name;

    @RequestMapping
    public String sayVersion(){
        return name + " version 0.0.1";
    }

}
