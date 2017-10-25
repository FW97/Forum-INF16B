package de.dhbw.StudentForum;

import java.util.Date;

/**
 * 
 * @author Peter Fischer
 *
 * Update the class with more attributes and methods by Jacob Krauth
 */

public class Posting {

	
	private final int id;
	private int userId;
	private String message;
	private Date whenDeleted;
	private Date whenPosted;
	private int forumId;
	private String[] tags;
	private int posRat;
	private int negRat;
	
	
	public Posting(int id) {
		this.id = id;
	}
	
	
	/* Getter- und Setter-Methoden */
	public int getId() {
		return id;
	}
	
	public int getUserId(){
		return userId;
	}
	public void setUserId(int userId){
		this.userId = userId;
	}
	
	public String getMessage(){
		return message;
	}
	public void setMessage(String message){
		this.message = message;
	}
	
	public Date getWhenDeleted() {
		return whenDeleted;
	}
	public void setWhenDeleted(Date whenDeleted) {
		this.whenDeleted = whenDeleted;
	}
	
	public Date getWhenPosted() {
		return whenPosted;
	}
	public void setWhenPosted(Date whenPosted) {
		this.whenPosted = whenPosted;
	}
	
	public int getForumId(){
		return forumId;
	}
	public void setForumId(int forumId){
		this.forumId = forumId;
	}
	
	public String[] getTags(){
		return tags;
	}
	public void setTags(String[] tags){
		this.tags = tags;
	}
	
	public int getPosRat(){
		return posRat;
	}
	public void setPosRat(int posRat){
		this.posRat = posRat;
	}

	public int getNegRat(){
		return negRat;
	}
	public void setNegRat(int negRat){
		this.negRat = negRat;
	}
}
