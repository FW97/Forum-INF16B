<!--
@author Bernhard Koll, Jan Malchert
Service to create a new posting
-->

<%@ page import = "java.util.GregorianCalendar, de.dhbw.StudentForum.Posting, de.dhbw.StudentForum.DAO " %>

<%	int subjectid = Integer.parseInt(request.getParameter("subjectid"));
    String replystring = request.getParameter("replystring");
    int id = 0;

    DAO daoObject = new DAO();

    if(subjectid <= 0 || replystring == null || replystring.length() == 0)
    {
        out.println("{status:\"ERROR\", message:\"Füllen Sie alle Informationen aus.\"}");
    }
    else
    {
        Posting newPosting = new Posting();
        newPosting.setMessage(replystring);
        newPosting.setwhenDeleted(null);
        newPosting.setwhenPosted(GregorianCalendar.getInstance().getTime());
        newPosting.setSubjectId(subjectid);
        newPosting.setPosRat(0);
        newPosting.setNegRat(0);

        int newPostingId = daoObject.addNewPosting(posting);
        out.println("{\"status\": \"OK\", \"postingid\": " + newPostingId + "}");
    }
%>
