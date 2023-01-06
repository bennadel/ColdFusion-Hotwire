<cfscript>

	param name="request.context.name" type="string" default="";
	param name="request.context.occurredAt" type="string" default="";
	param name="request.context.submitted" type="boolean" default=false;

	request.template.title = "Add a new Event";

	errorMessage = "";

	if ( request.context.submitted ) {

		if ( ! isDate( request.context.occurredAt ) ) {

			errorMessage = "Please provide a valid date for your event.";
			exit;

		}

		try {

			result = application.eventWorkflow.createEvent(
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

	}

</cfscript>
