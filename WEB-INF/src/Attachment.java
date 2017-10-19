package de.dhbw.StudentForum;

//author Andreas Memmel
public class Attachment {
	private int id;
	private String attachmentfilename;
	private int postingid;
	
	public Attachment(int id) {
		this.id = id;
	}
	public int getId() {
		return this.id;
	}
	public String getAttachment() {
		return this.attachmentfilename;
	}
	public void setAttachment(String attach) {
		this.attachmentfilename = attach;
	}
	public int getPostingid() {
		return this.postingid;
	}
	public void setPostingid(int postingid) {
		this.postingid = postingid;
	}
}
