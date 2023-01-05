
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<!--- BEGIN: Results. --->
		<cfif tips.len()>

			<h2>
				You have #view.tipFormat( stats.pendingAmountInCents )# in tips to distribute
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
							<a href="/index.cfm?event=tippee.view&id=#encodeForUrl( tip.tippee.id )#">#encodeForHtml( tip.tippee.name )#</a>
						</td>
						<td>
							<a href="/index.cfm?event=tip.view&id=#encodeForUrl( tip.id )#">#view.tipFormat( tip.amountInCents )#</a>
						</td>
						<td>
							<cfif tip.event.id>
								<a href="/index.cfm?event=event.view&id=#encodeForUrl( tip.event.id )#">#encodeForHtml( tip.event.name )#</a>
							</cfif>
						</td>
						<td>

							<!--- Quick action for marking a tip as completed. --->
							<form method="post" action="/index.cfm">
								<input type="hidden" name="event" value="dashboard" />
								<input type="hidden" name="id" value="#encodeForHtmlAttribute( tip.id )#" />

								<button type="submit" name="markAsCompleted" value="true">
									Mark as Complete
								</button>
							</form>

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
				You did it! &##x1F389; All tips have been distributed!
			</p>

			<p>
				<a href="/index.cfm?event=tip.add">Add a new tip</a>
			</p>

		</cfif>
		<!--- END: Empty State. --->

	</cfoutput>
</cfsavecontent>
