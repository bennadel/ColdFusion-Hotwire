<cfscript>

	param name="request.context.id" type="numeric" default=0;
	param name="request.context.markAsCompleted" type="boolean" default=false;

	if ( request.context.markAsCompleted ) {

		application.tipWorkflow.markAsCompleted( val( request.context.id ) );

		// In order for Hotwire Turbo Drive to work, form submissions must redirect to
		// another page (in this case, we're just going to refresh the page, essentially).
		location(
			url = "/index.htm?event=dashboard",
			addToken = false
		);

	}

	request.template.title = "Tip Dashboard";

	partial = application.dashboardPartial.getPartial();
	tips = partial.tips;
	stats = partial.stats;

</cfscript>
