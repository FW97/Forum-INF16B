<%@ page import = "java.util.GregorianCalendar, de.dhbw.StudentForum.Posting, de.dhbw.StudentForum.DAO " %>

<%
    // @author Bernhard Koll, Jan Malchert
    // Service to create a new posting

    int subjectid = Integer.parseInt(request.getParameter("subjectid"));
    String replystring = request.getParameter("replystring");

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

        int newPostingId = daoObject.addNewPosting(posting);
        out.println("{\"status\": \"OK\", \"postingid\": " + newPostingId + "}");
    }
%>
