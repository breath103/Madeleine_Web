package madeleine.dao;

import static common.JdbcTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import madeleine.reply.entitiy.MadeleineBookReplyEntity;
import madeleine.reply.entitiy.MadeleineMovieReplyEntity;
import madeleine.reply.entitiy.MadeleinePlaceReplyEntity;
import madeleine.reply.entitiy.MadeleineTextReplyEntity;


public class MadeleineReplyDAO {
	private Connection conn;
	public MadeleineReplyDAO(Connection conn){
		this.conn = conn;
	}
	public boolean insertTextReply(MadeleineTextReplyEntity reply)
	{
		PreparedStatement pstmt = null;
		String query = null;
		boolean insertOk = false;
		int insertCnt = 0;	
		try{
			query = "INSERT INTO MADELEINE_REPLY_TEXT(madeleine_idx,writter_idx,text)" +
					"VALUES(?, ?, ?)";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, reply.getMadeleine_idx());
			pstmt.setString(2, reply.getWritter_id());
			pstmt.setString(3, reply.getText());
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
	public ArrayList<MadeleineTextReplyEntity> findTextReplyByMadeleineIdx(int madeleine_idx)
	{
		ArrayList<MadeleineTextReplyEntity> entityList = new ArrayList<MadeleineTextReplyEntity>();
		
		String query = null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try{
			query = "SELECT * FROM MADELEINE_REPLY_TEXT WHERE madeleine_idx = ? order by idx";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, madeleine_idx);
			rset = pstmt.executeQuery();
			while(rset.next())
			{
				entityList.add(new MadeleineTextReplyEntity(rset.getInt("idx"),
													  rset.getInt("madeleine_idx"),
													  rset.getString("writter_id"),
													  rset.getTimestamp("created_time"),
													  rset.getString("text")));
			}
		} catch(SQLException e){
			e.printStackTrace();
		} finally{
			close(rset);
			close(pstmt);
		}
		return entityList;
	}
	
