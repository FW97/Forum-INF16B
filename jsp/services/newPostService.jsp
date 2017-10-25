<%@ page import = "de.dhbw.StudentForum.DAO, de.dhbw.StudentForum.Posting" %>

<%	//	@author Marco Dauber, Eric Dussel, Jacob Krauth
	//	Service to create a new subject and the first post in it 

	String title = request.getParameter("np_posting_titel");
	String text = request.getParameter("np_posting_text");
	String[] tags = ;	// Checkboxen aus Form 
	
	DAO daoObject = new DAO();
	
		if (title == null || text == null )
		{
			out.println("{status:\"ERROR\", message:\"Möglicherweise sind nicht alle Felder korrekt ausgefüllt. Bitte überprüfen Sie Ihre Eingaben.\"}");
		}
		else 
		{
			Subject subjectObject = new Subejct();
			subjectObject.setName(title);
			
			Posting postingObject = new Posting();			
			postingObject.setText(text);
			postingObject.setTags(tags);
			
			try{
				daoObject.addNewPosting(postingObject);
				daoObject.addNewSubject(subjectObject);
				out.println("{status:\"OK\", message:\"Ihr Subject wurde erfolgreich erstellt.\"}");
			}catch(IOException e){
				out.println("{status:\"ERROR\", message:\" Probleme bei der Erstellung Ihres Posts. Bitte versuchen Sie es erneut. \"}");
			}
		}
%>
