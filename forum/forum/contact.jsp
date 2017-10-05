<!-- INF16B Maximilian Gerlach -->
<jsp:include page="header.jsp" />
<div class=contact>
            <form>
                <h2>Kontakt aufnehmen</h2>
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