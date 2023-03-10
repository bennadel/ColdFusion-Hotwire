
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<cfif request.context.showDeleteSuccess>
			<p>
				<strong>Woot!</strong> Your event has been deleted.
			</p>
		</cfif>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			Events be happening.
		</p>

		<!--- BEGIN: Results. --->
		<cfif events.len()>

			<p>
				<a href="/index.htm?event=event.add">Add an Event</a>
			</p>

			<table width="100%" border="1">
			<thead>
				<tr>
					<th>
						Name
					</th>
					<th>
						Date
					</th>
					<th>
						Pending Tips
					</th>
					<th>
						Total Tips
					</th>
					<th>
						<!-- Actions. -->
					</th>
				</tr>
			</thead>
			<tbody>
				<cfloop item="event" array="#events#">
					<tr>
						<td>
							<a href="/index.htm?event=event.view&id=#encodeForUrl( event.id )#">#encodeForHtml( event.name )#</a>
						</td>
						<td>
							#dateFormat( event.occurredAt, "mmmm d, yyyy" )#
						</td>
						<td>
							<cfif event.tips.pendingTotal>
								#view.tipFormat( event.tips.pendingTotal )#
							</cfif>
						</td>
						<td>
							<cfif event.tips.total>
								#view.tipFormat( event.tips.total )#
							</cfif>
						</td>
						<td>
							<a href="/index.htm?event=event.view&id=#encodeForUrl( event.id )#">View</a>
							&mdash;
							<a href="/index.htm?event=event.edit&id=#encodeForUrl( event.id )#">Edit</a>
						</td>
					</tr>
				</cfloop>
			</tbody>
			</table>

		</cfif>
		<!--- END: Results. --->


		<!--- BEGIN: Empty State. --->
		<cfif ! events.len()>

			<p>
				Have a tip-oriented event coming up? <a href="/index.htm?event=event.add">Add your first event</a>.
			</p>

		</cfif>
		<!--- END: Empty State. --->

	</cfoutput>
</cfsavecontent>
