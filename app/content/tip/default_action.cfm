<cfscript>

	param name="request.context.showDeleteSuccess" type="boolean" default=false;
	param name="request.context.markAsCompleted" type="boolean" default=false;
	param name="request.context.markAsNotCompleted" type="boolean" default=false;
	param name="request.context.id" type="numeric" default=0;

	if ( request.context.markAsCompleted ) {

		application.tipWorkflow.markAsCompleted( val( request.context.id ) );

	}

	if ( request.context.markAsNotCompleted ) {

		application.tipWorkflow.markAsNotCompleted( val( request.context.id ) );

	}

	partial = application.tipListPartial.getPartial();
	tips = partial.tips;

	request.template.title = "Tips";

</cfscript>
