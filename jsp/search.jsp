<!--
  Assignment: 	Studentenforum
  Name: Felix Bertsch, Lukas Beck, Manuel Libal 
-->

<jsp:include page="header.jsp" />
<div class=search>
    <h1>Erweiterte Suche</h1>
    <form action="postings.jsp">
        <input name=search placeholder="Suchbegriff"><br>
        <select name="forumid">
            <option value="" disabled selected>Forum</option>
            <option value="1">Mathematik</option>
            <option value="2">Informatik</option>
            <option value="3">Campus</option>
        </select><br>
        <select name="tagid">
            <option value="" disabled selected>Tag</option>
            <option value="1">Spass</option>
            <option value="2">Computer</option>
            <option value="3">Games</option>
            <option value="4">Freizeit</option>
        </select><br>
        <select name="userid">
            <option value="" disabled selected>Author</option>
            <option value="1">Felix Bertsch</option>
            <option value="2">Lukas Beck</option>
            <option value="3">Manuel Libal</option>
        </select><br>
        <input placeholder="Suche ab Zeitpunkt" type="text" onfocus="(this.type='date')" onblur="(this.type='text')" name=mindate>-<input placeholder="Suche bis Zeitpunkt" type="text" onfocus="(this.type='date')" onblur="(this.type='text')" name=maxdate><br>
        <input type="checkbox" name="myposting" value="1">Von mir?<br>
        <input type="checkbox" name="latest" value="1">Neustes?<br>
        <input type=submit value="Forum durchsuchen">
    </form>
</div>
<jsp:include page="footer.jsp" />
