<%@ page import="de.dhbw.StudentForum.DAO, de.dhbw.StudentForum.User, de.dhbw.StudentForum.Hashing" %>

<%

	/**
	  * @author Niklas Portmann, Philipp Seitz, Morten Terhart
	  * created on 09.10.17
	  * Login Service to validate username and password and storing
	  * the session into the database
	  */

	response.setContentType("application/json");
	String username = request.getParameter("username");
	String password = request.getParameter("password");

	final String wrongCredentialsMessage = "Username or password is wrong! Please correct and try again!";

	if (username == null || password == null) {
		out.println(createResponse("Error", wrongCredentialsMessage));
		return;
	}

	DAO databaseObject = new DAO();
	User loggedUser = databaseObject.getUserByEmail(username);

	if (loggedUser == null) {
		out.println(createResponse("Error", wrongCredentialsMessage));
		return;
	}

	String generatedHash = hashPassword(password, loggedUser.getPwSalt());
	if (generatedHash.equals(loggedUser.getPwHash())) {
		session.setAttribute("user", loggedUser);
		out.println(createResponse("OK", null));
	} else {
		out.println(createResponse("Error", wrongCredentialsMessage));
	}
%>

<%!
	/**
	 * Forms a valid JSON string with status indication and optional message
	 * @param status the status indicating the process' result (either "OK" or "Error")
	 * @param message the message revealing the reason for an error or null, if
	 *                it should be omitted
	 * @return the JSON string to be sent
	 */
	private String createResponse(String status, String message) {
		if (message != null) {
			return "{ status: \"" + status + "\", message: \"" + message + "\" }";
		} else {
			return "{ status: \"" + status + "\" }";
		}
	}

	/**
	 * Generate the hashcode for the applied salt and password phrase. This method serves
	 * as comparison to the saved password hash in the user record to validate the passphrase.
	 * @param password The user's password
	 * @param salt The user's unique salt
	 * @return the hash generated out of salt and password
	 */
	private String hashPassword(String password, String salt) {
		return Hashing.getHashedPassword(password, salt);
	}
%>
