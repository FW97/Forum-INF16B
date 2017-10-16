<!--  Assigned Team: Alexander Memmel, Micha Spahr  -->
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<jsp:include page="/rate?thumbs=getThumbs" />
<div class="ratings" id="ratings">
	<c:choose>
		<c:when test = "${hasRatedAlready}">
			<button class="ratingBtn" name="thumbsUp" id="thumbsUp" disabled>
				<i class="fa fa-thumbs-up" aria-hidden="true"></i>
				<span class="tUpCount" id="tUpCount"><c:out value = "${tUpCount}"/></span>
			</button>
			<button class="ratingBtn" name="thumbsDown" id="thumbsDown" disabled>
				<i class="fa fa-thumbs-down" aria-hidden="true"></i>
				<span class="tDownCount" id="tDownCount"><c:out value = "${tDownCount}"/></span>
			</button>
		</c:when>
		<c:otherwise>
			<button class="ratingBtn" name="thumbsUp" id="thumbsUp" onclick="sendRating(this)">
				<i class="fa fa-thumbs-up" aria-hidden="true"></i>
				<span class="tUpCount" id="tUpCount"><c:out value = "${tUpCount}"/></span>
			</button>
			<button class="ratingBtn" name="thumbsDown" id="thumbsDown" onclick="sendRating(this)">
				<i class="fa fa-thumbs-down" aria-hidden="true"></i>
				<span class="tDownCount" id="tDownCount"><c:out value = "${tDownCount}"/></span>
			</button>
		</c:otherwise>
	</c:choose> 
</div>
<script>
function sendRating(elem){

	var id = elem.id;
	var url = "/forum/rate?thumbs="+id;
	req = new XMLHttpRequest();			
	req.open("GET", url, true);
	req.onreadystatechange = function(){
		if(req.readyState == 4 && req.status == 200){
			if(JSON.parse(req.responseText).status == "OK" && JSON.parse(req.responseText).hasUserRated == "false"){
				
				document.getElementById("tUpCount").innerHTML = JSON.parse(req.responseText).tUpCount;
				document.getElementById("tDownCount").innerHTML = JSON.parse(req.responseText).tDownCount;
				document.getElementById("ratings").style.pointerEvents = "none";
				document.getElementById("thumbsDown").disabled = true;
				document.getElementById("thumbsUp").disabled = true;
			}
			else{
				document.getElementById("ratings").className = "alert alert--error";
				document.getElementById("ratings").innerHTML = "<p>Error: Adding your vote has failed!</p>";
			}
		}
	}
	req.send(null);
}
</script>