package madeleine.biz;

import java.sql.Connection;
import java.util.ArrayList;

import madeleine.dao.MadeleineReplyDAO;
import madeleine.reply.entitiy.*;

import common.JdbcTemplate;

public class MadeleineReplyBiz {
	public boolean insert(MadeleineBookReplyEntity reply)
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleineReplyDAO dao = new MadeleineReplyDAO(conn);
		boolean result = false;
		
		result = dao.insertBookReply(reply);
		
		if( result ){
			JdbcTemplate.commit(conn);
		}
		else{
			JdbcTemplate.rollback(conn);
		}
		JdbcTemplate.close(conn);
		
		return result;
	}
	public boolean insert(MadeleineMovieReplyEntity reply)
	{
		System.out.println("ASDFASDf" + reply);
		Connection conn = JdbcTemplate.getConnection();
		MadeleineReplyDAO dao = new MadeleineReplyDAO(conn);
		boolean result = false;
		
		result = dao.insertMovieReply(reply);
		
		if( result ){
			JdbcTemplate.commit(conn);
		}
		else{
			JdbcTemplate.rollback(conn);
		}
		JdbcTemplate.close(conn);
		
		return result;
	}
	public boolean insert(MadeleinePlaceReplyEntity reply)
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleineReplyDAO dao = new MadeleineReplyDAO(conn);
		boolean result = false;
		
		result = dao.insertPlaceReply(reply);
		
		if( result ){
			JdbcTemplate.commit(conn);
		}
		else{
			JdbcTemplate.rollback(conn);
		}
		JdbcTemplate.close(conn);
		
		return result;
	}
	public boolean insert(MadeleineTextReplyEntity reply)
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleineReplyDAO dao = new MadeleineReplyDAO(conn);
		boolean result = false;
		
		result = dao.insertTextReply(reply);
		
		if( result ){
			JdbcTemplate.commit(conn);
		}
		else{
			JdbcTemplate.rollback(conn);
		}
		JdbcTemplate.close(conn);
		
		return result;
	}
	
	public ArrayList<MadeleineBookReplyEntity> findBookByMadeleineIdx(int madeleine_idx)
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleineReplyDAO dao = new MadeleineReplyDAO(conn);
		ArrayList<MadeleineBookReplyEntity> entityList = dao.findBookReplyByMadeleineIdx(madeleine_idx);
		JdbcTemplate.close(conn);
		return entityList;
	}
	public ArrayList<MadeleinePlaceReplyEntity> findPlaceByMadeleineIdx(int madeleine_idx)
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleineReplyDAO dao = new MadeleineReplyDAO(conn);
		ArrayList<MadeleinePlaceReplyEntity> entityList = dao.findPlaceReplyByMadeleineIdx(madeleine_idx);
		JdbcTemplate.close(conn);
		return entityList;
	}
	public ArrayList<MadeleineMovieReplyEntity> findMovieByMadeleineIdx(int madeleine_idx)
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleineReplyDAO dao = new MadeleineReplyDAO(conn);
		ArrayList<MadeleineMovieReplyEntity> entityList = dao.findMovieReplyByMadeleineIdx(madeleine_idx);
		JdbcTemplate.close(conn);
		return entityList;
	}
	public ArrayList<MadeleineTextReplyEntity> findTextByMadeleineIdx(int madeleine_idx)
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleineReplyDAO dao = new MadeleineReplyDAO(conn);
		ArrayList<MadeleineTextReplyEntity> entityList = dao.findTextReplyByMadeleineIdx(madeleine_idx);
		JdbcTemplate.close(conn);
		return entityList;
	}
}
