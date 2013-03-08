<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.restfb.*, com.restfb.types.*,facebook.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		// in : facebook_id 
		// out : access_token;
		FacebookBiz biz = new FacebookBiz();
		FacebookEntity entity = biz.find(request.getParameter("facebook_id"));
		
		if(entity != null)
			out.write(entity.getAccess_token());
		else
			out.write("null");
	%>
</body>
</html>