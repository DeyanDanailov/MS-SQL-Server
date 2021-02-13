SELECT i.Id,
		u.Username + ' : ' + i.Title AS IssueAssignee
	FROM Issues i
		LEFT JOIN Users u ON u.Id = i.AssigneeId
	ORDER BY i.Id DESC, IssueAssignee