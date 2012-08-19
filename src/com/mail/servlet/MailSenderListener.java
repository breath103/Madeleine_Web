package com.mail.servlet;


import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.types.User;

import madeleine.biz.MadeleineBiz;
import madeleine.entity.MadeleineEntity;
import common.GMailSender;
import facebook.*;
/**
 * Application Lifecycle Listener implementation class MailSenderListener
 *
 */
public class MailSenderListener implements ServletContextListener 
{
	public class MailSendingTask extends TimerTask
	{
		private MailSenderListener listener;
		private MadeleineEntity madeleine;
		public MailSendingTask( MailSenderListener listener,MadeleineEntity madeleine)
		{
			this.listener  = listener;
			this.madeleine = madeleine;
		}
		public void run()
		{
			// ������ ������,
			GMailSender mailSender = new GMailSender("breath103@gmail.com","dltkdgus");
			try {
				
				FacebookBiz fbBiz = new FacebookBiz();
				FacebookEntity fbEntity = fbBiz.find(madeleine.getCreator());
				FacebookClient FB 		= new DefaultFacebookClient(fbEntity.getAccess_token());
				User me = FB.fetchObject("/me", User.class);
					
				String mailTitle = me.getName()+"���� �Ҿ���� �ð��� ã�ƿԽ��ϴ�.";
				mailSender.sendMail(mailTitle, 
						"<center><a href = \"http://breath103.cafe24.com/Galary/sample1.jsp?id=" + madeleine.getIdx() + "\"><img src=\"http://breath103.cafe24.com/image/madeleine.jpg\"></a></center>",
									"sender",
									fbEntity.getEmail());
				System.out.println(fbEntity.getEmail());
				
				madeleine.setIs_sended(true);
				listener.getBiz().update(madeleine);
				System.out.println("Mail Sended");
			} catch (Exception e) {
				e.printStackTrace();
			}
		
			// ���� ������ ����
			listener.registerMailTask();
		}
		public MadeleineEntity getCurrentMadeleine(){return madeleine;}
	}
	
	private Timer task_timer;
	private MailSendingTask currentMailTask;
	private MadeleineBiz biz;
	static private MailSenderListener singleton;
	
    public MailSenderListener() {
        // TODO Auto-generated constructor stub
    	System.out.println("listener created;");
    	
    	singleton = this;
    	task_timer = new Timer();
    	biz 	   = new MadeleineBiz();
    	
    	registerMailTask();
    }
    static public MailSenderListener getSingleton() { return singleton; }
    
    public MailSendingTask getCurrentMailTask() {return currentMailTask;}
    public void registerMailTask()
    {
		task_timer.cancel();
		task_timer.purge();
		task_timer = new Timer();
    	
    	currentMailTask = null;
    	MadeleineEntity madeleine = biz.findSendableMail();
    	if(madeleine != null)
    	{
    		currentMailTask = new MailSendingTask(this,madeleine);
    		task_timer.schedule(currentMailTask, madeleine.getReserved_time());
    		
    		System.out.println("registerd : " + madeleine.getIdx() + " # " + madeleine.getReserved_time());
    	}
    	else
    	{
    		//��ϵǾ� �ִ� ������ �ϳ��� ���°��. ���� �������� ��� ���� 
    		System.out.println("there is no mail to send.");
    		final MailSenderListener outerThis = this;
    		task_timer.schedule(new TimerTask()
    		{
				public void run() {
					outerThis.registerMailTask();
				}
    		},1000 * 60); //1�е� ������
    	}
    }
    public void onNewMadeleine(MadeleineEntity madeleine)
    {
    	if(currentMailTask == null) //���� ����� ������ ���°�� 
    	{
    		this.registerMailTask();
    	}
    	else // ���� ����� ������ �ִ°�� 
    	{
    		// ����� ���鷻���� ���� ������ �ϴ� ���鷻�� ��� 
    		if( madeleine.getReserved_time().before(currentMailTask.getCurrentMadeleine().getReserved_time()) )
    		{
    			task_timer.cancel();
    			task_timer.purge();
    			task_timer = new Timer();
    	    	currentMailTask = new MailSendingTask(this,madeleine);
    	    	task_timer.schedule(currentMailTask, madeleine.getReserved_time());
    	    		
    	    	System.out.println("registerd : " + madeleine.getIdx() + " # " + madeleine.getReserved_time());
    		}
    	}
    }
    
    public void contextInitialized(ServletContextEvent arg0) {
    	System.out.println("init Context " + arg0);
    }
    public void contextDestroyed(ServletContextEvent arg0) {
    	System.out.println("destroy Context " + arg0);
    }
	
    public MadeleineBiz getBiz() {return biz;}
}
