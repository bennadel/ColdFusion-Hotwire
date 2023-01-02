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
