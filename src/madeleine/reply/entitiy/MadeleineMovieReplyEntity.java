package madeleine.reply.entitiy;

import java.sql.Timestamp;

public class MadeleineMovieReplyEntity extends MadeleineReplyBaseEntity{

	private String title;
	private String link;
	private String image;
	private String subtitle;
	private int pubdate;
	private String actor;
	private float rating;
	private String director;
	
	public MadeleineMovieReplyEntity(int idx, int madeleine_idx, String writter_id,
			Timestamp created_time, String title, String link, String image,
			String subtitle, int pubdate, String actor, float rating,
			String director) {
		super(idx, madeleine_idx, writter_id, created_time);
		this.title = title;
		this.link = link;
		this.image = image;
		this.subtitle = subtitle;
		this.pubdate = pubdate;
		this.actor = actor;
		this.rating = rating;
		this.director = director;
	}	
	
	public String getTitle() { return title;}
	public void   setTitle(String title) {this.title = title;}
	public String getLink() {return link;}
	public void   setLink(String link) {this.link = link;}
	public String getImage() {return image;}
	public void   setImage(String image) {this.image = image;}
	public String getSubtitle() {return subtitle;}
	public void   setSubtitle(String subtitle) {this.subtitle = subtitle;}
	public int getPubdate() {return pubdate;}
	public void   setPubdate(int pubdate) {this.pubdate = pubdate;}
	public String getActor() {return actor;}
	public void   setActor(String actor) {this.actor = actor;}
	public float  getRating() {return rating;}
	public void   setRating(float rating) {this.rating = rating;}
	public String getDirector() {return director;}
	public void   setDirector(String director) {this.director = director;} 
	
}
