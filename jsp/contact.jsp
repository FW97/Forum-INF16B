<!--  INF16B Maximilian Gerlach, Florian Schenk:added Header,Footer and Tags for CSS Styling-->
<jsp:include page="header.jsp" />
<div class=contact>
            <form>
                <h1>Kontakt aufnehmen</h1>
                <p>
                    <label for="email">Email</label>
                    <input type="text" id="email" placeholder="Email"/>
                </p>
                <p>
                    <label for="vorname">Vorname</label>
                    <input type="text" id="vorname" placeholder="Vorname"/>
                </p>
                <p>
                    <label for="nachname">Nachname</label>
                    <input type="text" id="nachname" placeholder="Nachname"/>
                </p>
                <p>
                    <label for="message">Nachricht</label>
                    <input type="text" id="message" placeholder="Nachricht"/>
                </p>
                <p>
                    <input class="button" type="submit" id="submit" value="Abschicken">
                </p>
            </form>
</div>
<jsp:include page="footer.jsp" />