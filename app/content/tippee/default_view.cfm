
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			The people who are receiving tips.
		</p>

		<!--- BEGIN: Results. --->
		<cfif tippees.len()>

			<p>
				<a href="/index.cfm?event=tippee.add">Add a Tippee</a>
			</p>

			<table width="100%" border="1">
			<thead>
				<tr>
					<th>
						Name
					</th>
					<th>
						Occupation
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
				<cfloop item="tippee" array="#tippees#">
					<tr>
						<td>
							<a href="/index.cfm?event=tippee.view&id=#encodeForUrl( tippee.id )#">#encodeForHtml( tippee.name )#</a>
						</td>
						<td>
							#encodeForHtml( tippee.occupation )#
						</td>
						<td>
							<cfif tippee.pendingTipTotal>
								#dollarFormat( tippee.pendingTipTotal / 100 )#
							</cfif>
						</td>
						<td>
							<cfif tippee.tipTotal>
								#dollarFormat( tippee.tipTotal / 100 )#
							</cfif>
						</td>
						<td>
							<a href="/index.cfm?event=tippee.view&id=#encodeForUrl( tippee.id )#">View</a>
						</td>
					</tr>
				</cfloop>
			</tbody>
			</table>

		</cfif>
		<!--- END: Results. --->


		<!--- BEGIN: Empty State. --->
		<cfif ! tippees.len()>

			<p>
				Let's get your <em>Give</em> on! <a href="/index.cfm?event=tippee.add">Add your first tippee</a>.
			</p>

		</cfif>
		<!--- END: Empty State. --->

	</cfoutput>
</cfsavecontent>
