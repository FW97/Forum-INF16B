<jsp:include page="header.jsp" />

<!-- Gruppe: Laura Kaipl, Tobias Siebig -->
    <div id="register">
		<form>
			<h1>Registrierung</h1>
			
			<!--
                <div id="accountinfodivleft">
                  <img id="profilepicture" src="http://mywindowshub.com/wp-content/uploads/2013/01/user-account.jpg" />
                  <input class="button" id="profilimage" type="file" value="Bild hinzufügen"/>
                  </div>
                <div id="accountinfodivright">
            -->			

			<p>
				<label for="email">Email</label>
				<input type="email" id="email" placeholder="Email" required/>
			</p>
			<p>
				<label for="firstname">Vorname</label>
				<input type="text" id="firstname" placeholder="Vorname" required/>
			</p>
			<p>
				<label for="lastname">Nachname</label>
				<input type="text" id="lastname" placeholder="Nachname" required/>
			</p>
			<p>
				<label for="password1">Passwort</label>
				<input type="password" id="password1" placeholder="Passwort" required/>
			</p>
			<p>
				<label for="password2">Passwort wiederholen</label>
				<input type="password" id="password2" placeholder="Passwort wiederholen" required/>
			</p>
              
            <script>
                var password1 = document.getElementById("password1"), password2 = document.getElementById("password2");
                function validatePassword(){
                    if(password1.value != password2.value) {
                        password2.setCustomValidity("Passwort stimmt nicht überein!");
                    } 
                    else 
                    {
                        password2.setCustomValidity('');
                    }
                }          
                password1.onchange = validatePassword;
                password2.onkeyup = validatePassword;
            </script>  
                
			<div  id="Nutzungsvereinbarungendiv">
				<form>
					<input name="rules" type="checkbox" required/> 
					<label id="Nutzungsvereinbarungenlabel">Ich akzeptiere die Nutzungsvereinbarungen.</label>
				</form>
			</div>
			<p>
				<input class="button" type="submit" id="submit" value="Account erstellen"/>
			</p>
		</form>
    </div>
      
<jsp:include page="footer.jsp" />
        

