
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			Be generous with people!
		</p>


		<!--- BEGIN: Results. --->
		<cfif tips.len()>

			<p>
				<a href="/index.cfm?event=tip.add">Add a Tip</a>
			</p>

			<table width="100%" border="1">
			<thead>
				<tr>
					<th>
						Created
					</th>
					<th>
						Tippee
					</th>
					<th>
						Amount
					</th>
					<th>
						Completed
					</th>
					<th>
						Event
					</th>
					<th>
						<!-- Actions. -->
					</th>
				</tr>
			</thead>
			<tbody>
				<cfloop item="tip" array="#tips#">
					<tr>
						<td>
							<a href="/index.cfm?event=tip.view&id=#encodeForUrl( tip.id )#">#dateFormat( tip.createdAt, "mmmm d, yyyy" )#</a>
						</td>
						<td>
							<a href="/index.cfm?event=tippee.view&id=#encodeForUrl( tip.tippee.id )#">#encodeForHtml( tip.tippee.name )#</a>
						</td>
						<td>
							#view.tipFormat( tip.amountInCents )#
						</td>
						<td>
							<cfif tip.isCompleted>

								<!--- Quick action for clearing a completed tip. --->
								<form method="post" action="/index.cfm">
									<input type="hidden" name="event" value="tip" />
									<input type="hidden" name="id" value="#encodeForHtmlAttribute( tip.id )#" />

									#dateFormat( tip.completedAt, "mmmm d, yyyy" )#
									&mdash;

									<button type="submit" name="markAsNotCompleted" value="true">
										Clear
									</button>
								</form>

							<cfelse>

								<!--- Quick action for marking a tip as completed. --->
								<form method="post" action="/index.cfm">
									<input type="hidden" name="event" value="tip" />
									<input type="hidden" name="id" value="#encodeForHtmlAttribute( tip.id )#" />

									<button type="submit" name="markAsCompleted" value="true">
										Mark as Complete
									</button>
								</form>

							</cfif>
						</td>
						<td>
							<cfif tip.event.id>
								<a href="/index.cfm?event=event.view&id=#encodeForUrl( tip.event.id )#">#encodeForHtml( tip.event.name )#</a>
							</cfif>
						</td>
						<td>
							<a href="/index.cfm?event=tip.view&id=#encodeForUrl( tip.id )#">View</a>
							&mdash;
							<a href="/index.cfm?event=tip.edit&id=#encodeForUrl( tip.id )#">Edit</a>
						</td>
					</tr>
				</cfloop>
			</tbody>
			</table>

		</cfif>
		<!--- END: Results. --->


		<!--- BEGIN: Empty State. --->
		<cfif ! tips.len()>

			<p>
				Want to show some appreciation? <a href="/index.cfm?event=tip.add">Add your first tip</a>.
			</p>

		</cfif>
		<!--- END: Empty State. --->

	</cfoutput>
</cfsavecontent>
