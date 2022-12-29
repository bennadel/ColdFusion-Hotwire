<cfscript>

	param name="request.template.statusCode" type="numeric";
	param name="request.template.statusText" type="string";
	param name="request.template.title" type="string";
	param name="request.template.body" type="string";

	cfheader(
		statusCode = request.template.statusCode,
		statusText = request.template.statusText
	);

</cfscript>
