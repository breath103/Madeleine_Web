package madeleine.reply.entitiy;

import java.sql.Timestamp;

public class MadeleineBookReplyEntity extends MadeleineReplyBaseEntity {
	private String title;
	private Timestamp created_time;
	private String link;
	private String image;
	private String author;
	private String publisher;
	
	public MadeleineBookReplyEntity(int idx, int madeleine_idx, String writter_id,
			Timestamp created_time, String title,
			String link, String image, String author, String publisher) {
		super(idx, madeleine_idx, writter_id, created_time);
		this.title = title;
		this.created_time = created_time;
		this.link = link;
		this.image = image;
		this.author = author;
		this.publisher = publisher;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Timestamp getCreated_time() {
		return created_time;
	}
	public void setCreated_time(Timestamp created_time) {
		this.created_time = created_time;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
}
