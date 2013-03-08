<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"
    %>
<%@ page import="java.net.*,java.io.*" %>
<%
	String urlStr = "http://openapi.naver.com/search?key=e3d0b258dc65f2c9dc9fe3a5a635d097&"+request.getQueryString();
	
	URL url;//URL 주소 객체
	URLConnection connection;//URL접속을 가지는 객체
	InputStream is;//URL접속에서 내용을 읽기위한 Stream
	 InputStreamReader isr;
	 BufferedReader br;
	
	 try{
	     //URL객체를 생성하고 해당 URL로 접속한다..
	     url = new URL(urlStr);
	     connection = url.openConnection();
	
	     //내용을 읽어오기위한 InputStream객체를 생성한다..
	     is = connection.getInputStream();
	     isr = new InputStreamReader(is);
	     br = new BufferedReader(isr);
	
	     //내용을 읽어서 화면에 출력한다..
	     String data = new String();
	     String buffer;
	     while(true){
	    	 buffer = br.readLine();
	         if(buffer == null) 
	        	 break;
	         else
	        	 data += buffer; 
	     }
	  	 out.write(data);
	     
	 }catch(MalformedURLException mue){
		 
	 }catch(IOException ioe){
	     ioe.printStackTrace();
	 }
%>