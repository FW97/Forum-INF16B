<!--
	@author Laura Kaipl, Tobias Siebig
	Service to register new User to our forum
-->

<% page import = "StudentForum.DAO, StudentForum.User" %>

<%
	import java.util.Random;

	String email = request.getParameter("email");
	String firstname = request.getParameter("firstname");
	String lastname = request.getParameter("lastname");
	String password = request.getParameter("password1");
	int id = 1000;
	byte[] salt = new byte[16];
	random.nextBytes(salt);
	DAO d = new DAO();
	User u = new User(id++);
	
	if(d.getUserByEmail(email) == null)
	{
		if (email == null || firstname == null || lastname == null|| password == null)
		{
			System.out.println("{status:\ERROR\, message:\Please fulfill all of the information.\}");
		}
		else 
		{
			u.setEmail(email);
			u.setFirstname(firstname);
			u.setLastname(lastname);
			u.setRole(1); <!--ist 1 normaler User?-->
			u.setPwHash(makeHash(password));
			u.setPwSalt(salt);
			
			d.addNewUser(u);
			
			System.out.println("{status:\OK\}");
		}
	}
	else
	{
		System.out.println("{status:\ERROR\, message:\Emails already registered.\}");
	}

%>