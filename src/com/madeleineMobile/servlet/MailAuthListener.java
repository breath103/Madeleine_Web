package com.madeleineMobile.servlet;

import java.util.*;

import javax.servlet.ServletContextAttributeEvent;
import javax.servlet.ServletContextAttributeListener;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;


import com.madeleineMobile.entitiy.*;
/**
 * Application Lifecycle Listener implementation class MailAuthListener
 *
 */
@WebListener
public class MailAuthListener implements ServletContextListener, ServletContextAttributeListener {
    /**
     * Default constructor. 
     */
	
	private Hashtable<String,MobileUserEntity> mailAuthList;
	public String registerMailForAuth(MobileUserEntity userEntity)
	{
		String hashCode = String.valueOf(userEntity.getEmail().hashCode());
		mailAuthList.put(hashCode, userEntity);
		System.out.printf("%s %s\n",hashCode, userEntity);
		// DB에 이미 등록된 메일인지 확인하여 이미 등록된 경우 null 반환
		return hashCode;
	}
	public MobileUserEntity checkAuthCode(String authCode)
	{
		return mailAuthList.get(authCode);
	}
	public void invalidateAuthCode(String authCode)
	{
		mailAuthList.remove(authCode);
	}
	private static MailAuthListener instance;
	public static MailAuthListener getInstance() { return instance; }
	
    public MailAuthListener() {
        // TODO Auto-generated constructor stub
    	mailAuthList = new Hashtable<String,MobileUserEntity>();
    	instance = this;
    }
  
	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent arg0) {
        // TODO Auto-generated method stub
    	System.out.println("mail auth listener Start");
    }
    
   
	/**
     * @see ServletContextAttributeListener#attributeAdded(ServletContextAttributeEvent)
     */
    public void attributeAdded(ServletContextAttributeEvent arg0) {
        // TODO Auto-generated method stub
    }
	/**
     * @see ServletContextAttributeListener#attributeReplaced(ServletContextAttributeEvent)
     */
    public void attributeReplaced(ServletContextAttributeEvent arg0) {
        // TODO Auto-generated method stub
    }
	/**
     * @see ServletContextAttributeListener#attributeRemoved(ServletContextAttributeEvent)
     */
    public void attributeRemoved(ServletContextAttributeEvent arg0) {
        // TODO Auto-generated method stub
    }
	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent arg0) {
        // TODO Auto-generated method stub
    }
	
}
