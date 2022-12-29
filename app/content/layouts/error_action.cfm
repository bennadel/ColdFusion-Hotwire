<cfscript>

	param name="request.template.statusCode" type="numeric" default=500;
	param name="request.template.statusText" type="string" default="Server Error";
	param name="request.template.title" type="string" default="Server Error";
	param name="request.template.message" type="string" default="An unexpected error occurred.";

	cfheader(
		statusCode = request.template.statusCode,
		statusText = request.template.statusText
	);

</cfscript>
