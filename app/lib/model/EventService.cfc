component
	accessors = true
	output = false
	hint = "I provide service methods for the event model."
	{

	// Define properties for dependency-injection.
	property gateway;
	property validation;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I create a new event and return the generated ID.
	*/
	public numeric function createEvent(
		required string name,
		required date occurredAt
		) {

		name = validation.testName( name );
		occurredAt = validation.testOccurredAt( occurredAt );

		var id = gateway.createEvent(
			name = name,
			occurredAt = occurredAt
		);

		return( id );

	}


	/**
	* I delete the event with the given ID.
	*/
	public void function deleteEvent( required numeric id ) {

		var event = getEvent( id );

		gateway.deleteEventByFilter( id = event.id );

	}


	/**
	* I get the event with the given ID.
	*/
	public struct function getEvent( required numeric id ) {

		var results = gateway.getEventByFilter( id = id );

		if ( ! results.recordCount ) {

			validation.throwNotFoundError();

		}

		return( asDto( results ) );

	}


	/**
	* I update the event with the given ID.
	*/
	public void function updateEvent(
		required numeric id,
		required string name,
		required date occurredAt
		) {

		var event = getEvent( id );

		name = validation.testName( name );
		occurredAt = validation.testOccurredAt( occurredAt );

		gateway.updateEvent(
			id = event.id,
			name = name,
			occurredAt = occurredAt
		);

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I return the current event row a simple data-transfer-object.
	*/
	private struct function asDto( required query results ) {

		return( results.rowData( results.currentRow ) );

	}

}
