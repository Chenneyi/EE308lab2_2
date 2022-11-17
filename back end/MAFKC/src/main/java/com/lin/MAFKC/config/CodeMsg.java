package com.lin.MAFKC.config;

public class CodeMsg {

    private int code;
    private String msg;

    
    public static CodeMsg NO_FOUND = new CodeMsg(400, "404");
    public static CodeMsg SUCCESS = new CodeMsg(0, "success");
    public static CodeMsg SERVER_ERROR = new CodeMsg(500100, "Server exception");
    public static CodeMsg BIND_ERROR = new CodeMsg(500101, "Abnormal parameter verification：%s");
    public static CodeMsg ACCESS_LIMIT_REACHED= new CodeMsg(500104, "Please wait for the peak time!");
    public static CodeMsg LOGIN_FAIL = new CodeMsg(500210, "login failure");
    public static CodeMsg SEND_CODE_FAIL = new CodeMsg(500211, "fail to send");
    public static CodeMsg REGISTER_FAIL = new CodeMsg(500212, "fail to register");
    public static CodeMsg MATCH_WAIT = new CodeMsg(500215, "Making a match");
    public static CodeMsg DIS_ERROR = new CodeMsg(500216, "Failure to terminate the relationship");
    public static CodeMsg ORDER_EMPTY = new CodeMsg(500310, "No orders");
    public static CodeMsg IMG_NOT_RIGHT = new CodeMsg(500400, "The uploaded image format is invalid");
    public static CodeMsg IMG_UPLOAD_FALSE = new CodeMsg(500401, "Uploading pictures Failed");
    public static CodeMsg SECKILL_OVER = new CodeMsg(500500, "The goods have been sold in seconds");
    public static CodeMsg REPEATE_SECKILL = new CodeMsg(500501, "You can't repeat the second kill");
    private CodeMsg() {
    }
    private CodeMsg(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }
    public int getCode() {
        return code;
    }
    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }


    public CodeMsg fillArgs(Object... args) {
        int code = this.code;
        String message = String.format(this.msg, args);
        return new CodeMsg(code, message);
    }

    @Override
    public String toString() {
        return "CodeMsg [code=" + code + ", msg=" + msg + "]";
    }


}
