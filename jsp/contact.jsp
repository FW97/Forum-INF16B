<!--  INF16B Maximilian Gerlach, Florian Schenk:added Header,Footer and Tags for CSS Styling
    +++
    updated Contact Form 19.10.17
    JSP + Java Class for Email Sender
    +++
-->
<jsp:include page="header.jsp" />

<%@ page import="de.dhbw.StudentForum.Contact"%>
<%@ page import="javax.mail.MessagingException;"%>
<%
	String message = null;
	String status = null;
	if (request.getParameter("submit") != null) {
		JavaEmail javaEmail = new JavaEmail();
		javaEmail.setMailServerProperties();
		String emailSubject = "Kontakt Formular Anfrage";
		String emailBody = "";
		if (request.getParameter("name") != null) {
			emailBody = "Absender Name: " + request.getParameter("name")
					+ "<br>";
		}
		if (request.getParameter("email") != null) {
			emailBody = emailBody + "Absender Email: "
					+ request.getParameter("email") + "<br>";
		}
		if (request.getParameter("message") != null) {
			emailBody = emailBody + "Nachricht: " + request.getParameter("message")
					+ "<br>";
		}
		javaEmail.createEmailMessage(emailSubject, emailBody);
		try {
			javaEmail.sendEmail();
			status = "Erfolg";
			message = "Email wurde erfolgreich gesendet!";
		} catch (MessagingException me) {
			status = "Fehler";
			message = "Fehler beim Senden der Mail!";
		}
	}
%>

<div class=contact>
        <form id="frmContact" name="frmContact" action="" method="POST" novalidate="novalidate">
            <h1>Kontakt aufnehmen</h1>
                <p>
                    <label for="vorname">Name</label>
                    <input type="text" id="name" name="name" placeholder="Ihr Name"/>
                </p>            
                <p>
                    <label for="email">Email</label>
                    <input type="text" id="email" name="email" placeholder="Email"/>
                </p>
                <p>
                    <label for="message">Nachricht</label>
                    <textarea id="message" name="message"
                    placeholder="enter your message here"></textarea>
                </p>
                <p>
                    <input class="button" type="submit" id="submit" name="submit" value="Abschicken">
                </p>
                <%
                if (null != message) {
                    out.println("<div class='" + status + "'>" + message + "</div>");
                }
                %>
        </form>
</div>
<jsp:include page="footer.jsp" />