component
	accessors = true
	output = false
	hint = "I provide service methods for the tip add partial."
	{

	// Define properties for dependency-injection.
	property gateway;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I return the partial for the tip creation.
	*/
	public struct function getPartial() {

		var tippees = getTippees();
		var events = getEvents();

		return({
			tippees: tippees,
			events: events
		});

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I return the collection of events.
	*/
	private array function getEvents() {

		return( gateway.getEvents() );

	}


	/**
	* I return the collection of tippees.
	*/
	private array function getTippees() {

		return( gateway.getTippees() );

	}

}
