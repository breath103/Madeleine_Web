package madeleine.entity;

import java.sql.Timestamp;

public class MadeleineEntity {
	private int    idx;
	private String name;
	private String creator;
	private Timestamp created_time;
	private Timestamp reserved_time;
	private boolean   is_opened;
	private boolean   is_sended;
	private boolean   is_public; 
	
	public MadeleineEntity(int idx, String name, String creator,
			Timestamp created_time, Timestamp reserved_time, boolean is_opened,
			boolean is_sended,
			boolean is_public) {
		super();
		this.idx = idx;
		this.name = name;
		this.creator = creator;
		this.created_time = created_time;
		this.reserved_time = reserved_time;
		this.is_opened = is_opened;
		this.is_sended = is_sended;
		this.is_public = is_public;
	}

	public int getIdx() {return idx;}
	public void setIdx(int idx) {this.idx = idx;}
	public Timestamp getReserved_time() {return reserved_time;}
	public void setReserved_time(Timestamp reserved_time) {this.reserved_time = reserved_time;}
	public void setCreated_time(Timestamp created_time) {this.created_time = created_time;}
	public String getName() { return name; }
	public void setName(String name) {	this.name = name;	}
	public String getCreator()	{ return creator; }
	public void setCreator(String creator) {this.creator = creator;}
	public Timestamp getCreated_time() { return created_time; }
	public boolean getIs_opened() {return is_opened;}
	public void setIs_opened(boolean is_opened) {this.is_opened = is_opened;}
	public boolean getIs_sended() {return is_sended;}
	public void setIs_sended(boolean is_sended) {this.is_sended = is_sended;}
	public boolean getIs_public() {return this.is_public;}
	public void setIs_public(boolean is_public) {this.is_public = is_public;}
	
}
