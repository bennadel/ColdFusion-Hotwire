component
	output = false
	hint = "I provide data-access methods for the event detail partial."
	{

	/**
	* I get the tips.
	*/
	public array function getTips( required numeric eventID ) {

		```
		<cfquery name="local.results" result="local.metaResults" returnType="array">
			/* DEBUG: eventDetailGateway.getTips(). */
			SELECT
				-- Get tip information.
				t.id,
				t.amountInCents,
				t.notes,
				t.createdAt,
				t.isCompleted,
				t.completedAt,

				-- Get tippee information.
				( e.id ) AS tippeeID,
				( e.name )AS tippeeName
			FROM
				tip t
			INNER JOIN
				tippee e
			ON
				(
						t.eventID = <cfqueryparam value="#eventID#" sqltype="bigint" />
					AND
						e.id = t.tippeeID
				)
			ORDER BY
				e.name ASC,
				e.id ASC
		</cfquery>
		```

		return( results );

	}

}
