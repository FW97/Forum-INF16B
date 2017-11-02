package de.dhbw.StudentForum;
import java.util.Date;
import java.sql.Timestamp;

/**
 * 
 * @author Peter Fischer
 *
 * Update the class with more attributes and methods by Jacob Krauth
 */

public class Posting {

	
	private final int id;
	private int userId;
	private String title;
	private String message;
	private Date whenDeleted;
	private Date whenPosted;
	private int subjectId;
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
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public void setWhenDeleted(Timestamp whenDeleted) {
		if(whenDeleted != null) {
			this.whenDeleted = new Date(whenDeleted.getTime());
		}
	}
	
	public Date getWhenPosted() {
		return whenPosted;
	}
	public void setWhenPosted(Timestamp whenPosted) {
		this.whenPosted = new Date(whenPosted.getTime());
	}
	
	public int getSubjectId(){
		return subjectId;
	}
	public void setSubjectId(int subjectId){
		this.subjectId = subjectId;
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
