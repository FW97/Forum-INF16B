<!--author: Niklas Portmann-->
<jsp:include page="jsp/header.jsp" />

<h1>Angesagte Themen</h1>
<!--dummy-->
<c:set var="latest" value="true" scope="request"/>
<jsp:include page="jsp/posting.jsp"/>

<h1>Angesagte Foren</h1>
<!--dummy-->
<jsp:include page="jsp/top8d.jsp" />

<h1>Kommentare zu eigenen Postings</h1>
<!--dummy-->
<jsp:include page="jsp/top8d.jsp" />

<jsp:include page="jsp/footer.jsp" />
