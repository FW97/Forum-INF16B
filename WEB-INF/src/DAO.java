package de.dhbw.StudentForum;

import java.sql.Date;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

import de.dhbw.StudentForum.Posting;
import de.dhbw.StudentForum.User;
import de.dhbw.StudentForum.MySQLDatabase;

/*
 * by 	Fabian Schulz,
 * 		Daniel Bilmann,
 * 		Jannik Zeyer,
 * 		Andreas Memmel
 * 
 * cleaned up by Morten Terhart
 * 
 * responsible is Andreas Memmel
 */

public class DAO {

	/**
	 * Adds new user to DB. Returns false if error occurred.
	 * @param user	User Object
	 * @return		Boolean: true if operation was successful
	 * @throws Exception
	 * @author Andreas Memmel
	 * @see User
	 */
	public boolean addNewUser(User user) throws Exception {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "INSERT INTO USER (" + "firstname, lastname, email, role, pwsalt, pwhash, imgurl) "
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
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	/**
	 * Adds post to DB. Returns the postingId. If an error occurred the return value is -1
	 * @param posting	Posting Object
	 * @return			the postingId of the Object added in the DB (-1 if error occurred)
	 * @throws Exception
	 * @author Andreas Memmel
	 * @see Posting
	 */
	public int addNewPosting(Posting posting) throws Exception {
		Connection con = null;
		PreparedStatement ps = null;
		int postingId = -1;

		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "INSERT INTO POSTING (" + "authorid, subjectid, Text) " + "VALUES (?, ?, ?)";

			String key[] = { "ID" };

			ps = con.prepareStatement(sqlString, key);
			ps.setInt(1, posting.getUserId());
			ps.setInt(2, posting.getSubjectId());
			ps.setString(3, posting.getMessage());
			ps.executeUpdate();

			String[] tags = posting.getTags();
			ResultSet rs = ps.getGeneratedKeys();
			if (rs.next()) {
				postingId = Integer.parseInt(rs.getString(1));

				if (tags != null) {

					sqlString = "INSERT INTO POSTINGTAG(" + "tag, postingid)" + "VALUES ";

					for (int i = 0; i < tags.length; i++) {
						if (i == 0) {
							sqlString = sqlString.concat("(" + tags[i] + ", " + postingId + ")");
						} else {
							sqlString = sqlString.concat(",(" + tags[i] + ", " + postingId + ")");
						}
					}

					sqlString = sqlString.concat(";");

					ps = con.prepareStatement(sqlString);
					ps.executeUpdate();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		ps.close();
		con.close();
		return postingId;
	}

	//Delete post from DB
	public boolean deletePosting(int postingid) throws Exception {
		Connection con = null;
		PreparedStatement ps = null;
		boolean result = false;
		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "UPDATE POSTING " + "SET whendeleted = CURRENT_TIMESTAMP WHERE postingid = ? ;";
			ps = con.prepareStatement(sqlString);
			ps.setInt(1, postingid);
			ps.executeUpdate();
			result = true;
		}catch(Exception e) {
			result = false;
			e.printStackTrace();
		}
		ps.close();
		con.close();
		return result;
	}
	
	// Add attachment to DB.
	public boolean addAttachment(String filename, int postingId) throws Exception {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "INSERT INTO ATTACHMENT (" + "attachmentfilename, postingid) " + "VALUES (?, ?)";

			ps = con.prepareStatement(sqlString);
			ps.setString(1, filename);
			ps.setInt(2, postingId);
			ps.executeUpdate();

			ps.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	// Add subject to DB.
	public int addSubject(Subject s) throws Exception {
		Connection con = null;
		PreparedStatement ps = null;
		int returnvalue = -1;

		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "INSERT INTO SUBJECT (" + "name, forumid) " + "VALUES (?, ?); ";

			ps = con.prepareStatement(sqlString);
			ps.setString(1, s.getName());
			ps.setInt(2, s.getForumid());
			ps.executeUpdate();
			
			sqlString = "SELECT LAST_INSERT_ID;";
			returnvalue = ps.executeUpdate();

			ps.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnvalue;
	}

	// Add forum to DB.
	public boolean addForum(Forum f) throws Exception {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "INSERT INTO FORUM (" + "name, moderatorid, category) " + "VALUES (?, ?, ?)";

			ps = con.prepareStatement(sqlString);
			ps.setString(1, f.getName());
			ps.setInt(2, f.getModeratorid());
			ps.setString(3, f.getCategory());
			ps.executeUpdate();

			ps.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	//Add rating to DB
	public boolean insertRating(int postingId, int userId, int rating) throws Exception {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "INSERT INTO POSTINGRATING (" + "rating, postingId, userId) " + "VALUES (?, ?, ?)";

			ps = con.prepareStatement(sqlString);
			ps.setInt(1, rating);
			ps.setInt(2, postingId);
			ps.setInt(3, userId);
			ps.executeUpdate();

			ps.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	//Add Tag to a Post in DB
	public boolean addTag(int postingId, String tag) {
		Connection con = null;
		PreparedStatement ps = null;

		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "INSERT INTO POSTINGTAG (" + "postingId, tag) " + "VALUES (?, ?)";

			ps = con.prepareStatement(sqlString);
			ps.setInt(1, postingId);
			ps.setString(2, tag);
			ps.executeUpdate();

			ps.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	/**
	 * Get User by first and last name. Does return 1 User. Warning: first and last name do not have to be unique
	 * @param fName	the first name of the User
	 * @param lName	the last name of the User
	 * @return		a User Object
	 * @see			User
	 * @author		Andreas Memmel
	 */
	public User getUserByName(String fName, String lName) {
		Connection con = null;
		ResultSet rs;
		User newUser = null;

		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "SELECT ID, firstname, lastname, email, role, pwsalt, pwhash FROM USER WHERE firstname=? AND lastname=? LIMIT 1;";

			PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setString(1, fName);
			ps.setString(2, lName);

			rs = ps.executeQuery();

			if (!rs.next()) {
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
		} catch (Exception e) {
			e.printStackTrace();
		}
		return newUser;
	}

	//Get User from DB by Email. returns 1 User. email is unique.
	public User getUserByEmail(String email) {
		Connection con = null;
		ResultSet rs;
		User newUser = null;

		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "SELECT ID, firstname, lastname, email, role, pwsalt, pwhash, imgurl FROM USER WHERE email=?;";

			PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setString(1, email);

			rs = ps.executeQuery();

			if (!rs.next()) {
				return null;
			}

			newUser = new User(rs.getInt("ID"));
			newUser.setFirstname(rs.getString("firstname"));
			newUser.setLastname(rs.getString("lastname"));
			newUser.setEmail(rs.getString("email"));
			newUser.setRole(rs.getInt("role"));
			newUser.setPwSalt(rs.getString("pwsalt"));
			newUser.setPwHash(rs.getString("pwhash"));
			newUser.setImgUrl(rs.getString("imgurl"));

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return newUser;
	}

	//Get User from DB by ID
	public User getUserById(int id) {
		Connection con = null;
		ResultSet rs;
		User newUser = null;

		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "SELECT ID, firstname, lastname, email, role, pwsalt, pwhash, imgurl FROM USER WHERE id=?;";

			PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setInt(1, id);

			rs = ps.executeQuery();

			if (!rs.next()) {
				return null;
			}

			newUser = new User(rs.getInt("ID"));
			newUser.setFirstname(rs.getString("firstname"));
			newUser.setLastname(rs.getString("lastname"));
			newUser.setEmail(rs.getString("email"));
			newUser.setRole(rs.getInt("role"));
			newUser.setPwSalt(rs.getString("pwsalt"));
			newUser.setPwHash(rs.getString("pwhash"));
			newUser.setImgUrl(rs.getString("imgurl"));

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return newUser;
	}

	//Get Post form DB by ID
	public Posting getPostingById(int id) {
		Connection con = null;
		ResultSet rs;
		Posting newPosting = null;

		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "SELECT ID, authorid, text, subjectid, whendeleted, whenposted, "
					+ "(SELECT GROUP_CONCAT(tag) FROM POSTINGTAG WHERE postingid=?) AS tags, "
					+ "(SELECT SUM(rating) FROM POSTINGRATING WHERE rating = 1 AND postingid=?) AS posrat, "
					+ "(SELECT SUM(rating) FROM POSTINGRATING WHERE rating = -1 AND postingid=?) AS negrat "
					+ "FROM POSTING WHERE id=?;";

			PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setInt(1, id);
			ps.setInt(2, id);
			ps.setInt(3, id);
			ps.setInt(4, id);

			rs = ps.executeQuery();

			if (!rs.next()) {
				return null;
			}

			newPosting = new Posting(rs.getInt("ID"));
			newPosting.setMessage(rs.getString("text"));
			newPosting.setUserId(rs.getInt("authorid"));
			newPosting.setSubjectId(rs.getInt("subjectid"));
			newPosting.setWhenDeleted(rs.getTimestamp("whendeleted"));
			newPosting.setWhenPosted(rs.getTimestamp("whenposted"));
			newPosting.setTags(rs.getString("tags").split(","));
			newPosting.setPosRat(rs.getInt("posrat"));
			newPosting.setNegRat(rs.getInt("negrat"));

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return newPosting;
	}

	public List<Posting> getPostingsBySubject(int subjectId) {
		Connection con = null;
		ResultSet rs;
		List<Posting> postings = new ArrayList<Posting>();

		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "SELECT parent.ID, parent.authorid, parent.subjectid, parent.text, parent.whenposted, parent.whendeleted, "
					+ "(SELECT GROUP_CONCAT(t.tag) FROM POSTINGTAG t WHERE t.postingId = parent.ID) AS tags, "
					+ "(SELECT SUM(rating) FROM POSTINGRATING r WHERE r.rating = 1 AND r.postingid = parent.ID) AS posrat, "
					+ "(SELECT SUM(rating) FROM POSTINGRATING r WHERE r.rating = -1 AND r.postingid = parent.ID) AS negrat "
					+ "FROM POSTING AS parent " + "WHERE subjectid=?;";

			PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setInt(1, subjectId);
			rs = ps.executeQuery();

			while (rs.next()) {
				Posting posting = new Posting(rs.getInt("ID"));
				posting.setUserId(rs.getInt("authorid"));
				posting.setSubjectId(rs.getInt("subjectid"));
				// posting.setUser(new User(rs.getInt("authorid")));
				posting.setMessage(rs.getString("text"));
				posting.setWhenPosted(rs.getTimestamp("whenposted"));
				posting.setWhenDeleted(rs.getTimestamp("whendeleted"));
				if (null != rs.getString("tags")) {
					posting.setTags(rs.getString("tags").split(","));
				}
				posting.setPosRat(rs.getInt("posrat"));
				posting.setNegRat(rs.getInt("negrat"));
				postings.add(posting);
			}

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return postings;
	}

	public List<Posting> getPopularPostings() {
		Connection con = null;
		ResultSet rs;
		List<Posting> postings = new ArrayList<Posting>();

		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "SELECT parent.ID, parent.authorid, parent.subjectid, parent.text, parent.whenposted, parent.whendeleted, "
					+ "(SELECT GROUP_CONCAT(t.tag) FROM POSTINGTAG t WHERE t.postingId = parent.ID) AS tags, "
					+ "(SELECT SUM(rating) FROM POSTINGRATING r WHERE rating = 1 AND r.postingid = parent.ID) AS posrat, "
					+ "(SELECT SUM(rating) FROM POSTINGRATING r WHERE rating = -1 AND r.postingid = parent.ID) AS negrat "
					+ "FROM POSTING AS parent";

			PreparedStatement ps = con.prepareStatement(sqlString);
			rs = ps.executeQuery();

			while (rs.next()) {
				Posting posting = new Posting(rs.getInt("ID"));
				posting.setUserId(rs.getInt("authorid"));
				posting.setSubjectId(rs.getInt("subjectid"));
				posting.setMessage(rs.getString("text"));
				posting.setWhenPosted(rs.getTimestamp("whenposted"));
				posting.setWhenDeleted(rs.getTimestamp("whendeleted"));
				posting.setTags(rs.getString("tags").split(","));
				posting.setPosRat(rs.getInt("posrat"));
				posting.setNegRat(rs.getInt("negrat"));
				postings.add(posting);
			}

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return postings;
	}

	public List<Posting> getPostingsByForum(int forumid) {
		Connection con = null;
		ResultSet rs;
		List<Posting> postings = new ArrayList<Posting>();

		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "SELECT parent.ID, parent.authorid, parent.subjectid, parent.text, parent.whenposted, parent.whendeleted, "
					+ "(SELECT GROUP_CONCAT(t.tag) FROM POSTINGTAG t WHERE t.postingId = parent.ID) AS tags, "
					+ "(SELECT SUM(rating) FROM POSTINGRATING r WHERE r.rating = 1 AND r.postingid = parent.ID) AS posrat, "
					+ "(SELECT SUM(rating) FROM POSTINGRATING r WHERE r.rating = -1 AND r.postingid = parent.ID) AS negrat "
					+ "FROM POSTING AS parent " 
					+ "WHERE subjectid IN (SELECT subjectid FROM subject WHERE forumid = ?);";

			PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setInt(1, forumid);
			rs = ps.executeQuery();

			while (rs.next()) {
				Posting posting = new Posting(rs.getInt("ID"));
				posting.setUserId(rs.getInt("authorid"));
				posting.setSubjectId(rs.getInt("subjectid"));
				posting.setMessage(rs.getString("text"));
				posting.setWhenPosted(rs.getTimestamp("whenposted"));
				posting.setWhenDeleted(rs.getTimestamp("whendeleted"));
				if (null != rs.getString("tags")) {
					posting.setTags(rs.getString("tags").split(","));
				}
				posting.setPosRat(rs.getInt("posrat"));
				posting.setNegRat(rs.getInt("negrat"));
				postings.add(posting);
			}

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return postings;
	}
	
	public List<Posting> getPostingsByUser(int userId) {
		Connection con = null;
		ResultSet rs;
		List<Posting> postings = new ArrayList<Posting>();

		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "SELECT parent.ID, parent.authorid, parent.subjectid, parent.text, parent.whenposted, parent.whendeleted, "
					+ "(SELECT GROUP_CONCAT(t.tag) FROM POSTINGTAG t WHERE t.postingId = parent.ID) AS tags, "
					+ "(SELECT SUM(rating) FROM POSTINGRATING r WHERE rating = 1 AND r.postingid = parent.ID) AS posrat, "
					+ "(SELECT SUM(rating) FROM POSTINGRATING r WHERE rating = -1 AND r.postingid = parent.ID) AS negrat "
					+ "FROM POSTING AS parent " + "WHERE authorid=?;";

			PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setInt(1, userId);
			rs = ps.executeQuery();

			while (rs.next()) {
				Posting posting = new Posting(rs.getInt("ID"));
				posting.setUserId(rs.getInt("authorid"));
				posting.setSubjectId(rs.getInt("subjectid"));
				posting.setMessage(rs.getString("text"));
				posting.setWhenPosted(rs.getTimestamp("whenposted"));
				posting.setWhenDeleted(rs.getTimestamp("whendeleted"));
				posting.setTags(rs.getString("tags").split(","));
				posting.setPosRat(rs.getInt("posrat"));
				posting.setNegRat(rs.getInt("negrat"));
				postings.add(posting);
			}

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return postings;
	}

	public List<Posting> getPostingsByTag(String tag) {
		Connection con = null;
		ResultSet rs;
		List<Posting> postings = new ArrayList<Posting>();

		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "SELECT parent.ID, parent.authorid, parent.subjectid, parent.text, parent.whenposted, parent.whendeleted, "
					+ "(SELECT GROUP_CONCAT(t.tag) FROM POSTINGTAG t WHERE t.postingId = parent.ID) AS tags, "
					+ "(SELECT SUM(rating) FROM POSTINGRATING r WHERE rating = 1 AND r.postingid = parent.ID) AS posrat, "
					+ "(SELECT SUM(rating) FROM POSTINGRATING r WHERE rating = -1 AND r.postingid = parent.ID) AS negrat "
					+ "FROM POSTING AS parent "
					+ "WHERE parent.ID IN (SELECT postingid FROM postingtag WHERE tag = ?);";

			PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setString(1, tag);
			rs = ps.executeQuery();

			while (rs.next()) {
				Posting posting = new Posting(rs.getInt("ID"));
				posting.setUserId(rs.getInt("authorid"));
				posting.setSubjectId(rs.getInt("subjectid"));
				posting.setMessage(rs.getString("text"));
				posting.setWhenPosted(rs.getTimestamp("whenposted"));
				posting.setWhenDeleted(rs.getTimestamp("whendeleted"));
				posting.setTags(rs.getString("tags").split(","));
				posting.setPosRat(rs.getInt("posrat"));
				posting.setNegRat(rs.getInt("negrat"));
				postings.add(posting);
			}

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return postings;
	}
	
	public List<Posting> getLatestPostings() {
		Connection con = null;
		ResultSet rs;
		List<Posting> postings = new ArrayList<Posting>();

		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "SELECT parent.ID, parent.authorid, parent.subjectid, parent.text, parent.whenposted, parent.whendeleted FROM forum.POSTING AS parent Order by parent.whenPosted DESC LIMIT 4;";

			PreparedStatement ps = con.prepareStatement(sqlString);
			rs = ps.executeQuery();

			while (rs.next()) {
				Posting posting = new Posting(rs.getInt("ID"));
				posting.setUserId(rs.getInt("authorid"));
				posting.setSubjectId(rs.getInt("subjectid"));
				posting.setMessage(rs.getString("text"));
				posting.setWhenPosted(rs.getTimestamp("whenposted"));
				posting.setWhenDeleted(rs.getTimestamp("whendeleted"));
				postings.add(posting);
			}

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return postings;	
	}
	
	public List<Posting> searchPostings(String searchTerm) {
			Connection con = null;
			ResultSet rs;
			List<Posting> postings = new ArrayList<Posting>();

			try {
				con = MySQLDatabase.getInstance().getConnection();

				String sqlString = "SELECT parent.ID, parent.authorid, parent.subjectid, parent.text, parent.whenposted, parent.whendeleted, "
						+ "(SELECT GROUP_CONCAT(t.tag) FROM POSTINGTAG t, POSTING p WHERE p.ID = parent.ID AND t.postingId = p.ID) AS tags, "
						+ "(SELECT SUM(rating) FROM POSTINGRATING r, POSTING p WHERE p.ID = parent.ID AND rating = 1 AND r.postingid = p.id) AS posrat, "
						+ "(SELECT SUM(rating) FROM POSTINGRATING r, POSTING p WHERE p.ID = parent.ID AND rating = -1 AND r.postingid = p.id) AS negrat "
						+ "From Posting as parent "
						+ "WHERE ";

				String[] searchwords = searchTerm.split(" ");
				for (int i = 0; i < searchwords.length; i++) {
					if(i == 0) {
						sqlString = sqlString.concat("parent.text like '%" + searchwords[i] + "%' ");
					}else {
						sqlString = sqlString.concat("AND parent.text like '%" + searchwords[i] + "%' ");
					}
				}
				sqlString = sqlString.concat(";");

				PreparedStatement ps = con.prepareStatement(sqlString);
				rs = ps.executeQuery();

				while (rs.next()) {
					Posting posting = new Posting(rs.getInt("ID"));
					posting.setUserId(rs.getInt("authorid"));
					posting.setSubjectId(rs.getInt("subjectid"));
					posting.setMessage(rs.getString("text"));
					posting.setWhenPosted(rs.getTimestamp("whenposted"));
					posting.setWhenDeleted(rs.getTimestamp("whendeleted"));
					if(rs.getString("tags") != null) {
						posting.setTags(rs.getString("tags").split(","));
					}
					posting.setPosRat(rs.getInt("posrat"));
					posting.setNegRat(rs.getInt("negrat"));
					postings.add(posting);
				}

				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return postings;
		//return null;
	}

	/**
	 * 
	 * @author Fabian Schulz, Andreas Memmel
	 */
	public List<Posting> searchPostings(String searchTerm, int forumid, String tag, Date minDate, Date maxDate, boolean myPosting) {
		Connection con = null;
		ResultSet rs;
		List<Posting> postings = new ArrayList<Posting>();

		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "SELECT parent.ID, parent.authorid, parent.subjectid, parent.text, parent.whenposted, parent.whendeleted, "
					+ "(SELECT GROUP_CONCAT(t.tag) FROM POSTINGTAG t, POSTING p WHERE p.ID = parent.ID AND t.postingId = p.ID) AS tags, "
					+ "(SELECT SUM(rating) FROM POSTINGRATING r, POSTING p WHERE p.ID = parent.ID AND rating = 1 AND r.postingid = p.id) AS posrat, "
					+ "(SELECT SUM(rating) FROM POSTINGRATING r, POSTING p WHERE p.ID = parent.ID AND rating = -1 AND r.postingid = p.id) AS negrat "
					+ "From Posting as parent "
					+ "Where parent.subjectid in (Select subjectid From subject where forumid = ?) "
					+ "And parent.whenposted Between ? AND ? "
					+ "AND parent.postingID IN (SELECT postingId where tag = ?)";

			String[] searchwords = searchTerm.split(" ");
			for (int i = 0; i < searchwords.length; i++) {
				sqlString.concat("AND p.text like '%" + searchwords[i] + "%'");
			}

			PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setInt(1, forumid);
			ps.setDate(2, minDate);
			ps.setDate(3, maxDate);
			ps.setString(4, tag);
			rs = ps.executeQuery();

			while (rs.next()) {
				Posting posting = new Posting(rs.getInt("ID"));
				posting.setUserId(rs.getInt("authorid"));
				posting.setSubjectId(rs.getInt("subjectid"));
				posting.setMessage(rs.getString("text"));
				posting.setWhenPosted(rs.getTimestamp("whenposted"));
				posting.setWhenDeleted(rs.getTimestamp("whendeleted"));
				posting.setTags(rs.getString("tags").split(","));
				posting.setPosRat(rs.getInt("posrat"));
				posting.setNegRat(rs.getInt("negrat"));
				postings.add(posting);
			}

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return postings;
	}

	public List<Integer> getSubjectIDsByForum(int forumId) {
		Connection con = null;
		ResultSet rs;
		List<Integer> subjects = new ArrayList<Integer>();

		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "SELECT id FROM SUBJECT WHERE forumid=?;";

			PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setInt(1, forumId);
			rs = ps.executeQuery();

			while (rs.next()) {
				subjects.add(rs.getInt("id"));
			}

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return subjects;
	}

	public Subject getSubjectById(int subjectid) {
		Connection con = null;
		ResultSet rs;
		Subject subject = null;

		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "SELECT id, name, forumid "
					+ "FROM SUBJECT "
					+ "WHERE id = ?";

			PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setInt(1, subjectid);
			rs = ps.executeQuery();

			if (rs.next()) {
				subject = new Subject(rs.getInt("id"));
				subject.setName(rs.getString("name"));
				subject.setForumid(rs.getInt("forumid"));
			}

			ps.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return subject;
	}
	
	public List<Attachment> getAttachmentsByPostingId(int postingid) {
		Connection con = null;
		ResultSet rs;
		List<Attachment> attachments = new ArrayList<Attachment>();

		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "SELECT id, attachmentfilename, postingid FROM ATTACHMENT WHERE postingid=?;";

			PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setInt(1, postingid);
			rs = ps.executeQuery();

			while (rs.next()) {
				Attachment attachment = new Attachment(rs.getInt("id"));
				attachment.setAttachment(rs.getString("attachmentfilename"));
				attachment.setPostingid(rs.getInt("postingid"));
				attachments.add(attachment);
			}

			ps.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return attachments;
	}
	
	public int[] getRatingByPostingId(int postingId) {
		Connection con = null;
		ResultSet rs;
		int[] rating = { 0, 0 };

		try {
			con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "SELECT COUNT(rating) AS posrat FROM POSTINGRATING WHERE postingid=? AND rating = 1;";

			PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setInt(1, postingId);
			rs = ps.executeQuery();

			while (rs.next()) {
				rating[0] = rs.getInt("posrat");
			}

			sqlString = "SELECT COUNT(rating) AS negrat FROM POSTINGRATING WHERE postingid=? AND rating = -1;";

			ps = con.prepareStatement(sqlString);
			ps.setInt(1, postingId);
			rs = ps.executeQuery();

			while (rs.next()) {
				rating[1] = rs.getInt("negrat");
			}

			con.close();
		} catch (Exception e) {
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

			String sqlString = "SELECT ID FROM user " + "WHERE email = ?";

			PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();

			if (rs.next())
				return true;

			rs.close();
			ps.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	/**
	 * 
	 * @author Michael Skrzypietz
	 */
	public static boolean updateProfilSettings(User user) {
		try {
			Connection con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "UPDATE USER " + "SET firstname = ?, lastname = ?, email = ? " + "WHERE ID = ?";

			PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setString(1, user.getFirstname());
			ps.setString(2, user.getLastname());
			ps.setString(3, user.getEmail());
			ps.setInt(4, user.getId());
			ps.executeUpdate();

			ps.close();
			con.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	/**
	 * 
	 * @author Michael Skrzypietz
	 */
	public static boolean updatePassword(User user) {
		try {
			Connection con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "UPDATE USER " + "SET pwhash = ? " + "WHERE ID = ?";

			PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setString(1, user.getPwHash());
			ps.setInt(2, user.getId());
			ps.executeUpdate();

			ps.close();
			con.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	/**
	 * 
	 * @author Michael Skrzypietz
	 */
	public static boolean updateImgurl(User user) {
		try {
			Connection con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "UPDATE USER " + "SET imgurl = ? " + "WHERE ID = ?";

			PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setString(1, user.getImgUrl());
			ps.setInt(2, user.getId());
			ps.executeUpdate();

			ps.close();
			con.close();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public boolean hasUserRated(int postingId, int userId) {
		try {
			Connection con = MySQLDatabase.getInstance().getConnection();

			String sqlString = "SELECT postingid FROM POSTINGRATING " + "WHERE postingId = ? AND userId = ?";

			PreparedStatement ps = con.prepareStatement(sqlString);
			ps.setInt(1, postingId);
			ps.setInt(2, userId);
			ResultSet rs = ps.executeQuery();

			if (rs.next())
				return true;

			rs.close();
			ps.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}
}

