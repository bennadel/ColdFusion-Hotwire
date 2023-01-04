<cfscript>

	param name="request.context.id" type="numeric";
	param name="request.context.markAsCompleted" type="boolean" default=false;
	param name="request.context.markAsNotCompleted" type="boolean" default=false;
	param name="request.context.showAddSuccess" type="boolean" default=false;
	param name="request.context.showEditSuccess" type="boolean" default=false;

	if ( request.context.markAsCompleted ) {

		application.tipWorkflow.markAsCompleted( val( request.context.id ) );

	}

	if ( request.context.markAsNotCompleted ) {

		application.tipWorkflow.markAsNotCompleted( val( request.context.id ) );

	}

	partial = application.tipDetailPartial.getPartial( val( request.context.id ) );
	tip = partial.tip;
	tippee = partial.tippee;
	event = partial.event;

	request.template.title = "#view.tipFormat( tip.amountInCents )# for #tippee.name#";

</cfscript>
