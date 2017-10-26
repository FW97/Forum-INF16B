package de.dhbw.StudentForum;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import com.mysql.jdbc.Statement;

import de.dhbw.StudentForum.Posting;
import de.dhbw.StudentForum.User;
import de.dhbw.StudentForum.MySQLDatabase;


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
		public int addNewPosting(Posting posting) throws Exception
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
	        
	        String key[] = {"ID"};
	        
			ps = con.prepareStatement(sqlString, key);
	        ps.setInt(1, posting.getUserId());
	        ps.setInt(2, posting.getSubjectId());
	        ps.setString(3, posting.getMessage());
	        ps.setDate(4, posting.getWhenPosted());
	        ps.setDate(5, posting.getWhenDeleted());
//	        ps.setString(4, new java.sql.Timestamp(System.currentTimeMillis()));	nur falls wir kein Objekt bekommen sollten
//	        ps.setString(5, null);
	        ps.executeUpdate();
	        
	        String[] tags = posting.getTags();
	        ResultSet rs = ps.getGeneratedKeys();
	        int postingId = -1;
	        if(rs.next()) {
	        	postingId = Integer.parseInt(rs.getString(1));
	        
	        if(tags != null) {
	        
	        	sqlString = "INSERT INTO POSTINGTAG("
	        			+ "tag, postingid)"
	        			+ "VALUES ";
	        	
	        	for(int i = 0; i < tags.length; i++) {
	        		if (i == 0) {
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
	        }
	        
	        
	        ps.close();
	        con.close();
	        return postingId;
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
				public boolean addSubject(Subject s) throws Exception
				{
					Connection con = null;
			        PreparedStatement ps = null;
			        
			        try
			        {
			            con = MySQLDatabase.getInstance().getConnection();
			        
			        String sqlString = "INSERT INTO SUBJECT ("
						        		+ "name, forumid) "
						        		+ "VALUES (?, ?)";
			        
					ps = con.prepareStatement(sqlString);
			        ps.setString(1, s.getName());
			        ps.setInt(2, s.getForumid());
			        ps.executeUpdate();
			        
			        ps.close();
			        con.close();
			        }
			        catch(Exception e) {
			        	e.printStackTrace();
			        	return false;
			        }
			        return true;
				}
				
				//Add forum to DB. 
				public boolean addForum(Forum f) throws Exception
				{
					Connection con = null;
			        PreparedStatement ps = null;
			        
			        try
			        {
			            con = MySQLDatabase.getInstance().getConnection();
			        
			        String sqlString = "INSERT INTO FORUM ("
						        		+ "name, moderatorid) "
						        		+ "VALUES (?, ?)";
			        
					ps = con.prepareStatement(sqlString);
			        ps.setString(1, f.getName());
			        ps.setInt(2, f.getModeratorid());
			        ps.executeUpdate();
			        
			        ps.close();
			        con.close();
			        }
			        catch(Exception e) {
			        	e.printStackTrace();
			        	return false;
			        }
			        return true;
				}
				
	public void insertRating(int postingId, int userId, int rating) throws Exception {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = MySQLDatabase.getInstance().getConnection();
		}
		catch(Exception e) {e.printStackTrace();}
		
		String sqlString = "INSERT INTO POSTINGRATING ("
				+ "rating, postingId, userId) "
				+ "VALUES (?, ?, ?)";
		
		ps = con.prepareStatement(sqlString);
		ps.setInt(1, rating);
		ps.setInt(2, postingId);
		ps.setInt(3, userId);
		ps.executeUpdate();
		
		ps.close();
		con.close();
	}
	
	public boolean addTag(int postingId, String tag) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = MySQLDatabase.getInstance().getConnection();
		
		String sqlString = "INSERT INTO POSTINGTAG ("
				+ "postingId, tag) "
				+ "VALUES (?, ?)";
		
		ps = con.prepareStatement(sqlString);
		ps.setInt(1, postingId);
		ps.setString(2, tag);
		ps.executeUpdate();
		
		ps.close();
		con.close();
		}
		catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	
	public User getUserByName(String fName, String lName) 
	{
		Connection con = null;
        ResultSet rs; 
        User newUser = null;
        
        try
        {
            con = MySQLDatabase.getInstance().getConnection();
        
	        String sqlString = "SELECT ID, firstname, lastname, email, role, pwsalt, pwhash FROM USER WHERE firstname=? AND lastname=?;";
	        
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
        
	        String sqlString = "SELECT ID, firstname, lastname, email, role, pwsalt, pwhash FROM USER WHERE email=?;";
	        
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
        
	        String sqlString = "SELECT ID, firstname, lastname, email, role, pwsalt, pwhash FROM USER WHERE id=?;";
	        
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
        Posting newPosting = null;
        
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
	        newPosting.setMessage(rs.getString("text"));
	        newPosting.setUserId(rs.getInt("authorid"));
	        newPosting.setSubjectId(rs.getInt("subjectid"));
	        newPosting.setWhenDeleted(rs.getDate("whendeleted"));
	        newPosting.setWhenPosted(rs.getDate("whenposted"));
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
	
	public ArrayList<Posting> getPostingsBySubject(int subjectId) 
	{
		Connection con = null;
        ResultSet rs; 
        ArrayList<Posting> postings = new ArrayList<Posting>();
        
        try
        {
            con = MySQLDatabase.getInstance().getConnection();

	        String sqlString = "SELECT ID, authorid, subjectid, text, whenposted, whendeleted, "
	        		+ "(SELECT GROUP_CONCAT(t.tag) FROM POSTINGTAG t, POSTING p WHERE p.subjectid=? AND t.postingId = p.ID) AS tags, "
	        		+ "(SELECT SUM(rating) FROM POSTINGRATING r, POSTING p WHERE p.subjectid=? AND rating = 1 AND r.postingid = p.id) AS posrat, "
	        		+ "(SELECT SUM(rating) FROM POSTINGRATING r, POSTING p WHERE p.subjectid=? AND rating = -1 AND r.postingid = p.id) AS negrat "
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
	        	posting.setUserId(rs.getInt("authorid"));
	        	posting.setSubjectId(rs.getInt("subjectid"));
	        	posting.setMessage(rs.getString("text"));
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
	
	public Set<Posting> getPostingsByUser(int userId) {
		Connection con = null;
        ResultSet rs; 
        Set<Posting> postings = new HashSet<Posting>();
        
        try{
            con = MySQLDatabase.getInstance().getConnection();
        	
            String sqlString = "SELECT ID, authorid, subjectid, text, whenposted, whendeleted, "
	        		+ "(SELECT GROUP_CONCAT(t.tag) FROM POSTINGTAG t, POSTING p WHERE p.authorid=? AND t.postingId = p.ID) AS tags, "
	        		+ "(SELECT SUM(rating) FROM POSTINGRATING r, POSTING p WHERE p.authorid=? AND rating = 1 AND r.postingid = p.id) AS posrat, "
	        		+ "(SELECT SUM(rating) FROM POSTINGRATING r, POSTING p WHERE p.authorid=? AND rating = -1 AND r.postingid = p.id) AS negrat "
	        		+ "FROM POSTING "
	        		+ "WHERE authorid=?;";
            
            PreparedStatement ps = con.prepareStatement(sqlString);
	        ps.setInt(1, userId);
	        ps.setInt(2, userId);
	        ps.setInt(3, userId);
	        ps.setInt(4, userId);
	        rs = ps.executeQuery();

	        while(rs.next())
	        {
	        	Posting posting = new Posting(rs.getInt("ID"));
	        	posting.setUserId(rs.getInt("authorid"));
	        	posting.setSubjectId(rs.getInt("subjectid"));
	        	posting.setMessage(rs.getString("text"));
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
	
	public Set<Posting> getPostingsByTag(String tag) {
		Connection con = null;
        ResultSet rs; 
        Set<Posting> postings = new HashSet<Posting>();
        
        try{
            con = MySQLDatabase.getInstance().getConnection();
        	
            String sqlString = "SELECT parent.ID, parent.authorid, parent.subjectid, parent.text, parent.whenposted, parent.whendeleted, "
	        		+ "(SELECT GROUP_CONCAT(t.tag) FROM POSTINGTAG t, POSTING p WHERE p.ID = parent.ID AND t.postingId = p.ID) AS tags, "
	        		+ "(SELECT SUM(rating) FROM POSTINGRATING r, POSTING p WHERE p.ID = parent.ID AND rating = 1 AND r.postingid = p.id) AS posrat, "
	        		+ "(SELECT SUM(rating) FROM POSTINGRATING r, POSTING p WHERE p.ID = parent.ID AND rating = -1 AND r.postingid = p.id) AS negrat "
	        		+ "FROM POSTING AS parent "
	        		+ "WHERE parent.ID IN (SELECT postingid FROM postingtag WHERE tag = ?);";
            
            PreparedStatement ps = con.prepareStatement(sqlString);
	        ps.setString(1, tag);
	        rs = ps.executeQuery();

	        while(rs.next())
	        {
	        	Posting posting = new Posting(rs.getInt("ID"));
	        	posting.setUserId(rs.getInt("authorid"));
	        	posting.setSubjectId(rs.getInt("subjectid"));
	        	posting.setMessage(rs.getString("text"));
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
        int[] rating = {0,0};
        
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
	        
	        sqlString = "SELECT COUNT(rating) AS negrat FROM POSTINGRATING WHERE postingid=? AND rating = -1;";
	        
	        ps = con.prepareStatement(sqlString);
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
        return rating;
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
			ps.setInt(1, postingId);
			ps.setInt(2, userId);
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
