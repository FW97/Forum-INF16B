<!--
	@author Laura Kaipl, Tobias Siebig
	Service to register new Users to our forum
-->

<%@ page import = "de.dhbw.StudentForum.DAO, de.dhbw.StudentForum.User, java.util.Random" %>

<%
	String email = request.getParameter("email");
	String firstname = request.getParameter("firstname");
	String lastname = request.getParameter("lastname");
	String password = request.getParameter("password1");
	
	Random randomNumber = new Random();
	byte salt = randomNumber.nextByte(32);
	
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
			u.setRole(1); // normaler User
			u.setPwHash(makeHash(password));
			u.setPwSalt(salt);
			u.setImgUrl("/img/profilImages/standardPic.png");
			
			d.addNewUser(u);
			
			out.println("{status:\"OK\"}");
		}
	}
	else
	{
		out.println("{status:\"Error\", message:\"Email already registered.\"}");
	}

%>
