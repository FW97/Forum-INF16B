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

<body>
  <nav>
    <div class="header">
      <div class="left">
        <input type="search" placeholder="Forum durchsuchen"/>
        <input type="button" class="button-search" value="Suchen"/>
      </div>
      <%
        // if user == admin, show 'add forum'-button
        if((User) session.getAttribute("username") != null) {
          if(((User) session.getAttribute("username")).getRole() == 2) {
      %>
	    <div class="newForumButton">
        <ul class="list">
          <li>
            <a href="/jsp/newForum.jsp">
              <span>Neues Forum erstellen</span>
            </a>
          </li>
        </ul>
      </div>
      <% }} %>
      <div class="right">
        <ul class="list">
          <% 
            if(session.getAttribute("username") == null 
               || ((String) session.getAttribute("username")).isEmpty()) {
          %>
          <li id="loginform">
            <a href="/jsp/register.jsp">
              Noch nicht registriert?
            </a>
            <form action="services/loginService.jsp" method="post" onsubmit="return false;">
              <input type="text" name="username" id="username" placeholder="Benutzername"/>
              <input type="password" name="password" id="password" placeholder="Passwort"/>
              <input type="submit" value=" Login "/>
            </form>
            </li>
          <% } else { %>
          <li id="loggedin">
             <a href="/jsp/profil.jsp">
               <span>Hallo, <%=((User) session.getAttribute("username")).getFirstname() %></span>
               <i class="fa fa-user-circle-o" aria-hidden="true"></i>
             </a>
          </li>
          <% } %>
        </ul>
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
    </div><br/> 
   
    <div class="breadcrumbs">
      <div class="left">
        <ul class="list">
        <%String[] a=request.getRequestURI().split("/");%>
          <li><a href="/index.jsp">
                <%String[] b=a[1].split("\\.");
                  out.println(b[0]);%>
              </a>
	  </li>    
		<%String[] c=a[a.length-1].split("\\.");%>
		<%if(c[0].equals("index") || c[0].equals("forum")){}
		  else{%>
          <li><a href="/jsp/<%out.println(a[a.length-1]);%>">
                <%out.println(c[0]);%>
              </a>
	  </li><%}%>
        </ul>
      </div>
    </div>
  </nav>
</body>

