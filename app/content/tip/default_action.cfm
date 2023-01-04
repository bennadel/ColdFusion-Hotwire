<cfscript>

	param name="request.context.showDeleteSuccess" type="boolean" default=false;
	param name="request.context.id" type="numeric" default=0;

	partial = application.tipListPartial.getPartial();
	tips = partial.tips;

	request.template.title = "Tips";

</cfscript>
