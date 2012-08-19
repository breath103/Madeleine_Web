package madeleine.reply.entitiy;

import java.sql.Timestamp;

public class MadeleineReplyBaseEntity {
	private int idx;
	private int madeleine_idx;
	private String writter_id; // facebook ID
	private Timestamp created_time;

	public MadeleineReplyBaseEntity(int idx, int madeleine_idx,
			String writter_id,Timestamp created_time) {
		super();
		this.idx 		   = idx;
		this.madeleine_idx = madeleine_idx;
		this.writter_id    = writter_id;
		this.created_time  = created_time;
	}
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getMadeleine_idx() {
		return madeleine_idx;
	}
	public void setMadeleine_idx(int madeleine_idx) {
		this.madeleine_idx = madeleine_idx;
	}
	public String getWritter_id() {
		return writter_id;
	}
	public void setWritter_id(String writter_id) {
		this.writter_id = writter_id;
	}
	public Timestamp getCreated_time() {
		return created_time;
	}
	public void setCreated_time(Timestamp created_time) {
		this.created_time = created_time;
	}

}
