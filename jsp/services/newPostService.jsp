<!--
	@author Marco Dauber, Eric Dussel, Jacob Krauth
	Service to create a new posting
-->

<%@ page import = "StudentForum.DAO, StudentForum.Posting" %>

<%	String title = request.getParameter("np_posting_titel");
	String text = request.getParameter("np_posting_text");
	int id = 100;
	
	DAO daoObject = new DAO();
	
		if (title.equals(null) || text.equals(null) || id == 0)
		{
			out.println("{status:\"ERROR\", message:\"Füllen Sie alle Informationen aus.\"}");
		}
		else 
		{
			Posting postingObject = new Posting(id++);			
			postingObject.setTitle(title)
			postingObject.setText(text)
			 
			daoObject.addNewPosting(postingObject);
			out.println("{status:\"OK\"}");
		}
%>
