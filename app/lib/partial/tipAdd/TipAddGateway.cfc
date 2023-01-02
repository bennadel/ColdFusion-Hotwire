component
	output = false
	hint = "I provide data-access methods for the tip add partial."
	{

	/**
	* I get the events.
	*/
	public array function getEvents() {

		```
		<cfquery name="local.results" result="local.metaResults" returnType="array">
			/* DEBUG: tipAddGateway.getEvents(). */
			SELECT
				e.id,
				e.name,
				e.occurredAt
			FROM
				event e
			ORDER BY
				e.occurredAt DESC
			LIMIT
				10
		</cfquery>
		```

		return( results );

	}


	/**
	* I get the tippees.
	*/
	public array function getTippees() {

		```
		<cfquery name="local.results" result="local.metaResults" returnType="array">
			/* DEBUG: tipAddGateway.getTippees(). */
			SELECT
				t.id,
				t.name,
				t.occupation
			FROM
				tippee t
			ORDER BY
				t.name ASC
		</cfquery>
		```

		return( results );

	}

}
