
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<cfif request.context.showAddSuccess>
			<p>
				<strong>Woot!</strong> Your new event has been created!
			</p>
		</cfif>
		<cfif request.context.showEditSuccess>
			<p>
				<strong>Woot!</strong> Your event has been updated!
			</p>
		</cfif>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<dl>
			<div>
				<dt> Name: </dt>
				<dd> #encodeForHtml( event.name )# </dd>
			</div>
			<div>
				<dt> Occurred: </dt>
				<dd> #dateFormat( event.occurredAt, "mmmm d, yyyy" )# </dd>
			</div>
		</dl>

		<p>
			<a href="/index.cfm?event=event">Back to list</a>
		</p>

		<p>
			<a href="/index.cfm?event=event.edit&id=#encodeForUrl( event.id )#">Edit</a> &mdash;
			<a href="/index.cfm?event=event.duplicate&id=#encodeForUrl( event.id )#">Duplicate</a> &mdash;
			<a href="/index.cfm?event=event.delete&id=#encodeForUrl( event.id )#">Delete</a>
		</p>

		<!--- BEGIN: Tips. --->
		<cfif tips.len()>

			<h2>
				Tips
			</h2>

			<table width="100%" border="1">
			<thead>
				<tr>
					<th>
						Tippee
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
							<a href="/index.cfm?event=tippee.view&id=#encodeForUrl( tip.tippee.id )#">#encodeForHtml( tip.tippee.name )#</a>
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
		<!--- END: Tips. --->


		<!--- BEGIN: No Tips. --->
		<cfif ! tips.len()>

			<p>
				You have not assigned any tips to #encodeForHtml( event.name )# yet.
				<a href="/index.cfm?event=tip.add&eventID=#encodeForUrl( event.id )#&cancelTo=event">Add a tip</a>
				for this event.
			</p>

		</cfif>
		<!--- END: No Tips. --->

	</cfoutput>
</cfsavecontent>
