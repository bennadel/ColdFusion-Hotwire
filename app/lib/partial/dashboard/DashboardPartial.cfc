component
	accessors = true
	output = false
	hint = "I provide service methods for the dashboard partial."
	{

	// Define properties for dependency-injection.
	property gateway;

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I return the partial for the dashboard.
	*/
	public struct function getPartial() {

		var tips = getTips();
		var stats = getStats( tips );

		return({
			tips: tips,
			stats: stats
		});

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I return stats about tips.
	*/
	private struct function getStats( required array tips ) {

		var stats = {
			pendingAmountInCents: 0
		};

		for ( var tip in tips ) {

			stats.pendingAmountInCents += tip.amountInCents;

		}

		return( stats );

	}


	/**
	* I return the collection of penidng tips.
	*/
	private array function getTips() {

		var tips = gateway.getTips().map(
			( tip ) => {

				return({
					id: tip.id,
					amountInCents: tip.amountInCents,
					createdAt: tip.createdAt,
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
