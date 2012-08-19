package facebook;

public class FacebookEntity {
	private String facebook_id;
	private String access_token;
	private String email;
	
	public FacebookEntity()
	{
		super();
	}
	public FacebookEntity(String facebook_id, String access_token,String email) {
		super();
		this.facebook_id = facebook_id;
		this.access_token = access_token;
		this.email = email;
	}
	
	public String getFacebook_id() {
		return facebook_id;
	}
	public void setFacebook_id(String facebook_id) {
		this.facebook_id = facebook_id;
	}
	public String getAccess_token() {
		return access_token;
	}
	public void setAccess_token(String access_token) {
		this.access_token = access_token;
	}
	public String getEmail() {return email;}
	public void setEmail(String email) {this.email = email;}
}
