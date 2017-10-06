import java.util.Date;

/**
 * 
 * @author Peter Fischer
 *
 */

public class Posting {

	
	private Date whenDeleted;
	private Date whenPosted;
	private final int id;
	private String text;
	
	
	
	public Posting(Date whenDeleted, Date whenPosted, int id, String text) {
		this.whenDeleted = whenDeleted;
		this.whenPosted = whenPosted;
		this.id = id;
		this.text = text;
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
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}

	
	
	
}
