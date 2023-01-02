<cfscript>

	// Since our template rendering is all being executed through includes, every template
	// essentially shares the same page context. As such, we can set this "view" component
	// reference in order to make view-helper methods available within the request. And,
	// if another page context (such as a custom tag) needs these helpers, they can be
	// grabbed out of either the REUQEST or APPLICATION scopes.
	view = request.view = application.viewUtilities;

	request.template = {
		statusCode: 200,
		statusText: "OK",
		layout: "standard",
		title: "",
		body: ""
	};

	try {

		// The event is provided as a dot-delimited string in either the URL or FORM
		// scopes. This is subsequently converted into an array which will determine the
		// routing of the request.
		param name="request.context.event" type="string" default="";

		request.event = request.context.event.listToArray( "." );

		param name="request.event[ 1 ]" type="string" default="dashboard";

		// Render the VIEW.
		switch ( request.event[ 1 ] ) {
			case "dashboard":
				include "/content/dashboard/index.cfm";
			break;
			case "event":
				include "/content/event/index.cfm";
			break;
			case "faq":
				include "/content/faq/index.cfm";
			break;
			case "tip":
				include "/content/tip/index.cfm";
			break;
			case "tippee":
				include "/content/tippee/index.cfm";
			break;
			default:
				throw(
					type = "App.Routing.Root.InvalidEvent",
					message = "Unknown routing event: Root.",
					detail = "Event item: #request.event[ 1 ]#"
				);
			break;
		}

		// Render the LAYOUT in which the VIEW is wrapped.
		switch ( request.template.layout ) {
			case "standard":
				include "/content/layouts/standard_action.cfm";
				include "/content/layouts/standard_view.cfm";
			break;
			default:
				throw(
					type = "App.Routing.Root.InvalidTemplate",
					message = "Unknown template layout.",
					default = "Template layout: #request.template.layout#"
				);
			break;
		}

	// Catch any errors thrown during routing and rendering. Unhandled errors will
	// override any existing template choices and cause the error template to render.
	} catch ( any error ) {

		// Uncomment for local debugging only.
		// dump( error ); abort;

		application.logService.logException( error );

		// Translate the unhandled error into a user-friendly error response.
		errorResponse = application.errorService.getResponse( error );

		request.template.statusCode = errorResponse.statusCode;
		request.template.statusText = errorResponse.statusText;
		request.template.layout = "error";
		request.template.title = errorResponse.title;
		request.template.message = errorResponse.message;

		include "/content/layouts/error_action.cfm";
		include "/content/layouts/error_view.cfm";

	}

</cfscript>
