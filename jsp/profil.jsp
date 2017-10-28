<!--
  Authors: Michael Skrzypietz, Justus Grauel
-->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*,java.util.*, javax.servlet.*, de.dhbw.StudentForum.DAO, de.dhbw.StudentForum.PostingLink, de.dhbw.StudentForum.Posting, de.dhbw.StudentForum.User, de.dhbw.StudentForum.SettingErrors"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%!
  List<PostingLink> userPostings = new ArrayList<>();
%>

<%
  // profile settings dummy data
  if (session.getAttribute("user") == null) {
    User user = new User(1);
    user.setEmail("max.mustermann@gmail.com");
    user.setFirstname("Max");
    user.setLastname("Mustermann");
    user.setImgUrl("/img/profilImages/standardPic.png");
    session.setAttribute("user", user);
  }

  // posts dummy data
  userPostings.clear();
  PostingLink testPostingLink = new PostingLink();
  testPostingLink.setPostingId(0);
  testPostingLink.setForumName("Campus");
  testPostingLink.setSubjectName("Brauche Hilfe bei Doppelintegralen in Mathe");
  String[] tags = new String[]{"Hilfe", "Wohnung"};
  testPostingLink.setTags(tags);
  testPostingLink.setAuthorName("Max Musterman");
  testPostingLink.setWhenPosted("12 Sep 2017");
  testPostingLink.setResponses(10);
  userPostings.add(testPostingLink);
%>

<%
/*
  User user = (User) session.getAttribute("user");
  ArrayList<Subject> subjectsOfCurrentUser = DAO.getSubjectsByUser(user.getId());
  for (subject : subjectsOfCurrentUser) {
    PostingLink postingLink = new PostingLink();
    Posting posting = new Posting(subject.getAuthorPostingId());
    postingLink.setPostingId(posting.getId());
    postingLink.setForumName(DAO.getForumNameById(posting.getForumId()));
    postingLink.setSubjectName(subject.getName());
    postingLink.setTags(posting.getTags());
    User author = (User) DAO.getUserById(posting.getId());
    postingLink.setAuthorName(author.getFirstname() + " " + author.getLastname());
    postingLink.setWhenPosted(posting.getWhenPosted());
    postingLink.setResponses(DAO.getNumberOfResponsesOfSubject(subject.getId()));
    userPostings.add(postingLink);
  }
  */
%>

<jsp:include page="header.jsp" />

  <div class="profil">
    <h1>Profileinstellungen</h1>
    
    <form method="post" action="/ProfilServlet" enctype="multipart/form-data">
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

    <h1>Eigene Beiträge</h1>

    <div class="postings">
      <c:forEach items="<%= userPostings %>" var="currentPosting">
        <a href="posting.jsp?postid=${currentPosting.getPostingId()}">
          <div class="post">
            <!-- <span class="category">${currentPosting.getForumName()} &gt; ${currentPosting.getSubjectName()}</span> -->
            <span class="category">${currentPosting.getForumName()}</span>
            <h1>${currentPosting.getSubjectName()}</h1>   
            <span class="tagbox">
              <c:forEach items="${currentPosting.getTags()}" var="tag">
                <span class="tag">${tag}</span> 
              </c:forEach>
            </span>
            <span class="author">
              ${currentPosting.getAuthorName()} 
              &bull; 
              ${currentPosting.getWhenPosted()} 
              &bull; 
              <c:if test="${currentPosting.getResponses() == 0}">
                Keine Antworten
              </c:if>
              <c:if test="${currentPosting.getResponses() == 1}">
                1 Antwort
              </c:if>
              <c:if test="${currentPosting.getResponses() > 1}">
                ${currentPosting.getResponses()} Antworten
              </c:if>
            </span>
          </div>
        </a>
      </c:forEach>
    </div>
  </div>
<jsp:include page="footer.jsp" />