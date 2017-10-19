<!--
  Authors: Michael Skrzypietz, Justus Grauel
  
  TODO: User importieren, dann kann man die auskommentierten Testdaten wieder einfügen
-->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*, de.dhbw.StudentForum.User"%>

<%
	User user = new User(1);
	user.setEmail("max.mustermann@gmail.com");
	user.setFirstname("Max");
	user.setLastname("Mustermann");
	user.setImgUrl("http://via.placeholder.com/150x150");
	session.setAttribute("user", user);
%>

<jsp:include page="header.jsp" />


  <div class="profil">
    <h1>Profileinstellungen</h1>
    
    <form method="post" action="ProfilServlet" enctype="multipart/form-data">
      <div class="settingBox">
        <div class="setting">
          <div class="settingLabel settingSpacing">
            <label>E-Mail</label>
          </div>
          <div class="settingContent settingSpacing">
            <input type="text" name="email" value="${user.email}" />
          </div>
        </div> 

        <div class="setting">
          <div class="settingLabel settingSpacing">
            <label>Vorname</label>
          </div>
          <div class="settingContent settingSpacing">
            <input type="text" name="firstName" value="${user.firstname}" />
          </div>
        </div>
  
        <div class="setting">
          <div class="settingLabel">
            <label>Nachname</label>
            </div>
          <div class="settingContent">
            <input type="text" name="lastName" value="${user.lastname}" />
          </div>
        </div>
      </div>

      <div class="settingBox">
        <div class="setting">
          <div class="settingLabel">
            <label>Profilbild</label>
          </div>
          <div class="settingContent"> 
            <img src="${user.imgUrl}">
            <input type="file" name="file" id="uploadImage" value="Datei ausw&auml;hlen">
          </div>
        </div>
      </div>

      <div class="settingBox">
        <div class="setting">
          <div class="settingLabel settingSpacing">
            <label>Altes Passwort</label>
          </div>
          <div class="settingContent settingSpacing">
            <input type="password" name="currentPassword"></input>
          </div>
        </div>

        <div class="setting">
          <div class="settingLabel settingSpacing">
            <label>Neues Passwort</label>
          </div>
          <div class="settingContent settingSpacing">
            <input type="password" name="newPassword"></input>
          </div>
        </div>

        <div class="setting">
          <div class="settingLabel">
            <label>Neues Passwort best&auml;tigen</label>
          </div>
          <div class="settingContent">
            <input type="password" name="newPassword2"></input>
          </div>
        </div>
      </div>
      <br>
      <input type="submit" href="index.jsp" value="&Auml;nderungen speichern">
    </form>
  </div>
<jsp:include page="footer.jsp" />