<cfscript>

	param name="request.context.id" type="numeric";
	param name="request.context.isCascade" type="boolean" default=false;
	param name="request.context.isAgree" type="boolean" default=false;
	param name="request.context.submitted" type="boolean" default=false;

	event = application.eventService.getEvent( val( request.context.id ) );

	request.template.title = "Delete #event.name#";

	errorMessage = "";

	if ( request.context.submitted ) {

		// NOTE: In order for Turbo Drive to work with properly with FORM SUBMISSIONS, we
		// must set an appropriate HTTP status code on the response. Turbo Drive expects a
		// "Location" (redirect) header when a form is submitted successfully. As such, in
		// order for our form to re-render on a failed submission, we must return a non-
		// 200 status code.

		if ( ! request.context.isAgree ) {

			errorResponse = application.errorService.as422({
				message: "You must agree that you understand the impact of your action."
			});
			request.template.statusCode = errorResponse.statusCode;
			request.template.statusText = errorResponse.statusText;

			errorMessage = errorResponse.message;
			exit;

		}

		try {

			result = ( request.context.isCascade )
				? application.eventWorkflow.deleteEventWithCascade( event.id )
				: application.eventWorkflow.deleteEvent( event.id )
			;

			location(
				url = "/index.htm?event=event&showDeleteSuccess=true",
				addToken = false
			);

		} catch ( any error ) {

			application.logService.logException( error );
			
			errorResponse = application.errorService.getResponse( error );
			request.template.statusCode = errorResponse.statusCode;
			request.template.statusText = errorResponse.statusText;

			errorMessage = errorResponse.message;

		}

	}

</cfscript>
