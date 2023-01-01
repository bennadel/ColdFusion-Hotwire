component
	accessors = true
	output = false
	hint = "I provide workflow / use-case methods for events."
	{

	// Define properties for dependency-injection.
	property eventService;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I create a new event and return the result.
	*/
	public struct function createEvent(
		required string name,
		required string occurredAt
		) {

		var id = eventService.createEvent(
			name = name,
			occurredAt = occurredAt
		);

		return({
			id: id
		});

	}


	/**
	* I update the event with the given ID and return the result.
	*/
	public struct function updateEvent(
		required numeric id,
		required string name,
		required string occurredAt
		) {

		eventService.updateEvent(
			id = id,
			name = name,
			occurredAt = occurredAt
		);

		return({
			id: id
		});

	}

}
