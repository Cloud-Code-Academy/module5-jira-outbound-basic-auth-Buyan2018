/**
 * Service class for making callouts to the Jira API
 */
public with sharing class JiraAPIService {
	/**
	 * Creates a project in Jira
	 * @param projectWrapper The project wrapper object containing all necessary data
	 * @return String The Jira project ID
	 *
	 * TODO: Implement this method to make a callout to Jira API to create a project
	 * Reminder: Extract and return the project ID from the response
	 */
	private static final String API_NAMED_CREDENTIALS = 'callout:JiraAPI';
	public static String createProject(JiraWrapper.ProjectWrapper projectWrapper) {
		// Your implementation goes here
		Http http = new Http();
		HttpRequest req = new HttpRequest();
		String endpointEnding = '/project';
		req.setEndpoint(API_NAMED_CREDENTIALS + endpointEnding);
		req.setMethod('POST');
		req.setBody(JSON.serialize(projectWrapper));

		HttpResponse res = http.send(req);
		String projectId;
		String stringResp = res.getBody();
		JiraWrapper jiraResponse;
		if (res.getStatusCode() >= 200 && res.getStatusCode() <= 299) {
			jiraResponse = (JiraWrapper)JSON.deserialize(stringResp, JiraWrapper.class);
			projectId = jiraResponse.id;
		}
		return projectId;
	}

	/**
	 * Creates an issue in Jira
	 * @param issueWrapper The issue wrapper object containing all necessary data
	 * @return String The Jira issue key
	 *
	 * TODO: Implement this method to make a callout to Jira API to create an issue
	 * Reminder: Extract and return the issue key from the response
	 */
	public static String createIssue(JiraWrapper.IssueWrapper issueWrapper) {
		// Your implementation goes here
		Http http = new Http();
		HttpRequest req = new HttpRequest();
		String endpointEnding = '/issue';
		req.setEndpoint(API_NAMED_CREDENTIALS + endpointEnding);
		req.setMethod('POST');
		req.setBody(JSON.serialize(issueWrapper.generateIssuePayloadMap()));

		HttpResponse res = http.send(req);
		String issueKey;
		String stringResp = res.getBody();
		JiraWrapper jiraResponse;
		if (res.getStatusCode() >= 200 && res.getStatusCode() <= 299) {
			jiraResponse = (JiraWrapper)JSON.deserialize(stringResp, JiraWrapper.class);
			issueKey = jiraResponse.key;
		}
		return issueKey;
	}
}