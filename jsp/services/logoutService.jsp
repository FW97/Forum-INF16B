<%
    /**
     * @author Morten Terhart
     * Service for server-side termination of login session
     */

    // Clear the login session
    session.invalidate();
%>

<p>Logged out.</p>