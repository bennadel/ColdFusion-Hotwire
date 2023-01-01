<cfscript>

	param name="request.context.id" type="numeric";
	param name="request.context.isAgree" type="boolean" default=false;
	param name="request.context.submitted" type="boolean" default=false;

	tippee = application.tippeeService.getTippee( val( request.context.id ) );

	request.template.title = "Delete #tippee.name#";

	errorMessage = "";

	if ( request.context.submitted ) {

		if ( ! request.context.isAgree ) {

			errorMessage = "You must agree that you understand the impact of your action.";
			exit;

		}

		try {

			result = application.tippeeWorkflow.deleteTippee( tippee.id );

			location(
				url = "/index.cfm?event=tippee&showDeleteSuccess=true",
				addToken = false
			);

		} catch ( any error ) {

			application.logService.logException( error );
			errorMessage = application.errorService.getResponseMessage( error );

		}

	}

</cfscript>
