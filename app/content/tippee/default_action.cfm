<cfscript>

	request.template.title = "Tippees";

	partial = application.tippeeListPartial.getPartial();
	tippees = partial.tippees;

</cfscript>
