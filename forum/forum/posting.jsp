<!--
Assignment: Studentenforum
Name: Theresa Hillenbrand, Jan Malchert, Bernhard Koll
-->

<%@ page import="java.util.GregorianCalendar" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String forum = "Informatik";
    String subjectTitle = "INF16A: Brauche   hilfe bei Hausaufgaben";
    Date date = GregorianCalendar.getInstance().getTime();
    String postings[] = {"Actually im new to angular JS. We started to learn angular 4 but there are no much tutorials on angular 4. If it is fine to learn Angular 2 for Angular 4, Hope there was no much differences between 2 and 4.\n" +
            "\n" +
            "Can any one provide link of angular 4 and what are the major changes between them.\n" +
            "\n", "There is nothing path breaking between angular 2 and angular 4 like angular 1 and angular 2. They are just doing it to maintain SEMVER(Sementic Versioning). Angular 2 is stable now so it would be better to prefer angular 2 instead of angular 4.\n" +
            "\n" +
            "Angular 2 was a complete rewrite of AngularJS 1.x with many new concepts. Angular 4 however is the next version of Angular 2. The underlying concepts are still the same and if you have already learned Angular 2 you’re well prepared to switch to Angular 4 now.\n" +
            "\n" +
            "The reason it’s Angular 4 and not Angular 3 is that the Angular Router package has already been in version 3 before. The Angular team would like to avoid confusion and decided to skip version 3 for Angular and continue with Version 4."};
    String tags[] = {"Angular", "Controller", "Material Design"};
    String author[] = {"Ike Broflovski", "Homer Nukular Simpson"};
    int i = 0;
%>

<script>
function sendReply() { // per AJAX oder über Form?
  var replyText = document.forms.namedItem("reply-form")["replybox"].value;
  var xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
     document.getElementById("reply-form").insertAdjacentHTML("beforebegin", this.responseText);
    }
  };
  xhr.open("POST", "posting-reply.jsp", true);
  xhr.send(replyText);
}
</script>

<jsp:include page="header.jsp"/>

<div class="subject">
    <span class="forumCategory"><%=forum%></span>
    <h1><%=subjectTitle%>
    </h1>
    <p>
        <c:forEach var="tag" items="<%=tags%>"><span class="tag"><c:out value="${tag}"/></span></c:forEach>
    </p>

    <c:forEach items="<%=postings%>" var="posting" varStatus="loop">

        <%-- <span class="author">${author[loop.index]}</span> &bull;--%>
        <span class="author"><%=author[i]%><% i++;%></span> &bull;
        <span class="date"><%=date%></span>
        <p class="posting">
                <c:out value="${posting}"/>
        <div class="attachment">
            <!-- temporary as placeholder-->
                <%--<c:forEach var="attachment" items="${posting.attachments}">
              <span>${attachment.attachmentFilename}</span>
              </c:forEach>-
              --%>
            <img src="https://d30y9cdsu7xlg0.cloudfront.net/png/101389-200.png" width="30" height="30">
        </div>
        </p>
    </c:forEach>


    <form action="reply" method="post" id="reply-form">
        <textarea class="replybox" name="replybox" placeholder="Write your reply here"></textarea>
        <input type="hidden" value="${subject.id}" name="subject_id">
        <input onclick="sendReply()" class="button" value="Reply">
    </form>


</div>
<jsp:include page="footer.jsp"/>
