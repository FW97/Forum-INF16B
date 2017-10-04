<!--
  Assignment: 	Studentenforum
  Name: Theresa Hillenbrand, Jan Malchert, Bernhard Koll 
-->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="header.jsp"/>

<div class="subject">
  <span class="forumCategory">${subject.forumCategory}</span>
  <h1>${subject.name}</h1>
  <span class="author">${subject.firstPosting.author}</span> &bull;
  <span class="date">${subject.firstPosting.whenPosted}</span>
  <p>
    <c:forEach var="tags" items="${subject.tags}"><span class="tag">#${tags.name}</span></c:forEach>
  </p>


  <c:forEach var="posting" items="${subject.postings}">
    <p class="posting">
      ${posting.text}
    </p>
    <div class="attachment">
      <c:forEach var="attachment" items="${posting.attachments}">
        <span>${attachment.attachmentFilename}</span>
      </c:forEach>
    </div>
  </c:forEach>

  <form action="reply" method="post">
    <textarea class="replybox" name="replybox" placeholder="Write your reply here"></textarea>
    <input type="hidden" value="${subject.id}" name="subject_id">
    <input type="submit" class="button" value="Reply">
  </form>


</div>
<jsp:include page="footer.jsp"/>
