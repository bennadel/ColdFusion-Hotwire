component
	accessors = true
	output = false
	hint = "I provide service methods for the tip model."
	{

	// Define properties for dependency-injection.
	property gateway;
	property utilities;
	property validation;

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
		required string notes
		) {

		tippeeID = validation.testTippeeID( tippeeID );
		eventID = validation.testEventID( eventID );
		amountInCents = validation.testAmountInCents( amountInCents );
		notes = validation.testNotes( notes );

		var createdAt = utilities.utcNow();

		var id = gateway.createTip(
			tippeeID = tippeeID,
			eventID = eventID,
			amountInCents = amountInCents,
			notes = notes,
			createdAt = createdAt,
			isCompleted = false,
			completedAt = gateway.NULL_DATE
		);

		return( id );

	}


	/**
	* I delete the tip with the given ID.
	*/
	public void function deleteTip( required numeric id ) {

		var tip = getTip( id );

		gateway.deleteTipByFilter( id = tip.id );

	}


	/**
	* I get the tip with the given ID.
	*/
	public struct function getTip( required numeric id ) {

		var results = gateway.getTipByFilter( id = id );

		if ( ! results.recordCount ) {

			validation.throwNotFoundError();

		}

		return( asDto( results ) );

	}


	/**
	* I get the tips for the given event.
	*/
	public array function getTipForEvent( required numeric eventID ) {

		var results = gateway.getTipByFilter( eventID = eventID );

		return( asDtoArray( results ) );

	}


	/**
	* I get the tips for the given tippee.
	*/
	public array function getTipForTippee( required numeric tippeeID ) {

		var results = gateway.getTipByFilter( tippeeID = tippeeID );

		return( asDtoArray( results ) );

	}


	/**
	* I mark the given tip as completed (if it is currently pending).
	*/
	public void function markAsCompleted( required numeric id ) {

		var tip = getTip( id );

		if ( tip.isCompleted ) {

			return;

		}

		var completedAt = utilities.utcNow();

		gateway.updateTip(
			id = tip.id,
			isCompleted = true,
			completedAt = completedAt
		);

	}


	/**
	* I mark the given tip as not completed (if it is currently completed).
	*/
	public void function markAsNotCompleted( required numeric id ) {

		var tip = getTip( id );

		if ( ! tip.isCompleted ) {

			return;

		}

		gateway.updateTip(
			id = tip.id,
			isCompleted = false,
			completedAt = gateway.NULL_DATE
		);

	}


	/**
	* I remove the event association from the given tip.
	*/
	public void function removeEvent( required numeric id ) {

		var tip = getTip( id );

		if ( ! tip.eventID ) {

			return;

		}

		gateway.updateTip(
			id = tip.id,
			eventID = 0
		);

	}


	/**
	* I update the tip with the given ID.
	*/
	public void function updateTip(
		required numeric id,
		required numeric eventID,
		required numeric amountInCents,
		required string notes,
		required boolean isCompleted
		) {

		var tip = getTip( id );

		eventID = validation.testEventID( eventID );
		amountInCents = validation.testAmountInCents( amountInCents );
		notes = validation.testNotes( notes );

		// Moving into a completed state.
		var completedAt = ( isCompleted && ! tip.isCompleted )
			? utilities.utcNow()
			: gateway.NULL_DATE
		;

		gateway.updateTip(
			id = tip.id,
			eventID = eventID,
			amountInCents = amountInCents,
			notes = notes,
			isCompleted = isCompleted,
			completedAt = completedAt
		);

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I return the current tip row a simple data-transfer-object.
	*/
	private struct function asDto( required query results ) {

		return({
			id: results.id,
			tippeeID: results.tippeeID,
			eventID: results.eventID,
			amountInCents: results.amountInCents,
			notes: results.notes,
			createdAt: results.createdAt,
			isCompleted: !! results.isCompleted,
			completedAt: results.completedAt
		});

	}


	/**
	* I return the tip rows as an array of simple data-transfer-objects.
	*/
	private array function asDtoArray( required query results ) {

		var tips = [];

		loop query = results {

			tips.append( asDto( results ) );

		}

		return( tips );

	}

}
