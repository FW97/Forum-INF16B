package de.dhbw.StudentForum;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet for reading and inserting ratings on postings
 * @author Andreas Memmel, Micha Spahr
 *
 */
@WebServlet("/rate")
public class RatingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = request.getParameter("thumbs");

		boolean hasUserRated = false;
		int ratings[] = new int[2]; 
		int tUpCount = 0;
		int tDownCount = 0;
		String status = "";
		int postId = Integer.parseInt(request.getParameter("postId"));
		int userId = Integer.parseInt(request.getParameter("userId"));
	
		//DAO d = new DAO();
		//hasUserRated = d.hasUserRated(postId, userId);
		
		//TODO: delete this lines and uncomment the sections after DAO is finished
		tUpCount = 42;
		tDownCount = 12;
		hasUserRated = false;
		
		if((action.equals("thumbsUp") || action.equals("thumbsDown")) && !hasUserRated){
		
			//ratings = d.getRatingByPostingId(postId);
			//tUpCount = ratings[0];
			//tDownCount = ratings[1];
				
			if(action.equals("thumbsUp")){
				tUpCount += 1;
				//d.insertRating(postId, userId, 1);
			}	
			else if(action.equals("thumbsDown")){
				tDownCount += 1;
				//d.insertRating(postId, userId, -1);
			}
				
				
			status = "OK";
			
	        response.setContentType("application/json");
	        response.getWriter().write(buildJson(tUpCount, tDownCount, hasUserRated, status));
		}
		else if(action.equals("getThumbs")){		
			request.setAttribute("hasRatedAlready", hasUserRated);
			request.setAttribute("tUpCount", tUpCount);
			request.setAttribute("tDownCount", tDownCount);
		}
		else
			response.getWriter().write(buildJson(tUpCount, tDownCount, hasUserRated, "ERROR"));
	}
	
	/**
	 * Creates JSON-Type String with given params
	 * @param tUpCount Count of up votes
	 * @param tDownCount Count of down votes
	 * @param hasUserRated Has the user rated already
	 * @param status Status of the operation
	 * @return JSON-Type String
	 */
	private String buildJson(int tUpCount, int tDownCount, boolean hasUserRated, String status){
		
		StringBuilder sb = new StringBuilder();
		
		sb.append("{");
		
		if(status.equals("ERROR"))
			sb.append("\"status\": \"" + status + "\"");
		else{
			sb.append("\"status\": \"" + status + "\",");
			sb.append("\"hasUserRated\": \"" + hasUserRated + "\",");
			sb.append("\"tUpCount\": \"" + tUpCount + "\",");
			sb.append("\"tDownCount\": \"" + tDownCount + "\"");
		}
		
		sb.append("}");
		
		return sb.toString();
	}
}
