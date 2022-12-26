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
		"/vendor": "#this.appDirectory#../vendor"
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

		// ...

	}


	/**
	* I run once to initialize the incoming request.
	*/
	public void function onRequestStart( required string scriptName ) {

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
		required string eventType
		) {

		systemOutput( "An error occurred outside normal control flow.", true, true );
		systemOutput( error, true, true );

	}

}
