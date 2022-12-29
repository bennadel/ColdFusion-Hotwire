component
	accessors = true
	output = false
	hint = "I provide service methods for the tippee model."
	{

	// Define properties for dependency-injection.
	property gateway;
	property utilities;
	property validation;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I create a new tippee and return the generated ID.
	*/
	public numeric function createTippee(
		required string name,
		required string occupation,
		required string notes
		) {

		name = validation.testName( name );
		occupation = validation.testOccupation( occupation );
		notes = validation.testNotes( notes );

		var createdAt = utilities.utcNow();

		var id = gateway.createTippee(
			name = name,
			occupation = occupation,
			notes = notes,
			createdAt = createdAt
		);

		return( id );

	}


	/**
	* I delete the tippee with the given ID.
	*/
	public void function deleteTippee( required numeric id ) {

		var tippee = getTippee( id );

		gateway.deleteTippeeByFilter( id = tippee.id );

	}


	/**
	* I get the tippee with the given ID.
	*/
	public struct function getTippee( required numeric id ) {

		var results = gateway.getTippeeByFilter( id = id );

		if ( ! results.recordCount ) {

			validation.throwNotFoundError();

		}

		return( asDto( results ) );

	}


	/**
	* I update the tippee with the given ID.
	*/
	public void function updateTippee(
		required numeric id,
		required string name,
		required string occupation,
		required string notes
		) {

		var tippee = getTippee( id );

		name = validation.testName( name );
		occupation = validation.testOccupation( occupation );
		notes = validation.testNotes( notes );

		gateway.updateTippee(
			id = tippee.id,
			name = name,
			occupation = occupation,
			notes = notes
		);

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I return the current tippee row a simple data-transfer-object.
	*/
	private struct function asDto( required query results ) {

		return( results.rowData( results.currentRow ) );

	}

}
