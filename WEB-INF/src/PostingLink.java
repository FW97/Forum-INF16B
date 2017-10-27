package de.dhbw.StudentForum;

import java.util.Date;

/**
 * 
 * @author Michael Skrzypietz
 */

public class PostingLink {
	
	private int postingId;
	private String forumName;
	private String subjectName;
	private String postingTitle;
	private String[] tags;
	private String authorName;
	private String whenPosted;
	private int responses;
	
	public PostingLink() {	
	}

	public int getPostingId() {
		return postingId;
	}

	public void setPostingId(int postingId) {
		this.postingId = postingId;
	}

	public String getForumName() {
		return forumName;
	}

	public void setForumName(String forumName) {
		this.forumName = forumName;
	}

	public String getSubjectName() {
		return subjectName;
	}

	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}

	public String getPostingTitle() {
		return postingTitle;
	}

	public void setPostingTitle(String postingTitle) {
		this.postingTitle = postingTitle;
	}

	public String[] getTags() {
		return tags;
	}

	public void setTags(String[] tags) {
		this.tags = tags;
	}

	public String getAuthorName() {
		return authorName;
	}

	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}

	public String getWhenPosted() {
		return whenPosted;
	}

	public void setWhenPosted(String whenPosted) {
		this.whenPosted = whenPosted;
	}

	public int getResponses() {
		return responses;
	}

	public void setResponses(int responses) {
		this.responses = responses;
	}
	
}
