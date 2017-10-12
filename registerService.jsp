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
	int id = 1000;
	byte[] salt = new byte[16];
	random.nextBytes(salt);
	
		if (email == null || firstname == null || lastname == null|| password == null || password2 == null)
		{
			System.out.println("{status:\ERROR\, message:\Please fulfill all of the information.\}");
		}
		else 
		{
			DAO d = new DAO();
			User u = new User(id++);
			u.setEmail(email);
			u.setFirstname(firstname);
			u.setLastname(lastname);
			u.setRole(1); <!--ist 1 normaler User?-->
			u.setPwHash(makeHash(password));
			u.setPwSalt(salt);
			
			d.addNewUser(u);
			
			System.out.println("{status:\OK\}");
		}

%>