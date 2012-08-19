<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServlet" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="madeleine.biz.MadeleineReplyBiz" %>
<%@ page import="madeleine.reply.entitiy.*" %>

<%
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html; charset=utf-8");
	
	MadeleineReplyBiz biz = new MadeleineReplyBiz();
	
	String title = request.getParameter("title");
	
	String link = request.getParameter("link");
	String image = request.getParameter("image");
	String subtitle = request.getParameter("subtitle");
	String pubdate = request.getParameter("pubdate");
	String actor = request.getParameter("actor");
	String rating = request.getParameter("rating");
	String director = request.getParameter("director");
	String author = request.getParameter("author");
	String publisher = request.getParameter("publisher");
	String target = request.getParameter("target");
	String description = request.getParameter("description");
	String telephone = request.getParameter("telephone");
	String address = request.getParameter("address");
	String mapX = request.getParameter("mapX");
	String mapY = request.getParameter("mapY");
	
	
	if(target.equals("local")){
		MadeleinePlaceReplyEntity MPRE =new MadeleinePlaceReplyEntity(1, 1, "admin", null, title, link, description, telephone, address, Integer.valueOf(mapX), Integer.valueOf(mapY));
		
		biz.insert(MPRE);
	}else if(target.equals("movie")){
		MadeleineMovieReplyEntity MMRE =new MadeleineMovieReplyEntity(1, 1, "admin", null, title, link, image, subtitle, Integer.parseInt(pubdate), actor, Float.parseFloat(rating), director);
		biz.insert(MMRE);
				
	}else if(target.equals("book")){
		MadeleineBookReplyEntity MBRE = new MadeleineBookReplyEntity(1, 1, "admin", null, title, link, image, author, publisher);
		
		biz.insert(MBRE);
	}
	
	out.write(request.getQueryString());
	

%>