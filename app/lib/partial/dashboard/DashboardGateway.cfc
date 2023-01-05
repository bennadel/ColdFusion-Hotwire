component
	output = false
	hint = "I provide data-access methods for the dashboard partial."
	{

	/**
	* I get the pending tips.
	*/
	public array function getTips() {

		```
		<cfquery name="local.results" result="local.metaResults" returnType="array">
			/* DEBUG: dashboardGateway.getTips(). */
			SELECT
				-- Get the tip information.
				t.id,
				t.amountInCents,
				t.createdAt,

				-- Get the tippee information.
				( e.id ) AS tippeeID,
				( e.name ) AS tippeeName,

				-- Get the event information.
				( v.id ) AS eventID,
				( v.name ) AS eventName
			FROM
				tip t
			INNER JOIN
				tippee e
			ON
				(
						t.isCompleted = FALSE
					AND
						e.id = t.tippeeID
				)
			LEFT OUTER JOIN
				event v
			ON
				v.id = t.eventID
			ORDER BY
				t.id DESC
		</cfquery>
		```

		return( results );

	}

}
