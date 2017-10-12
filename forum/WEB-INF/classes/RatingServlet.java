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
		
		/*
		* Uncomment when DB and Session management is done
		* String postId = session.getAttribute("postId");
		* String userId = session.getAttribute("userId");
		*	
		* // Example insert
		* DAO d = new DAO();
		* if(!d.hasUserRated(userId, postId)
		* 	d.insertRating(postId, userId, action);
		*
		*/
		
		if(action.equals("thumbsUp"))
			System.out.println("Rating up");
		else if(action.equals("thumbsDown"))
			System.out.println("Rating down");
	}
}
