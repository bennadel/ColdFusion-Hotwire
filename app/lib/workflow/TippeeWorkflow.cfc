component
	accessors = true
	output = false
	hint = "I provide workflow / use-case methods for tippees."
	{

	// Define properties for dependency-injection.
	property tippeeService;
	property tipService;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I create a new tippee and return the result.
	*/
	public struct function createTippee(
		required string name,
		required string occupation,
		required string notes
		) {

		var id = tippeeService.createTippee(
			name = name,
			occupation = occupation,
			notes = notes
		);

		return({
			id: id
		});

	}


	/**
	* I delete the tippee with the given ID and return the result. This will also delete
	* any tips associated with said tippee.
	*/
	public struct function deleteTippee( required numeric id ) {

		var tippee = tippeeService.getTippee( id );

		// Before we delete the tippee, we need to delete all of the tips associated with
		// this tippee. This way, if something goes wrong mid-processing, this method can
		// be idempotently (safely) called again.
		for ( var tip in tipService.getTipForTippee( tippee.id ) ) {

			tipService.deleteTip( tip.id );

		}

		tippeeService.deleteTippee( tippee.id );

		return({
			id: id
		});

	}


	/**
	* I update the tippee with the given ID and return the result.
	*/
	public struct function updateTippee(
		required numeric id,
		required string name,
		required string occupation,
		required string notes
		) {

		tippeeService.updateTippee(
			id = id,
			name = name,
			occupation = occupation,
			notes = notes
		);

		return({
			id: id
		});

	}

}
