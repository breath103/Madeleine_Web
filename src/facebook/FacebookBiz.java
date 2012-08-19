package facebook;

import java.sql.Connection;
import common.JdbcTemplate;


public class FacebookBiz {
	
	public FacebookEntity find(String facebook_id)
	{
		Connection conn = JdbcTemplate.getConnection();
		FacebookDAO dao = new FacebookDAO(conn);
		
		FacebookEntity fb_entity = dao.find(facebook_id);
		
		JdbcTemplate.close(conn);
		
		return fb_entity;
	}
	public boolean insert(FacebookEntity fb_Entity)
	{
		Connection conn = JdbcTemplate.getConnection();
		FacebookDAO dao = new FacebookDAO(conn);
		boolean result = false ;
		
		result = dao.insert(fb_Entity);
		
		if( result ){
			JdbcTemplate.commit(conn);
		}
		else{
			JdbcTemplate.rollback(conn);
		}
		JdbcTemplate.close(conn);
		
		return result;
	}
	public boolean update(FacebookEntity fb_Entity)
	{
		Connection conn = JdbcTemplate.getConnection();
		FacebookDAO dao = new FacebookDAO(conn);
		int result = 0 ;
		
		result = dao.update(fb_Entity);
		
		if( result > 0 ){
			JdbcTemplate.commit(conn);
		}
		else{
			JdbcTemplate.rollback(conn);
		}
		JdbcTemplate.close(conn);
		
		return result > 0;
	}
	public int delete(String facebook_id)
	{
		return 0;
	}
}

