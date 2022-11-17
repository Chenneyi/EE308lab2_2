package com.lin.MAFKC.vo;

import lombok.Data;

import javax.validation.constraints.Email;

@Data
public class LoginVO {

    @Email(message = "Incorrect email format")
    private String id;

    private String password;
}
