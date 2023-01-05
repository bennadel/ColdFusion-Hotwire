<cfscript>

	param name="request.context.id" type="numeric" default=0;
	param name="request.context.markAsCompleted" type="boolean" default=false;

	if ( request.context.markAsCompleted ) {

		application.tipWorkflow.markAsCompleted( val( request.context.id ) );

	}

	request.template.title = "Tip Dashboard";

	partial = application.dashboardPartial.getPartial();
	tips = partial.tips;
	stats = partial.stats;

</cfscript>
