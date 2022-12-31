component
	output = false
	hint = "I provide data-access methods for the tippee detail partial."
	{

	/**
	* I get the recent tips for the given tippee.
	*/
	public array function getTips( required numeric tippeeID ) {

		```
		<cfquery name="local.results" result="local.metaResults" returnType="array">
			/* DEBUG: tippeeDetailGateway.getTips(). */
			SELECT
				-- Get tip information.
				t.id,
				t.amountInCents,
				t.notes,
				t.createdAt,
				t.isCompleted,
				t.completedAt,

				-- Get event information (may be null).
				( e.id ) AS eventID,
				( e.name ) AS eventName
			FROM
				tip t
			LEFT OUTER JOIN
				event e
			ON
				e.id = t.eventID
			WHERE
				t.tippeeID = <cfqueryparam value="#tippeeID#" sqltype="bigint" />
			ORDER BY
				t.id DESC
			LIMIT
				50
			;
		</cfquery>
		```

		return( results );

	}

}
