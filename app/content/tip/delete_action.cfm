<cfscript>

	param name="request.context.id" type="numeric";
	param name="request.context.submitted" type="boolean" default=false;

	tip = application.tipService.getTip( val( request.context.id ) );
	tippee = application.tippeeService.getTippee( tip.tippeeID );

	request.template.title = "Delete #view.tipFormat( tip.amountInCents )# for #tippee.name#";

	errorMessage = "";

	if ( request.context.submitted ) {

		try {

			result = application.tipWorkflow.deleteTip( tip.id );

			location(
				url = "/index.htm?event=tip&showDeleteSuccess=true",
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
