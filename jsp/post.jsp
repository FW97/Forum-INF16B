<!--
   Assignment: 	Studentenforum
   Name: Eric Dussel, Marco Dauber, Jacob Krauth
 -->
<jsp:include page="header.jsp" />

<table id="np_table">

  <tr>
    <th class="np_desc">Titel</th>
    <td class="np_content">
    	<input id="np_titel" name="np_posting_titel" size="100" type="text">
    </td> 
  </tr>
  
  <tr>
    <th class="np_desc">Text</th>
    <td class="np_content">
    	<textarea id="np_text" name="np_posting_text"  rows="20" cols="75"></textarea>
    </td>
  </tr>
  
  <tr>
    <th class="np_desc">Tags</th>
    <td class="np_content">
    <input type="checkbox" class="np_tagbox"><label class="np_tagtext">f&uumlr alle</label>
    <input type="checkbox" class="np_tagbox"><label class="np_tagtext">Hausaufgaben</label>
    <input type="checkbox" class="np_tagbox"><label class="np_tagtext">Hilfe</label>
    </br>
    <input type="checkbox" class="np_tagbox"><label class="np_tagtext">Notfall</label>
    <input type="checkbox" class="np_tagbox"><label class="np_tagtext">Wohnung</label>
    </td>
  </tr>
  
  <tr>
    <th class="np_desc"></th>
    <td class="np_content">
    <form action="select.html">
        <label>Post in folgendem Forum erstellen: 
            <select size="1"> 
                <option>Allgemeines</option> 
                <option>Java</option> 
                <option>JavaScript</option> 
                <option>Webservices</option> 
                <option>Wasauchsonst</option>
            </select> 
        </label>
    </form>
    </td>
  </tr>

  <tr>
    <th class="np_desc"></th>
    <td class="np_content">
    	<!--<button id="np_button">Erstellen</button>-->
      <input type="button" id="np_button" onclick="window.location.replace('/jsp/services/newPostService.jsp');" value="Erstellen"/>
    </td>
  </tr>
  
</table>

<jsp:include page="footer.jsp" />
