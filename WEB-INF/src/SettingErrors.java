package de.dhbw.StudentForum;

/**
 * 
 * @author Michael Skrzypietz, Justus Grauel
 */

public class SettingErrors {
	
	private String email;
	private String firstName;
	private String lastName;
	private String profilImage;
	private String password;
		
	public SettingErrors(){
	}
	
	public String getEmail() {
		return this.email;
	}
	
	public void setEmail(String errorMsg) {
		this.email = errorMsg;
	}
	
	public String getFirstName() {
		return this.firstName;
	}
	
	public void setFirstName(String errorMsg) {
		this.firstName = errorMsg;
	}

	public String getLastName() {
		return this.lastName;
	}
	
	public void setLastName(String errorMsg) {
		this.lastName = errorMsg;
	}
	
	public String getProfilImage() {
		return this.profilImage;
	}
	
	public void setProfilImage(String errorMsg) {
		this.profilImage = errorMsg;
	}

	public String getPassword() {
		return this.password;
	}
	
	public void setPassword(String errorMsg) {
		this.password = errorMsg;
	}

}