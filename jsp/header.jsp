 <!--
   Assignment: 	Studentenforum
   Name: Eric Dussel, Hans Fuchs
 -->
<%@ page import="de.dhbw.StudentForum.User" %>

<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
   <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
   <link rel="stylesheet" type="text/css" href="/css/forum.css">
</head>

<%
    // Hold the current login session (if existent)
    User loginSession = (User) session.getAttribute("username");
%>

<body>
  <nav>
    <div class="header">
      <div class="left">
        <input type="search" placeholder="Forum durchsuchen"/>
        <input type="button" class="button-search" value="Suchen"/>
      </div>

      <%
        // if user == admin, show 'add forum'-button
        if(loginSession != null) {
          if(loginSession.getRole() == 2) {
      %>
	      <div class="newForumButton">
          <input type="button" onclick="window.location.replace('/jsp/newForum.jsp');" 
                 value="Neues Forum erstellen"/>
        </div>
      <% }} %>

      <div class="right">
        <% 
          if(loginSession == null) {
        %>
          <div id="loginform">
            <a href="/jsp/register.jsp">
              Noch nicht registriert?
            </a>
            <form action="services/loginService.jsp" method="post" onsubmit="return false;">
              <input type="text" name="username" id="username" placeholder="Benutzername"/>
              <input type="password" name="password" id="password" placeholder="Passwort"/>
              <input type="submit" value=" Login "/>
            </form>
          </div>
        <% } else { %>
          <div id="loggedin">
            <a href="/jsp/profil.jsp">
              Hallo, <%=loginSession.getFirstname() %>
              <i class="fa fa-user-circle-o" aria-hidden="true"></i>
            </a>
          </div>
        <% } %>
      </div>
    </div>

    <div class="navbar">
      <div class="left">
        <ul class="list">
          <li><a href="/index.jsp">Home</a></li>
          <li><a href="/jsp/search.jsp">Erweiterte Suche</a></li>
          <li><a href="/jsp/forumlist.jsp">Forenliste</a></li>
          <li><a href="/index.jsp">Neueste Beitr&auml;ge</a></li>
        </ul>
      </div>
    </div>
    
    <br/> 
   
    <div class="breadcrumbs">
      <div class="left">
        <% 
          String[] a = request.getRequestURI().split("/");
          String[] b = a[1].split("\\.");
          String[] c = a[a.length-1].split("\\.");
        %>
        <a href="/index.jsp">
          <% out.println(b[0]); %>
        </a>
		    <%
          if(!(c[0].equals("index")) || !(c[0].equals("forum"))) {
        %>
          <a href="/jsp/<%out.println(a[a.length-1]);%>">
            <% out.println(c[0]); %>
          </a>
        <% } %>
      </div>
    </div>
  </nav>
</body>

