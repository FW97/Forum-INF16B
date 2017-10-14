import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/* Authors
 * Andreas Memmel, Micha Spahr
*/

@WebServlet("/rate")
public class RatingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = request.getParameter("thumbs");
		HttpSession session = request.getSession();
		boolean hasUserRated = false;
		
		/*
		* Uncomment when DB and Session management is done
		* String postId = session.getAttribute("postId");
		* String userId = session.getAttribute("userId");
		*	
		* // Example insert
		* DAO d = new DAO();
		* hasUserRated = d.hasUserRated(userId, postId);
		* 
		* if(!hasUserRated){
			d.insertRating(postId, userId, action);
			out.println("{Status: \"OK\"}");
		  }
		* 	
		*
		*/
		String jsonResp = "";
		
		if(action.equals("thumbsUp"))
			jsonResp = "{\"status\": \"OK\"}";
		else if(action.equals("thumbsDown"))
			jsonResp = "{\"status\": \"ERROR\"}";
	
        response.setContentType("application/json");
        response.getWriter().write(jsonResp);
	}
}
