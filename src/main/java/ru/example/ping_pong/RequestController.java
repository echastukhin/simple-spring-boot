package ru.example.ping_pong;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.time.LocalTime;

@RestController
public class RequestController {

    @RequestMapping("/ping")
    public String sayPong(){
        return "pong...";
    }

    @RequestMapping("/date")
    public String sayDate(){
        return "Date: " + LocalDate.now() +" "+ LocalTime.now();
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
