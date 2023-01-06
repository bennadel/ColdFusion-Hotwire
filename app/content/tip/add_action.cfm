<cfscript>

	param name="request.context.tippeeID" type="numeric" default=0;
	param name="request.context.tippeeName" type="string" default="";
	param name="request.context.tippeeOccupation" type="string" default="";
	param name="request.context.eventID" type="numeric" default=0;
	param name="request.context.eventName" type="string" default="";
	param name="request.context.eventOccurredAt" type="string" default="";
	param name="request.context.amountInDollars" type="string" default="50";
	param name="request.context.notes" type="string" default="";
	param name="request.context.submitted" type="boolean" default=false;
	param name="request.context.cancelTo" type="string" default="";

	request.template.title = "Add a new Tip";

	errorMessage = "";

	if ( request.context.submitted ) {

		// TODO: / CAUTION: Since the following on-the-fly create actions are being done
		// as part of the form submission, if the form has be submitted twice (such as for
		// invalid data), the create actions fire AGAIN, causing the same entities to be
		// created twice in a row. I'm not sure the best way to overcome this without
		// JavaScript. Probably I can check to see if the most recently-created entity
		// already exists and then ignore it? Not sure.

		// We're creating a NEW TIPPEE as part of the form submission.
		if ( ! request.context.tippeeID && request.context.tippeeName.len() ) {

			try {

				result = application.tippeeWorkflow.createTippee(
					name = request.context.tippeeName,
					occupation = request.context.tippeeOccupation,
					notes = ""
				);

			} catch ( error ) {

				application.logService.logException( error );
				errorMessage = application.errorService.getResponseMessage( error );
				exit;

			}

			request.context.tippeeID = result.id;
			request.context.tippeeName = "";
			request.context.tippeeOccupation = "";

		}

		// We're creating a NEW EVENT as part of the form submission.
		if ( ! request.context.eventID && request.context.eventName.len() ) {

			if ( ! isDate( request.context.eventOccurredAt ) ) {

				errorMessage = "Please provide a valid date for your event.";
				exit;

			}

			try {

				result = application.eventWorkflow.createEvent(
					name = request.context.eventName,
					occurredAt = parseDateTime( request.context.eventOccurredAt )
				);

			} catch ( error ) {

				application.logService.logException( error );
				errorMessage = application.errorService.getResponseMessage( error );
				exit;

			}

			request.context.eventID = result.id;
			request.context.eventName = "";
			request.context.eventOccurredAt = "";

		}

		// Finally, if we've finished creating any new TIPPEES or EVENTS entities, we can
		// proceed to creating the actual tip.
		try {

			result = application.tipWorkflow.createTip(
				tippeeID = val( request.context.tippeeID ),
				eventID = val( request.context.eventID ),
				amountInCents = ( val( request.context.amountInDollars ) * 100 ),
				notes = request.context.notes
			);

			location(
				url = "/index.htm?event=tip.view&id=#encodeForUrl( result.id )#&showAddSuccess=true",
				addToken = false
			);

		} catch ( any error ) {

			application.logService.logException( error );
			errorMessage = application.errorService.getResponseMessage( error );

		}

	} // END: Submitted.

	partial = application.tipAddPartial.getPartial();
	tippees = partial.tippees;
	events = partial.events;

</cfscript>
