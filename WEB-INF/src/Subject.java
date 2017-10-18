package de.dhbw.Forum;

//author Andreas Memmel
public class Subject {
	private final int id;
	private String name;
	private int forumid;
	
	public Subject(int id) {
		this.id = id;
	}
	public int getId() {
		return this.id;
	}
	public String getName() {
		return this.name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getForumid() {
		return this.forumid;
	}
	public void setForumid(int forumid) {
		this.forumid = forumid;
	}
}