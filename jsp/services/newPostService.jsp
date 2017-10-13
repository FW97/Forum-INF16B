<!--
	@author Marco Dauber, Eric Dussel, Jacob Krauth
	Service to create a new posting
-->

<% page import = "StudentForum.DAO, StudentForum.Posting" %>

	String title = request.getParameter("np_posting_titel");
	Date whenDeleted = request.getParameter("");
	Date whenPosted = request.getParameter("");
	int id = request.getParameter("");
	String text = request.getParameter("np_posting_text");
	
	DAO daoObject = new DAO();

		if (title.equals(null) || text.equals(null) || id == 0)
		{
			System.out.println("{status:\ERROR\, message:\Füllen Sie alle Informationen aus.\}");
		}
		else 
		{
			Posting postingObject = new Posting(whenDeleted, whenPosted, id, text);			
			daoObject.addNewPosting(postingObject);
			System.out.println("{status:\OK\}");
		}
%>
