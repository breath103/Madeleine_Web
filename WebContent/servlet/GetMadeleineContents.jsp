<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.util.ArrayList"%>
<%@ page import = "madeleine.biz.*"%>
<%@ page import = "madeleine.entity.*"%>
<%@ page import = "net.sf.json.*"%>
<%@ page import = "com.restfb.*"%>
<%@ page import = "com.restfb.types.Comment"%>	
<%@ page import = "facebook.*"%>
<%@ page import="madeleine.biz.MadeleineReplyBiz" %>
<%@ page import="madeleine.reply.entitiy.*" %>
<% 
	MadeleineBiz biz = new MadeleineBiz();
	String madeleine_idx = request.getParameter("id");
	
	MadeleinePhotoBiz photoBiz = new MadeleinePhotoBiz();
	
	System.out.println(madeleine_idx);
	MadeleineEntity madeleine =  biz.findByIdx(madeleine_idx);
	
	JSONObject json_outObject = new JSONObject();
	
	if(madeleine!=null)
	{	
		ArrayList<MadeleinePhotoEntity> photos = photoBiz.findByParentId(Integer.parseInt(madeleine_idx));
	
		json_outObject.put("info",madeleine); //마들렌 자체의 정보를 추가
		
		//마들렌을 만든 사람의 페이스북 아이디를 가지고 검색해서 액세스 토큰을 얻는다. 
		FacebookBiz    fbBiz 	= new FacebookBiz();
		FacebookEntity fbEntity = fbBiz.find(madeleine.getCreator()); 
		FacebookClient FB 		= new DefaultFacebookClient(fbEntity.getAccess_token());
		
		JSONArray jsonPhotoArray = new JSONArray();
		for( MadeleinePhotoEntity photo : photos)
		{
		//	com.restfb.Connection<Comment> comments = FB.fetchConnection(photo.getFacebook_id() + "/comments", Comment.class);
			
			JSONObject json_photo = new JSONObject();
			json_photo.put("type", "photo");
			json_photo.put("src", photo.getSrc());
			/*
			ArrayList<JSONObject> comment_list = new ArrayList<JSONObject>();
			for( Comment comment : comments.getData())
			{
				JSONObject json_comment = new JSONObject();
				json_comment.put("from",comment.getFrom().getName());
				json_comment.put("message",comment.getMessage());
				comment_list.add(json_comment);
			}
			json_photo.put("comments",comment_list);
			*/
			jsonPhotoArray.add(json_photo);
		}
		json_outObject.put("contents",jsonPhotoArray);
	
		
		MadeleineReplyBiz replyBiz  = new MadeleineReplyBiz();
		
		ArrayList<MadeleineBookReplyEntity>  MBRE = replyBiz.findBookByMadeleineIdx( Integer.valueOf(madeleine_idx));
		ArrayList<MadeleinePlaceReplyEntity> MPRE = replyBiz.findPlaceByMadeleineIdx(Integer.valueOf(madeleine_idx));
		ArrayList<MadeleineMovieReplyEntity> MMRE = replyBiz.findMovieByMadeleineIdx(Integer.valueOf(madeleine_idx));
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("book", MBRE);
		jsonObject.put("movie", MMRE);
		jsonObject.put("place", MPRE);
		
		json_outObject.put("reply",jsonObject);
		
		
		System.out.println(json_outObject.toString());
		response.getWriter().write(json_outObject.toString());
	}
%>