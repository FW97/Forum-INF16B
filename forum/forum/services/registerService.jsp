<!--
	@author Laura Kaipl, Tobias Siebig
	Service to register new User to our forum
-->

<% page import = "StudentForum.DAO, StudentForum.User" %>

<%
	String email = request.getParameter("email");
	String firstname = request.getParameter("firstname");
	String lastname = request.getParameter("lastname");
	String password = request.getParameter("password1");
	
	DAO daoObject = new DAO();
	boolean useralreadyregistered = daoObject.isEmailTaken(email);
	
	if(!useralreadyregistered)
	{
		if (email == null || firstname == null || lastname == null|| password == null)
		{
			System.out.println("{status:\ERROR\, message:\Füllen Sie alle Informationen aus.\}");
		}
		else 
		{
			User userObject = new User();
			userObject.setEmail = email;
			userObject.setFirstname = firstname;
			userObject.setLastname = lastname;
			userObject.setPassword = makeHash(password);
			
			daoObject.addNewUser(userObject);
			
			System.out.println("{status:\OK\}");
		}
	}
	else
	{
		System.out.println("{status:\ERROR\, message:\User/E-Mail bereits registriert!\}");
	}
%>
