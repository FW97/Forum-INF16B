<!--
Assignment: Studentenforum
Name: Theresa Hillenbrand, Jan Malchert, Bernhard Koll
-->
<%@ page import="java.util.GregorianCalendar, java.util.Date, de.dhbw.StudentForum.*" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%

    DAO daoObject = new DAO();
    int subjectid = 0;
    try {
        subjectid = Integer.parseInt(request.getParameter("id"));
    }
    catch(Exception e) {}

    Subject subject = daoObject.getSubjectById(subjectid);
    List<Posting> subjectPostings = daoObject.getPostingsBySubject(subject.getId());

%>

<jsp:include page="header.jsp"/>

<c:if test="${subjectid>0}">
<div class="subject">
    <h1><%= subject.getName() %>
    </h1>
    <c:forEach items="${subjectPostings}" var="posting">
    <c:set var="author" value="${daoObject.getUserById(posting.getUserId())}" />
    <span class="author">${author.getFirstname()} ${author.getLastname()}</span> &bull;
	<span class="date"><c:out value="${posting.getWhenPosted()}" /></span>
        <p class="posting">
			<c:out value="${posting.message}"/>
		<div class="attachment">
		    <!-- temporary as placeholder-->
			<%--<c:forEach var="attachment" items="${posting.attachments}">
			  <c:if test="${attachment.postingid == posting.id}"><a href=""><span>${attachment.attachmentFilename}</span></a></c:if>
			  </c:forEach>
			--%>
		    <img src="https://d30y9cdsu7xlg0.cloudfront.net/png/101389-200.png" width="30" height="30">
		</div>
		<p>
		    <c:forEach var="tag" items="${posting.getTags()}">
			<a class="tag" href="posting.jsp"><c:out value="${tag}"/></a>
		    </c:forEach>
		</p>
        </p>
    </c:forEach>


    <form id="reply-form">
        <textarea class="replybox" name="replybox" placeholder="Write your reply here"></textarea>
        <input type="hidden" value="${subject.id}" name="subject_id">
        <button onclick="sendReply()" class="button">Reply</button>
    </form>


</div>
</c:if>
<c:if test="${subjectid<=0}"><div class='errorbox'>Fehler beim Laden</div></c:if>

<jsp:include page="footer.jsp"/>

<script>
    function loadDiv(postingid) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            var html;

            if (this.readyState == 4 && this.status == 200) {
                html = this.responseText;
            } else if (this.readyState == 4 && this.status != 200) {
                html = "<div class='errorbox'>Fehler beim Laden des neues Postings.</div>";
            }

            document.getElementById("reply-form").insertAdjacentHTML("beforebegin", html);
        };
        xhr.open("POST", "postingdiv.jsp", false);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.send("postingid=" + postingid);
    }

    function sendReply() {
        var replyText = document.forms.namedItem("reply-form")["replybox"].value;
        var subjectid = document.forms.namedItem("reply-form")["subject_id"].value;

        if (replyText.length == 0) return;

        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                var response = JSON.parse(this.responseText);

                if (response["status"] == "Ok") {
                    /* Falls die Response nicht die ID des angelegten Posting zurückgeben wird/kann/darf,
                     * muss das zu ladene Posting auf andere Art ermittelt werden.
                     * Evtl. serverseitig das neueste Posting ermitteln und hierfür den div zurückliefern.
                     */
                    loadDiv(response["postingid"]);
                } else {
                    var html = "<div class='errorbox'>" + response["message"] + "</div>";
                    document.getElementById("reply-form").insertAdjacentHTML("beforebegin", html);
                }
            }
        };
        xhr.open("POST", "services/newPostService.jsp", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.send("subjectid=" + subjectid + "&replystring=" + replyText);
    }
</script>
