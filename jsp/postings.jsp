<!-- @author Marco Dauber, Philipp Seitz, Morten Terhart
  -- * Displays a list of posts supplying certain filter criteria
  -- * received through a GET request from the URL
--> 

<%-- Import Statements --%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.lang.*" %>
<%@ page import="de.dhbw.StudentForum.Posting" %>
<%@ page import="de.dhbw.StudentForum.User" %>
<%@ page import="de.dhbw.StudentForum.DAO" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<%!
    // Uniform declarations of used parameter identifiers
    private static final String POST_ID_PARAMETER         = "postid";
    private static final String USER_ID_PARAMETER         = "userid";
    private static final String LATEST_PARAMETER          = "latest";
    private static final String SEARCH_TERM_PARAMETER     = "searchterm";
    private static final String MAX_POSTINGS_PARAMETER    = "maxpostings";
    private static final String FORUM_ID_PARAMETER        = "forumid";
    private static final String TAG_ID_PARAMETER          = "tag";
    private static final String MIN_DATE_PARAMETER        = "mindate";
    private static final String MAX_DATE_PARAMETER        = "maxdate";
    private static final String POPULAR_POSTS_PARAMETER   = "popular";
    private static final String DISPLAY_HEADING_PARAMETER = "displayheader";

    // Object instance to get access to the database
    private DAO databaseObject = new DAO();
%>

<%!
	// Private Postings constants and container for
	// applied parameters on the URL (either via
    // GET or POST request)
    private int postId = -1;
    private int forumId = -1;
    private String tag = null;
    private int userId = -1;
    private int maxPostings = 100;
    private boolean latest = false;
    private boolean popularPosts = false;
    private boolean displayHeader = false;
    private Date minDate = null;
    private Date maxDate = null;

    // Collection of retrieved postings to iterate over
    // to display as list overview
    List<Posting> postSelection = new ArrayList<>();
%>

<%
    // Dummy elements
    // String dummyAuthor = "Max Mustermann";

    // Posting p1 = new Posting(0);
    //p1.setTitle("Brauche Hilfe bei Doppelintegralen in Mathe");
    //p1.setWhenPosted(new Date());
    //String[] tags1 = { "Mathe", "Integral" };
    //p1.setTags(tags1);
    // postSelection.add(p1);
%>

<%
    // --- Parameter Handling ---
    // Accessing the Parameters
    String postIdString        = request.getParameter(POST_ID_PARAMETER);
    String tagString           = request.getParameter(TAG_ID_PARAMETER);
    String userIdString        = request.getParameter(USER_ID_PARAMETER);
    String forumIdString       = request.getParameter(FORUM_ID_PARAMETER);
    String latestString        = request.getParameter(LATEST_PARAMETER);
    String maxPostingsString   = request.getParameter(MAX_POSTINGS_PARAMETER);
    String searchTermString    = request.getParameter(SEARCH_TERM_PARAMETER);
    String minDateString       = request.getParameter(MIN_DATE_PARAMETER);
    String maxDateString       = request.getParameter(MAX_DATE_PARAMETER);
    String popularPostsString  = request.getParameter(POPULAR_POSTS_PARAMETER);
    String displayHeaderString = request.getParameter(DISPLAY_HEADING_PARAMETER);

    // Validating and parsing the parameters to the consigned
    // data types such as integer, boolean or dates
    DateFormat format = DateFormat.getDateInstance();
    try {
        if (postIdString != null) {
            postId = Integer.parseInt (postIdString);
        }
        if (userIdString != null) {
            userId = Integer.parseInt (userIdString);
        }
        if (forumIdString != null) {
            forumId = Integer.parseInt (forumIdString);
        }
        if (maxPostingsString != null) {
            maxPostings = Integer.parseInt (maxPostingsString);
        }
        if (latestString != null) {
            latest = Boolean.parseBoolean (latestString);
        }
        if (minDateString != null) {
            minDate = format.parse (minDateString);
        }
        if (maxDateString != null) {
            maxDate = format.parse (maxDateString);
        }
        if (popularPostsString != null) {
            popularPosts = Boolean.parseBoolean (popularPostsString);
        }
        if (displayHeaderString != null) {
            displayHeader = Boolean.parseBoolean (displayHeaderString);
        }
    } catch(NumberFormatException exc) {
        System.err.println("postings.jsp: Could not perform integer parsing");
        exc.printStackTrace();
        return;
    } catch(ParseException exc) {
        System.err.println("postings.jsp: Could not parse the date received by the request");
        exc.printStackTrace();
        return;
    }

    // Action Decision Investigation
    // The following if statements represent various use cases for the postings
    // component inside the INF16B forum. Depending on the assigned parameters
    // they decide which kind of postings to load from the database. Therefore
    // all the parameters are checked against an inequality of `null`.
    if (searchTermString != null && minDateString != null && maxDateString != null && tagString != null && forumIdString != null) {
        // Extended Search Request
        extendedSearchRequest (searchTermString, forumId, tag, minDate, maxDate);
        logMessage ("Activated extended search request");
    } else if (latestString != null && latest && maxPostingsString != null && maxPostings == 8) {
        // Top 8 Postings on the homepage
        selectTop8Postings ();
        logMessage ("Activated selecting latest postings");
    } else if (searchTermString != null) {
        // Simple Search Request from the Header line
        simpleSearchRequest (searchTermString);
        logMessage ("Activated simple search request");
    } else if (popularPostsString != null && popularPosts) {
        // Posts with most comments in various forums
        selectPopularPostings();
        logMessage ("Activated selection of popular postings");
    } else if (forumIdString != null) {
        // Postings of a specific forum
        selectForumPostings(forumId);
        logMessage ("Activated selecting postings of specific forum");
    } else if (tagString != null) {
        // Postings of a specific tag
        selectTagPostings(tag);
        logMessage ("Activated selection of postings with a specific tag");
    } else if (userIdString != null) {
        // Postings of a specific user
        selectUserPostings(userId);
        logMessage ("Activated selection of postings by a specific user");
    } else {
        // If none of these use cases is matched, create an empty set
        // and display nothing
        postSelection = new ArrayList<Posting>();
        System.err.println("postings.jsp: Error while parsing parameters! Wrong combination " +
            "of parameters or none supplied");
    }
