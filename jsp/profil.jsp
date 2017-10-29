<!--
  Authors: Michael Skrzypietz, Justus Grauel
-->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*,java.util.*, javax.servlet.*, de.dhbw.StudentForum.Hashing, de.dhbw.StudentForum.DAO, de.dhbw.StudentForum.User, de.dhbw.StudentForum.SettingErrors"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="header.jsp" />

  <div class="profil">
    <h1>Profileinstellungen</h1>
  
    <form method="post" action="../ProfilServlet" enctype="multipart/form-data">
      <div class="settingBox clearTopPadding">
        <div class="setting">
          <div class="settingLabel settingSpacing">
            <label>E-Mail</label>
          </div>
          <div class="settingContent settingSpacing">
            <input type="text" name="email" value="${user.email}" /> 
            <br>
            <div class="settingError">
              <c:if test = "${settingErrors.email.length() > 0}">
                <c:out value="${settingErrors.email}"></c:out>
              </c:if>
            </div>
          </div>
        </div> 
        
        <div class="setting">
          <div class="settingLabel settingSpacing">
            <label>Vorname</label>
          </div>
          <div class="settingContent settingSpacing">
            <input type="text" name="firstName" value="${user.firstname}" />
            <br>
            <div class="settingError">
              <c:if test = "${settingErrors.firstName.length() > 0}">
                <c:out value="${settingErrors.firstName}"></c:out>
              </c:if>
            </div>
          </div>
        </div>

        <div class="setting">
          <div class="settingLabel">
            <label>Nachname</label>
            </div>
          <div class="settingContent">
            <input type="text" name="lastName" value="${user.lastname}" />
            <br>
            <div class="settingError">
              <c:if test = "${settingErrors.lastName.length() > 0}">
                <c:out value="${settingErrors.lastName}"></c:out>
              </c:if>
            </div>
          </div>
        </div>
      </div>

      <div class="settingBox">
        <div class="setting">
          <div class="settingLabel">
            <label>Profilbild</label>
          </div>
          <div class="settingContent"> 
            <img class="centered-and-cropped" src="<c:url value="${user.imgUrl}"/>" alt="Profil Image"  height="150" width="150">
            <br>
            <input type="file" name="file" id="uploadImage" value="Datei ausw&auml;hlen">
            <br>
            <div class="settingError">
              <c:if test = "${settingErrors.profilImage.length() > 0}">
                <c:out value="${settingErrors.profilImage}"></c:out>
              </c:if>
            </div>
          </div>
        </div>
      </div>

      <div class="settingBox">
        <div class="setting">
          <div class="settingLabel settingSpacing">
            <label>Altes Passwort</label>
          </div>
          <div class="settingContent settingSpacing">
            <input type="password" name="currentPassword" />
          </div>
        </div>

        <div class="setting">
          <div class="settingLabel settingSpacing">
            <label>Neues Passwort</label>
          </div>
          <div class="settingContent settingSpacing">
            <input type="password" name="newPassword" />
          </div>
        </div>

        <div class="setting">
          <div class="settingLabel">
            <label>Neues Passwort best&auml;tigen</label>
          </div>
          <div class="settingContent">
            <input type="password" name="newPassword2" />
            <br>
            <div class="settingError">
              <c:if test = "${settingErrors.password.length() > 0}">
                <c:out value="${settingErrors.password}"></c:out>
              </c:if>
            </div>
          </div>
        </div>
      </div>
      <br>
      <input type="submit" value="&Auml;nderungen speichern">
    </form>
    <br>

    <c:if test="${settingSuccess == true}">
      <div id="successAlert" class="success-alert alert alert--confirm elementToFadeInAndOut">
        &Auml;nderungen wurden erfoglreich gespeichert.
      </div>
      <script type="text/javascript">
        setTimeout(function() {
          var alert = document.getElementById('successAlert');
          alert.style.display = "none";
        }, 5000);
      </script>
      <%
        session.setAttribute("settingSuccess", false);
      %>
    </c:if>
  
    <!--
    <h1>Eigene Beiträge</h1>
    -->
  </div>
<jsp:include page="footer.jsp" />
