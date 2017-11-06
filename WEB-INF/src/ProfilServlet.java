package de.dhbw.StudentForum;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
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
	private static final String SAVE_DIR = "img" + File.separator + "profilImages" + File.separator;
	private SettingErrors errors;
	
	public ProfilServlet() {
		super();
	}

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		this.errors = new SettingErrors();
		User user = (User) session.getAttribute("user");
		if (user == null) {
			System.out.println("User is not set in the session storage.");
			return;
		} 

		if (isInputChange(request, user) && isValidInputChange(request, user.getEmail().trim())) {
			user.setFirstname(request.getParameter("firstName").trim());
			user.setLastname(request.getParameter("lastName").trim());
			user.setEmail(request.getParameter("email").trim());
			
			session.setAttribute("user", user);
			session.setAttribute("settingSuccess", true);
			DAO.updateProfilSettings(user);
		}
		
		if (isPasswordChange(request) && isValidPasswordChange(request)) {
			user = (User) session.getAttribute("user"); 	
			String pwhash = Hashing.getHashedPassword(request.getParameter("newPassword"), user.getPwSalt());
			user.setPwHash(pwhash);
			
			session.setAttribute("settingSuccess", true);
			session.setAttribute("user", user);
			DAO.updatePassword(user);
		} 
		
		if (isValidImageUpload(request)) {
			Part filePart = request.getPart("file");
			String userFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
			String fileType = userFileName.substring(userFileName.indexOf("."), userFileName.length());
			String fileName = ((User) request.getSession().getAttribute("user")).getId() + fileType.toLowerCase();
		   
			filePart.write(request.getServletContext().getRealPath("") + SAVE_DIR + fileName);
			
			user = (User) session.getAttribute("user");
			String imgurl = File.separator + SAVE_DIR + fileName;
			user.setImgUrl(imgurl);
			
			session.setAttribute("settingSuccess", true);
			session.setAttribute("user", user);
			DAO.updateImgurl(user);
		}
		
		session.setAttribute("settingErrors", this.errors);
		response.sendRedirect("jsp/profil.jsp");
	}

	/** 
	*	@param HttpServletRequest to access the firstname, lastname and email parameters of the form
	*	@return true if firstname, lastname or email does not match its value in the database
	*/
	private boolean isInputChange(HttpServletRequest request, User user) {
		return !user.getFirstname().trim().equals(request.getParameter("firstName").trim()) ||
			!user.getLastname().trim().equals(request.getParameter("lastName").trim()) ||
			!user.getEmail().trim().equals(request.getParameter("email").trim());
	}
	
	/** 
	*	@param HttpServletRequest to access the firstname, lastname and email parameters of the form
	*	@return true if every input by the user is valid
	*/
	private boolean isValidInputChange(HttpServletRequest request, String userEmail) {
		if (!isValidFirstName(request.getParameter("firstName"))) {
			this.errors.setFirstName("Vornamen dürfen keine Zahlen enthalten und müssen zwischen 2 und 16 Zeichen lang sein.");
			System.out.println("Profil settings change Error: invalid firstname");
			return false;
		}
		
		if (!isValidLastName(request.getParameter("lastName"))) {
			this.errors.setLastName("Nachnamen dürfen keine Zahlen enthalten und müssen zwischen 2 und 16 Zeichen lang sein.");
			System.out.println("Profil settings change Error: invalid lastname");
			return false;
		}
		
		if (!isValidEmail(request.getParameter("email"))) {
			this.errors.setEmail("Bitte geben Sie eine korrekte Email-Addresse ein.");
			System.out.println("Profil settings change Error: invalid email");
			return false;
		}
		
		if (!userEmail.equals(request.getParameter("email").trim()) && DAO.isEmailTaken(request.getParameter("email"))) {
			this.errors.setEmail("Die Email ist bereits vergeben.");
			System.out.println("Profil settings change Error: email is taken");
			return false;
		}
		
		return true;
	}
	
	/**
	*	@return true if the given firstname contains only letters and is between 2 and 15 characters long
	*/
	private boolean isValidFirstName(String firstName) {
		return firstName != null && !firstName.matches(".*\\d+.*") &&
			firstName.length() > 1 && firstName.length() < 16;
	}
	
	/**
	*	@return true if the given lastname contains only letters and is between 2 and 15 characters long
	*/
	private boolean isValidLastName(String lastName) {
		return lastName != null && !lastName.matches(".*\\d+.*") &&
			lastName.length() > 1 && lastName.length() < 16;
	}
	
	/**
	*	@return true if the given email matches the email pattern
	*/
	private boolean isValidEmail(String email) {
		Pattern pattern = Pattern.compile(EMAIL_PATTERN);
		Matcher matcher = pattern.matcher(email);
		return matcher.matches();
	}
	
	/** 
	*	@param HttpServletRequest to access the password parameters of the form
	*	@return true if any password field contains input 
	*/
	private boolean isPasswordChange(HttpServletRequest request) {
		return request.getParameter("currentPassword").length() > 0
				|| request.getParameter("newPassword").length() > 0
				|| request.getParameter("newPassword2").length() > 0;
	}
	
	/**
	*	@param HttpServletRequest to access the password parameters of the form
	*	@return true if the old password is correct and if the new password 
	*/
	private boolean isValidPasswordChange(HttpServletRequest request) {
		User user = (User) request.getSession().getAttribute("user");
		String newPassword = request.getParameter("newPassword");
		String newPassword2 = request.getParameter("newPassword2");	
		String pwhash = Hashing.getHashedPassword(request.getParameter("currentPassword"), user.getPwSalt());
		if (newPassword.equals(newPassword2) && pwhash.equals(user.getPwHash())) return true; 
		
		this.errors.setPassword("Das alte Passwort ist falsch oder die neuen Passwörter stimmen nicht überein.");
		System.out.println("Invalid password change.");
		return false;
	}
	
	/**
	*	@param HttpServletRequest to access the file parameter of the form
	*	@return true if it is a file of type png, jpg or jpeg
	*/
	private boolean isValidImageUpload(HttpServletRequest request) throws IOException, ServletException {
		if (request.getPart("file") == null) return false;
		Part filePart = request.getPart("file");
		String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
		String fileType = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length());

		boolean result = !fileName.equals("") && (fileType.toUpperCase().equals("PNG") || fileType.toUpperCase().equals("JPEG") || fileType.toUpperCase().equals("JPG"));
		if (!result && !fileName.equals("")) {
			this.errors.setProfilImage("Bitte wählen Sie nur png oder jpeg Dateien aus.");
			System.out.println("Bitte wählen Sie nur png oder jpeg Dateien aus.");
		}
		return result;
	}
	
}