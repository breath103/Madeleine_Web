<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="madeleine.biz.MadeleineReplyBiz" %>
<%@ page import="madeleine.reply.entitiy.*" %>
<%
	MadeleineReplyBiz biz = new MadeleineReplyBiz();
	String madeleine_idx ="615";//= request.getParameter("id");
	
	ArrayList<MadeleineBookReplyEntity>  MBRE = biz.findBookByMadeleineIdx(Integer.valueOf(madeleine_idx));
	ArrayList<MadeleinePlaceReplyEntity> MPRE = biz.findPlaceByMadeleineIdx(Integer.valueOf(madeleine_idx));
	ArrayList<MadeleineMovieReplyEntity> MMRE = biz.findMovieByMadeleineIdx(Integer.valueOf(madeleine_idx));
	
	JSONObject jsonObject = new JSONObject();
	jsonObject.put("book", MBRE.subList(0,1));
	jsonObject.put("movie", MMRE.subList(0,1));
	jsonObject.put("place", MPRE.subList(0,1));
	System.out.println(jsonObject.toString());
	response.getWriter().write(jsonObject.toString());
%>

