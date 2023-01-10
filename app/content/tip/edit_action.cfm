<cfscript>

	param name="request.context.id" type="numeric";
	param name="request.context.tippeeID" type="numeric" default=0;
	param name="request.context.tippeeName" type="string" default="";
	param name="request.context.tippeeOccupation" type="string" default="";
	param name="request.context.eventID" type="numeric" default=0;
	param name="request.context.eventName" type="string" default="";
	param name="request.context.eventOccurredAt" type="string" default="";
	param name="request.context.amountInDollars" type="string" default="";
	param name="request.context.notes" type="string" default="";
	param name="request.context.submitted" type="boolean" default=false;

	tip = application.tipService.getTip( val( request.context.id ) );
	tippee = application.tippeeService.getTippee( tip.tippeeID );

	request.template.title = "Edit #view.tipFormat( tip.amountInCents )# for #tippee.name#";

	errorMessage = "";

	if ( request.context.submitted ) {

		// NOTE: In order for Turbo Drive to work with properly with FORM SUBMISSIONS, we
		// must set an appropriate HTTP status code on the response. Turbo Drive expects a
		// "Location" (redirect) header when a form is submitted successfully. As such, in
		// order for our form to re-render on a failed submission, we must return a non-
		// 200 status code.

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

				errorResponse = application.errorService.as422({
					message: "Please provide a valid date for your event."
				});
				request.template.statusCode = errorResponse.statusCode;
				request.template.statusText = errorResponse.statusText;

				errorMessage = errorResponse.message;
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
		// proceed to updating the actual tip.
		try {

			result = application.tipWorkflow.updateTip(
				id = tip.id,
				tippeeID = val( request.context.tippeeID ),
				eventID = val( request.context.eventID ),
				amountInCents = ( val( request.context.amountInDollars ) * 100 ),
				notes = request.context.notes
			);

			location(
				url = "/index.htm?event=tip.view&id=#encodeForUrl( result.id )#&showEditSuccess=true",
				addToken = false
			);

		} catch ( any error ) {

			application.logService.logException( error );

			errorResponse = application.errorService.getResponse( error );
			request.template.statusCode = errorResponse.statusCode;
			request.template.statusText = errorResponse.statusText;

			errorMessage = errorResponse.message;

		}

	} else {

		request.context.tippeeID = tip.tippeeID;
		request.context.eventID = tip.eventID;
		request.context.amountInDollars = ( tip.amountInCents / 100 );
		request.context.notes = tip.notes;

	}

	// TODO: Change name of partial; or duplicate partial for editing.
	partial = application.tipAddPartial.getPartial();
	tippees = partial.tippees;
	events = partial.events;

</cfscript>
