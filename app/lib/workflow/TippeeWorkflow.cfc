component
	accessors = true
	output = false
	hint = "I provide workflow / use-case methods for tippees."
	{

	// Define properties for dependency-injection.
	property tippeeService;

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
