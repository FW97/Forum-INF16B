<!--
	@author Florian Keilhofer, Manuel Libal, Theresa Hillenbrand
-- * created on 11.10.17
-- * New Forum Service
-->

<% page import = "StudentForum.DAO, StudentForum.User" %>

<%
	response.setContentType("application/json");
	final String successfulForumMessage  = "Forum created successful!";
	final String ErrorForumMessage  = "You have no permission!";
	final String successfulForumStatus  = "OK";
	final String ErrorForumStatus  = "ERROR";

	String newForumName = request.getParameter("newForumName");
	String newForumKategorie = request.getParameter("newForumKategorie");

	DAO databaseObject = new DAO();
	Int loggedUserID = session.getAttribute("userid");
	User loggedUser = databaseObject.getUserById(loggedUserID);

	//Hierbei wird angenommen, dass wenn die Role eines Benutzers auf 1 steht, er Admin ist und die Berechtigung zum Erstellen von Foren hat.
	if(loggedUser.getRole == 1)
	{
		databaseObject.addForum(newForumName, newForumKategorie, loggedUserID);
		System.out.println("{ status: \"" + successfulForumStatus + "\", message: \"" + successfulForumMessage + "\" }");
	} else {
		System.out.println("{ status: \"" + ErrorForumStatus + "\", message: \"" + ErrorForumMessage + "\" }");
	}
%>
