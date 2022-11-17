package com.lin.MAFKC.service;

import com.lin.MAFKC.config.RedisUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.util.Random;

@Service
public class MailService {

    Logger logger = LoggerFactory.getLogger(this.getClass());

    @Value("${spring.mail.username}")
    private String mailFrom;

    @Autowired
    private RedisUtil redisUtil;

    @Autowired
    private JavaMailSender mailSender;


    public SimpleMailMessage generateMailByExamId(String userMail) {
     
        String sources = "0123456789"; 
        Random rand = new Random();
        StringBuffer flag = new StringBuffer();
        for (int j = 0; j < 6; j++)
        {
            flag.append(sources.charAt(rand.nextInt(9)) + "");
        }
        String code = flag.toString();

        SimpleMailMessage message = new SimpleMailMessage();
        message.setSubject("[MAFKC]");
        message.setText("Dear user, your verification code is" + code +",Dear users, your verification code for the verification code within 5 minutes, thank you for using.");
        message.setTo(userMail);
        message.setFrom(mailFrom);

        
        redisUtil.set(userMail,code);
        redisUtil.expire(userMail,300);
        System.out.println(redisUtil.getExpire(userMail));
        return message;
    }


    public void sendOut(SimpleMailMessage message) {
        System.out.println(message);
        mailSender.send(message);
    }
}
