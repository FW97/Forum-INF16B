
<%@ page import = "de.dhbw.StudentForum.DAO, de.dhbw.StudentForum.User, de.dhbw.StudentForum.Hashing" %>

<%
	/*
	@author Laura Kaipl, Tobias Siebig
	Service to register new Users to our forum
	*/

	String email = request.getParameter("email");
	String firstname = request.getParameter("firstname");
	String lastname = request.getParameter("lastname");
	String password = request.getParameter("password1");
	
	User u = new User(0);
	DAO d = new DAO();
	
	if(d.getUserByEmail(email) == null)
	{
		if (email == null || firstname == null || lastname == null || password == null)
		{
			out.println("{status:\"Error\", message:\"Please fulfill all of the information.\"}");
		}
		else 
		{
			u.setEmail(email);
			u.setFirstname(firstname);
			u.setLastname(lastname);
			u.setRole(1);
			u.setImgUrl(request.getContextPath()+"/img/profilImages/standardPic.png");
			
			String[] saltAndHash = Hashing.hashNewUser(password);
			
			u.setPwSalt(saltAndHash[0]);
			u.setPwHash(saltAndHash[1]);
			
			d.addNewUser(u);
			
			out.println("{status:\"OK\"}");
		}
	}
	else
	{
		out.println("{status:\"Error\", message:\"Email is already registered, please try to login.\"}");
	}

%>
