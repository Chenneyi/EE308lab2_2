package com.lin.MAFKC.controller;

import com.lin.MAFKC.config.CodeMsg;
import com.lin.MAFKC.config.Result;
import com.lin.MAFKC.mapper.UserMapper;
import com.lin.MAFKC.service.UserService;
import com.lin.MAFKC.vo.GetCodeVO;
import com.lin.MAFKC.vo.LoginVO;
import com.lin.MAFKC.vo.RegisterVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@CrossOrigin
public class UserController {

    @Autowired
    UserMapper userMapper;

    @Autowired
    UserService userService;

   
    @PostMapping("/user/login")
    Result<Map<String,String>> userLogin(@RequestBody LoginVO loginVO){
        if(userService.login(loginVO) == 1)
            return Result.success(userService.getName(loginVO.getId()));
        else
            return Result.error(CodeMsg.LOGIN_FAIL);
    }


    @PostMapping("/user/getCode")
    Result<String> getCode(@RequestBody GetCodeVO VO) {
        if(userService.sendCode(VO.getId()) == 1)
            return Result.success("Send successfully");
        else
            return Result.error(CodeMsg.SEND_CODE_FAIL);
    }

    @PostMapping("/user/register")
    Result<String> userRegister(@RequestBody RegisterVO VO) {
        if(userService.register(VO) == 1)
            return Result.success("log in successfully");
        else
            return Result.error(CodeMsg.REGISTER_FAIL);
    }

}
