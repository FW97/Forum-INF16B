<!--
  Assignment: 	Studentenforum
  Name: Felix Bertsch, Lukas Beck, Manuel Libal 
-->

<jsp:include page="header.jsp" />
<div class=search>
    <h1>Erweiterte Suche</h1>
    <form action="postings.jsp">
        <input name="searchterm" placeholder="Suchbegriff"><br>
        <input placeholder="Suche ab Zeitpunkt" type="text" onfocus="(this.type='date')" onblur="(this.type='text')" name="mindate">-<input placeholder="Suche bis Zeitpunkt" type="text" onfocus="(this.type='date')" onblur="(this.type='text')" name="maxdate"><br>
        <input type="checkbox" name="myposting" value="true">Von mir?<br>
        <input type="checkbox" name="latest" value="true">Neustes?<br>
        <input type=submit value="Forum durchsuchen">
    </form>
</div>
<jsp:include page="footer.jsp" />

