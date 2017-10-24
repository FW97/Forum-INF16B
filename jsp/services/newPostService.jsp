<%@ page import = "de.dhbw.StudentForum.DAO, de.dhbw.StudentForum.Posting" %>

<%	//	@author Marco Dauber, Eric Dussel, Jacob Krauth
	//	Service to create a new subject and the first post in it 

	String title = request.getParameter("np_posting_titel");
	String text = request.getParameter("np_posting_text");
	int id = 0;
	
	DAO daoObject = new DAO();
	
		if (title == null || text == null || id == 0)
		{
			out.println("{status:\"ERROR\", message:\"Möglicherweise sind nicht alle Felder korrekt ausgefüllt. Bitte überprüfen Sie Ihre Eingaben.\"}");
		}
		else 
		{
			Subject subjectObject = new Subejct(/*Subject-ID*/);
			subjectObject.setName(title);
			
			Posting postingObject = new Posting(id);			
			postingObject.setTitle(title);
			postingObject.setText(text);
			 
			daoObject.addNewPosting(postingObject);
			out.println("{status:\"OK\", message:\"Ihr Subject wurde erfolgreich erstellt.\"}");
		}
%>
