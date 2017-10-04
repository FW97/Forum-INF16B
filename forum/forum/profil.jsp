<jsp:include page="header.jsp" />

  <div class="profil">
    <h1>Profileinstellungen</h1>
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
          <input type="button" id="uploadImage" value="Datei ausw&auml;hlen">
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
          <label>Neues Passwort best&auml;tigen</label>
        </div>
        <div class="settingContent">
          <input type="text"></input>
        </div>
      </div>
    </div>
    <br>
    <input type="button" href="index.jsp" value="&Auml;nderungen speichern">
    
  </div>
<jsp:include page="footer.jsp" />
