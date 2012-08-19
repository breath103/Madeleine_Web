package madeleine.reply.entitiy;

import java.sql.Timestamp;

public class MadeleinePlaceReplyEntity extends MadeleineReplyBaseEntity {
	private String title;
	private String link;
	private String description;
	private String telephone;
	private String address;
	private int mapx;
	private int mapy;
	
	public MadeleinePlaceReplyEntity(int idx, int madeleine_idx, String writter_id,
			Timestamp created_time, String title, String link,
			String description, String telephone, String address, int mapx,
			int mapy) {
		super(idx, madeleine_idx, writter_id, created_time);
		this.title = title;
		this.link = link;
		this.description = description;
		this.telephone = telephone;
		this.address = address;
		this.mapx = mapx;
		this.mapy = mapy;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getMapx() {
		return mapx;
	}
	public void setMapx(int mapx) {
		this.mapx = mapx;
	}
	public int getMapy() {
		return mapy;
	}
	public void setMapy(int mapy) {
		this.mapy = mapy;
	}
	
}
