component
	accessors = true
	output = false
	hint = "I provide service methods for the tippee detail partial."
	{

	// Define properties for dependency-injection.
	property gateway;
	property tippeeService;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I return the partial for the tippee list.
	*/
	public struct function getPartial( required numeric tippeeID ) {

		var tippee = tippeeService.getTippee( tippeeID );
		var tips = getTips( tippee.id );

		return({
			tippee: tippee,
			tips: tips
		});

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I return the recent tips for the given tippee.
	*/
	private array function getTips( required numeric tippeeID ) {

		var tips = gateway.getTips( tippeeID ).map(
			( tip ) => {

				return({
					id: tip.id,
					amountInCents: tip.amountInCents,
					notes: tip.notes,
					createdAt: tip.createdAt,
					isCompleted: !! tip.isCompleted,
					completedAt: tip.completedAt,
					event: {
						id: val( tip.eventID ),
						name: tip.eventName
					}
				});

			}
		);

		return( tips );

	}

}
