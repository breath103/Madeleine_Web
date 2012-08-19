package madeleine.reply.entitiy;

import java.sql.Timestamp;


public class MadeleineTextReplyEntity extends MadeleineReplyBaseEntity{
	private String text;
	
	public MadeleineTextReplyEntity(int idx, int madeleine_idx, String writter_id, Timestamp created_time, String text) {
		super(idx, madeleine_idx, writter_id,created_time);
		this.text = text;
	}
	public void setText(String text) {this.text = text;}
	public String getText() {return text;}
}
