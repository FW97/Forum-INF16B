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
			out.println("{status:\"Error\", message:\"Möglicherweise sind nicht alle Felder korrekt ausgefüllt. Bitte überprüfen Sie Ihre Eingaben.\"}");
		}
		else 
		{
			Subject subjectObject = new Subject(0);
			subjectObject.setName(title);
			int id = daoObject.addSubject(subjectObject);
			
			if (id != -1){
				Posting postingObject = new Posting(0);			
				postingObject.setMessage(text);
				//postingObject.setTags(tags);
				postingObject.setUserId(loggedUser);
				postingObject.setSubjectId(id);
				
				try{
					daoObject.addNewPosting(postingObject);
					out.println("{status:\"Ok\", message:\"Ihr Subject wurde erfolgreich erstellt.\"}");
				}catch(Exception e){
					out.println("{status:\"Error\", message:\" Probleme bei der Erstellung Ihres Posts. Bitte versuchen Sie es erneut. \"}");
				}
			}
			else {
				out.println("{status:\"Ok\", message:\"Fehler beim Erstellen des Subjects.\"}");
			}	
		}
%>
