<!-- @author Marco Dauber, Philipp Seitz, Morten Terhart
  -- * Displays a list of posts supplying certain filter criteria
  -- * received through a GET request from the URL
--> 

<%@ page import = "java.io.*, java.util.*, javax.servlet.ServletRequest, java.lang.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<%!
    // Uniform declarations of used parameter identifiers
    private static final String SEARCH_TERM_PARAMETER = "searchterm";
    private static final String FORUM_ID_PARAMETER    = "forumid";
    private static final String TAG_ID_PARAMETER      = "tagid";
    private static final String MIN_DATE_PARAMETER    = "mindate";
    private static final String MAX_DATE_PARAMETER    = "maxdate";
%>

<%!
	// Private Postings constants and container for
	// filter criteria
	private int postId = -1;
	private int forumId = -1;
	private int tagId = -1;
	private int userId = -1;
	private int maxPostings = 100;
	private boolean latest = false;
	private String searchTerm = null;
	private Date minDate = null;
	private Date maxDate = null;
	private String name = "Max Mustermann";
	private Date date = GregorianCalendar.getInstance().getTime();
	private String category = "Campus";
	private String subject = "Suche WG";
	private String[] tags = { "Netztechnik", "Informatik", "INF16B" };
	// TODO: Replace String with Posting after figuring out how to import the class
	private Set<String> postSelection = new HashSet<>();

	// Object instance to get access to the database
	// private DAO daoObject = new DAO();
	// TODO: Declare new instance of DAO Object when imported
%>

<%!
    // Methods used by the Postings component

    /**
     * Selects the latest 8 postings out of the database to show
     * on the index page
     */
    public void selectTop8Postings() {
        latest = true;
        maxPostings = 8;
        // Collections.addAll(postSelection, daoObject.getLatestPosts());
    }

    /**
     * Applies the given parameters as query to the database object and selects
     * the posts matching the criteria
     * @param searchTerm the string that is searched after
     * @param forumId the identifier of the forum which is searched in
     * @param tagId the identifier of the tag the posts must contain
     * @param minDate the minimal date specifying the lower border of creation date
     * @param maxDate the maximal date specifying the upper border of creation date
     */
    public void transmitSearchRequest(String searchTerm, int forumId, int tagId, Date minDate, Date maxDate) {
        if (searchTerm == null) {

        }
    }
%>

<%
    transmitSearchRequest (request.getParameter(SEARCH_TERM_PARAMETER), request.getParameter(FORUM_ID_PARAMETER),
            request.getParameter(TAG_ID_PARAMETER), request.getParameter(MIN_DATE_PARAMETER),
            request.getParameter(MAX_DATE_PARAMETER));
%>

<c:forEach items="<%= postSelection %>" var="currentPost">
    <a href="/posting.jsp?${currentPost.getId()}">
        <div class="post">
            <div class="profilbild">
                <img src="http://www.iconsdb.com/icons/preview/gray/user-xxl.png" height="60" width="60" >
            </div>
            <div>
                <span class="author"> <%= name %> </span><span class="category"><%= category %></span>
                <br> <span class="date"><%= date %></span>

                <h1><i><%= subject %></i></h1>

                <c:forEach items="<%= tags %>">
                    <span class="tagbox"></span>
                </c:forEach>

                <span class="answer"> 200 Antworten </span>
            </div>
        </div>
    </a>
</c:forEach>
