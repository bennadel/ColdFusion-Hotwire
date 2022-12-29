component
	output = false
	hint = "I provide validation methods for the tip model."
	{

	/**
	* I test and normalize the amountInCents property. Returns the normalized value; or,
	* throws an error if the value is not valid.
	*/
	public numeric function testAmountInCents( required numeric amountInCents ) {

		amountInCents = val( amountInCents );

		if ( ! amountInCents ) {

			throw(
				type = "App.Tip.AmountInCents.Empty",
				message = "AmountInCents is empty."
			);

		}

		return( amountInCents );

	}


	/**
	* I test and normalize the eventID property. Returns the normalized value; or, throws
	* an error if the value is not valid.
	*/
	public numeric function testEventID( required numeric eventID ) {

		return( val( eventID ) );

	}


	/**
	* I test and normalize the notes property. Returns the normalized value; or, throws an
	* error if the value is not valid.
	*/
	public string function testNotes( required string notes ) {

		notes = notes.trim();

		if ( notes.len() > 300 ) {

			throw(
				type = "App.Tip.Notes.TooLong",
				message = "Tip notes is too long."
			);

		}

		return( notes );

	}


	/**
	* I test and normalize the tippeeID property. Returns the normalized value; or, throws
	* an error if the value is not valid.
	*/
	public numeric function testTippeeID( required numeric tippeeID ) {

		tippeeID = val( tippeeID );

		if ( ! tippeeID ) {

			throw(
				type = "App.Tip.TippeeID.Empty",
				message = "TippeeID is empty."
			);

		}

		return( tippeeID );

	}


	/**
	* I throw a not-found error for a tip.
	*/
	public void function throwNotFoundError() {

		throw(
			type = "App.Tip.NotFound",
			messge = "Tip not found."
		);

	}

}
