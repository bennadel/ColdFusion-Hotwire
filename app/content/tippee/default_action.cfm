<cfscript>

	param name="request.context.showDeleteSuccess" type="boolean" default=false;

	request.template.title = "Tippees";

	partial = application.tippeeListPartial.getPartial();
	tippees = partial.tippees;

</cfscript>
