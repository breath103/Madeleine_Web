package madeleine.entity;

public class MadeleinePhotoEntity {
	private int idx;
	private int madeleine_idx;
	private String src;
	private String facebook_id = null;

	public MadeleinePhotoEntity(int id, int madeleine_idx, String src,String facebook_id) {
		super();
		this.idx = id;
		this.madeleine_idx = madeleine_idx;
		this.src = src;
		this.facebook_id = facebook_id;
	}
	
	public int getIdx() {
		return idx;
	}
	public void setId(int idx) {
		this.idx = idx;
	}
	public int getMadeleine_Idx() {
		return madeleine_idx;
	}
	public void setMadeleine_Idx(int madeleine_idx) {
		this.madeleine_idx = madeleine_idx;
	}
	public String getSrc() {
		return src;
	}
	public void setSrc(String src) {
		this.src = src;
	}	
	public String getFacebook_id() {
		return facebook_id;
	}
	public void setFacebook_id(String facebook_id) {
		this.facebook_id = facebook_id;
	}
}
