package madeleine.entity;

public class MadeleinePostEntity {
	private int idx;
	private int madeleine_idx;
	private String facebook_id;

	public MadeleinePostEntity(int idx, int madeleine_idx, String facebook_id) {
		super();
		this.idx = idx;
		this.madeleine_idx = madeleine_idx;
		this.facebook_id = facebook_id;
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
	public String getFacebook_id() {
		return facebook_id;
	}
	public void setFacebook_id(String facebook_id) {
		this.facebook_id = facebook_id;
	}
}
