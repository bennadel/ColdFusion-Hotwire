
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<cfif request.context.showAddSuccess>
			<p>
				<strong>Woot!</strong> Your new tippee has been created!
			</p>
		</cfif>
		<cfif request.context.showEditSuccess>
			<p>
				<strong>Woot!</strong> Your tippee has been updated!
			</p>
		</cfif>

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
			<a href="/index.htm?event=tippee">Back to list</a>
		</p>

		<p>
			<a href="/index.htm?event=tippee.edit&id=#encodeForUrl( tippee.id )#">Edit</a> &mdash;
			<a href="/index.htm?event=tippee.delete&id=#encodeForUrl( tippee.id )#">Delete</a>
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
							<a href="/index.htm?event=event.view&id=#encodeForUrl( tip.event.id )#">#encodeForHtml( tip.event.name )#</a>
						</td>
						<td>
							#view.tipFormat( tip.amountInCents )#
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
				<a href="/index.htm?event=tip.add&tippeeID=#encodeForUrl( tippee.id )#&cancelTo=tippee">Add a tip</a>
				for this tippee.
			</p>

		</cfif>
		<!--- END: No Tips. --->

	</cfoutput>
</cfsavecontent>
