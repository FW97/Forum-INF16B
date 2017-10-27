

<%@ page import ="de.dhbw.StudentForum.DAO, de.dhbw.StudentForum.User, de.dhbw.StudentForum.Forum" %>

<%
	/*
	* @author Florian Keilhofer, Manuel Libal, Theresa Hillenbrand
	* created on 11.10.17
	* New Forum Service 
	*/
	
	response.setContentType("application/json");
	final String successfulForumMessage  = "Forum created successful!";
	final String ErrorForumMessage  = "You have no permission!";
	final String successfulForumStatus  = "OK";
	final String ErrorForumStatus  = "ERROR";

	String newForumName = request.getParameter("newForumName");
	if (newForumName==null || newForumName.length()==0){
		out.println("{\"status\": \"Error\",\"message\":\"kein Forumname\"}");
		return;
	}
	String newForumKategorie = request.getParameter("newForumKategorie");
	if (newForumKategorie==null || newForumKategorie.length()==0){
		out.println("{\"status\": \"Error\",\"message\":\"keine Forumkategorie\"}");
		return;
	}

	DAO databaseObject = new DAO();
	User loggedUser = (User)session.getAttribute("user");
	if (loggedUser==null){
		out.println("{\"status\": \"Error\",\"message\":\"kein eingeloggter User\"}");
		return;
	}
	else{
		Forum forum = new Forum(1);
		forum.setName(newForumName);
		forum.setCategory(newForumKategorie);
		forum.setModeratorid(loggedUser.getId());

		//Hierbei wird angenommen, dass wenn die Rolle eines Benutzers auf 1 steht, er Admin ist und die Berechtigung zum Erstellen von Foren hat.
		if(loggedUser.getRole() == 1)
		{
			databaseObject.addForum(forum);
			out.println("{ status: \"" + successfulForumStatus + "\", message: \"" + successfulForumMessage + "\" }");
		} else {
			out.println("{ status: \"" + ErrorForumStatus + "\", message: \"" + ErrorForumMessage + "\" }");
			return;
		}
	}
%>
