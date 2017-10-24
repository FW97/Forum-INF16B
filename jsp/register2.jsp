<html>
	<head>
		<title>Registrierung</title>
		<meta charset="UTF-8">
		<style>
			body {
				font-family: calibri;
				background: rgb(170,170,170);
			}
			form {
  				background: #fff;
				padding: 4em 4em 2em;
				max-width: 400px;
				margin: 50px auto 0;
				box-shadow: 0 0 1em #222;
				border-radius: 4px;
			}
			h1 {
    				margin:0 0 50px 0;
				padding:10px;
				text-align:center;
    				font-size:30px;
				color:darken(#e5e5e5, 50%);
				border-bottom:solid 1px #e5e5e5;
			}
  			p {
    				margin: 0 0 3em 0;
    				position: relative;
  			}
  			input, select {
    				display: block;
    				box-sizing: border-box;
    				width: 100%;
    				outline: none;
    				margin:0;
    				background: #fff;
    				border: 1px solid #dbdbdb;
    				font-size: 25px;
    				padding: .8em .5em;
    				border-radius: 4px;
  			}
			select:invalid {
				color: gray;
			}
			label{
				position: absolute;
				left: 8px;
				color: #999;
				display: inline-block;
				padding: 4px 10px;
				font-weight: 400;
				background-color: white;
				top: -11px;
				background-color: rgba(255,255,255,0.8);
				font-size: 14px;
			}
			.button {
				background: rgb(230,0,0);
				color: white;
				font-weight: 500;
				font-size: 25px;
				cursor: pointer;
				border-radius: 4px;
			}
		</style>
	</head>
	<body>
		<form>
			<h1>Registrierung</h1>
			<p>
				<label for="email">Email</label>
				<input type="text" id="email" placeholder="Email"/>
			</p>
			<p>
				<label for="username">Username</label>
				<input type="text" id="username" placeholder="Username"/>
			</p>
			<p>
				<label for="kurs">Kurs</label>
				<select name="kurs" required>
					<option disabled selected hidden>bitte w&auml;hlen...</option>
					<option value="INF16A">INF16A</option>
					<option value="INF16B">INF16B</option>
				</select>
			</p>
			<p>
				<label for="geburtsdatum">Geburtsdatum</label>
				<input type="date" id="geburtsdatum" placeholder="Geburtsdatum"/>
			</p>
			<p>
				<label for="password1">Passwort</label>
				<input type="password" id="password1" placeholder="Passwort"/>
			</p>
			<p>
				<label for="password2">Passwort wiederholen</label>
				<input type="password" id="password2" placeholder="Passwort wiederholen"/>
			</p>
			<p>
				<input class="button" type="submit" id="submit" value="Account erstellen">
		</form>
	</body>
</html>