<cfscript>

	param name="request.context.id" type="numeric";
	param name="request.context.isAgree" type="boolean" default=false;
	param name="request.context.submitted" type="boolean" default=false;

	tippee = application.tippeeService.getTippee( val( request.context.id ) );

	request.template.title = "Delete #tippee.name#";

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

			result = application.tippeeWorkflow.deleteTippee( tippee.id );

			location(
				url = "/index.htm?event=tippee&showDeleteSuccess=true",
				addToken = false
			);

		} catch ( any error ) {

			application.logService.logException( error );
			errorMessage = application.errorService.getResponseMessage( error );

		}

	}

</cfscript>
