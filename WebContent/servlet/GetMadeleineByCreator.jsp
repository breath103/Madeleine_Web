<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.util.ArrayList"%>
<%@ page import = "madeleine.biz.MadeleineBiz"%>
<%@ page import = "madeleine.entity.*"%>
<%@ page import = "net.sf.json.*"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "common.*"%> 	
<% 
	/*
	MadeleineBiz biz = new MadeleineBiz();
	String creator = request.getParameter("creator");
	if(creator == null)
		creator = "100002717246207";
	ArrayList<MadeleineEntity> madeleine_list = biz.findByCreator(creator);
	JSONArray jsonArray = JSONArray.fromObject(madeleine_list);
	System.out.println(jsonArray.toString());
	response.getWriter().write(jsonArray.toString());
	*/
	
	
	
	String query = null;
	Connection conn = JdbcTemplate.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rset = null;
	
	JSONArray jsonArray = new JSONArray();
	
	String creator = request.getParameter("creator");
	System.out.println(creator);
	try{
		query = "select m.*,(select mp.src from madeleine_photo mp where mp.madeleine_idx=m.idx and rownum<=1) as cover_photo from madeleine m where m.creator = ?";
		pstmt = conn.prepareStatement(query);
		
		pstmt.setString(1, creator);

		rset = pstmt.executeQuery();
		while(rset.next())
		{
			MadeleineEntity madeleine_entity = new MadeleineEntity (rset.getInt("idx"),
												    rset.getString("name"),
													rset.getString("creator"),
													rset.getTimestamp("created_time"),
													rset.getTimestamp("reserved_time"),
													rset.getBoolean("is_opened"),
													rset.getBoolean("is_sended"),
													rset.getBoolean("is_public"));
			JSONObject obj = JSONObject.fromObject(madeleine_entity);
			obj.put("created_time",madeleine_entity.getCreated_time().toGMTString());
			obj.put("reserved_time",madeleine_entity.getReserved_time().toString());
			if(madeleine_entity.getIs_opened())
			{
				obj.put("cover_photo",rset.getString("cover_photo"));
			}
			else
			{
				obj.put("cover_photo",null);
			}
			jsonArray.add(obj);
		}
	} catch(SQLException e){
		e.printStackTrace();
	} finally{
		JdbcTemplate.close(rset);
		JdbcTemplate.close(pstmt);
	}

	
	response.getWriter().write(jsonArray.toString());
%>