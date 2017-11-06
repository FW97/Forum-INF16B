<%@ page import = "de.dhbw.StudentForum.Posting, de.dhbw.StudentForum.DAO, de.dhbw.StudentForum.User" %>

<%
    // @author Bernhard Koll, Jan Malchert
    // Service to create a new posting

    int subjectid = Integer.parseInt(request.getParameter("subjectid"));
    String replystring = request.getParameter("replystring");
    User loggedUser = (User) session.getAttribute("user");

    DAO daoObject = new DAO();

    if(subjectid <= 0 || replystring == null || replystring.length() == 0)
    {
        out.println("{status:\"ERROR\", message:\"Füllen Sie alle Informationen aus.\"}");
    }
    else
    {
        Posting newPosting = new Posting(0);
        newPosting.setMessage(replystring);
        newPosting.setSubjectId(subjectid);
        newPosting.setUserId(loggedUser.getId());


        int newPostingId = daoObject.addNewPosting(newPosting);
        out.println("{\"status\": \"OK\", \"postingid\": " + newPostingId + "}");
    }
%>
