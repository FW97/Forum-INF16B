<!--
Assignment: Studentenforum
Name: Jan Malchert, Bernhard Koll
-->
<%@ page import="de.dhbw.StudentForum.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // Posting posting = dao.getPosting(Integer.parseInt(request.getParameter("id")));
    String author = "John Doe"; // posting.getAuthor();
    Date date = GregorianCalendar.getInstance().getTime(); // posting.getWhenPosted();
    String text = "Test answer"; // posting.getMessage();
%>

<span class="author"><%=author%></span>
&bull;
<span class="date"><%=date%></span>
<p class="posting">
   <c:out value="${text}"/>
   <div class="attachment">
            <!-- temporary as placeholder-->
                <%--<c:forEach var="attachment" items="${posting.attachments}">
              <span>${attachment.attachmentFilename}</span>
              </c:forEach>-
              --%>
            <img src="https://d30y9cdsu7xlg0.cloudfront.net/png/101389-200.png" width="30" height="30">
    </div>
</p>
