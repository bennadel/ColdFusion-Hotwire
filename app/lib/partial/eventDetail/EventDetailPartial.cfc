component
	accessors = true
	output = false
	hint = "I provide service methods for the event detail partial."
	{

	// Define properties for dependency-injection.
	property eventService;
	property gateway;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I return the partial for the event detail.
	*/
	public struct function getPartial( required numeric eventID ) {

		var event = eventService.getEvent( eventID );
		var tips = getTips( event.id );

		return({
			event: event,
			tips: tips
		});

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I return the collection of tips.
	*/
	private array function getTips( required numeric eventID ) {

		var tips = gateway.getTips( eventID ).map(
			( tip ) => {

				return({
					id: tip.id,
					amountInCents: tip.amountInCents,
					notes: tip.notes,
					createdAt: tip.createdAt,
					isCompleted: !! tip.isCompleted,
					completedAt: tip.completedAt,
					tippee: {
						id: tip.tippeeID,
						name: tip.tippeeName
					}
				});

			}
		);

		return( tips );

	}

}
