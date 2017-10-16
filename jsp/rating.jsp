<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%
// Authors: Alexander Memmel, Micha Spahr

// Check if user has already voted
//String postId = session.getAttribute("postId");
//String userId = session.getAttribute("userId"); 

//Dao d = new Dao();

//boolean hasRatedAlready = d.hasUserRated(userId, postId) ? true : false;

//Temp until Controller is finished
boolean hasRatedAlready = false;
session.setAttribute("hasRatedAlready", hasRatedAlready);

%>
<div id="ratings">
	<c:choose>
		<c:when test = "${hasRatedAlready}">
			<button name="thumbsUp" id="thumbsUp" disabled>+</button>
			<button name="thumbsDown" id="thumbsDown" disabled>-</button>
		</c:when>
		<c:otherwise>
		   <button name="thumbsUp" id="thumbsUp" onclick="sendRating(this)">+</button>
		   <button name="thumbsDown" id="thumbsDown" onclick="sendRating(this)">-</button>
		</c:otherwise>
	</c:choose> 
</div>
<script language="Javascript">
function sendRating(elem){

	var id = elem.id;
	var url = "/forum/rate?thumbs="+id;
	req = new XMLHttpRequest();			
	req.open("GET", url, true);
	req.onreadystatechange = function(){
		if(req.readyState == 4 && req.status == 200){
			if(JSON.parse(req.responseText).Status == "OK"){
				document.getElementById(id).style.height = "50px";
				document.getElementById(id).style.width = "50px";
				document.getElementById("ratings").style.pointerEvents = "none";
			}
		}
	}
	req.send(null);
}
</script>