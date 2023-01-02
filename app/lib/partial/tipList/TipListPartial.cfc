component
	accessors = true
	output = false
	hint = "I provide service methods for the tip list partial."
	{

	// Define properties for dependency-injection.
	property gateway;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I return the partial for the tip list.
	*/
	public struct function getPartial() {

		var tips = getTips();

		return({
			tips: tips
		});

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I return the collection of tips.
	*/
	private array function getTips() {

		var tips = gateway.getTips().map(
			( tip ) => {

				return({
					id: tip.id,
					amountInCents: tip.amountInCents,
					createdAt: tip.createdAt,
					isCompleted: !! tip.isCompleted,
					completedAt: tip.completedAt,
					tippee: {
						id: tip.tippeeID,
						name: tip.tippeeName
					},
					// Some of these values may be empty/NULL if there is no event
					// associated with this tip.
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
