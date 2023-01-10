<cfscript>

	param name="request.context.id" type="numeric";
	param name="request.context.name" type="string" default="";
	param name="request.context.occurredAt" type="string" default="";
	param name="request.context.submitted" type="boolean" default=false;

	event = application.eventService.getEvent( val( request.context.id ) );

	request.template.title = "Edit #event.name#";

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
