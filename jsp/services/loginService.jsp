<!--
  -- @author Niklas Portmann, Philipp Seitz, Morten Terhart
  -- * created on 09.10.17
  -- * Login Service to validate username and password and storing
  -- * the session into the database
  -->
<%@ page import="de.dhbw.StudentForum.DAO, de.dhbw.StudentForum.User" %>
<%
	// TODO: Replace the out.write() method of type JspWriter with out.println()
	// to send the reponse instead of writing it plain to the HTML
	response.setContentType("application/json");
	String username = "jason"; //request.getParameter("username");
	String password = "jason's password"; // request.getParameter("password");

	final String wrongCredentialsMessage = "Username or password seems to be wrong!";
	final String successfulLoginMessage  = "Authentication successful!";
	final String loginErrorMessage       = "Authentication failed!";

	if (username == null || password == null) {
		out.write(createResponse("Error", wrongCredentialsMessage));
		return;
	}

	DAO databaseObject = new DAO();
	User loggedUser = new User(0); //databaseObject.getUserByEmail(username);
	loggedUser.setFirstname("Jason");
	loggedUser.setLastname("Biggs");
	loggedUser.setEmail("j.biggs24@t-online.de");
	loggedUser.setPwHash("4tUs4DhaGkX3JlXC5jds4Do0rX");
	loggedUser.setPwSalt("E1F53135E559C253");
	loggedUser.setRole(2);
	loggedUser.setImgUrl("https://i.imgur.com/5pgEunI.png");

	if (loggedUser == null) {
		out.write(createResponse("Error", wrongCredentialsMessage));
	}

	String generatedHash = makeHash(loggedUser.getPwSalt(), password);
	if (generatedHash.equals(loggedUser.getPwHash())) {
		session.setAttribute("username", loggedUser);
		out.write(createResponse("OK", null));
	} else {
		out.write(createResponse("Error", wrongCredentialsMessage));
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
	 * @param salt The user's unique salt
	 * @param password The user's password
	 * @return the hash generated out of salt and password
	 */
	private String makeHash(String salt, String password) {
	    return "4tUs4DhaGkX3JlXC5jds4Do0rX";
	}
%>
