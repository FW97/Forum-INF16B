<!--
  -- @author Niklas Portmann, Philipp Seitz, Morten Terhart
  -- * created on 09.10.17
  -- * Login Service to validate username and password and storing
  -- * the session into the database
  -->
<!--%@ page import = "de.dhbw.StudentExchange.*" %-->
<%@ page import="DAO, User" %>
<%
	response.setContentType("application/json");
	String username = request.getParameter("username");
	String password = request.getParameter("password");

	final String wrongCredentialsMessage = "Username or password seems to be wrong!";
	final String successfulLoginMessage  = "Authentication successful!";
	final String loginErrorMessage       = "Authentication failed!";

	if (username == null || password == null) {
		out.write(sendResponse("Error", wrongCredentialsMessage));
		return;
	}

	DAO databaseObject = new DAO();
	User loggedUser = databaseObject.getUserByEmail(username);
	if (loggedUser == null) {
		out.write(sendResponse("Error", wrongCredentialsMessage));
	}

	String generatedHash = makeHash(loggedUser.salt, password);
	if (generatedHash.equals(loggedUser.passwordHash)) {
		session.setAttribute("username", loggedUser);
		out.write(sendResponse("OK", successfulLoginMessage));
	} else {
		out.write(sendResponse("Error", wrongCredentialsMessage));
	}
%>

<%!
	public static String sendResponse(String status, String message) {
		return "{ status: \"" + status + "\", message: \"" + message + "\" }";
	}
%>
