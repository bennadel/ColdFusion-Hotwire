<cfscript>

	param name="request.context.id" type="numeric";
	param name="request.context.isCascade" type="boolean" default=false;
	param name="request.context.isAgree" type="boolean" default=false;
	param name="request.context.submitted" type="boolean" default=false;

	event = application.eventService.getEvent( val( request.context.id ) );

	request.template.title = "Delete #event.name#";

	errorMessage = "";

	if ( request.context.submitted ) {

		if ( ! request.context.isAgree ) {

			errorMessage = "You must agree that you understand the impact of your action.";
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
			errorMessage = application.errorService.getResponseMessage( error );

		}

	}

</cfscript>
