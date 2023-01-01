<cfscript>

	param name="request.context.id" type="numeric";
	param name="request.context.name" type="string" default="";
	param name="request.context.occurredAt" type="string" default="";
	param name="request.context.submitted" type="boolean" default=false;

	event = application.eventService.getEvent( val( request.context.id ) );

	request.template.title = "Duplicate #event.name#";

	errorMessage = "";

	if ( request.context.submitted ) {

		if ( ! isDate( request.context.occurredAt ) ) {

			errorMessage = "Please provide a valid date for your event.";
			exit;

		}

		try {

			result = application.eventWorkflow.duplicateEvent(
				id = event.id,
				name = request.context.name,
				occurredAt = parseDateTime( request.context.occurredAt )
			);

			location(
				url = "/index.cfm?event=event.view&id=#encodeForUrl( result.id )#&showAddSuccess=true",
				addToken = false
			);

		} catch ( any error ) {

			application.logService.logException( error );
			errorMessage = application.errorService.getResponseMessage( error );

		}

	} else {

		// When initializing the date for the next occurrence of this event, let's try to
		// get clever and update the year if it exists in the name of the event. In
		// other words, let's go from something like "Christmas 2023" to "Christmas 2024"
		// automatically.
		lastOccurredAt = event.occurredAt;
		lastYear = dateFormat( lastOccurredAt, "yyyy" );
		// Use the CURRENT year, but duplicate the month/day from previous event.
		nextOccurredAt = createDate(
			year( now() ),
			month( lastOccurredAt ),
			day( lastOccurredAt )
		);
		nextYear = dateFormat( nextOccurredAt, "yyyy" );

		request.context.name = event.name.reReplace( "\b#lastYear#\b", nextYear );
		request.context.occurredAt = dateFormat( nextOccurredAt, "yyyy-mm-dd" );

	}

</cfscript>
