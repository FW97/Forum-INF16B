package de.dhbw.StudentForum;

//author Andreas Memmel
public class Forum {
	private final int id;
	private int moderatorid;
	private String name;
	private String category;

	public Forum(int id) {
		this.id = id;
	}
	public int getId() {
		return this.id;
	}
	public void setModeratorid(int modId) {
		this.moderatorid = modId;
	}
	public int getModeratorid() {
		return this.moderatorid;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getName() {
		return this.name;
	}
	public void setCategory(String cat) {
		this.category = cat;
	}
	public String getCategory() {
		return this.category;
	}
}
