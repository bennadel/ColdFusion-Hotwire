<cfscript>

	param name="request.context.id" type="numeric";
	param name="request.context.showAddSuccess" type="boolean" default=false;
	param name="request.context.showEditSuccess" type="boolean" default=false;

	partial = application.tippeeDetailPartial.getPartial( val( request.context.id ) );
	tippee = partial.tippee;
	tips = partial.tips;

	request.template.title = tippee.name;

</cfscript>