	public boolean insertBookReply(MadeleineBookReplyEntity reply)
	{
		PreparedStatement pstmt = null;
		String query = null;
		boolean insertOk = false;
		int insertCnt = 0;	
		try{
			query = "INSERT INTO MADELEINE_REPLY_BOOK(madeleine_idx,writter_idx,title,link,image,author,publisher)" +
					"VALUES(?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt( 1, reply.getMadeleine_idx()); //madeleine_idx);
			pstmt.setString(2, reply.getWritter_id());//writter_id
			pstmt.setString(3, reply.getTitle());//title
			pstmt.setString(4, reply.getLink());//link
			pstmt.setString(5, reply.getImage()); //image
			pstmt.setString(6, reply.getAuthor());//author
			pstmt.setString(7, reply.getPublisher());//publisher
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
	public ArrayList<MadeleineBookReplyEntity> findBookReplyByMadeleineIdx(int madeleine_idx)
	{
		ArrayList<MadeleineBookReplyEntity> entityList = new ArrayList<MadeleineBookReplyEntity>();
		
		String query = null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try{
			query = "SELECT * FROM MADELEINE_REPLY_BOOK WHERE madeleine_idx = ? order by idx";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, madeleine_idx);
			rset = pstmt.executeQuery();
			while(rset.next())
			{
				entityList.add(new MadeleineBookReplyEntity(rset.getInt("idx"),
													  		rset.getInt("madeleine_idx"),
													  		rset.getString("writter_idx"),
															rset.getTimestamp("created_time"),
															rset.getString("title"),
															rset.getString("link"),
															rset.getString("image"),
															rset.getString("author"),
															rset.getString("publisher")) );
			}
		} catch(SQLException e){
			e.printStackTrace();
		} finally{
			close(rset);
			close(pstmt);
		}
		return entityList;
	}
	
	public boolean insertMovieReply(MadeleineMovieReplyEntity reply)
	{
		PreparedStatement pstmt = null;
		String query = null;
		boolean insertOk = false;
		int insertCnt = 0;	
		try{
			query = "INSERT INTO MADELEINE_REPLY_MOVIE(madeleine_idx,writter_idx,title,link,image,subtitle,pubdate,actor,rating,director) " +
					"VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt( 1, reply.getMadeleine_idx()); //madeleine_idx);
			pstmt.setString(2, reply.getWritter_id());//writter_id
			pstmt.setString(3, reply.getTitle());//title
			pstmt.setString(4, reply.getLink());//link
			pstmt.setString(5, reply.getImage()); //image
			pstmt.setString(6, reply.getSubtitle());
			pstmt.setInt(7, reply.getPubdate());
			pstmt.setString(8, reply.getActor());
			pstmt.setFloat(9, reply.getRating());
			pstmt.setString(10, reply.getDirector());
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
	public ArrayList<MadeleineMovieReplyEntity> findMovieReplyByMadeleineIdx(int madeleine_idx)
	{
		ArrayList<MadeleineMovieReplyEntity> entityList = new ArrayList<MadeleineMovieReplyEntity>();
		
		String query = null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try{
			query = "SELECT * FROM MADELEINE_REPLY_MOVIE WHERE madeleine_idx = ? order by idx";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, madeleine_idx);
			rset = pstmt.executeQuery();
			while(rset.next())
			{
				entityList.add(new MadeleineMovieReplyEntity(rset.getInt("idx"),
													  		rset.getInt("madeleine_idx"),
													  		rset.getString("writter_idx"),
															rset.getTimestamp("created_time"),
															rset.getString("title"),
															rset.getString("link"),
															rset.getString("image"),
															rset.getString("subtitle"),
															rset.getInt("pubdate"),
															rset.getString("actor"),
															rset.getFloat("rating"),
															rset.getString("director")) );
			}
		} catch(SQLException e){
			e.printStackTrace();
		} finally{
			close(rset);
			close(pstmt);
		}
		return entityList;
	}
	
	public boolean insertPlaceReply(MadeleinePlaceReplyEntity reply)
	{
		PreparedStatement pstmt = null;
		String query = null;
		boolean insertOk = false;
		int insertCnt = 0;	
		try{
			query = "INSERT INTO MADELEINE_REPLY_PLACE(madeleine_idx,writter_idx,title,link,description,telephone,address,mapx,mapy)" +
					"VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt( 1, reply.getMadeleine_idx()); //madeleine_idx);
			pstmt.setString(2, reply.getWritter_id());//writter_id
			pstmt.setString(3, reply.getTitle());//title
			pstmt.setString(4, reply.getLink());//link
			pstmt.setString(5, reply.getDescription()); //image
			pstmt.setString(6, reply.getTelephone());
			pstmt.setString(7, reply.getAddress());
			pstmt.setInt(8, reply.getMapx());
			pstmt.setInt(9, reply.getMapy());
			
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
	public ArrayList<MadeleinePlaceReplyEntity> findPlaceReplyByMadeleineIdx(int madeleine_idx)
	{
		ArrayList<MadeleinePlaceReplyEntity> entityList = new ArrayList<MadeleinePlaceReplyEntity>();
		
		String query = null;

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		try{
			query = "SELECT * FROM MADELEINE_REPLY_PLACE WHERE madeleine_idx = ? order by idx";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1, madeleine_idx);
			rset = pstmt.executeQuery();
			while(rset.next())
			{
				entityList.add(new MadeleinePlaceReplyEntity(rset.getInt("idx"),
													  		rset.getInt("madeleine_idx"),
													  		rset.getString("writter_idx"),
															rset.getTimestamp("created_time"),
															rset.getString("title"),
															rset.getString("link"),
															rset.getString("description"),
															rset.getString("telephone"),
															rset.getString("address"),
															rset.getInt("mapx"),
															rset.getInt("mapy")) );
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
