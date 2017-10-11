<!DOCTYPE html>
<!-- @author Marco Dauber, Philipp Seitz, Morten Terhart
  -- * Displays a list of posts supplying certain filter criteria
  -- * received through a GET request from the URL
--> 

<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>


<%
	int postID;
	int forumID;
	int tagID;
	int userID;
	boolean latest;
	String searchTerm;
	Date minDate, maxDate;
	int maxPostings;
	String name = "Max Mustermann";
	Date date = GregorianCalendar.getInstance().getTime();
	String category = "Campus";
	String title = "Suche WG";
%>

<c:forEach items="<%=posts%>">
	<div class=post onClick="window.location='posting.jsp?postid=<%=postID%>'">
		<div class=profilbild>
			<img src="http://www.iconsdb.com/icons/preview/gray/user-xxl.png" height="60" width="60" >
		</div>
		<div>
			<span class=author> <%=name%> </span>	<span class=category><%=category%></span>
			<br> <span class="date"><%=date%></span>
			
			<h1><i><%=title%></i></h1>
			
			<%
				for(int i=0; i<hashtags.length; i++){ %>
					<span class=tagbox><%=hashtags[i]%></span>
				<%}
			%>
			
			<span class=answer> 200 Antworten </span>
		</div>
	</div>
</c:forEach>
