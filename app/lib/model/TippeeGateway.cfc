component
	output = false
	hint = "I provide data-access methods for the tippee model."
	{

	/**
	* I create a new tippee and return the generated ID.
	*/
	public numeric function createTippee(
		required string name,
		required string occupation,
		required string notes,
		required date createdAt
		) {

		```
		<cfquery name="local.results" result="local.metaResults">
			/* DEBUG: tippeeGateway.createTippee(). */
			INSERT INTO
				tippee
			SET
				name = <cfqueryparam value="#name#" sqltype="varchar" />,
				occupation = <cfqueryparam value="#occupation#" sqltype="varchar" />,
				notes = <cfqueryparam value="#notes#" sqltype="varchar" />,
				createdAt = <cfqueryparam value="#createdAt#" sqltype="timestamp" />
			;
		</cfquery>
		```

		return( val( metaResults.generatedKey ) );

	}


	/**
	* I delete the tippees that match the given filters.
	*/
	public void function deleteTippeeByFilter( numeric id ) {

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
			/* DEBUG: tippeeGateway.deleteTippeeByFilter(). */
			DELETE FROM
				tippee
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
	* I get the tippees that match the given filters.
	*/
	public query function getTippeeByFilter( numeric id ) {

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
			/* DEBUG: tippeeGateway.getTippeeByFilter(). */
			SELECT
				t.id,
				t.name,
				t.occupation,
				t.notes,
				t.createdAt
			FROM
				tippee t
			WHERE
				TRUE

			<cfif arguments.keyExists( "id" )>
				AND
					t.id = <cfqueryparam value="#id#" sqltype="bigint" />
			</cfif>
			;
		</cfquery>
		```

		return( results );

	}


	/**
	* I update the tippee with the given ID.
	*/
	public void function updateTippee(
		required numeric id,
		string name,
		string occupation,
		string notes
		) {

		```
		<cfquery name="local.results" result="local.metaResults">
			/* DEBUG: tippeeGateway.updateTippee(). */
			UPDATE
				tippee t
			SET
				<cfif arguments.keyExists( "name" )>
					t.name = <cfqueryparam value="#name#" sqltype="varchar" />,
				</cfif>

				<cfif arguments.keyExists( "occupation" )>
					t.occupation = <cfqueryparam value="#occupation#" sqltype="varchar" />,
				</cfif>

				<cfif arguments.keyExists( "notes" )>
					t.notes = <cfqueryparam value="#notes#" sqltype="varchar" />,
				</cfif>

				t.id = t.id
			WHERE
				t.id = <cfqueryparam value="#id#" sqltype="bigint" />
			;
		</cfquery>
		```

	}

}
