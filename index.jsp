<!--author: Niklas Portmann-->
<jsp:include page="jsp/header.jsp" />

<%@ page import="de.dhbw.StudentForum.User" %>
<% User loginSession = (User) session.getAttribute("user"); %>

<h1>Angesagte Themen</h1>
<jsp:include page="jsp/postings.jsp?latest=true&maxpostings=8" />

<h1>Angesagte Foren</h1>
<jsp:include page="jsp/postings.jsp?popular=true&maxpostings=8" />

<% if(loginSession != null) { %>
    <jsp:include page="jsp/postings.jsp?userid=<%= loginSession.getId() %>&maxpostings=8&displayheader=true" />
<% } %>

<jsp:include page="jsp/footer.jsp" />
