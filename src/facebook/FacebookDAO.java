package facebook;

import static common.JdbcTemplate.close;

import java.sql.*;

public class FacebookDAO {
	private Connection conn;
	public FacebookDAO(Connection conn){
		this.conn = conn;
	}
	
	public boolean insert(FacebookEntity fb_entity)
	{
		PreparedStatement pstmt = null;
		String query = null;
		boolean insertOk = false;
		int insertCnt = 0;
		
		try{
			query = "INSERT INTO FACEBOOK_INFO(facebook_id,access_token,email)" +
					"VALUES(?, ?, ?)";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, fb_entity.getFacebook_id());
			pstmt.setString(2, fb_entity.getAccess_token()); 
			pstmt.setString(3, fb_entity.getEmail());
			insertCnt = pstmt.executeUpdate();
			if (insertCnt > 0){
				insertOk = true;
			}
		}catch (SQLException e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return insertOk;
	}
	public FacebookEntity find(String facebook_id)
	{
		String query = null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		FacebookEntity fb_entity = null; 
		try{
			query = "SELECT * FROM FACEBOOK_INFO WHERE facebook_id = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, facebook_id);
			rset = pstmt.executeQuery();
			if(rset.next())
			{
				fb_entity = new FacebookEntity( rset.getString("facebook_id"),
												rset.getString("access_token"),
												rset.getString("email"));
			}
		} catch(SQLException e){
			e.printStackTrace();
		} finally{
			close(rset);
			close(pstmt);
		}
		
		return fb_entity; 
	}
	public int delete(String facebook_id)
	{
		int deletedEntityCnt = 0;
		
		PreparedStatement pstmt = null;
		String query = null;
		
		try{
			query = "DELETE FACEBOOK_INFO WHERE facebook_id = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,facebook_id);
			deletedEntityCnt = pstmt.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		return deletedEntityCnt;
	}
	public int update( FacebookEntity fb_entity)
	{
		int updatedEntityCnt = 0;
		
		PreparedStatement pstmt = null;
		String query = null;
		
		try{
			query = "UPDATE FACEBOOK_INFO SET access_token = ?,email = ? WHERE facebook_id = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,fb_entity.getAccess_token());
			pstmt.setString(2,fb_entity.getEmail());
			pstmt.setString(3,fb_entity.getFacebook_id()); 
			updatedEntityCnt = pstmt.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return updatedEntityCnt; 
	}
}
