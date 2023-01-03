component
	accessors = true
	output = false
	hint = "I provide workflow / use-case methods for tips."
	{

	// Define properties for dependency-injection.
	property tipService;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I create a new tip and return the result.
	*/
	public struct function createTip(
		required numeric tippeeID,
		required numeric eventID,
		required numeric amountInCents,
		required string notes
		) {

		var id = tipService.createTip(
			tippeeID: tippeeID,
			eventID: eventID,
			amountInCents: amountInCents,
			notes: notes
		);

		return({
			id: id
		});

	}


	/**
	* I delete the tip with the given ID and return the result.
	*/
	public struct function deleteTip( required numeric id ) {

		tipService.deleteTip( id );

		return({
			id: id
		});

	}


	/**
	* I mark the given tip as complete and return the result.
	*/
	public struct function markAsCompleted( required numeric id ) {

		tipService.markAsCompleted( id );

		return({
			id: id
		});

	}


	/**
	* I mark the given tip as not complete and return the result.
	*/
	public struct function markAsNotCompleted( required numeric id ) {

		tipService.markAsNotCompleted( id );

		return({
			id: id
		});

	}

}
