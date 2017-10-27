<%@ page import = "de.dhbw.StudentForum.DAO, de.dhbw.StudentForum.Posting, de.dhbw.StudentForum.Subject, de.dhbw.StudentForum.User" %>

<%	//	@author Marco Dauber, Eric Dussel, Jacob Krauth
	//	Service to create a new subject and the first post in it 

	String title = request.getParameter("np_posting_titel");
	String text = request.getParameter("np_posting_text");
	//String[] tags = ;	// Checkboxen aus Form 
	User loggedUser = (User) session.getAttribute("user");
	
	
	DAO daoObject = new DAO();
	
		if (title == null || text == null )
		{
			out.println("{status:\"ERROR\", message:\"Möglicherweise sind nicht alle Felder korrekt ausgefüllt. Bitte überprüfen Sie Ihre Eingaben.\"}");
		}
		else 
		{
			Subject subjectObject = new Subject(0);
			subjectObject.setName(title);
			//int id = subjectObject.getId();
			
			Posting postingObject = new Posting(0);			
			postingObject.setText(text);
			//postingObject.setTags(tags);
			postingObject.setAuthorid(loggedUser);
			
			try{
				daoObject.addNewPosting(postingObject);
				daoObject.addNewSubject(subjectObject);
				out.println("{status:\"OK\", message:\"Ihr Subject wurde erfolgreich erstellt.\"}");
			}catch(IOException e){
				out.println("{status:\"ERROR\", message:\" Probleme bei der Erstellung Ihres Posts. Bitte versuchen Sie es erneut. \"}");
			}
		}
%>
