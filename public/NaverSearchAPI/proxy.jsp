<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"
    %>
<%@ page import="java.net.*,java.io.*" %>
<%
	String urlStr = "http://openapi.naver.com/search?key=e3d0b258dc65f2c9dc9fe3a5a635d097&"+request.getQueryString();
	
	URL url;//URL �ּ� ��ü
	URLConnection connection;//URL������ ������ ��ü
	InputStream is;//URL���ӿ��� ������ �б����� Stream
	 InputStreamReader isr;
	 BufferedReader br;
	
	 try{
	     //URL��ü�� �����ϰ� �ش� URL�� �����Ѵ�..
	     url = new URL(urlStr);
	     connection = url.openConnection();
	
	     //������ �о�������� InputStream��ü�� �����Ѵ�..
	     is = connection.getInputStream();
	     isr = new InputStreamReader(is);
	     br = new BufferedReader(isr);
	
	     //������ �о ȭ�鿡 ����Ѵ�..
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