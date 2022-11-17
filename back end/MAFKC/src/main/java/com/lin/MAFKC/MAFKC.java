package com.lin.MAFKC;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.lin.MAFKC.mapper")
public class MAFK {

    public static void main(String[] args) {
        SpringApplication.run(MAFKC.class, args);
    }

}
