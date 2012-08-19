package madeleine.biz;

import java.sql.Connection;
import java.util.ArrayList;

import madeleine.dao.MadeleinePhotoDAO;
import madeleine.entity.MadeleinePhotoEntity;
import madeleine.entity.MadeleinePostEntity;


import common.JdbcTemplate;
import facebook.FacebookDAO;
import facebook.FacebookEntity;

public class MadeleinePhotoBiz {
	public ArrayList<MadeleinePhotoEntity> findByParentId(int parent_id)
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleinePhotoDAO dao = new MadeleinePhotoDAO(conn);
		
		ArrayList<MadeleinePhotoEntity> resultList = dao.findByParentId(parent_id);
		
		JdbcTemplate.close(conn);
		
		return resultList;
	}
	public boolean insert(MadeleinePhotoEntity photo)
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleinePhotoDAO dao = new MadeleinePhotoDAO(conn);
		
		boolean result = dao.insert(photo);
		
		if( result ){
			JdbcTemplate.commit(conn);
		}
		else{
			JdbcTemplate.rollback(conn);
		}
		JdbcTemplate.close(conn);
		
		return result;
	}
	public boolean insert(MadeleinePostEntity post)
	{
		Connection conn = JdbcTemplate.getConnection();
		MadeleinePhotoDAO dao = new MadeleinePhotoDAO(conn);
		
		boolean result = dao.insert(post);
		
		if( result ){
			JdbcTemplate.commit(conn);
		}
		else{
			JdbcTemplate.rollback(conn);
		}
		JdbcTemplate.close(conn);
		
		return result;
	}
}
