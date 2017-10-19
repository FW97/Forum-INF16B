<!--  Author: INF16B Florian Schenk, Manuel Libal, Theresa Hillenbrand-->
<jsp:include page="header.jsp" />
<div class=createForum>
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
                    <input class="button" type="submit" id="create" value="Erstellen">
                </p>
            </form>
</div>
<jsp:include page="footer.jsp" />