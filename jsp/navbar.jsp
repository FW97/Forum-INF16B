 <!--
   Assignment: 	Studentenforum
   Name: Eric Dussel, Hans Fuchs

   extended by Morten Terhart
 -->
<%@ page import="de.dhbw.StudentForum.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Hold the current login session (if existent)
    User loginSession = (User) session.getAttribute("user");

    // Load servlet and context path to build specific paths
    // for the index page and the jsp folder
    String servletPath = request.getServletPath();
    String contextPath = request.getContextPath();

    String indexPath = contextPath + "/index.jsp";
    String jspPath   = contextPath + "/jsp";
%>

<%-- Path Constants --%>
<c:set var="indexPath"    value="<%= indexPath    %>" />
<c:set var="jspPath"      value="<%= jspPath      %>" />
<c:set var="contextPath"  value="<%= contextPath  %>" />


<c:set var="loginSession" value="<%= loginSession %>" />
<nav>
<div class="header">
    <div class="left">
        <input type="search" placeholder="Forum durchsuchen"/>
        <input type="button" class="button-search" value="Suchen"/>
    </div>

    <%-- if user == admin, show 'add forum'-button --%>
    <c:if test="${loginSession != null && loginSession.getRole() == 2}">
        <div class="newForumButton">
            <a href="${jspPath}/newForum.jsp">
                <input type="button" value="Neues Forum erstellen"/>
            </a>
        </div>
    </c:if>

    <script>
    function loginAjax() {
        var xhr = new XMLHttpRequest();
        var curr_url = window.location.href;
        xhr.open("POST", "jsp/services/loginService.jsp", true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        var username = document.getElementById("username").value;                
        var password = document.getElementById("password").value;
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && this.status === 200) {
                var response = JSON.parse(xhr.responseText);
                var errorBox = document.getElementById("loginerrorbox");

                if (response.status === "Error") {
                    errorBox.innerHTML = response.message;
                    errorBox.style.display = "inline-block";
                } else if (response.status === "OK") {
                    errorBox.style.display = "none";
                }
            }
        };
        xhr.send("username=" + username + "&password=" + password);
    }

    function logoutAjax() {
        var xhr = new XMLHttpRequest;
        var curr_url = window.location.href;
        xhr.open("GET", "jsp/services/logoutService.jsp", true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && this.status === 200) {
                console.log("Logged out!");
            }
        };
        xhr.send();
    }
    </script>

    <div class="right">
        <c:if test="${loginSession == null}">
            <div id="loginform">
                <a href="${jspPath}/register.jsp">
                    Noch nicht registriert?</a>
                <form action="" method="post" onsubmit="loginAjax(); return false;">
                    <input type="text" name="username" id="username" placeholder="Benutzername"/>
                    <input type="password" name="password" id="password" placeholder="Passwort"/>
                    <input type="submit" value=" Login "/>
                </form>
                <div class="alert alert--error" id="loginerrorbox" style="display: none;"></div>
            </div>
        </c:if>

        <c:if test="${loginSession != null}">
            <div id="loggedin">
                <a href="${jspPath}/profil.jsp">
                    Hallo, ${loginSession.getFirstname()}
                    <i class="fa fa-user-circle-o" aria-hidden="true"></i>
                </a>
                <a href="${indexPath}" onclick="logoutAjax(); return false;">
                    Logout
                </a>
            </div>
        </c:if>
    </div>
</div>

<div class="navbar">
    <div class="left">
        <ul class="list">
            <li><a href="${contextPath}/index.jsp">Home</a></li>
            <li><a href="${jspPath}/search.jsp">Erweiterte Suche</a></li>
            <li><a href="${jspPath}/forumlist.jsp">Forenliste</a></li>
            <li><a href="${contextPath}/index.jsp">Neueste Beitr&auml;ge</a></li>
        </ul>
    </div>
</div>

<br/>

<div class="breadcrumbs">
    <div class="left">
      <ul class="list">
        <%  
            String[] a = request.getRequestURI().split("/");
            String[] b = a[1].split("\\.");
            String[] c = a[a.length-1].split("\\.");
        %>
        <li><a href="${contextPath}/index.jsp">
            <% out.println(b[0]); %>
        </a>
        </li>
        <%
            if(!(c[0].equals("index") && c[0].equals("forum"))) {
        %>
               <li><a href="${contextPath}/<%out.println(a[a.length-1]);%>">
               <% out.println(c[0]); %>
               </a>
               </li>
        <% } %>
      </ul>
    </div>
</div>
</nav>
