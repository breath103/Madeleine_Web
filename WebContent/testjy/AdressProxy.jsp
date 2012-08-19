<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.httpclient.HttpClient"%>
<%@ page import="org.apache.commons.httpclient.methods.GetMethod" %>
<%@ page import="org.apache.commons.httpclient.HttpStatus" %>
<%
	request.setCharacterEncoding("UTF-8");
	String query = request.getParameter("query"); 
	
	String url="http://openapi.map.naver.com/api/geocode.php?key=146b6875b92cd9555ab2f60103ec6ff6&encoding=utf-8&coord=latlng&query="+query+"";
	HttpClient client = new HttpClient();
	GetMethod method = new GetMethod(url);
	try{
		int statusCode=client.executeMethod(method);
		out.clearBuffer();
		response.reset();
		response.setStatus(statusCode);
		if(statusCode == HttpStatus.SC_OK){
			String result = method.getResponseBodyAsString();
			response.setContentType("application/xml; charset=utf-8");
			out.println(result);
		}
	}finally{
		if(method !=null)method.releaseConnection();
	}

%>