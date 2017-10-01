<jsp:include page="header.jsp" />
<style>
	 div {
	  display: block;
	}

	.outerBox > button {
	  margin-top: 1rem;
	  background-color: #4CAF50;
	  border: none;
	  color: white;
	  padding: 1rem 2rem;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  font-size: 1rem;
	}


</style>

  <div class="profil">
    <H1>Profileinstellungen</H1>
    <div class="settingBox">
      <div class="setting">
        <div class="settingLabel settingSpacing">
          <label>E-Mail</label>
        </div>
        <div class="settingContent settingSpacing">
          <input type="text"></input>
        </div>
      </div>

      <div class="setting">
        <div class="settingLabel settingSpacing">
          <label>Vorname</label>
          </div>
        <div class="settingContent settingSpacing">
          <input type="text"></input>
        </div>
      </div>
  
      <div class="setting">
        <div class="settingLabel">
          <label>Nachname</label>
          </div>
        <div class="settingContent">
          <input type="text"></input>
        </div>
      </div>
    </div>

    <div class="settingBox">
      <div class="setting">
        <div class="settingLabel">
          <label>Profilbild</label>
        </div>
        <div class="settingContent">
          <a href="https://placeholder.com"><img src="http://via.placeholder.com/150x150"></a>
          <button id="uploadImage" type="button">Datei auswählen</button>
        </div>
      </div>
    </div>

    <div class="settingBox">
      <div class="setting">
        <div class="settingLabel settingSpacing">
          <label>Altes Passwort</label>
        </div>
        <div class="settingContent settingSpacing">
          <input type="text"></input>
        </div>
      </div>

      <div class="setting">
        <div class="settingLabel settingSpacing">
          <label>Neues Passwort</label>
        </div>
        <div class="settingContent settingSpacing">
          <input type="text"></input>
        </div>
      </div>

      <div class="setting">
        <div class="settingLabel">
          <label>Neues Passwort bestätigen</label>
        </div>
        <div class="settingContent">
          <input type="text"></input>
        </div>
      </div>
    </div>

    <a class=button href="index.jsp">Änderungen speichern</a>
    
  </div>
<jsp:include page="footer.jsp" />
