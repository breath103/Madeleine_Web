<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.httpclient.HttpClient"%>
<%@ page import="org.apache.commons.httpclient.methods.GetMethod" %>
<%@ page import="org.apache.commons.httpclient.HttpStatus" %>
<%
request.setCharacterEncoding("utf-8");
String query = request.getParameter("query");
String target = request.getParameter("target");
String start = request.getParameter("start");
String url="http://openapi.naver.com/search?key=51c1d95b7fcab8890b58bc202f2830c8&query="+query+"&target="+target+"&start="+start+"&display=10";
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