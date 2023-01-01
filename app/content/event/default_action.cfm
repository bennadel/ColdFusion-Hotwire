<cfscript>

	param name="request.context.showDeleteSuccess" type="boolean" default=false;

	partial = application.eventListPartial.getPartial();
	events = partial.events;

	request.template.title = "Events";

</cfscript>
