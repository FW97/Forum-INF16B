<jsp:include page="header.jsp" />

<!-- Gruppe: Laura Kaipl, Tobias Siebig, Lukas Beck -->
    <div id="register">
		<form action="services/registerService.jsp" method="POST">
			<h1>Registrierung</h1>

			<p>
				<label for="email">Email</label>
				<input type="email" name="email" id="email" placeholder="Email" required/>
			</p>
			<p>
				<label for="firstname">Vorname</label>
				<input type="text" name="firstname" id="firstname" placeholder="Vorname" required/>
			</p>
			<p>
				<label for="lastname">Nachname</label>
				<input type="text" name="lastname" id="lastname" placeholder="Nachname" required/>
			</p>
			<p>
				<label for="password1">Passwort</label>
				<input type="password" name="password1" id="password1" placeholder="Passwort" required/>
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
