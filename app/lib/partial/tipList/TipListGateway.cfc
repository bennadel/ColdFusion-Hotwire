component
	output = false
	hint = "I provide data-access methods for the tip list partial."
	{

	/**
	* I get the tips.
	*/
	public array function getTips() {

		```
		<cfquery name="local.results" result="local.metaResults" returnType="array">
			/* DEBUG: tipListGateway.getTips(). */
			SELECT
				-- Get the tip information.
				t.id,
				t.amountInCents,
				t.createdAt,
				t.isCompleted,
				t.completedAt,

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
				e.id = t.tippeeID
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
