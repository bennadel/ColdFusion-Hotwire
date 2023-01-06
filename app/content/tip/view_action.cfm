<cfscript>

	param name="request.context.id" type="numeric";
	param name="request.context.markAsCompleted" type="boolean" default=false;
	param name="request.context.markAsNotCompleted" type="boolean" default=false;
	param name="request.context.showAddSuccess" type="boolean" default=false;
	param name="request.context.showEditSuccess" type="boolean" default=false;

	if ( request.context.markAsCompleted ) {

		application.tipWorkflow.markAsCompleted( val( request.context.id ) );

		// In order for Hotwire Turbo Drive to work, form submissions must redirect to
		// another page (in this case, we're just going to refresh the page, essentially).
		location(
			url = "/index.htm?event=tip.view&id=#encodeForUrl( request.context.id )#",
			addToken = false
		);

	}

	if ( request.context.markAsNotCompleted ) {

		application.tipWorkflow.markAsNotCompleted( val( request.context.id ) );

		// In order for Hotwire Turbo Drive to work, form submissions must redirect to
		// another page (in this case, we're just going to refresh the page, essentially).
		location(
			url = "/index.htm?event=tip.view&id=#encodeForUrl( request.context.id )#",
			addToken = false
		);

	}

	partial = application.tipDetailPartial.getPartial( val( request.context.id ) );
	tip = partial.tip;
	tippee = partial.tippee;
	event = partial.event;

	request.template.title = "#view.tipFormat( tip.amountInCents )# for #tippee.name#";

</cfscript>
