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

		<p>
			In the meantime, you can <a href="/index.htm?event=dashboard">return to your dashboard</a> &rarr;
		</p>

	</body>
	</html>

</cfoutput>
