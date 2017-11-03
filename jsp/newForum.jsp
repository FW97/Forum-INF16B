<!--  Author: INF16B Florian Schenk, Manuel Libal, Theresa Hillenbrand-->
<jsp:include page="header.jsp" />
<div class=createForum id=newForum>
            <form>
                <h1>Neues Forum erstellen</h1>
                <p>
                    <label for="name">Forumname</label>
                    <input type="text" id="forumname" placeholder="Forumname"/>
                </p>
                <p>
                    <label for="category">Forumkategorie</label>
                    <input type="text" id="category" placeholder="Forumkategorie"/>
                </p>
                <p>
                    <input class="button" type="submit" id="create" value="Erstellen" onclick="sendForum()">
                </p>
            </form>
</div>
<script>
function sendForum(){
	var newForumName = document.getElementById("forumname").value;
	var newForumKategorie = document.getElementById("category").value;
	var url = "services/newForumService.jsp?newForumName="+newForumName+"&newForumKategorie="+newForumKategorie;
	req = new XMLHttpRequest();			
	req.open("GET", url, true);
	req.onreadystatechange = function(){
		if(req.readyState == 4 && req.status == 200){
			if(JSON.parse(req.responseText).status == "OK"){
				document.getElementById("newForum").innerHTML = req.respoceText;
			}
		}
	}
	req.send(null);
}
</script>
<jsp:include page="footer.jsp" />
