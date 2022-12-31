<cfscript>

	param name="request.context.id" type="numeric";

	partial = application.tippeeDetailPartial.getPartial( val( request.context.id ) );
	tippee = partial.tippee;
	tips = partial.tips;

	request.template.title = tippee.name;

</cfscript>
