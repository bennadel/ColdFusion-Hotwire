
<h1>
	Hello World!
</h1>

<cfquery name="test">
	SELECT * FROM event;
</cfquery>

<cfdump var="#test#" />
