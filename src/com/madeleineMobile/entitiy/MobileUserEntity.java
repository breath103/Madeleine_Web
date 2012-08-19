package com.madeleineMobile.entitiy;

public class MobileUserEntity {
	private int idx;
	private String email;
	private String password;
	
	public MobileUserEntity(int idx, String email, String password) {
		super();
		this.idx = idx;
		this.email = email;
		this.password = password;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	
}
