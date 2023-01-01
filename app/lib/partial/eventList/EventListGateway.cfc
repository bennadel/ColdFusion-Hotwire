component
	output = false
	hint = "I provide data-access methods for the event list partial."
	{

	/**
	* I get the events.
	*/
	public array function getEvents() {

		```
		<cfquery name="local.results" result="local.metaResults" returnType="array">
			/* DEBUG: eventListGateway.getEvents(). */
			SELECT
				-- Get the event information.
				e.id,
				e.name,
				e.occurredAt,

				-- Get the tip information.
				tips.amountInCentsTotal,
				tips.pendingAmountInCentsTotal
			FROM
				event e
			INNER JOIN LATERAL
				(

					SELECT
						SUM( tip.amountInCents ) AS amountInCentsTotal,
						SUM( IF( tip.isCompleted, 0, tip.amountInCents ) ) AS pendingAmountInCentsTotal
					FROM
						tip
					WHERE
						tip.eventID = e.id

				) AS tips
			ORDER BY
				e.occurredAt DESC
		</cfquery>
		```

		return( results );

	}

}
