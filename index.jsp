<!--author: Niklas Portmann-->
<jsp:include page="jsp/header.jsp" />

<%@ page import="de.dhbw.StudentForum.User" %>
<% User loginSession = (User) session.getAttribute("user"); %>

<h1>Angesagte Themen</h1>
<jsp:include page="jsp/postings.jsp?latest=true&maxpostings=8" />

<h1>Angesagte Foren</h1>
<!--dummy-->
<jsp:include page="jsp/top8d.jsp" />

<% if(loginSession != null) { %>
    <h1>Kommentare zu eigenen Postings</h1>
    <jsp:include page="jsp/postings.jsp?userid=<%= loginSession.getId() %>%maxpostings=8" />
<% } %>

<jsp:include page="jsp/footer.jsp" />
