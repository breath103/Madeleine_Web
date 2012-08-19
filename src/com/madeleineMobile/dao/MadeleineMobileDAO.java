package com.madeleineMobile.dao;

import static common.JdbcTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.madeleineMobile.entitiy.*;

public class MadeleineMobileDAO {
	private Connection conn;
	public MadeleineMobileDAO(Connection conn){
		this.conn = conn;
	}

	public boolean insert(MobileUserEntity entity)
	{
		PreparedStatement pstmt = null;
		String query = null;
		boolean insertOk = false;
		int insertCnt = 0;
		
		try{
			query = "INSERT INTO MOBILE_USER(email,password)"+
					"VALUES(?,?)";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, entity.getEmail());
			pstmt.setString(2, entity.getPassword());
			
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
	
	public int getIDXSequence() 
	{
		PreparedStatement pstmt = null;
		String query;
		int currval = -1;
		ResultSet rset = null;
		try{
			query = "SELECT MAX(IDX) FROM MOBILE_USER";
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
	
	public int update(MobileUserEntity entity)
	{
		int updatedEntityCnt = 0;
		
		PreparedStatement pstmt = null;
		String query = null;
		
		try{
			query = "UPDATE MOBILE_USER SET " +
					"email = ? ," +
					"password = ? "+
					"WHERE idx = ?";
			pstmt = conn.prepareStatement(query);
			
			pstmt.setString(1, entity.getEmail());
			pstmt.setString(2, entity.getPassword());
			pstmt.setInt(3, entity.getIdx());
			
			updatedEntityCnt = pstmt.executeUpdate();
			System.out.println("MOBILE_USER update " + updatedEntityCnt);
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return updatedEntityCnt; 
	}
	
	public MobileUserEntity findByIdx(String idx)
	{
		String query = null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		MobileUserEntity entity = null; 
		try{
			query = "SELECT * FROM MADELEINE WHERE idx = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, idx);
			rset = pstmt.executeQuery();
			if(rset.next())
			{
				entity = new MobileUserEntity( rset.getInt("idx"), rset.getString("email"),rset.getString("password"));	
			}
		} catch(SQLException e){
			e.printStackTrace();
		} finally{
			close(rset);
			close(pstmt);
		}
		return entity; 
	}
	public MobileUserEntity findByEmail(String email)
	{
		String query = null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		MobileUserEntity entity = null; 
		try{
			query = "SELECT * FROM MOBILE_USER WHERE email = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, email);
			rset = pstmt.executeQuery();
			if(rset.next())
			{
				entity = new MobileUserEntity( rset.getInt("idx"), rset.getString("email"),rset.getString("password"));	
			}
		} catch(SQLException e){
			e.printStackTrace();
		} finally{
			close(rset);
			close(pstmt);
		}
		return entity; 	
	}
}
