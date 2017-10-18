package de.dhbw.StudentForum;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * 
 * @author Michael Skrzypietz, Justus Grauel
 */

@WebServlet("/ProfilServlet")
@MultipartConfig(fileSizeThreshold=1024*1024*2, 
maxFileSize=1024*1024*10,     
maxRequestSize=1024*1024*50)   
public class ProfilServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private static final String EMAIL_PATTERN =
			"^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
			+ "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
	private static final String SAVE_DIR = "uploadFiles";
	
	public ProfilServlet() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		if (user == null) {
			System.out.println("User is not set in the session storage.");
			return;
		} -> uncomment in production*/ 
		User user = new User(1); // Delete in production
		user.setFirstname(request.getParameter("firstName"));
		user.setLastname(request.getParameter("lastName"));
		user.setEmail(request.getParameter("email"));

		if (isValidInput(user)) {
			//DAO.updateProfilSettings(user); -> uncomment in production
		}
		
		if (isPasswordChange(request) && isValidPasswordChange(request)) {
			//user = (User) session.getAttribute("user"); -> uncomment in production
			user = new User(2); // Delete in production
			user.setPwSalt("3"); // Delete in production
			
			String pwhash = Hashing.getHashedPassword(request.getParameter("newPassword"), user.getPwSalt());
			user.setPwHash(pwhash);
			
			//DAO.updatePassword(user); -> uncomment in production
		} else {
			System.out.println("Invalid password change.");
		}
		
		
		if (isImageUpload(request)) {
			Part filePart = request.getPart("file");
		    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
		    
			String appPath = request.getServletContext().getRealPath("");
			String savePath = appPath + File.separator + SAVE_DIR;
	         
	        File fileSaveDir = new File(savePath);
	        if (!fileSaveDir.exists()) {
	            fileSaveDir.mkdir();
	        }
	        
	        filePart.write(savePath + File.separator  + fileName); 
	        
	        // user = (User) session.getAttribute("user"); -> uncomment in production
	        user = new User(1); // delete in production
	        user.setImgUrl(savePath + File.separator  + fileName);
	        //DAO.updateImgurl(user); -> uncomment in prodcution
		}
 
	}
	
	private boolean isValidInput(User user) {
		if (!isValidFirstName(user.getFirstname())) {
			System.out.println("Profil settings change Error: invalid firstname");
			return false;
		}
		
		if (!isValidLastName(user.getLastname())) {
			System.out.println("Profil settings change Error: invalid lastname");
			return false;
		}
		
		if (!isValidEmail(user.getEmail())) {
			System.out.println("Profil settings change Error: invalid email");
			return false;
		}
		/*
		if (DAO.isEmailTaken(user.getEmail())) {
			System.out.println("Profil settings change Error: email is taken");
			return false;
		} -> uncomment in production*/
		
		return true;
	}
	
	private boolean isValidFirstName(String firstName) {
		return firstName != null && firstName.length() > 0 && firstName.length() < 16;
	}
	
	private boolean isValidLastName(String lastName) {
		return lastName != null && lastName.length() > 0 && lastName.length() < 16;
	}
	
	private boolean isValidEmail(String email) {
		Pattern pattern = Pattern.compile(EMAIL_PATTERN);
		Matcher matcher = pattern.matcher(email);
		return matcher.matches();
	}
	
	private boolean isPasswordChange(HttpServletRequest request) {
		return request.getParameter("currentPassword").length() > 0
				&& request.getParameter("newPassword").length() > 0
				&& request.getParameter("newPassword2").length() > 0
				&& !request.getParameter("currentPassword").equals(
						request.getParameter("newPassword"));
	}
	
	private boolean isValidPasswordChange(HttpServletRequest request) {
		String newPassword = request.getParameter("newPassword");
		String newPassword2 = request.getParameter("newPassword2");
		
		if (newPassword.equals(newPassword2)) return true;
		
		System.out.println("Passwords don't match");
		return false;
	}
	
	private boolean isImageUpload(HttpServletRequest request) throws IOException, ServletException {
		if (request.getPart("file") == null) return false;
		Part filePart = request.getPart("file");
	    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
	    String fileType = fileName.substring(fileName.indexOf(".") + 1, fileName.length());
		return !fileName.equals("") && (fileType.equals("png") || fileType.equals("jpeg"));
	}
	
}
