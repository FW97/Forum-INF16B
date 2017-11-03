<!--author: Niklas Portmann-->
<jsp:include page="jsp/header.jsp" />

<%@ page import="de.dhbw.StudentForum.User" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<% User loginSession = (User) session.getAttribute("user"); %>

<h1>Angesagte Themen</h1>
<jsp:include page="jsp/postings.jsp?latest=true&maxpostings=8&addjsppath=true" />

<h1>Angesagte Foren</h1>
<jsp:include page="jsp/postings.jsp?popular=true&maxpostings=8&addjsppath=true" />

<c:if test="${loginSession != null}">
    <jsp:include page="jsp/postings.jsp?userid=${loginSession.getId()}&maxpostings=8&displayheader=true&addjsppath=true" />
</c:if>

<jsp:include page="jsp/footer.jsp" />
