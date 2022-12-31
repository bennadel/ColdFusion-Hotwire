component
	accessors = true
	output = false
	hint = "I provide service methods for the tippee list partial."
	{

	// Define properties for dependency-injection.
	property gateway;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I return the partial for the tippee list.
	*/
	public struct function getPartial() {

		var tippees = getTippees();

		return({
			tippees: tippees
		});

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I return the collection of tippees.
	*/
	private array function getTippees() {

		var tippees = gateway.getTippees().map(
			( tippee ) => {

				return({
					id: tippee.id,
					name: tippee.name,
					occupation: tippee.occupation,
					createdAt: tippee.createdAt,
					// These values will come back empty/NULL if there are no tips.
					tipTotal: val( tippee.tipTotal ),
					pendingTipTotal: val( tippee.pendingTipTotal )
				});

			}
		);

		return( tippees );

	}

}
