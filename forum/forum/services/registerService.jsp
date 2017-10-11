<!--
	@author Laura Kaipl
	Service to register new User to our forum
-->

<% page import = "StudentForum.DAO, StudentForum.User" %>

<%
	String email = request.getParameter("email");
	String firstname = request.getParameter("firstname");
	String lastname = request.getParameter("lastname");
	String password = request.getParameter("password1");
	String password2 = request.getParameter("password2");
	
	String useralreadyregistered = DaoObject.getEmail();
	
	if(useralreadyregistered == null)
	{
		if (email == null || firstname == null || lastname == null|| password == null || password2 == null)
		{
			System.out.println("{status:\ERROR\, message:\Please fulfill all of the information.\}");
		}
		else 
		{
			DaoObject.setEmail = email;
			DaoObject.setFirstname = firstname;
			DaoObject.setLastname = lastname;
			DaoObject.setPassword = makeHash(password);
			
			System.out.println("{status:\OK\}");
		}
	}
	else
	{
		System.out.println("{status:\ERROR\, message:\User already registered\}");
	}
%>