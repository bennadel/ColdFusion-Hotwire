component
	output = false
	hint = "I provide the application settings and event handlers."
	{

	// Define the application settings.
	this.name = "ColdFusionAndHotwireDemo";
	this.applicationTimeout = createTimeSpan( 1, 0, 0, 0 );
	this.sessionManagement = false;
	this.setClientCookies = false;

	// Unscoped variable assignments should be stored in the LOCAL scope of a function.
	// --
	// NOTE: I don't actively leverage this in my component code; but, I do use it as a
	// fail-safe to make sure no values accidentally leak into the variables scope.
	this.localmode = true;

	// DO NOT search scopes like CGI, FORM, URL, COOKIE, etc. Only search in explicit
	// scopes as well as VARIABLES, LOCAL, and ARGUMENTS scopes.
	this.searchImplicitScopes = false;

	// Setup paths for mappings.
	this.wwwrootDirectory = getDirectoryFromPath( getCurrentTemplatePath() );
	this.appDirectory = ( this.wwwrootDirectory & "../" );
	// Define the per-application custom mappings.
	this.mappings = {
		"/content": "#this.appDirectory#content",
		"/lib": "#this.appDirectory#lib",
		"/vendor": "#this.appDirectory#vendor"
	};

	// Define the per-application database source names.
	this.defaultDatasource = "sticky_tips";
	this.datasources[ this.defaultDatasource ] = {
	 	class: "com.mysql.cj.jdbc.Driver",
		bundleName: "com.mysql.cj",
		bundleVersion: "8.0.30",
		connectionString: (
			"jdbc:mysql://#server.system.environment.MYSQL_SERVER#:3306/#server.system.environment.MYSQL_DATABASE#" &
			"?characterEncoding=UTF-8" &
			"&allowMultiQueries=true" &
			"&maxReconnects=3" &
			"&autoReconnect=true" &
			"&cachePrepStmts=true"
		),
		username: server.system.environment.MYSQL_USERNAME,
		password: server.system.environment.MYSQL_PASSWORD,	
		blob: true,
		clob: true,
		connectionLimit: 20,
		liveTimeout: 15, // Minutes.
		alwaysSetTimeout: true,
		validate: false
	};

	// ---
	// LIFE-CYCLE METHODS.
	// ---

	/**
	* I run once to initialize the application. When invoked by the application server,
	* this method is inherently single-threaded and will only be called once (if the
	* application starts-up successfully).
	*/
	public void function onApplicationStart() {

		// We want to declare the Error and Log services as early as possible so that we
		// might be able to use it in the onError() handler should something go wrong
		// while initializing the application.
		application.logService = new lib.LogService();
		application.errorService = new lib.ErrorService();
		application.utilities = new lib.Utilities();

		// Model services.
		application.eventService = new lib.model.event.EventService()
			.setGateway( new lib.model.event.EventGateway() )
			.setValidation( new lib.model.event.EventValidation() )
		;
		application.tipService = new lib.model.tip.TipService()
			.setGateway( new lib.model.tip.TipGateway() )
			.setUtilities( application.utilities )
			.setValidation( new lib.model.tip.TipValidation() )
		;
		application.tippeeService = new lib.model.tippee.TippeeService()
			.setGateway( new lib.model.tippee.TippeeGateway() )
			.setUtilities( application.utilities )
			.setValidation( new lib.model.tippee.TippeeValidation() )
		;

		// Partial services.
		application.tippeeDetailPartial = new lib.partial.tippeeDetail.TippeeDetailPartial()
			.setGateway( new lib.partial.tippeeDetail.TippeeDetailGateway() )
			.setTippeeService( application.tippeeService )
		;
		application.tippeeListPartial = new lib.partial.tippeeList.TippeeListPartial()
			.setGateway( new lib.partial.tippeeList.TippeeListGateway() )
		;

		// Workflow services.
		application.tippeeWorkflow = new lib.workflow.TippeeWorkflow()
			.setTippeeService( application.tippeeService )
		;

	}


	/**
	* I run once to initialize the incoming request.
	*/
	public void function onRequestStart( required string scriptName ) {

		// During development, it's often nice to be able to quickly re-initialize the
		// application without the overhead of stopping / starting the application space.
		if ( url.keyExists( "init" ) ) {

			onApplicationStart();
			url.delete( "init" );

		}

		// Combine the URL and FORM scope into a single collection for when the processing
		// code doesn't have to care in which scope information has been provided.
		request.context = structNew()
			.append( url )
			.append( form )
		;

	}


	/**
	* I catch any unhandled error within the request.
	* 
	* CAUTION: This may be called before the application has been successfully
	* bootstrapped. As such, all of the runtime components may not be available yet.
	*/
	public void function onError(
		required any error,
		required string eventName
		) {

		logError( error );

		// If the headers have already been flushed to the client, attempting to reset the
		// output will cause its own error. In that case, let's just output an in-place
		// error and abort all other processing.
		if ( isResponseCommitted( eventName ) ) {

			echo( "Sorry, an unexpected error occurred while processing your request." );
			abort;

		}

		// Since the response hasn't been committed yet, we have a chance to reset the
		// output and render our standard application error page. But, since we don't know
		// where the error occurred, let's be safe and entirely define the template data
		// as well as wrap this in its own try/catch.
		try {

			// Translate the unhandled error into a user-friendly error response.
			var errorResponse = application.errorService.getResponse( error );

			request.template = {
				statusCode: errorResponse.statusCode,
				statusText: errorResponse.statusText,
				title: errorResponse.title,
				body: errorResponse.message
			};

			include "/content/layouts/error_action.cfm";
			include "/content/layouts/error_view.cfm";

		// EDGE CASE: If the application hasn't been bootstrapped yet, or if there's an
		// issue with the error template itself, something might go wrong while trying to
		// render it.
		} catch ( any renderError ) {

			logError( renderError );

		}

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I determine if the underlying Servlet HTTP response headers has been flushed to the
	* client (which would mean that at least some sense of output has already been
	* generated by the current request and the response cannot be reset).
	*/
	private boolean function isResponseCommitted( required string eventName ) {

		// CAUTION: There is no viable page context in the "end" event handler. As such,
		// we'll consider those error contexts to be "committed".
		return(
			( eventName == "onApplicationEnd" ) ||
			( eventName == "onSessionEnd" ) ||
			getPageContext().getResponse().isCommitted()
		);

	}


	/**
	* I log the error using either the application logger (if the application has been
	* successfully bootstrapped) or low-level serialization as a fall-back.
	*/
	private void function logError( required any error ) {

		if ( ! isNull( application.logService ) ) {

			application.logService.logException( error, "Unhandled error caught in Application." );
			return;

		}

		// If the application logger wasn't available, fall-back to serialization.
		systemOutput( serializeJson( error ), true, true );

	}

}
