package de.dhbw.StudentForum;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import de.dhbw.StudentForum.MySQLDatabase;
import de.dhbw.StudentForum.Posting;
import de.dhbw.StudentForum.User;


/*
 * by 	Fabian Schulz,
 * 		Daniel Bilmann,
 * 		Jannik Zeyer,
 * 		Andreas Memmel
 */

public class DAO {
	
	//Add new user to DB. 
	public void addNewUser(User user) throws Exception
	{
		Connection con = null;
        PreparedStatement ps = null;
        
        try
        {
            con = MySQLDatabase.getInstance().getConnection();

        }
        catch(Exception e) {e.printStackTrace();}
        
        String sqlString = "INSERT INTO USER ("
			        		+ "firstname, lastname, email, role, pwsalt, pwhash, imgurl) "
			        		+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
		ps = con.prepareStatement(sqlString);
        ps.setString(1, user.getFirstname());
        ps.setString(2, user.getLastname());
        ps.setString(3, user.getEmail());
        ps.setInt(4, user.getRole());
        ps.setString(5, user.getPwSalt());
        ps.setString(6, user.getPwHash());
        ps.setString(7, user.getImgUrl());
        ps.executeUpdate();
        
        
        ps.close();
        con.close();
	}
	
	//Add post to DB. 
		public void addNewPosting(Posting posting) throws Exception
		{
			Connection con = null;
	        PreparedStatement ps = null;
	        
	        try
	        {
	            con = MySQLDatabase.getInstance().getConnection();

	        }
	        catch(Exception e) {e.printStackTrace();}
	        
	        String sqlString = "INSERT INTO POSTING ("
				        		+ "authorid, subjectid, Text, whenposted, whendeleted) "
				        		+ "VALUES (?, ?, ?, ?, ?)";
	        
	        
			ps = con.prepareStatement(sqlString, Statement.RETURN_GENERATED_KEYS);
	        ps.setInt(1, posting.getAuthorId());
	        ps.setInt(2, posting.getSubjectId());
	        ps.setString(3, posting.getText());
	        ps.setDate(4, posting.getWhenposted());
	        ps.setDate(5, posting.getWhendeleted());
//	        ps.setString(4, new java.sql.Timestamp(System.currentTimeMillis()));	nur falls wir kein Objekt bekommen sollten
//	        ps.setString(5, null);
	        ps.executeUpdate();
	        
	        String[] tags = posting.getTags();
	        int postingId = ps.getGeneratedKeys();
	        
	        if(tags.length>0) {
	        
	        	sqlString = "INSERT INTO POSTINGTAG("
	        			+ "tag, postingid)"
	        			+ "VALUES ";
	        	
	        	for(int i = 0; i < tags.length; i++) {
	        		if (i=0) {
	        			sqlString.concat("(" + tags[i] + ", " + postingId + ")");
	        		}
	        		else {
	        			sqlString.concat(",(" + tags[i] + ", " + postingId + ")");
	        		}
	        	}
	        	
	        	sqlString.concat(";");
	        	
	        	ps = con.prepareStatement(sqlString);
	        	ps.executeUpdate();
	        }
	        
	        ps.close();
	        con.close();
		}
		
		//Add attachement to DB. 
		public void addAttachement(String filename, int postingId) throws Exception
		{
			Connection con = null;
	        PreparedStatement ps = null;
	        
	        try
	        {
	            con = MySQLDatabase.getInstance().getConnection();

	        }
	        catch(Exception e) {e.printStackTrace();}
	        
	        String sqlString = "INSERT INTO ATTACHEMENT ("
				        		+ "attachementfilename, postingid) "
				        		+ "VALUES (?, ?)";
	        
			ps = con.prepareStatement(sqlString);
	        ps.setString(1, filename);
	        ps.setInt(2, postingId);
	        ps.executeUpdate();
	        
	        ps.close();
	        con.close();
		}
		
		//Add subject to DB. 
				public void addSubject(String name, int forumId) throws Exception
				{
					Connection con = null;
			        PreparedStatement ps = null;
			        
			        try
			        {
			            con = MySQLDatabase.getInstance().getConnection();

			        }
			        catch(Exception e) {e.printStackTrace();}
			        
			        String sqlString = "INSERT INTO SUBJECT ("
						        		+ "name, forumid) "
						        		+ "VALUES (?, ?)";
			        
					ps = con.prepareStatement(sqlString);
			        ps.setString(1, name);
			        ps.setString(2, forumId);
			        ps.executeUpdate();
			        
			        ps.close();
			        con.close();
				}
				
