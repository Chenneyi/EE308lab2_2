package config;

import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;
import cn.hutool.log.Log;
import cn.hutool.log.LogFactory;



@ServerEndpoint("/imserver/{userId}")
@Component
public class WebSocketServer {

    static Log log=LogFactory.get(WebSocketServer.class);
  
    private static int onlineCount = 0;

    private static ConcurrentHashMap<String,WebSocketServer> webSocketMap = new ConcurrentHashMap<>();
 
    private Session session;

    private String userId="";

    @OnOpen
    public void onOpen(Session session,@PathParam("userId") String userId) {
        this.session = session;
        this.userId=userId;
        if(webSocketMap.containsKey(userId)){
            webSocketMap.remove(userId);
            webSocketMap.put(userId,this);
     
        }else{
            webSocketMap.put(userId,this);
        
            addOnlineCount();
       
        }

        log.info("User connection:"+userId+",the number of people currently online is:" + getOnlineCount());

        try {
            sendMessage("successfu lconnection");
        } catch (IOException e) {
            log.error("USer:"+userId+",network anomaly!!!!!!");
        }
    }

  
    @OnClose
    public void onClose() {
        if(webSocketMap.containsKey(userId)){
            webSocketMap.remove(userId);
       
            subOnlineCount();
        }
        log.info("User Exit:"+userId+",The number of people currently online is:" + getOnlineCount());
    }


    @OnMessage
    public void onMessage(String message, Session session) {
        log.info("User Message:"+userId+",message:"+message);
       
        if(StringUtils.isNotBlank(message)){
            try {
                
                JSONObject jsonObject = JSON.parseObject(message);
               
                jsonObject.put("fromUserId",this.userId);
                String toUserId=jsonObject.getString("toUserId");
                
                if(StringUtils.isNotBlank(toUserId)&&webSocketMap.containsKey(toUserId)){
                    webSocketMap.get(toUserId).sendMessage(jsonObject.toJSONString());
                }else{
                    log.error("The required userId:"+toUserId+"Not on the server");
                
                }
            }catch (Exception e){
                e.printStackTrace();
            }
        }
    }


    @OnError
    public void onError(Session session, Throwable error) {
        log.error("User error:"+this.userId+",reason:"+error.getMessage());
        error.printStackTrace();
    }
  
    public void sendMessage(String message) throws IOException {
        this.session.getBasicRemote().sendText(message);
    }


    public static void sendInfo(String message,@PathParam("userId") String userId) throws IOException {
        log.info("sent the message to:"+userId+"，message:"+message);
        if(StringUtils.isNotBlank(userId)&&webSocketMap.containsKey(userId)){
            webSocketMap.get(userId).sendMessage(message);
        }else{
            log.error("User"+userId+",isn't online！");
        }
    }

    public static synchronized int getOnlineCount() {
        return onlineCount;
    }

    public static synchronized void addOnlineCount() {
        WebSocketServer.onlineCount++;
    }

    public static synchronized void subOnlineCount() {
        WebSocketServer.onlineCount--;
    }
}
