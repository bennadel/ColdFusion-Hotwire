<cfscript>

	param name="request.context.id" type="numeric";
	param name="request.context.name" type="string" default="";
	param name="request.context.occupation" type="string" default="";
	param name="request.context.notes" type="string" default="";
	param name="request.context.submitted" type="boolean" default=false;

	tippee = application.tippeeService.getTippee( val( request.context.id ) );

	errorMessage = "";

	if ( request.context.submitted ) {

		try {

			result = application.tippeeWorkflow.updateTippee(
				id = tippee.id,
				name = request.context.name,
				occupation = request.context.occupation,
				notes = request.context.notes
			);

			location(
				url = "/index.cfm?event=tippee.view&id=#encodeForUrl( result.id )#&showEditSuccess=true",
				addToken = false
			);

		} catch ( any error ) {

			application.logService.logException( error );
			errorMessage = application.errorService.getResponseMessage( error );

		}

	} else {

		request.context.name = tippee.name;
		request.context.occupation = tippee.occupation;
		request.context.notes = tippee.notes;

	}

	request.template.title = "Edit #tippee.name#";

</cfscript>
