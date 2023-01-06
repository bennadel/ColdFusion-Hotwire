<cfscript>

	param name="request.context.id" type="numeric";
	param name="request.context.name" type="string" default="";
	param name="request.context.occurredAt" type="string" default="";
	param name="request.context.submitted" type="boolean" default=false;

	event = application.eventService.getEvent( val( request.context.id ) );

	request.template.title = "Edit #event.name#";

	errorMessage = "";

	if ( request.context.submitted ) {

		if ( ! isDate( request.context.occurredAt ) ) {

			errorMessage = "Please provide a valid date for your event.";
			exit;

		}

		try {

			result = application.eventWorkflow.updateEvent(
				id = event.id,
				name = request.context.name,
				occurredAt = parseDateTime( request.context.occurredAt )
			);

			location(
				url = "/index.htm?event=event.view&id=#encodeForUrl( result.id )#&showEditSuccess=true",
				addToken = false
			);

		} catch ( any error ) {

			application.logService.logException( error );
			errorMessage = application.errorService.getResponseMessage( error );

		}

	} else {

		request.context.name = event.name;
		request.context.occurredAt = dateFormat( event.occurredAt, "yyyy-mm-dd" );

	}

</cfscript>
