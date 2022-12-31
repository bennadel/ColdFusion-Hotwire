<cfscript>

	param name="request.event[ 2 ]" type="string" default="default";

	switch ( request.event[ 2 ] ) {
		case "default":
			include "default_action.cfm"
			include "default_view.cfm";
		break;
		default:
			throw(
				type = "App.Routing.Faq.InvalidEvent",
				message = "Unknown routing event: Faq.",
				detail = "Event item: #request.event[ 2 ]#"
			);
		break;
	}

</cfscript>
