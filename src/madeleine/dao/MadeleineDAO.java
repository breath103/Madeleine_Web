package madeleine.dao;

import static common.JdbcTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import madeleine.entity.MadeleineEntity;
import madeleine.entity.MadeleinePresentEntity;


import common.JdbcTemplate;

public class MadeleineDAO {
	private Connection conn;
	public MadeleineDAO(Connection conn){
		this.conn = conn;
	}
	public int getIDXSequence() 
	{
		PreparedStatement pstmt = null;
		String query;
		int currval = -1;
		ResultSet rset = null;
		try{
			query = "SELECT MAX(IDX) FROM MADELEINE";
						pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			while(rset.next())
			{
				currval = rset.getInt("MAX(IDX)");
			}
		}catch (SQLException e){
			e.printStackTrace();
		}finally{
			close(rset);
		}
		System.out.println(currval);
		return currval;
		
	}
	public boolean insert(MadeleineEntity madeleine_entity)
	{
		PreparedStatement pstmt = null;
		String query = null;
		boolean insertOk = false;
		int insertCnt = 0;
		
		try{
			query = "INSERT INTO MADELEINE(name,creator,created_time,reserved_time,is_opened,is_sended,is_public)"+
					"VALUES(?, ?, (select current_timestamp from dual), ?, 0, 0, ?)";
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, madeleine_entity.getName());
			pstmt.setString(2, madeleine_entity.getCreator()); 
			pstmt.setTimestamp(3, madeleine_entity.getReserved_time());
			pstmt.setBoolean(4, madeleine_entity.getIs_public());
			
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
	public int update(MadeleineEntity madeleine_entity)
	{
		int updatedEntityCnt = 0;
		
		PreparedStatement pstmt = null;
		String query = null;
		
		try{
			query = "UPDATE MADELEINE SET " +
					"name = ? ," +
					"creator = ? ," + 
					"created_time = ? ," +
					"reserved_time = ? ," +
					"is_opened = ? ," +
					"is_sended = ? ," +
					"is_public = ? " +
					"WHERE idx = ?";
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1,madeleine_entity.getName());
			pstmt.setString(2,madeleine_entity.getCreator());
			pstmt.setTimestamp(3, madeleine_entity.getCreated_time());
			pstmt.setTimestamp(4, madeleine_entity.getReserved_time());
			pstmt.setBoolean(5, madeleine_entity.getIs_opened());
			pstmt.setBoolean(6, madeleine_entity.getIs_sended());
			pstmt.setBoolean(7, madeleine_entity.getIs_public());
			pstmt.setInt(8, madeleine_entity.getIdx());
			
			
			updatedEntityCnt = pstmt.executeUpdate();
			System.out.println("madeleine update " + updatedEntityCnt);
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return updatedEntityCnt; 
	}

	public MadeleineEntity findByIdx(String idx)
	{
		String query = null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		MadeleineEntity madeleine_entity = null; 
		try{
			query = "SELECT * FROM MADELEINE WHERE idx = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, idx);
			rset = pstmt.executeQuery();
			if(rset.next())
			{
				madeleine_entity = new MadeleineEntity( rset.getInt("idx"),
														rset.getString("name"),
														rset.getString("creator"),
														rset.getTimestamp("created_time"),
														rset.getTimestamp("reserved_time"),
														rset.getBoolean("is_opened"),
														rset.getBoolean("is_sended"),
														rset.getBoolean("is_public"));
			}
		} catch(SQLException e){
			e.printStackTrace();
		} finally{
			close(rset);
			close(pstmt);
		}
		return madeleine_entity; 
	}
	
	public ArrayList<MadeleineEntity> findByCreator(String creator)
	{
		ArrayList<MadeleineEntity> entityList = new ArrayList<MadeleineEntity>();
		
		String query = null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try{
			query = "SELECT * FROM MADELEINE WHERE creator = ? order by created_time";
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
				entityList.add(madeleine_entity);
			}
		} catch(SQLException e){
			e.printStackTrace();
		} finally{
			close(rset);
			close(pstmt);
		}
		
		return entityList;
	}
	
	public MadeleineEntity findSendableMail()
	{
		String query = null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		MadeleineEntity madeleine_entity = null; 
		try{
			query = "SELECT * FROM madeleine WHERE rownum <= 1 AND is_sended = 0 ORDER BY reserved_time ASC";
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			if(rset.next())
			{
				madeleine_entity = new MadeleineEntity( rset.getInt("idx"),
														rset.getString("name"),
														rset.getString("creator"),
														rset.getTimestamp("created_time"),
														rset.getTimestamp("reserved_time"),
														rset.getBoolean("is_opened"),
														rset.getBoolean("is_sended"),
														rset.getBoolean("is_public") );
			}
		} catch(SQLException e){
			e.printStackTrace();
		} finally{
			close(rset);
			close(pstmt);
		}
		
		return madeleine_entity; 
	}
	public MadeleineEntity getRandomPublicMadeleine()
	{
		String query = null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		MadeleineEntity madeleine_entity = null; 
		try{
			query = "SELECT * FROM (select * from madeleine where is_public = 1 order by dbms_random.value) where rownum = 1";
			pstmt = conn.prepareStatement(query);
			rset = pstmt.executeQuery();
			if(rset.next())
			{
				madeleine_entity = new MadeleineEntity( rset.getInt("idx"),
														rset.getString("name"),
														rset.getString("creator"),
														rset.getTimestamp("created_time"),
														rset.getTimestamp("reserved_time"),
														rset.getBoolean("is_opened"),
														rset.getBoolean("is_sended"),
														rset.getBoolean("is_public"));
			}
		} catch(SQLException e){
			e.printStackTrace();
		} finally{
			close(rset);
			close(pstmt);
		}
		
		return madeleine_entity; 
	}
	
	
	
	
	
	public boolean insert(MadeleinePresentEntity present_entity)
	{
		PreparedStatement pstmt = null;
		String query = null;
		boolean insertOk = false;
		int insertCnt = 0;
		
		try{
			query = "INSERT INTO MADELEINE_PRESENT(owner_idx,madeleine_idx,is_opened)"+
					"VALUES(?,?,?)";
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, present_entity.getOwner_id());
			pstmt.setInt(2, present_entity.getMadeleine_idx()); 
			pstmt.setBoolean(3, present_entity.getIs_opened());
			
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
	public ArrayList<MadeleinePresentEntity> findMadeleinePresentByOwner(String owner_id)
	{
		ArrayList<MadeleinePresentEntity> entityList = new ArrayList<MadeleinePresentEntity>();
		
		String query = null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try{
			query = "SELECT * FROM MADELEINE_PRESENT WHERE owner_id = ? order by idx";
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, owner_id);

			rset = pstmt.executeQuery();
			while(rset.next())
			{
				MadeleinePresentEntity present_entity = new MadeleinePresentEntity (rset.getInt("idx"),
													    rset.getString("owner_idx"),
														rset.getInt("madeleine_idx"),
														rset.getBoolean("is_opened"));
				entityList.add(present_entity);
			}
		} catch(SQLException e){
			e.printStackTrace();
		} finally{
			close(rset);
			close(pstmt);
		}
		
		return entityList;
	}
}
