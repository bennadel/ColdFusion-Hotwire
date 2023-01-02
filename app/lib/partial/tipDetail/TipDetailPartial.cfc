component
	accessors = true
	output = false
	hint = "I provide service methods for the tip detail partial."
	{

	// Define properties for dependency-injection.
	property eventService;
	property tippeeService;
	property tipService;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I return the partial for the tip detail.
	*/
	public struct function getPartial( required numeric tipID ) {

		var tip = getTip( tipID );
		var tippee = getTippee( tip.tippeeID );
		var event = getEvent( tip.eventID );

		return({
			tip: tip,
			tippee: tippee,
			event: event
		});

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I get the event with the given ID. Or a null-object event.
	*/
	private struct function getEvent( required numeric eventID ) {

		if ( eventID ) {

			return( eventService.getEvent( eventID ) );

		} else {

			return({
				id: 0,
				name: ""
			});

		}

	}


	/**
	* I get the tip with the given ID.
	*/
	private struct function getTip( required numeric tipID ) {

		return( tipService.getTip( tipID ) );

	}


	/**
	* I get the tippee with the given ID.
	*/
	private struct function getTippee( required numeric tippeeID ) {

		return( tippeeService.getTippee( tippeeID ) );

	}

}
