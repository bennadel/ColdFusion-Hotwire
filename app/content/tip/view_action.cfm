<cfscript>

	param name="request.context.id" type="numeric";
	param name="request.context.showAddSuccess" type="boolean" default=false;
	param name="request.context.showEditSuccess" type="boolean" default=false;

	partial = application.tipDetailPartial.getPartial( val( request.context.id ) );
	tip = partial.tip;
	tippee = partial.tippee;
	event = partial.event;

	request.template.title = "#view.tipFormat( tip.amountInCents )# for #tippee.name#";

</cfscript>
