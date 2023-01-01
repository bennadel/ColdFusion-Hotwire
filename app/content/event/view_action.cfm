<cfscript>

	param name="request.context.id" type="numeric";

	partial = application.eventDetailPartial.getPartial( val( request.context.id ) );
	event = partial.event;
	tips = partial.tips;

	request.template.title = event.name;

</cfscript>
