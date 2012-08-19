package madeleine.dao;

import static common.JdbcTemplate.close;

import java.sql.*;
import java.util.ArrayList;

import madeleine.entity.MadeleinePhotoEntity;
import madeleine.entity.MadeleinePostEntity;



public class MadeleinePhotoDAO {	
	private Connection conn;
	public MadeleinePhotoDAO(Connection conn)
	{
		this.conn = conn;
		
	}
	public ArrayList<MadeleinePhotoEntity> findByParentId(int parent_idx)
	{
		ArrayList<MadeleinePhotoEntity> entityList = new ArrayList<MadeleinePhotoEntity>();
		
		String query = null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try{
			query = "SELECT * FROM MADELEINE_PHOTO WHERE madeleine_idx = ? order by idx";
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, parent_idx);

			rset = pstmt.executeQuery();
			while(rset.next())
			{
				entityList.add(new MadeleinePhotoEntity(rset.getInt("idx"),
														rset.getInt("madeleine_idx"),
														rset.getString("src"),
														rset.getString("facebook_id")));
			}
		} catch(SQLException e){
			e.printStackTrace();
		} finally{
			close(rset);
			close(pstmt);
		}
		
		return entityList;
	}
	public boolean insert(MadeleinePhotoEntity photo_entity)
	{
		PreparedStatement pstmt = null;
		String query = null;
		boolean insertOk = false;
		int insertCnt = 0;
		
		try{
			query = "INSERT INTO MADELEINE_PHOTO(madeleine_idx,src,facebook_id)" +
					"VALUES(?, ?, ?)";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, photo_entity.getMadeleine_Idx());
			pstmt.setString(2, photo_entity.getSrc());
			pstmt.setString(3, photo_entity.getFacebook_id());
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
	
	
	public ArrayList<MadeleinePostEntity> findPostByParentId(int parent_idx)
	{
		ArrayList<MadeleinePostEntity> entityList = new ArrayList<MadeleinePostEntity>();
		
		String query = null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try{
			query = "SELECT * FROM MADELEINE_POST WHERE madeleine_idx = ? order by idx";
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, parent_idx);

			rset = pstmt.executeQuery();
			while(rset.next())
			{
				entityList.add(new MadeleinePostEntity(rset.getInt("idx"),
													   rset.getInt("madeleine_idx"),
													   rset.getString("facebook_id")));
			}
		} catch(SQLException e){
			e.printStackTrace();
		} finally{
			close(rset);
			close(pstmt);
		}
		
		return entityList;
	}
	public boolean insert(MadeleinePostEntity postEntity)
	{
		PreparedStatement pstmt = null;
		String query = null;
		boolean insertOk = false;
		int insertCnt = 0;
		
		try{
			query = "INSERT INTO MADELEINE_POST(madeleine_idx,facebook_id)" +
					"VALUES(?, ?)";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, postEntity.getMadeleine_idx());
			pstmt.setString(2, postEntity.getFacebook_id()); 
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
	
}
