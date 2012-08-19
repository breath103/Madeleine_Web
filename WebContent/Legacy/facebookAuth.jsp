<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="java.net.*" %>    
<%

        String appID = "191785150891389"; // 자신의 appID로 수정
        String callbackUrl = "http://localhost:8787/Madeleine/callback.jsp";
        String oauthUrl = "https://www.facebook.com/dialog/oauth?" +
                        "client_id="+ appID + "&redirect_uri=" + URLEncoder.encode(callbackUrl, "UTF-8")+
                        "&scope=user_about_me,user_photos,publish_stream,read_friendlists,offline_access";
        response.sendRedirect (oauthUrl);

%>