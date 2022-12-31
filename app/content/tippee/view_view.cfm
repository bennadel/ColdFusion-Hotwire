
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<dl>
			<div>
				<dt> Name: </dt>
				<dd> #encodeForHtml( tippee.name )# </dd>
			</div>
			<div>
				<dt> Occupation: </dt>
				<dd> #encodeForHtml( tippee.occupation )# </dd>
			</div>
			<cfif tippee.notes.len()>
				<div>
					<dt> Notes: </dt>
					<dd> #encodeForHtml( tippee.notes )# </dd>
				</div>
			</cfif>
			<div>
				<dt> Added: </dt>
				<dd> #dateFormat( tippee.createdAt, "mmmm d, yyyy" )# </dd>
			</div>
		</dl>

		<p>
			<a href="/index.cfm?event=tippee">Back to list</a>
		</p>

		<p>
			<a href="/index.cfm?event=tippee.edit&id=#encodeForUrl( tippee.id )#">Edit</a> &mdash;
			<a href="/index.cfm?event=tippee.delete&id=#encodeForUrl( tippee.id )#">Delete</a>
		</p>

		<!--- BEGIN: Recent Tips. --->
		<cfif tips.len()>

			<h2>
				Recent Tips
			</h2>

			<table width="100%" border="1">
			<thead>
				<tr>
					<th>
						Event
					</th>
					<th>
						Amount
					</th>
					<th>
						Notes
					</th>
					<th>
						Created
					</th>
					<th>
						Completed
					</th>
				</tr>
			</thead>
			<tbody>
				<cfloop item="tip" array="#tips#">
					<tr>
						<td>
							#encodeForHtml( tip.event.name )#
						</td>
						<td>
							#dollarFormat( tip.amountInCents / 100 )#
						</td>
						<td>
							#encodeForHtml( tip.notes )#
						</td>
						<td>
							#dateFormat( tip.createdAt, "mmmm d, yyyy" )#
						</td>
						<td>
							<cfif tip.isCompleted>
								#dateFormat( tip.completedAt, "mmmm d, yyyy" )#
							</cfif>
						</td>
					</tr>
				</cfloop>
			</tbody>
			</table>

		</cfif>
		<!--- END: Recent Tips. --->


		<!--- BEGIN: No Tips. --->
		<cfif ! tips.len()>

			<p>
				You have not given any tips to #encodeForHtml( tippee.name )# yet.
				<!--- TODO: Add a link to the tip creation form. --->
			</p>

		</cfif>
		<!--- END: No Tips. --->

	</cfoutput>
</cfsavecontent>
