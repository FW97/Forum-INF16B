package de.dhbw.StudentForum;


/**
 * Class to represent an Object of type User
 * @author Micha Spahr
 *
 */
public class User {
	
	private final int id;
	private String firstname;
	private String lastname;
	private String email;
	private String pwHash;
	private String pwSalt;
	private int role;
	private String imgUrl;
		
	public User(int id){
		this.id = id;
	}

	public int getId() {
		return id;
	}
	
	public String getFirstname() {
		return firstname;
	}
	
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	
	public String getLastname() {
		return lastname;
	}
	
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getPwHash() {
		return pwHash;
	}
	
	public void setPwHash(String pwHash) {
		this.pwHash = pwHash;
	}
	
	public String getPwSalt() {
		return pwSalt;
	}
	
	public void setPwSalt(String pwSalt) {
		this.pwSalt = pwSalt;
	}
	
	public int getRole() {
		return role;
	}
	
	public void setRole(int role) {
		this.role = role;
	}
	
	public String getImgUrl() {
		return imgUrl;
	}
	
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
}
