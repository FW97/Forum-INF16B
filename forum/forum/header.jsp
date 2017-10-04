 <!--
   Assignment: 	Studentenforum
   Name: Eric Dussel, Hans Fuchs
 -->

<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
   <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
   <link rel="stylesheet" type="text/css" href="css/forum.css">
</head>

<body>
  <nav>
    <div class="header">
      <div class="left">
        <input type="search" placeholder="Forum durchsuchen"/>
        <input type="button" class="button-search" value="Suchen"/>
      </div>
      <div class="right">
        <ul class="list">
          <li>
            <a href="profil.jsp">
              <span>Martin Schulz</span>
              <i class="fa fa-user-circle-o" aria-hidden="true"></i>
            </a>
          </li>
        </ul>
      </div>
    </div>

    <div class="navbar">
      <div class="left">
        <ul class="list">
          <li><a href="index.jsp">Home</a></li>
          <li><a href="search.jsp">Erweiterte Suche</a></li>
          <li><a href="forumlist.jsp">Forenliste</a></li>
          <li><a href="index.jsp">Neuste Beitr&auml;ge</a></li>
        </ul>
      </div>
    </div><br/>
     
    <div class="breadcrumbs">
      <div class="left">
        <ul class="list">
        <%String[] a=request.getRequestURI().split("/");%>
          <li><a href="<%out.println(a[1]);%>">
                <%String[] b=a[1].split("\\.");
                  out.println(b[0]);
                %></a></li>                 
          <li><a href="<%out.println(a[1]);%>/<%out.println(a[2]);%>">
                <%String[] c=a[2].split("\\.");
                  out.println(c[0]);
                %></a></li>
        </ul>
      </div>
    </div> 
  </nav>

