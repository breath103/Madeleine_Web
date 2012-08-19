package com.madeleineMobile.biz;

import java.sql.Connection;
import java.util.ArrayList;

import madeleine.dao.MadeleineDAO;

import com.madeleineMobile.dao.*;
import com.madeleineMobile.entitiy.*;

import common.JdbcTemplate;

public class MadeleineMobileBiz {
	public void insert(MobileUserEntity entity)
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleineMobileDAO dao = new MadeleineMobileDAO(conn);
		boolean result = dao.insert(entity);
		
		if( result ){
			JdbcTemplate.commit(conn);
		}
		else{
			JdbcTemplate.rollback(conn);
		}
		JdbcTemplate.close(conn);
	}
	public MobileUserEntity findByIdx(String idx)
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleineMobileDAO dao = new MadeleineMobileDAO(conn);
		MobileUserEntity entity = dao.findByIdx(idx);
		
		JdbcTemplate.close(conn);
		return entity;
	}
	public MobileUserEntity findByEmail(String email)
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleineMobileDAO dao = new MadeleineMobileDAO(conn);
		MobileUserEntity entity = dao.findByEmail(email);
		
		JdbcTemplate.close(conn);
		return entity;	
	}

	public int getLastIDX()
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleineMobileDAO dao = new MadeleineMobileDAO(conn);
		
		int lastIDX = dao.getIDXSequence();
		
		JdbcTemplate.close(conn);
		
		return lastIDX;
	}
}
