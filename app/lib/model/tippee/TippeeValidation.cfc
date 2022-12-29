component
	output = false
	hint = "I provide validation methods for the tippee model."
	{

	/**
	* I test and normalize the name property. Returns the normalized value; or, throws an
	* error if the value is not valid.
	*/
	public string function testName( required string name ) {

		name = name.trim();

		if ( ! name.len() ) {

			throw(
				type = "App.Model.Tippee.Name.Empty",
				message = "Tippee name is empty."
			);

		}

		if ( name.len() > 50 ) {

			throw(
				type = "App.Model.Tippee.Name.TooLong",
				message = "Tippee name is too long."
			);

		}

		if ( name != canonicalizeInput( name ) ) {

			throw(
				type = "App.Model.Tippee.Name.SuspiciousEncoding",
				message = "Tippee name contains suspicious encodings."
			);

		}

		return( name );

	}


	/**
	* I test and normalize the notes property. Returns the normalized value; or, throws an
	* error if the value is not valid.
	*/
	public string function testNotes( required string notes ) {

		notes = notes.trim();

		if ( notes.len() > 300 ) {

			throw(
				type = "App.Model.Tippee.Notes.TooLong",
				message = "Tippee notes is too long."
			);

		}

		return( notes );

	}


	/**
	* I test and normalize the occupation property. Returns the normalized value; or,
	* throws an error if the value is not valid.
	*/
	public string function testOccupation( required string occupation ) {

		occupation = occupation.trim();

		if ( occupation.len() > 50 ) {

			throw(
				type = "App.Model.Tippee.Occupation.TooLong",
				message = "Tippee occupation is too long."
			);

		}

		if ( occupation != canonicalizeInput( occupation ) ) {

			throw(
				type = "App.Model.Tippee.Occupation.SuspiciousEncoding",
				message = "Tippee occupation contains suspicious encodings."
			);

		}

		return( occupation );

	}


	/**
	* I throw a not-found error for a tippee.
	*/
	public void function throwNotFoundError() {

		throw(
			type = "App.Model.Tippee.NotFound",
			messge = "Tippee not found."
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
