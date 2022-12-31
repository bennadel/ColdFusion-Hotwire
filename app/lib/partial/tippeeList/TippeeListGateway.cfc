component
	output = false
	hint = "I provide data-access methods for the tippee list partial."
	{

	/**
	* I get the tippees.
	*/
	public array function getTippees() {

		```
		<cfquery name="local.results" result="local.metaResults" returnType="array">
			/* DEBUG: tippeeListGateway.getTippees(). */
			SELECT
				t.id,
				t.name,
				t.occupation,
				t.createdAt,

				-- Get the total tip amount.
				(

					SELECT
						SUM( tip.amountInCents )
					FROM
						tip
					WHERE
						tip.tippeeID = t.id

				) AS tipTotal,

				-- Get the pending tip amount.
				(

					SELECT
						SUM( tip.amountInCents )
					FROM
						tip
					WHERE
						tip.tippeeID = t.id
					AND
						tip.isCompleted = FALSE

				) AS pendingTipTotal
			FROM
				tippee t
			ORDER BY
				t.name ASC,
				t.id ASC
		</cfquery>
		```

		return( results );

	}

}
