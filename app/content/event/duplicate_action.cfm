<cfscript>

	param name="request.context.id" type="numeric";
	param name="request.context.name" type="string" default="";
	param name="request.context.occurredAt" type="string" default="";
	param name="request.context.submitted" type="boolean" default=false;

	event = application.eventService.getEvent( val( request.context.id ) );

	request.template.title = "Duplicate #event.name#";

	errorMessage = "";

	if ( request.context.submitted ) {

		// NOTE: In order for Turbo Drive to work with properly with FORM SUBMISSIONS, we
		// must set an appropriate HTTP status code on the response. Turbo Drive expects a
		// "Location" (redirect) header when a form is submitted successfully. As such, in
		// order for our form to re-render on a failed submission, we must return a non-
		// 200 status code.

		if ( ! isDate( request.context.occurredAt ) ) {

			errorResponse = application.errorService.as422({
				message: "Please provide a valid date for your event."
			});
			request.template.statusCode = errorResponse.statusCode;
			request.template.statusText = errorResponse.statusText;

			errorMessage = errorResponse.message;
			exit;

		}

		try {

			result = application.eventWorkflow.duplicateEvent(
				id = event.id,
				name = request.context.name,
				occurredAt = parseDateTime( request.context.occurredAt )
			);

			location(
				url = "/index.htm?event=event.view&id=#encodeForUrl( result.id )#&showAddSuccess=true",
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
