<!--
Assignment: Studentenforum
Name: Theresa Hillenbrand, Jan Malchert, Bernhard Koll
-->
<%@ page import="java.util.GregorianCalendar, java.util.Date, de.dhbw.StudentForum.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%

    DAO daoObject = new DAO();
    List<Posting> subjectPostings  = new ArrayList();
    List<User> authors = new ArrayList();
    DateFormat formatter = new SimpleDateFormat("dd. MMMM, HH:mm 'Uhr'");

    int subjectid = 0;
    int author_id = 0;
    int i = 0 ;

    try {
        subjectid = Integer.parseInt(request.getParameter("id"));
    }
    catch(Exception e) {}

    Subject subject = daoObject.getSubjectById(subjectid);

    if (subject!=null) {
        subjectPostings = daoObject.getPostingsBySubject(subject.getId());
    }
    for(Posting p : subjectPostings) {
        authors.add(daoObject.getUserById(p.getUserId()));
    }
%>

<jsp:include page="header.jsp"/>

<c:set var="subjectPostings" value="<%= subjectPostings %>" />
<c:set var="subjectid" value="<%=subjectid%>"/>
<c:set var="subject" value="<%=subject%>"/>
<c:set var="formatter" value="<%=formatter%>"/>


<c:if test="${subject != null}">
<div class="subject">
    <h1><%= subject.getName() %>
    </h1>

    <c:set var="subjectid" value="<%=subjectid%>"/>
    <c:forEach items="${subjectPostings}" var="posting">
    <c:set var="author_id" value="${authors.get(i)}%>" />
    <span class="author"><c:out value="<%=authors.get(i).getFirstname()%>" /> <c:out value="<%=authors.get(i).getLastname()%>" /></span> &bull;
	<span class="date"><c:out value="${formatter.format(posting.getWhenPosted())}" /></span>
        <p class="posting">
		<c:out value="${posting.getMessage()}"/>
		<div class="attachment">
			<c:forEach var="attachment" items="${dao.getAttachmentsByPostingId(posting.getId())}">	
			  <a href="<c:url value="/attachment/${attachment.getAttachmentFilename()}"/>"/>
				  <img src="https://d30y9cdsu7xlg0.cloudfront.net/png/101389-200.png" width="30" height="30">
				  <span>${attachment.getAttachmentFilename()}</span>
			  </a>
			</c:forEach>		    
		</div>
		<p>
		    <c:forEach var="tag" items="${posting.getTags()}">
			<a class="tag" href="jsp/posting.jsp"><c:out value="${tag}"/></a>
		    </c:forEach>
		</p>
        </p>
        <% i++;%>
    </c:forEach>
</div>
</c:if>

<c:if test="${subjectid<=0 || subject == null}"><div class='errorbox'>Fehler beim Laden</div></c:if>
    <form id="reply-form">
        <textarea class="replybox" name="replybox" placeholder="Write your reply here"></textarea>
        <input type="hidden" value="${subject.id}" name="subject_id">
        <a onclick="sendReply()" class="button-link">Reply</a>
    </form>
</div>




<jsp:include page="footer.jsp"/>

<script>
    function loadDiv(postingid) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {

            if (this.readyState == 4) {
                var html = "";
                if (this.status == 200) {
                    html = this.responseText;
                } else {
                    html = "<div class='errorbox'>Fehler beim Laden des neues Postings.</div>";
                }

                document.getElementById("reply-form").insertAdjacentHTML("beforebegin", html);
            }
        };
        xhr.open("POST", "postingdiv.jsp", true);
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
                if (response["status"] == "OK") {
                    /* Falls die Response nicht die ID des angelegten Posting zurückgeben wird/kann/darf,
                     * muss das zu ladene Posting auf andere Art ermittelt werden.
                     * Evtl. serverseitig das neueste Posting ermitteln und hierfür den div zurückliefern.
                     */
                    // wenn erfolgreich, wird input-Feld gecleared
                    document.forms.namedItem("reply-form")["replybox"].value = "";
                    loadDiv(response["postingid"]);
                }
            }
        };

        xhr.open("POST", "services/newPostingService.jsp", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.send("subjectid=" + subjectid + "&replystring=" + replyText);
    }
</script>
