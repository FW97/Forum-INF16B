<!--
@author Bernhard Koll, Jan Malchert
Service to create a new posting
-->

<%@ page import = "de.dhbw.StudentForum.Posting, de.dhbw.StudentForum.DAO, de.dhbw.StudentForum.User " %>

<%	int subjectid = Integer.parseInt(request.getParameter("subjectid"));
    String replystring = request.getParameter("replystring");
    User loggedUser = (User) session.getAttribute("user");


    DAO daoObject = new DAO();

    if(subjectid <= 0 || replystring == null || replystring.length() == 0)
    {
        out.println("{status:\"ERROR\", message:\"Füllen Sie alle Informationen aus.\"}");
    }
    else
    {
        Posting newPosting = new Posting();
        newPosting.setMessage(replystring);
        newPosting.setSubjectId(subjectid);
        newPosting.setAuthorId(loggedUser);

        int newPostingId = daoObject.addNewPosting(posting);
        out.println("{\"status\": \"OK\", \"postingid\": " + newPostingId + "}");
    }
%>
