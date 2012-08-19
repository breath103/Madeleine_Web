<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.util.ArrayList"%>
<%@ page import = "madeleine.biz.MadeleineBiz"%>
<%@ page import = "madeleine.entity.MadeleineEntity"%>
<%@ page import = "net.sf.json.*"%>
<%@ page import = "com.mail.servlet.MailSenderListener"%>

<% 
	MailSenderListener listener = MailSenderListener.getSingleton();

	if( listener!= null && listener.getCurrentMailTask() != null)	
	{
		
		MadeleineEntity madeleine = listener.getCurrentMailTask().getCurrentMadeleine();
	//	out.write("idx : " + madeleine.getIdx() + " reserved_time : " + madeleine.getReserved_time() + " created_time : " + madeleine.getCreated_time());
		JSONObject json_madeleine = JSONObject.fromObject(madeleine);
		out.write(json_madeleine.toString());		
	}
%>