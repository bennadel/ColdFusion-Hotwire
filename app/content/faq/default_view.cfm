
<cfsavecontent variable="request.template.body">
	<cfoutput>

		<h1>
			#encodeForHtml( request.template.title )#
		</h1>

		<p>
			FAQs
		</p>

		<dl>
			<div>
				<dt>
					Postal Carrier
				</dt>
				<dd>
					$20 - Technically, federal employees are not allowed to receive gratuities. However, we live in the real world; as such, the Postal Service simply asks that tips not exceed $20.
				</dd>
			</div>
		</dl>

		<h2>
			Sources
		</h2>

		<ul>
			<li>
				<a href="https://money.cnn.com/pf/features/lists/holiday_tipping/" target="_blank">CNN Money: Holiday Tipping</a>
			</li>
		</ul>

	</cfoutput>
</cfsavecontent>
