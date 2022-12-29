component
	output = false
	hint = "I provide validation methods for the event model."
	{

	/**
	* I test and normalize the name property. Returns the normalized value; or, throws an
	* error if the value is not valid.
	*/
	public string function testName( required string name ) {

		name = name.trim();

		if ( ! name.len() ) {

			throw(
				type = "App.Event.Name.Empty",
				message = "Event name is empty."
			);

		}

		if ( name.len() > 100 ) {

			throw(
				type = "App.Event.Name.TooLong",
				message = "Event name is too long."
			);

		}

		if ( name != canonicalizeInput( name ) ) {

			throw(
				type = "App.Event.Name.SuspiciousEncoding",
				message = "Event name contains suspicious encodings."
			);

		}

		return( name );

	}


	/**
	* I test and normalize the occurredAt property. Returns the normalized value; or,
	* throws an error if the value is not valid.
	*/
	public date function testOccurredAt( required date occurredAt ) {

		return( occurredAt );

	}


	/**
	* I throw a not-found error for an event.
	*/
	public void function throwNotFoundError() {

		throw(
			type = "App.Event.NotFound",
			messge = "Event not found."
		);

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I return the strictly canonicalized version of the given input. If an error is
	* thrown during the decoding, an empty string is returned.
	*/
	private string function canonicalizeInput( required string input ) {

		try {

			return( canonicalize( input, true, true ) );

		} catch ( any error ) {

			return( "" );

		}

	}

}
