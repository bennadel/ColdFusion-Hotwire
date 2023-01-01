component
	accessors = true
	output = false
	hint = "I provide service methods for the event list partial."
	{

	// Define properties for dependency-injection.
	property gateway;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I return the partial for the event list.
	*/
	public struct function getPartial() {

		var events = getEvents();

		return({
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

		var events = gateway.getEvents().map(
			( event ) => {

				return({
					id: event.id,
					name: event.name,
					occurredAt: event.occurredAt,
					// Some of these values will come back empty/NULL if there are no tips
					// associated with this event.
					tips: {
						total: val( event.amountInCentsTotal ),
						pendingTotal: val( event.pendingAmountInCentsTotal )
					}
				});

			}
		);

		return( events );

	}

}
