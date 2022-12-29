<cfscript>

	// This page is called by the DOCKER runtime. Sending back a 200 OK status indicates
	// that this container is healthy and ready to receive traffic.
	header
		statusCode = 200
		statusText = "OK"
	;
	content
		type = "text/plain; charset=utf-8"
	;
	echo( "ColdFusion Is Life!" );

</cfscript>
