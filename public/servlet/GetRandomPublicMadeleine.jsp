<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.util.ArrayList"%>
<%@ page import = "madeleine.biz.*"%>
<%@ page import = "madeleine.entity.*"%>
<%@ page import = "net.sf.json.*"%>
<%@ page import = "com.restfb.*"%>
<%@ page import = "com.restfb.types.Comment"%>	
<%@ page import = "facebook.*"%>
<% 
	MadeleineBiz biz = new MadeleineBiz();
	
	MadeleineEntity madeleine =  biz.getRandomPublicMadeleine();
	
	JSONObject json_outObject = JSONObject.fromObject(madeleine);
	json_outObject.put("created_time",madeleine.getCreated_time().toGMTString());
	json_outObject.put("reserved_time",madeleine.getReserved_time().toString());
	
	if(madeleine!= null)
		response.getWriter().write(json_outObject.toString());
%>