<cfscript>

	param name="request.context.id" type="numeric";
	param name="request.context.name" type="string" default="";
	param name="request.context.occupation" type="string" default="";
	param name="request.context.notes" type="string" default="";
	param name="request.context.submitted" type="boolean" default=false;

	tippee = application.tippeeService.getTippee( val( request.context.id ) );

	request.template.title = "Edit #tippee.name#";

	errorMessage = "";

	if ( request.context.submitted ) {

		// NOTE: In order for Turbo Drive to work with properly with FORM SUBMISSIONS, we
		// must set an appropriate HTTP status code on the response. Turbo Drive expects a
		// "Location" (redirect) header when a form is submitted successfully. As such, in
		// order for our form to re-render on a failed submission, we must return a non-
		// 200 status code.

		try {

			result = application.tippeeWorkflow.updateTippee(
				id = tippee.id,
				name = request.context.name,
				occupation = request.context.occupation,
				notes = request.context.notes
			);

			location(
				url = "/index.htm?event=tippee.view&id=#encodeForUrl( result.id )#&showEditSuccess=true",
				addToken = false
			);

		} catch ( any error ) {

			application.logService.logException( error );

			errorResponse = application.errorService.getResponse( error );
			request.template.statusCode = errorResponse.statusCode;
			request.template.statusText = errorResponse.statusText;

			errorMessage = errorResponse.message;

		}

	} else {

		request.context.name = tippee.name;
		request.context.occupation = tippee.occupation;
		request.context.notes = tippee.notes;

	}

</cfscript>
