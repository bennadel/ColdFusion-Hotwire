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

		<div>
			Sticky Tips
		</div>

		<nav>
			<ul>
				<li>
					<a href="/index.cfm?event=dashboard">Dashboard</a>
				</li>
				<li>
					<a href="/index.cfm?event=tip">Tips</a>
				</li>
				<li>
					<a href="/index.cfm?event=tippee">Tippees</a>
				</li>
				<li>
					<a href="/index.cfm?event=event">Events</a>
				</li>
				<li>
					<a href="/index.cfm?event=faq">FAQ</a>
				</li>
			</ul>
		</nav>

		<hr />

		#request.template.body#

	</body>
	</html>

</cfoutput>
