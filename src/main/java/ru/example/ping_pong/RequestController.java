package ru.example.ping_pong;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RequestController {

    @RequestMapping("/ping")
    public String sayPong(){
        return "pong...";
    }

    @Value("${spring.application.name}")
    private String name;

    @Value("${spring.application.version}")
    private String version;

    @RequestMapping
    public String sayVersion(){
        return name + " " + version;
    }

}
