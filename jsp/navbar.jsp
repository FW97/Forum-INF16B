 <!--
   Assignment: 	Studentenforum
   Name: Eric Dussel, Hans Fuchs
 -->
<%@ page import="de.dhbw.StudentForum.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // Hold the current login session (if existent)
    User loginSession = (User) session.getAttribute("user");
%>
<nav>
<div class="header">
    <div class="left">
        <input type="search" placeholder="Forum durchsuchen"/>
        <input type="button" class="button-search" value="Suchen"/>
    </div>

    <%-- if user == admin, show 'add forum'-button --%>
    <c:if test="${loginSession != null && loginSession.getRole() == 2}">
        <div class="newForumButton">
            <input type="button" onclick="window.location.replace('newForum.jsp');"
                   value="Neues Forum erstellen"/>
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
                <a href="jsp/register.jsp">
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
                <a href="jsp/profil.jsp">
                    Hallo, ${loginSession.getFirstname()}
                    <i class="fa fa-user-circle-o" aria-hidden="true"></i>
                </a>
                <a href="#" onclick="logoutAjax(); return false;">
                    Logout
                </a>
            </div>
        </c:if>
    </div>
</div>

<div class="navbar">
    <div class="left">
        <ul class="list">
            <li><a href="../index.jsp">Home</a></li>
            <li><a href="search.jsp">Erweiterte Suche</a></li>
            <li><a href="forumlist.jsp">Forenliste</a></li>
            <li><a href="../index.jsp">Neueste Beitr&auml;ge</a></li>
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
        <a href="../index.jsp">
            <% out.println(b[0]); %>
        </a>
        <%
            if(!(c[0].equals("index")) || !(c[0].equals("forum"))) {
        %>
               <a href="<%out.println(a[a.length-1]);%>">
               <% out.println(c[0]); %>
               </a>
        <% } %>
    </div>
</div>
</nav>
