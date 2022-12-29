/**
* CAUTION: At this time, this entire ColdFusion component is really just a PLACEHOLDER to
* provide logging methods without doing much below the surface. All values are just
* printed to the system output at this time.
*/
component
	output = false
	hint = "I provide logging methods for errors and arbitrary data."
	{

	/**
	* I record the given item using a CRITICAL log-level.
	*/
	public void function critical(
		required string message,
		any data = {}
		) {

		// NOTE: This is just placeholder logic.
		systemOutput( "CRITICAL:", true, true );
		systemOutput( message, true, true );
		systemOutput( data, true, true );

	}


	/**
	* I record the given item using a DEBUG log-level.
	*/
	public void function debug(
		required string message,
		any data = {}
		) {

		// NOTE: This is just placeholder logic.
		systemOutput( "DEBUG:", true, true );
		systemOutput( message, true, true );
		systemOutput( data, true, true );

	}


	/**
	* I record the given item using an ERROR log-level.
	*/
	public void function error(
		required string message,
		any data = {}
		) {

		// NOTE: This is just placeholder logic.
		systemOutput( "ERROR:", true, true );
		systemOutput( message, true, true );
		systemOutput( data, true, true );

	}


	/**
	* I record the given item using an INFO log-level.
	*/
	public void function info(
		required string message,
		any data = {}
		) {

		// NOTE: This is just placeholder logic.
		systemOutput( "INFO:", true, true );
		systemOutput( message, true, true );
		systemOutput( data, true, true );

	}


	/**
	* I record the given EXCEPTION object using an ERROR log-level. The difference between
	* this method and other methods is that this method will filter-out some logging based
	* on the TYPE of error being passed-in. This should be the preferred logging method in
	* a production application.
	*/
	public void function logException(
		required any error,
		string message = "",
		any data = {}
		) {

		switch ( error.type ) {
			// The following errors are high-volume and don't represent much value.
			case "Nope":
				// Swallow error for now.
			break;
			default:
				// NOTE: This is just placeholder logic.
				systemOutput( "EXCEPTION:", true, true );
				systemOutput( message, true, true );
				systemOutput( error, true, true );
				systemOutput( data, true, true );
			break;
		}

	}


	/**
	* I record the given item using a WARNING log-level.
	*/
	public void function warning(
		required string message,
		any data = {}
		) {

		// NOTE: This is just placeholder logic.
		systemOutput( "WARNING:", true, true );
		systemOutput( message, true, true );
		systemOutput( data, true, true );

	}

}