				//Add forum to DB. 
				public void addForum(String name, String category, int modId) throws Exception
				{
					Connection con = null;
			        PreparedStatement ps = null;
			        
			        try
			        {
			            con = MySQLDatabase.getInstance().getConnection();

			        }
			        catch(Exception e) {e.printStackTrace();}
			        
			        String sqlString = "INSERT INTO FORUM ("
						        		+ "name, category, moteratorid) "
						        		+ "VALUES (?, ?, ?)";
			        
					ps = con.prepareStatement(sqlString);
			        ps.setString(1, name);
			        ps.setString(2, category);
			        ps.setInt(3, modId);
			        ps.executeUpdate();
			        
			        ps.close();
			        con.close();
				}
				
	public void insertRating(int postingId, int userId, int rating) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = MySQLDatabase.getInstance().getConnection();
		}
		catch(Exception e) {e.printStackTrace();}
		
		String sqlString = "INSERT INTO POSTINGRATING ("
				+ "rating, postingId, userId) "
				+ "VALUES (?, ?, ?)";
		
		ps.con.prepareStatement(sqlString);
		ps.setInt(1, rating);
		ps.setInt(2, postingId);
		ps.setInt(3, userId);
		ps.executeUpdate();
		
		ps.close();
		con.close();
	}
	
	
	public User getUserByName(String fName, String lName) 
	{
		Connection con = null;
        ResultSet rs; 
        User newUser = null;
        
        try
        {
            con = MySQLDatabase.getInstance().getConnection();
        
	        String sqlString = "SELECT ID, firstname, lastname, email, role, pwsalt, pwhash FROM USERS WHERE firstname=? AND lastname=?;";
	        
	        PreparedStatement ps = con.prepareStatement(sqlString);
	        ps.setString(1, fName);
	        ps.setString(2, lName);
	        
	        rs = ps.executeQuery();
	        
	        if(!rs.next())
	        {
	            return null;
	        }
	        
	        newUser = new User(rs.getInt("ID"));
	        newUser.setFirstname(rs.getString("firstname"));
	        newUser.setLastname(rs.getString("lastname"));
	        newUser.setEmail(rs.getString("email"));
	        newUser.setRole(rs.getInt("role"));
	        newUser.setPwSalt(rs.getString("pwsalt"));
	        newUser.setPwHash(rs.getString("pwhash"));
	        
	        con.close();
	    }
        catch (Exception e)
        {
        	e.printStackTrace();
        }
        return newUser;
	}
	
	public User getUserByEmail(String email) 
	{
		Connection con = null;
        ResultSet rs; 
        User newUser = null;
        
        try
        {
            con = MySQLDatabase.getInstance().getConnection();
        
	        String sqlString = "SELECT ID, firstname, lastname, email, role, pwsalt, pwhash FROM USERS WHERE email=?;";
	        
	        PreparedStatement ps = con.prepareStatement(sqlString);
	        ps.setString(1, email);
	        
	        rs = ps.executeQuery();
	        
	        if(!rs.next())
	        {
	            return null;
	        }
	        
	        newUser = new User(rs.getInt("ID"));
	        newUser.setFirstname(rs.getString("firstname"));
	        newUser.setLastname(rs.getString("lastname"));
	        newUser.setEmail(rs.getString("email"));
	        newUser.setRole(rs.getInt("role"));
	        newUser.setPwSalt(rs.getString("pwsalt"));
	        newUser.setPwHash(rs.getString("pwhash"));
	        
	        con.close();
	    }
        catch (Exception e)
        {
        	e.printStackTrace();
        }
        return newUser;
	}
	
	public User getUserById(int id) 
	{
		Connection con = null;
        ResultSet rs; 
        User newUser = null;
        
        try
        {
            con = MySQLDatabase.getInstance().getConnection();
        
	        String sqlString = "SELECT ID, firstname, lastname, email, role, pwsalt, pwhash FROM USERS WHERE id=?;";
	        
	        PreparedStatement ps = con.prepareStatement(sqlString);
	        ps.setInt(1, id);
	        
	        rs = ps.executeQuery();
	        
	        if(!rs.next())
	        {
	            return null;
	        }
	        
	        newUser = new User(rs.getInt("ID"));
	        newUser.setFirstname(rs.getString("firstname"));
	        newUser.setLastname(rs.getString("lastname"));
	        newUser.setEmail(rs.getString("email"));
	        newUser.setRole(rs.getInt("role"));
	        newUser.setPwSalt(rs.getString("pwsalt"));
	        newUser.setPwHash(rs.getString("pwhash"));
	        
	        con.close();
	    }
        catch (Exception e)
        {
        	e.printStackTrace();
        }
        return newUser;
	}
	
	public Posting gePostingById(int id) 
	{
		Connection con = null;
        ResultSet rs; 
        User newUser = null;
        
        try
        {
            con = MySQLDatabase.getInstance().getConnection();
        
	        String sqlString = "SELECT ID, authorid, text, subjectid, whendeleted, whenposted, "
	        		+ "(SELECT CONCAT_WS(\";\", tag) FROM POSTINGTAG WHERE postingid=?) AS tags "
	        		+ "(SELECT SUM(rating) FROM POSTINGRATING WHERE rating = 1 AND postingid=?) AS posrat, "
	        		+ "(SELECT SUM(rating) FROM POSTINGRATING WHERE rating = -1 AND postingid=?) AS negrat "
	        		+ "FROM POSTING WHERE id=?;";
	        
	        PreparedStatement ps = con.prepareStatement(sqlString);
	        ps.setInt(1, id);
	        ps.setInt(2, id);
	        ps.setInt(3, id);
	        ps.setInt(4, id);
	        
	        rs = ps.executeQuery();
	        
	        if(!rs.next())
	        {
	            return null;
	        }
	        
	        newPosting = new Posting(rs.getInt("ID"));
	        newPosting.setText(rs.getString("text"));
	        newPosting.setAuthorid(rs.getInt("authorid"));
	        newPosting.setSubjectid(rs.getInt("subjectid"));
	        newPosting.setWhendeleted(rs.getDate("whendeleted"));
	        newPosting.setWhenposted(rs.getDate("whenposted"));
	        newPosting.setTags(rs.getString("tags").split(";"));
	        newPosting.setPosRat(rs.getInt("posrat"));
	        newPosting.setNegRat(rs.getInt("negrat"));
	        
	        con.close();
	    }
        catch (Exception e)
        {
        	e.printStackTrace();
        }
        return newPosting;
	}
	
	public static ArrayList<Posting> getPostingsBySubject(int subjectId) 
	{
		Connection con = null;
        ResultSet rs; 
        ArrayList<Posting> postings = new ArrayList<Posting>();
        
        try
        {
            con = MySQLDatabase.getInstance().getConnection();

	        String sqlString = "SELECT ID, authorid, subjectid, text, whenposted, whedeleted "
	        		+ "(SELECT CONCAT_WS(\";\", t.tag) FROM POSTINGTAG t, POSTING p ON t.postingid = p.id WHERE p.subjectid=?) AS tags "
	        		+ "(SELECT SUM(rating) FROM POSTINGRATING r, POSTING p ON r.postingid = p.id WHERE p.subjectid=? AND rating = 1) AS posrat, "
	        		+ "(SELECT SUM(rating) FROM POSTINGRATING r, POSTING p ON r.postingid = p.id WHERE p.subjectid=? AND rating = -1) AS negrat "
	        		+ "FROM POSTING WHERE subjectid=?;";
	        
	        PreparedStatement ps = con.prepareStatement(sqlString);
	        ps.setInt(1, subjectId);
	        ps.setInt(2, subjectId);
	        ps.setInt(3, subjectId);
	        ps.setInt(4, subjectId);
	        rs = ps.executeQuery();

	        while(rs.next())
	        {
	        	Posting posting = new Posting(rs.getInt("ID"));
	        	posting.setAuthorId(rs.getInt("authorid"));
	        	posting.setSubjectId(rs.getInt("subjectid"));
	        	posting.setText(rs.getString("text"));
	        	posting.setWhenPosted(rs.getDate("whenposted"));
	        	posting.setWhenDeleted(rs.getDate("whendeleted"));
	        	posting.setTags(rs.getString("tags").split(";"));
	        	posting.setPosRat(rs.getInt("posrat"));
	        	posting.setNegRat(rs.getInt("negrat"));
	        	postings.add(posting);
	        }
	        
	        con.close();
	    }
        catch (Exception e)
        {
        	e.printStackTrace();
        }
        return postings;
	} 
	
	public static ArrayList<Integer> getSubjectIDsByForum(int forumId) {
		Connection con = null;
        ResultSet rs; 
        ArrayList<Integer> subjects = new ArrayList<Integer>();
        
        try
        {
            con = MySQLDatabase.getInstance().getConnection();

	        String sqlString = "SELECT id FROM SUBJECT WHERE forumid=?;";
	        
	        PreparedStatement ps = con.prepareStatement(sqlString);
	        ps.setInt(1, forumId);
	        rs = ps.executeQuery();

	        while(rs.next())
	        {
	        	subjects.add(rs.getInt("id"));
	        }
	        
	        con.close();
	    }
        catch (Exception e)
        {
        	e.printStackTrace();
        }
        return subjects;
	}
	
	public int[] getRatingByPostingId(int postingId) {
		Connection con = null;
        ResultSet rs; 
        int[2] rating;
        
        try
        {
            con = MySQLDatabase.getInstance().getConnection();

	        String sqlString = "SELECT COUNT(rating) AS posrat FROM POSTINGRATING WHERE postingid=? AND rating = 1;";
	        
	        PreparedStatement ps = con.prepareStatement(sqlString);
	        ps.setInt(1, postingId);
	        rs = ps.executeQuery();

	        while(rs.next())
	        {
	        	rating[0] = rs.getInt("posrat");
	        }
	        
	        String sqlString = "SELECT COUNT(rating) AS negrat FROM POSTINGRATING WHERE postingid=? AND rating = -1;";
	        
	        PreparedStatement ps = con.prepareStatement(sqlString);
	        ps.setInt(1, postingId);
	        rs = ps.executeQuery();

	        while(rs.next())
	        {
	        	rating[1] = rs.getInt("negrat");
	        }
	        
	        con.close();
	    }
        catch (Exception e)
        {
        	e.printStackTrace();
        }
        return subjects;
	}
		
	/**
	 * 
	 * @author Michael Skrzypietz
	 */
	public static boolean isEmailTaken(String email) {
		try {
        	Connection con = MySQLDatabase.getInstance().getConnection();
            
            String sqlString = "SELECT ID FROM user "
	        		+ "WHERE email = ?";

            PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) return true;
			
			rs.close();
			ps.close();
			con.close();
        } catch(Exception e) {
        	e.printStackTrace();
        }
        
		return false;
	}

	/**
	 * 
	 * @author Michael Skrzypietz
	 */
	public static void updateProfilSettings(User user) {
        try {
        	Connection con = MySQLDatabase.getInstance().getConnection();
            
            String sqlString = "UPDATE USER "
	        		+ "SET firstname = ?, lastname = ?, email = ? "
	        		+ "WHERE ID = ?";

            PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setString(1, user.getFirstname());
			ps.setString(2, user.getLastname());
			ps.setString(3, user.getEmail());
			ps.setInt(4, user.getId());
			ps.executeUpdate();
			
			ps.close();
	        con.close();
        } catch(Exception e) {
        	e.printStackTrace();
        }  
	}
	
	/**
	 * 
	 * @author Michael Skrzypietz
	 */
	public static void updatePassword(User user) {
        try {
        	Connection con = MySQLDatabase.getInstance().getConnection();
            
            String sqlString = "UPDATE USER "
	        		+ "SET pwhash = ? "
	        		+ "WHERE ID = ?";

            PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setString(1, user.getPwHash());
			ps.setInt(2, user.getId());
			ps.executeUpdate();
			
			ps.close();
			con.close();
        } catch(Exception e) {
        	e.printStackTrace();
        }
	}

	/**
	 * 
	 * @author Michael Skrzypietz
	 */
	public static void updateImgurl(User user) {
		try {
        	Connection con = MySQLDatabase.getInstance().getConnection();
            
            String sqlString = "UPDATE USER "
	        		+ "SET imgurl = ? "
	        		+ "WHERE ID = ?";

            PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setString(1, user.getImgUrl());
			ps.setInt(2, user.getId());
			ps.executeUpdate();
			
			ps.close();
			con.close();
        } catch(Exception e) {
        	e.printStackTrace();
        }
	}
	
	public boolean hasUserRated(int postingId, int userId) {
		try {
        	Connection con = MySQLDatabase.getInstance().getConnection();
            
            String sqlString = "SELECT postingid FROM POSTINGRATING "
	        		+ "WHERE postingId = ? AND userId = ?";

            PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setString(1, postingId);
			ps.setString(2, userId);
			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) return true;
			
			rs.close();
			ps.close();
			con.close();
        } catch(Exception e) {
        	e.printStackTrace();
        }
        
		return false;
	}
}
