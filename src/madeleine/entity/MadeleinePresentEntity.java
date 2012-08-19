package madeleine.entity;

public class MadeleinePresentEntity {
	public MadeleinePresentEntity(int idx, String owner_id, int madeleine_idx,
			boolean is_opened) {
		super();
		this.idx = idx;
		this.owner_id = owner_id;
		this.madeleine_idx = madeleine_idx;
		this.is_opened = is_opened;
	}
	private int idx;
	private String owner_id;
	private int madeleine_idx;
	private boolean is_opened;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getOwner_id() {
		return owner_id;
	}
	public void setOwner_id(String owner_id) {
		this.owner_id = owner_id;
	}
	public int getMadeleine_idx() {
		return madeleine_idx;
	}
	public void setMadeleine_idx(int madeleine_idx) {
		this.madeleine_idx = madeleine_idx;
	}
	public boolean getIs_opened() {
		return is_opened;
	}
	public void setIs_opened(boolean is_opened) {
		this.is_opened = is_opened;
	}
	
	
}
