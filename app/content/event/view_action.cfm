<cfscript>

	param name="request.context.id" type="numeric";
	param name="request.context.showAddSuccess" type="boolean" default=false;
	param name="request.context.showEditSuccess" type="boolean" default=false;

	partial = application.eventDetailPartial.getPartial( val( request.context.id ) );
	event = partial.event;
	tips = partial.tips;

	request.template.title = event.name;

</cfscript>
