component
	accessors = true
	output = false
	hint = "I provide workflow / use-case methods for events."
	{

	// Define properties for dependency-injection.
	property eventService;
	property tipService;

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
	* I delete the event with the given ID and return the result. Any tips associated with
	* this event will be left in place but disassociated from said event.
	*/
	public struct function deleteEvent( required numeric id ) {

		var event = eventService.getEvent( id );
		var tips = tipService.getTipForEvent( event.id );

		// Before we delete the event, we need to disassociate all of the tips associated
		// with this event. This way, if something goes wrong mid-processing, this method
		// can be idempotently (safely) called again.
		for ( var tip in tips ) {

			tipService.removeEvent( tip.id );

		}

		eventService.deleteEvent( event.id );

		return({
			id: id
		});

	}


	/**
	* I delete the event with the given ID and return the result. This will also delete
	* any tips associated with said event.
	*/
	public struct function deleteEventWithCascade( required numeric id ) {

		var event = eventService.getEvent( id );
		var tips = tipService.getTipForEvent( event.id );

		// Before we delete the event, we need to delete all of the tips associated with
		// this event. This way, if something goes wrong mid-processing, this method can
		// be idempotently (safely) called again.
		for ( var tip in tips ) {

			tipService.deleteTip( tip.id );

		}

		eventService.deleteEvent( event.id );

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
