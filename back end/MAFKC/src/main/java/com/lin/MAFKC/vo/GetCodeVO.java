package com.lin.MAFKC.vo;

import lombok.Data;

import javax.validation.constraints.Email;

@Data
public class GetCodeVO {

    @Email(message = "Incorrect email format")
    private String id;
}
