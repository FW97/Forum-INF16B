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

	final String wrongCredentialsMessage = "Username or password seems to be wrong!";
	final String successfulLoginMessage  = "Authentication successful!";
	final String loginErrorMessage       = "Authentication failed!";

	if (username == null || password == null) {
		out.println(createResponse("Error", wrongCredentialsMessage));
		return;
	}

	DAO databaseObject = new DAO();
	User loggedUser = new User(0); // databaseObject.getUserByEmail(username);
	loggedUser.setFirstname("Jason");
	loggedUser.setLastname("Biggs");
	loggedUser.setEmail("j.biggs24@t-online.de");
	loggedUser.setPwHash("+v1SQl2PKeYFFiPfoemlHQGttPLm5aj2MQEtuMHS78NbuKpIghr4VPKroGZTtKa3gKZMcy9ROKMkMUqLBnVGIw==");
	loggedUser.setPwSalt("sqndpB7MOQO8rZ6mZJPIfs3UNwq87FEdUCoMgMDHa6V3v22OMMT+Bo019B6Fee5GaoTziWrm2l30BReYZYFWCA==");
	loggedUser.setRole(2);
	loggedUser.setImgUrl("https://i.imgur.com/5pgEunI.png");

	if (loggedUser == null) {
		out.println(createResponse("Error", wrongCredentialsMessage));
	}

	String generatedHash = hashPassword(password, loggedUser.getPwSalt());
	if (generatedHash.equals(loggedUser.getPwHash())) {
		session.setAttribute("username", loggedUser);
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
