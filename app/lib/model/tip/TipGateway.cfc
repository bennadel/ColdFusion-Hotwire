component
	output = false
	hint = "I provide data-access methods for the tip model."
	{

	// This date is provided in order to make it easier to pass-in and handle a "NULL"
	// date. Instead of dealing with optional arguments, by using a specified NULL date,
	// we can use the "null" attribute of the CFQueryParam tag so as to keep our SQL
	// structure consistent.
	this.NULL_DATE = createDate( 100, 1, 1 );

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I create a new tip and return the generated ID.
	*/
	public numeric function createTip(
		required numeric tippeeID,
		required numeric eventID,
		required numeric amountInCents,
		required string notes,
		required date createdAt,
		required boolean isCompleted,
		required date completedAt
		) {

		```
		<cfquery name="local.results" result="local.metaResults">
			/* DEBUG: tipGateway.createTip(). */
			INSERT INTO
				tip
			SET
				tippeeID = <cfqueryparam value="#tippeeID#" sqltype="bigint" />,
				eventID = <cfqueryparam value="#eventID#" sqltype="bigint" />,
				amountInCents = <cfqueryparam value="#amountInCents#" sqltype="bigint" />,
				notes = <cfqueryparam value="#notes#" sqltype="varchar" />,
				createdAt = <cfqueryparam value="#createdAt#" sqltype="timestamp" />,
				isCompleted = <cfqueryparam value="#isCompleted#" sqltype="tinyint" />,
				completedAt = <cfqueryparam value="#completedAt#" sqltype="timestamp" null="#isNullCreatedAt( completedAt )#" />
			;
		</cfquery>
		```

		return( val( metaResults.generatedKey ) );

	}


	/**
	* I delete the tips that match the given filters.
	*/
	public void function deleteTipByFilter(
		numeric id,
		numeric tippeeID,
		numeric eventID
		) {

		// Make sure at least one index-oriented (prefix) column is provided so that we
		// don't accidentally delete the entire table.
		if (
			isNull( id ) &&
			isNull( tippeeID ) &&
			isNull( eventID )
			) {

			throw(
				type = "UnboundedQuery",
				message = "An unbounded DELETE was going to be performed."
			);

		}

		```
		<cfquery name="local.results" result="local.metaResults">
			/* DEBUG: tipGateway.deleteTipByFilter(). */
			DELETE FROM
				tip
			WHERE
				TRUE

			<cfif arguments.keyExists( "id" )>
				AND
					id = <cfqueryparam value="#id#" sqltype="bigint" />
			</cfif>

			<cfif arguments.keyExists( "tippeeID" )>
				AND
					tippeeID = <cfqueryparam value="#tippeeID#" sqltype="bigint" />
			</cfif>

			<cfif arguments.keyExists( "eventID" )>
				AND
					eventID = <cfqueryparam value="#eventID#" sqltype="bigint" />
			</cfif>
			;
		</cfquery>
		```

	}


	/**
	* I get the tips that match the given filters.
	*/
	public query function getTipByFilter(
		numeric id,
		numeric tippeeID,
		numeric eventID
		) {

		// Make sure at least one index-oriented (prefix) column is provided so that we
		// don't accidentally select the entire table.
		if (
			isNull( id ) &&
			isNull( tippeeID ) &&
			isNull( eventID )
			) {

			throw(
				type = "UnboundedQuery",
				message = "An unbounded SELECT was going to be performed."
			);

		}

		```
		<cfquery name="local.results" result="local.metaResults">
			/* DEBUG: tipGateway.getTipByFilter(). */
			SELECT
				t.id,
				t.tippeeID,
				t.eventID,
				t.amountInCents,
				t.notes,
				t.createdAt,
				t.isCompleted,
				t.completedAt
			FROM
				tip t
			WHERE
				TRUE

			<cfif arguments.keyExists( "id" )>
				AND
					t.id = <cfqueryparam value="#id#" sqltype="bigint" />
			</cfif>

			<cfif arguments.keyExists( "tippeeID" )>
				AND
					t.tippeeID = <cfqueryparam value="#tippeeID#" sqltype="bigint" />
			</cfif>

			<cfif arguments.keyExists( "eventID" )>
				AND
					t.eventID = <cfqueryparam value="#eventID#" sqltype="bigint" />
			</cfif>
			;
		</cfquery>
		```

		return( results );

	}


	/**
	* I update the tip with the given ID.
	*/
	public void function updateTip(
		required numeric id,
		numeric tippeeID,
		numeric eventID,
		numeric amountInCents,
		string notes,
		boolean isCompleted,
		date completedAt
		) {

		```
		<cfquery name="local.results" result="local.metaResults">
			/* DEBUG: tipGateway.updateTip(). */
			UPDATE
				tip t
			SET
				<cfif arguments.keyExists( "tippeeID" )>
					t.tippeeID = <cfqueryparam value="#tippeeID#" sqltype="bigint" />,
				</cfif>

				<cfif arguments.keyExists( "eventID" )>
					t.eventID = <cfqueryparam value="#eventID#" sqltype="bigint" />,
				</cfif>

				<cfif arguments.keyExists( "amountInCents" )>
					t.amountInCents = <cfqueryparam value="#amountInCents#" sqltype="bigint" />,
				</cfif>

				<cfif arguments.keyExists( "notes" )>
					t.notes = <cfqueryparam value="#notes#" sqltype="varchar" />,
				</cfif>

				<cfif arguments.keyExists( "isCompleted" )>
					t.isCompleted = <cfqueryparam value="#isCompleted#" sqltype="tinyint" />,
				</cfif>

				<cfif arguments.keyExists( "completedAt" )>
					t.completedAt = <cfqueryparam value="#completedAt#" sqltype="timestamp" null="#isNullCreatedAt( completedAt )#" />,
				</cfif>

				t.id = t.id
			WHERE
				t.id = <cfqueryparam value="#id#" sqltype="bigint" />
			;
		</cfquery>
		```

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I determine if the given createdAt value is the "magic" NULL_DATE value.
	*/
	private boolean function isNullCreatedAt( required date value ) {

		return( value == this.NULL_DATE );

	}

}
