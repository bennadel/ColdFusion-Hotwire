
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<cfif request.context.showAddSuccess>
			<p>
				<strong>Woot!</strong> Your new tip has been created!
			</p>
		</cfif>
		<cfif request.context.showEditSuccess>
			<p>
				<strong>Woot!</strong> Your tip has been updated!
			</p>
		</cfif>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<dl>
			<cfif event.id>
				<div>
					<dt> Event: </dt>
					<dd> #encodeForHtml( event.name )# </dd>
				</div>
			</cfif>
			<div>
				<dt> Tippee: </dt>
				<dd>
					#encodeForHtml( tippee.name )#
					<cfif tippee.occupation.len()>
						- #encodeForHtml( tippee.occupation )#
					</cfif>
				</dd>
			</div>
			<div>
				<dt> Amount: </dt>
				<dd> #view.tipFormat( tip.amountInCents )# </dd>
			</div>
			<cfif tip.notes.len()>
				<div>
					<dt> Notes: </dt>
					<dd> #encodeForHtml( tip.notes )# </dd>
				</div>
			</cfif>
			<div>
				<dt> Added: </dt>
				<dd> #dateFormat( tip.createdAt, "mmmm d, yyyy" )# </dd>
			</div>
			<div>
				<dt> Completed: </dt>
				<dd>
					<cfif tip.isCompleted>

						<!--- Quick action for clearing a completed tip. --->
						<form method="post" action="/index.htm">
							<input type="hidden" name="event" value="tip.view" />
							<input type="hidden" name="id" value="#encodeForHtmlAttribute( tip.id )#" />

							#dateFormat( tip.completedAt, "mmmm d, yyyy" )#
							&mdash;

							<button type="submit" name="markAsNotCompleted" value="true">
								Clear
							</button>
						</form>

					<cfelse>

						<!--- Quick action for marking a tip as completed. --->
						<form method="post" action="/index.htm">
							<input type="hidden" name="event" value="tip.view" />
							<input type="hidden" name="id" value="#encodeForHtmlAttribute( tip.id )#" />

							<button type="submit" name="markAsCompleted" value="true">
								Mark as Complete
							</button>
						</form>

					</cfif>
				</dd>
			</div>
		</dl>

		<p>
			<a href="/index.htm?event=tip">Back to list</a>
		</p>

		<p>
			<a href="/index.htm?event=tip.edit&id=#encodeForUrl( tip.id )#">Edit</a> &mdash;
			<a href="/index.htm?event=tip.delete&id=#encodeForUrl( tip.id )#">Delete</a>
		</p>

	</cfoutput>
</cfsavecontent>