%>

<%!
    // Methods used by the Postings component to select
    // various kinds of postings

    /**
     * Selects the latest 8 postings out of the database to show
     * on the index page
     */
    private void selectTop8Postings() {
        latest = true;
        postSelection = databaseObject.getLatestPostings();
    }

    /**
     * Applies the given parameters as query to the database object and selects
     * the posts matching the criteria
     * @param searchTerm the string that is searched after
     * @param forumId the identifier of thfe forum which is searched in
     * @param tag the identifier of the tag the posts must contain
     * @param minDate the minimal date specifying the lower border of creation date
     * @param maxDate the maximal date specifying the upper border of creation date
     */
    private void extendedSearchRequest(String searchTerm, int forumId, String tag, Date minDate, Date maxDate) {
        postSelection = databaseObject.searchPostings(searchTerm, forumId, tag,
                new java.sql.Date(minDate.getTime()), new java.sql.Date(maxDate.getTime()));
    }

    /**
     * Initializes the postSelection with postings containing the search term
     * @param searchTerm the specific search term to look after
     */
    private void simpleSearchRequest(String searchTerm) {
        postSelection = databaseObject.searchPostings(searchTerm);
    }

    /**
     * Initializes the postSelection with all postings appearing in a specific forum
     * @param forumId the id of the specific forum
     */
    private void selectForumPostings(int forumId) {
        postSelection = databaseObject.getPostingsByForum(forumId);
    }

    /**
     * Initializes the postSelection with all postings attached with a specific tag
     * @param tag the name of the specific tag
     */
    private void selectTagPostings(String tag) {
        postSelection = databaseObject.getPostingsByTag(tag);
    }

    /**
     * Initializes the postSelection with all postings submitted by a specific user
     * @param userId the id of the specific user
     */
    private void selectUserPostings(int userId) {
        postSelection = databaseObject.getPostingsByUser(userId);
    }

    /**
     * Initializes the postSelection with all postings matching the popularity
     * criteria (postings with a high rating)
     */
    private void selectPopularPostings() {
        // postSelection = databaseObject.getPopularPostings();
    }

    /**
     * Write a message to the log file prepended with the name of this file
     * @param message the message to log
     */
    private void logMessage(String message) {
        System.out.println("postings.jsp: " + message);
    }
%>

<c:if test="${displayHeader && !postSelection.isEmpty()}">
    <h1>Kommentare zu eigenen Postings</h1>
</c:if>
<c:forEach items="${postSelection}" var="currentPost" end="${maxPostings}">
    <c:set var="author" value="${databaseObject.getUserById(currentPost.getUserId())}" />
    <a href="posting.jsp?postid=${currentPost.getId()}">
        <div class="post">
            <div class="profilbild">
                <img src="${(author.getImgUrl()}" height="60" width="60" />
            </div>
            <div>
                <div>INF16B &gt; Mathe</div>
                <span class="author"> ${author.getFirstname()} ${author.getLastname()} </span>
                <span class="date"> ${currentPost.getWhenPosted()} </span>

                <h1><i> ${currentPost.getTitle()} </i></h1>

                <c:forEach items="${currentPost.getTags()}" var="tag">
                    <span class="tagbox">${tag}</span>
                </c:forEach>

                <span class="answer"> 200 Antworten </span>
            </div>
        </div>
    </a>
</c:forEach>
