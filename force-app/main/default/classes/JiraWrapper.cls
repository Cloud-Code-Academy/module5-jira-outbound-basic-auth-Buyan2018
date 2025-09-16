/**
 * Wrapper classes for Jira entities (Project and Issue)
 */
public class JiraWrapper {
	private static final String LEAD_ACCOUNT_ID = '6290d5b1d5ec4f0069ea4615';
	private static final String PROJECT_TEMPLATE_KEY = 'com.pyxis.greenhopper.jira:basic-software-development-template';
	private static final String ASSIGNEE_TYPE = 'PROJECT_LEAD';
	private static final Integer AVATAR_ID = 10200;
	private static final Integer CATEGORY_ID = 10000;
	private static final Integer ISSUE_SECURITY_SCHEME = 10034;
	private static final Integer NOTIFICATION_SCHEME = 10000;
	private static final Integer PERMISSION_SCHEME = 0;
	private static final String PROJECT_TYPE_KEY = 'business';
	private static final String URL = 'http://atlassian.com';
	public String id { get; set; }
	public String key { get; set; }

	/**
	 * Wrapper for Jira Project
	 */
	public class ProjectWrapper {
		public String name;
		public String key;
		public String description;
		public String leadAccountId;
		public String projectTemplateKey;
		public String assigneeType;
		public Integer avatarId;
		public Integer categoryId;
		public Integer issueSecurityScheme;
		public Integer notificationScheme;
		public Integer permissionScheme;
		public String projectTypeKey;
		public String url;

		/**
		 * Constructor for ProjectWrapper
		 */
		public ProjectWrapper(String name, String key, String description) {
			this.name = name;
			this.key = key;
			this.description = description;
			this.leadAccountId = LEAD_ACCOUNT_ID;
			this.projectTemplateKey = PROJECT_TEMPLATE_KEY;
			this.assigneeType = ASSIGNEE_TYPE;
			this.avatarId = AVATAR_ID;
			this.categoryId = CATEGORY_ID;
			this.issueSecurityScheme = ISSUE_SECURITY_SCHEME;
			this.notificationScheme = NOTIFICATION_SCHEME;
			this.permissionScheme = PERMISSION_SCHEME;
			this.projectTypeKey = PROJECT_TYPE_KEY;
			this.url = URL;
		}
	}

	/**
	 * Wrapper for Jira Issue
	 */
	public class IssueWrapper {
		public String name;
		public String key;
		public String description;
		public String projectKey;
		public String summary;
		public String issueType;

		/**
		 * Constructor for IssueWrapper
		 */
		public IssueWrapper(
			String projectKey,
			String summary,
			String description,
			String issueType
		) {
			this.projectKey = projectKey;
			this.summary = summary;
			this.description = description;
			this.issueType = (String.isNotBlank(issueType)) ? issueType : 'Task';
		}

		/**
		 * Convert IssueWrapper to a Map for serialization
		 *
		 * TODO: Implement this method to create a Map that represents
		 * the JSON payload needed for the Jira API. The Map should contain:
		 * - fields object with project information (key)
		 * - issuetype object with the issue type name
		 * - summary field
		 * - description field (formatted using formatDescription method)
		 * - Example:
		 */
		public Map<String, Object> generateIssuePayloadMap() {
			// Your implementation goes here
			Map<String, Object> issueMap = new Map<String, Object>();
			Map<String, Object> assigneeMap = new Map<String, Object>();
			Map<String, Object> issueTypeMap = new Map<String, Object>();
			Map<String, Object> projectMap = new Map<String, Object>();
			assigneeMap.put('id', LEAD_ACCOUNT_ID);
			issueMap.put('assignee', assigneeMap);
			issueMap.put('description', formatDescription(description));
			issueTypeMap.put('name', issueType);
			issueMap.put('issuetype', issueTypeMap);
			projectMap.put('key', projectKey);
			issueMap.put('project', projectMap);
			issueMap.put('summary', summary);
			return issueMap;
		}

		/**
		 * Format description as per Jira Cloud API requirements
		 *
		 * TODO: Implement this method to format the description text
		 * according to Jira Cloud API requirements.
		 * - Create a Map with type="doc" and version=1
		 * - Add content array with paragraph object
		 * - Add text object inside paragraph content with the description
		 * - Example:
		 *   {
		 *     "description": {
		 *       "type": "doc",
		 *       "version": 1,
		 *       "content": [
		 *         {
		 *           "type": "paragraph",
		 *           "content": [
		 *             {
		 *               "type": "text",
		 *               "text": "Order entry fails when selecting supplier."
		 *             }
		 *           ]
		 *         }
		 *       ]
		 *     }
		 *   }
		 */
		private Map<String, Object> formatDescription(String descText) {
			// Your implementation goes here
			Map<String, Object> descriptionMap = new Map<String, Object>();
			Map<String, Object> contentMap = new Map<String, Object>();
			Map<String, Object> subContentMap = new Map<String, Object>();
			descriptionMap.put('type', 'doc');
			descriptionMap.put('version', 1);
			contentMap.put('type', 'paragraph');
			subContentMap.put('text', descText);
			subContentMap.put('type', 'text');
			contentMap.put('content', subContentMap);
			descriptionMap.put('content', contentMap);
			return descriptionMap;
		}
	}
}