import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 
 * @author Michael Skrzypietz, Justus Grauel
 */

@WebServlet("/ProfilServlet")
public class ProfilServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private static final String EMAIL_PATTERN =
			"^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
			+ "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
	
	public ProfilServlet() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		user.setFirstname(request.getParameter("firstName"));
		user.setLastname(request.getParameter("lastName"));
		user.setEmail(request.getParameter("email"));

		if (isValidInput(user)) {
			DAO.updateProfilSettings(user);
		}
		
		if (isPasswordChange(request) && isValidPasswordChange(request)) {
			user = (User) session.getAttribute("user");
			String pwhash = Hashing.getHashedPassword(request.getParameter("newPassword"), user.getPwSalt());
			user.setPwHash(pwhash);
			
			DAO.updatePassword(user);
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
		
		if (DAO.isEmailTaken(user.getEmail())) {
			System.out.println("Profil settings change Error: email is taken");
			return false;
		}
		
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
				&& request.getParameter("newPassword2").length() > 0;
	}
	
	private boolean isValidPasswordChange(HttpServletRequest request) {
		String newPassword = request.getParameter("newPassword");
		String newPassword2 = request.getParameter("newPassword2");
		
		if (newPassword.equals(newPassword2)) return true;
		
		System.out.println("Passwords don't match");
		return false;
	}
}
