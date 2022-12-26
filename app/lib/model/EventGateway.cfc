component
	output = false
	hint = "I provide data-access methods for the event model."
	{

	/**
	* I create a new event and return the generated ID.
	*/
	public numeric function createEvent(
		required string name,
		required date occurredAt
		) {

		```
		<cfquery name="local.results" result="local.metaResults">
			/* DEBUG: eventGateway.createEvent(). */
			INSERT INTO
				event
			SET
				name = <cfqueryparam value="#name#" sqltype="varchar" />,
				occurredAt = <cfqueryparam value="#occurredAt#" sqltype="timestamp" />
			;
		</cfquery>
		```

		return( val( metaResults.generatedKey ) );

	}


	/**
	* I delete the events that match the given filters.
	*/
	public void function deleteEventByFilter( numeric id ) {

		// Make sure at least one index-oriented (prefix) column is provided so that we
		// don't accidentally delete the entire table.
		if ( isNull( id ) ) {

			throw(
				type = "UnboundedQuery",
				message = "An unbounded DELETE was going to be performed."
			);

		}

		```
		<cfquery name="local.results" result="local.metaResults">
			/* DEBUG: eventGateway.deleteEventByFilter(). */
			DELETE FROM
				event
			WHERE
				TRUE

			<cfif arguments.keyExists( "id" )>
				AND
					id = <cfqueryparam value="#id#" sqltype="bigint" />
			</cfif>
			;
		</cfquery>
		```

	}


	/**
	* I get the events that match the given filters.
	*/
	public query function getEventByFilter( numeric id ) {

		// Make sure at least one index-oriented (prefix) column is provided so that we
		// don't accidentally select the entire table.
		if ( isNull( id ) ) {

			throw(
				type = "UnboundedQuery",
				message = "An unbounded SELECT was going to be performed."
			);

		}

		```
		<cfquery name="local.results" result="local.metaResults">
			/* DEBUG: eventGateway.getEventByFilter(). */
			SELECT
				e.id,
				e.name,
				e.occurredAt
			FROM
				event e
			WHERE
				TRUE

			<cfif arguments.keyExists( "id" )>
				AND
					e.id = <cfqueryparam value="#id#" sqltype="bigint" />
			</cfif>
			;
		</cfquery>
		```

		return( results );

	}


	/**
	* I update the event with the given ID.
	*/
	public void function updateEvent(
		required numeric id,
		string name,
		date occurredAt
		) {

		```
		<cfquery name="local.results" result="local.metaResults">
			/* DEBUG: eventGateway.updateEvent(). */
			UPDATE
				event e
			SET
				<cfif arguments.keyExists( "name" )>
					e.name = <cfqueryparam value="#name#" sqltype="varchar" />,
				</cfif>

				<cfif arguments.keyExists( "occurredAt" )>
					e.occurredAt = <cfqueryparam value="#occurredAt#" sqltype="timestamp" />,
				</cfif>

				e.id = e.id
			WHERE
				e.id = <cfqueryparam value="#id#" sqltype="bigint" />
			;
		</cfquery>
		```

	}

}
