package madeleine.biz;


import java.sql.Connection;
import java.util.ArrayList;

import com.restfb.*;
import com.restfb.types.Comment;

import madeleine.dao.MadeleineDAO;
import madeleine.entity.*;
import common.JdbcTemplate;
import facebook.*;

public class MadeleineBiz {
	
	public MadeleineEntity findByIdx(String idx)
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleineDAO dao = new MadeleineDAO(conn);
		MadeleineEntity madeleine_entity = dao.findByIdx(idx);
		
		JdbcTemplate.close(conn);
		
		return madeleine_entity;
	}
	public ArrayList<MadeleineEntity> findByCreator(String creator)
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleineDAO dao = new MadeleineDAO(conn);
		ArrayList<MadeleineEntity> entityList = dao.findByCreator(creator);
		
		JdbcTemplate.close(conn);
		
		return entityList;
	}
	public MadeleineEntity findSendableMail()
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleineDAO dao = new MadeleineDAO(conn);
		MadeleineEntity madeleine_entity = dao.findSendableMail();
		
		JdbcTemplate.close(conn);
		
		return madeleine_entity;
	}
	public MadeleineEntity getRandomPublicMadeleine()
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleineDAO dao = new MadeleineDAO(conn);
		MadeleineEntity madeleine_entity = dao.getRandomPublicMadeleine();
		
		JdbcTemplate.close(conn);
		
		return madeleine_entity;
	}
	public boolean update(MadeleineEntity madeleine_entity)
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleineDAO dao = new MadeleineDAO(conn);
		boolean result = false;
		
		result =  0 < dao.update(madeleine_entity);
		
		if( result )
		{
			JdbcTemplate.commit(conn);
		}
		else
		{
			JdbcTemplate.rollback(conn);
		}
		JdbcTemplate.close(conn);
		
		return result;
	}
	public int getLastIDX()
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleineDAO dao = new MadeleineDAO(conn);
		
		int lastIDX = dao.getIDXSequence();
		
		JdbcTemplate.close(conn);
		
		return lastIDX;
	}
	public boolean insert(MadeleineEntity madeleine_info)
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleineDAO dao = new MadeleineDAO(conn);
		boolean result = false;
		
		result = dao.insert(madeleine_info);
		
		if( result ){
			JdbcTemplate.commit(conn);
		}
		else{
			JdbcTemplate.rollback(conn);
		}
		JdbcTemplate.close(conn);
		
		return result;
	}
	public String getHTMLSlides(String slideshowName,String madeleine_idx)
	{
		String html = "";
		
		MadeleinePhotoBiz photoBiz = new MadeleinePhotoBiz();
		
		System.out.println(madeleine_idx);
		MadeleineEntity madeleine =  findByIdx(madeleine_idx);
	
		
		if(madeleine!=null)
		{	
			ArrayList<MadeleinePhotoEntity> photos = photoBiz.findByParentId(Integer.parseInt(madeleine_idx));
		
			html += String.format("slideShow = new "+slideshowName+"(\"%s\",\"%s\",\"%s\");\n" , madeleine.getName(),madeleine.getCreator(),madeleine.getCreated_time());
		
			//마들렌을 만든 사람의 페이스북 아이디를 가지고 검색해서 액세스 토큰을 얻는다. 
			FacebookBiz fbBiz = new FacebookBiz();
			FacebookEntity fbEntity = fbBiz.find(madeleine.getCreator()); 
			FacebookClient FB = new DefaultFacebookClient(fbEntity.getAccess_token());
			
			for( MadeleinePhotoEntity photo : photos)
			{
				com.restfb.Connection<Comment> comments = FB.fetchConnection(photo.getFacebook_id() + "/comments", Comment.class);
				
				html += "newSlide = slideShow.addSlide(\"photo\",\""+ photo.getSrc() + "\");\n";
				
				for( Comment comment : comments.getData())
				{
					String message = comment.getMessage();
					message = message.replace("\'","\\'");
					message = message.replace("\n","\\n");
					message = message.replace("\r","\\r");
					message = message.replace("\t","\\t");
					html += "newSlide.addComment(\"" + comment.getFrom().getName() + " : " + message + "\");\n";
				}
			}

			//조회를 했음으로 마들렌의 상태를 open으로 변경
			
			madeleine.setIs_opened(false);
			update(madeleine);
			
		
		}	
		return html;
	}
	
	public boolean insert(MadeleinePresentEntity entity)
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleineDAO dao = new MadeleineDAO(conn);
		boolean result = false;
		
		result = dao.insert(entity);
		
		if( result ){
			JdbcTemplate.commit(conn);
		}
		else{
			JdbcTemplate.rollback(conn);
		}
		JdbcTemplate.close(conn);
		
		return result;
	}
	public ArrayList<MadeleinePresentEntity> findMadeleinePresentByOwner(String owner_id)
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleineDAO dao = new MadeleineDAO(conn);
		ArrayList<MadeleinePresentEntity> present_array = dao.findMadeleinePresentByOwner(owner_id);
		
		JdbcTemplate.close(conn);
		
		return present_array;
	}
}
