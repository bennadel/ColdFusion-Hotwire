<cfscript>

	param name="request.event[ 2 ]" type="string" default="default";

	switch ( request.event[ 2 ] ) {
		case "add":
			include "add_action.cfm"
			include "add_view.cfm";
		break;
		case "default":
			include "default_action.cfm"
			include "default_view.cfm";
		break;
		case "delete":
			include "delete_action.cfm"
			include "delete_view.cfm";
		break;
		case "edit":
			include "edit_action.cfm"
			include "edit_view.cfm";
		break;
		case "view":
			include "view_action.cfm"
			include "view_view.cfm";
		break;
		default:
			throw(
				type = "App.Routing.Tippee.InvalidEvent",
				message = "Unknown routing event: Tippee.",
				detail = "Event item: #request.event[ 2 ]#"
			);
		break;
	}

</cfscript>
