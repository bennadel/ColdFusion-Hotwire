<!--- Reset the output buffer. --->
<cfcontent type="text/html; charset=utf-8" />
<cfoutput>

	<!doctype html>
	<html lang="en">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<title>
			#encodeForHtml( request.template.title )#
		</title>
	</head>
	<body>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			#encodeForHtml( request.template.message )#
		</p>

	</body>
	</html>

</cfoutput>
