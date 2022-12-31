<cfscript>

	param name="request.context.name" type="string" default="";
	param name="request.context.occupation" type="string" default="";
	param name="request.context.notes" type="string" default="";
	param name="request.context.submitted" type="boolean" default=false;

	errorMessage = "";

	if ( request.context.submitted ) {

		try {

			result = application.tippeeWorkflow.createTippee(
				name = request.context.name,
				occupation = request.context.occupation,
				notes = request.context.notes
			);

			location(
				url = "/index.cfm?event=tippee.view&id=#encodeForUrl( result.id )#&showAddSuccess=true",
				addToken = false
			);

		} catch ( any error ) {

			application.logService.logException( error );
			errorMessage = application.errorService.getResponseMessage( error );

		}

	}

	request.template.title = "Add a new Tippee";

</cfscript>
