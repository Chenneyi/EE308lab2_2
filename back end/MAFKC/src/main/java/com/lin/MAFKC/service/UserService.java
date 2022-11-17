package com.lin.MAFKC.service;

import com.lin.MAFKC.config.RedisUtil;
import com.lin.MAFKC.entity.User;
import com.lin.MAFKC.mapper.UserMapper;
import com.lin.MAFKC.vo.LoginVO;
import com.lin.MAFKC.vo.RegisterVO;
import org.springframework.beans.factory.annotation.Autowired;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class UserService {

    private Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    UserMapper userMapper;

    @Autowired
    MailService mailService;

    @Autowired
    RedisUtil redisUtil;

    public int login(LoginVO loginVO){
        User getUser;
        try {
            getUser = userMapper.selectById(loginVO.getId());
            logger.info(getUser.getId());
            if (getUser.getId().equals(loginVO.getId())) {
                logger.info("The email is exist");
                if (getUser.getPassword().equals(loginVO.getPassword())) {
                    logger.info("The passwords are correct");
                    return 1;
                }
                else {
                    logger.info("The passwords are wrong");
                    return 0;
                }
            }
        }
        catch (Exception e){
            logger.info("The email isn't exist");
            return 0;
        }
        return 0;
    }


    public int sendCode(String userMail){
        try{
            SimpleMailMessage message = mailService.generateMailByExamId(userMail);
            mailService.sendOut(message);
            return 1;
        }
        catch (Exception e){
            logger.info("fail to send");
            return 0;
        }
    }

    
    public int register(RegisterVO VO) {
        String mail = VO.getId();
        String password = VO.getPassword();
        String name = VO.getName();
        User user = new User(mail,password,name);
        try {
            userMapper.insert(user);
            return 1;
        }
        catch (Exception e){
            return 0;
        }
    }

    public Map<String, String> getName(String mail) {
        User user = userMapper.selectById(mail);
        Map<String,String> map = new HashMap<>();
        map.put("username", user.getName());
        return map;
    }
}
