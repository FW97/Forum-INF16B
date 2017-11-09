<!--
  Assignment: 	Studentenforum
  Name: Felix Bertsch, Lukas Beck, Manuel Libal 
-->

<jsp:include page="header.jsp" />
<div class=search>
    <h1>Erweiterte Suche</h1>
    <form action="postings.jsp">
        <input name=search placeholder="Suchbegriff"><br>
        <input placeholder="Suche ab Zeitpunkt" type="text" onfocus="(this.type='date')" onblur="(this.type='text')" name="MIN_DATE_PARAMETER">-<input placeholder="Suche bis Zeitpunkt" type="text" onfocus="(this.type='date')" onblur="(this.type='text')" name="MAX_DATE_PARAMETER"><br>
        <input type="checkbox" name="myposting" value="1">Von mir?<br>
        <input type="checkbox" name="LATEST_PARAMETER" value="1">Neustes?<br>
        <input type=submit value="Forum durchsuchen">
    </form>
</div>
<jsp:include page="footer.jsp" />

