component
	output = false
	hint = "I help translate application errors into appropriate response codes and user-friendly messages."
	{

	/**
	* I return a generic 400 Bad Request response.
	*/
	public struct function getGeneric400Response() {

		return({
			statusCode: 400,
			statusText: "Bad Request",
			type: "BadRequest",
			title: "Bad Request",
			message: "Please validate the information in your request and try submitting it again."
		});

	}


	/**
	* I return a generic 403 Forbidden response.
	*/
	public struct function getGeneric403Response() {

		return({
			statusCode: 403,
			statusText: "Forbidden",
			type: "Forbidden",
			title: "Forbidden",
			message: "Sorry, the request you made is not permitted at this time."
		});

	}


	/**
	* I return a generic 404 Not Found response.
	*/
	public struct function getGeneric404Response() {

		return({
			statusCode: 404,
			statusText: "Not Found",
			type: "NotFound",
			title: "Page Not Found",
			message: "Sorry, it seems that the page you requested either doesn't exist or has been moved to a new location."
		});

	}


	/**
	* I return a generic 422 Unprocessable Entity response.
	*/
	public struct function getGeneric422Response() {

		return({
			statusCode: 422,
			statusText: "Unprocessable Entity",
			type: "UnprocessableEntity",
			title: "Unprocessable Entity",
			message: "Please validate the information in your request and try submitting it again."
		});

	}


	/**
	* I return a generic 500 Server Error response.
	*/
	public struct function getGeneric500Response() {

		return({
			statusCode: 500,
			statusText: "Server Error",
			type: "ServerError",
			title: "Something Went Wrong",
			message: "Sorry, an unexpected error occurred while processing your request."
		});

	}


	/**
	* I return the error RESPONSE for the given error object. This response information is
	* safe to show to the user.
	*/
	public struct function getResponse( required any error ) {

		switch ( error.type ) {
			case "App.Model.Event.Name.Empty":
				return(
					as422({
						type: error.type,
						message: "Please provide an event name."
					})
				);
			break;
			case "App.Model.Event.Name.SuspiciousEncoding":
				return(
					as400({
						type: error.type,
						message: "Your event name contains encoded characters. This might be an indication of malicious intent. If someone asked you to paste-in this value, do not trust it."
					})
				);
			break;
			case "App.Model.Event.Name.TooLong":
				return(
					as422({
						type: error.type,
						message: "Please keep your event name under 50 characters."
					})
				);
			break;
			case "App.Model.Event.NotFound":
				return( as404() );
			break;
			case "App.Model.Tip.AmountInCents.Empty":
				return(
					as422({
						type: error.type,
						message: "Please provide a dollar amount for your tip."
					})
				);
			break;
			case "App.Model.Tip.Notes.TooLong":
				return(
					as422({
						type: error.type,
						message: "Please keep your tip notes under 300 characters."
					})
				);
			break;
			case "App.Model.Tip.NotFound":
				return( as404() );
			break;
			case "App.Model.Tip.TippeeID.Empty":
				return(
					as422({
						type: error.type,
						message: "Please select a recipient for your tip."
					})
				);
			break;
			case "App.Model.Tippee.Name.Empty":
				return(
					as422({
						type: error.type,
						message: "Please provide a tippee name."
					})
				);
			break;
			case "App.Model.Tippee.Name.SuspiciousEncoding":
				return(
					as400({
						type: error.type,
						message: "Your tippee name contains encoded characters. This might be an indication of malicious intent. If someone asked you to paste-in this value, do not trust it."
					})
				);
			break;
			case "App.Model.Tippee.Name.TooLong":
				return(
					as422({
						type: error.type,
						message: "Please keep your tippee name under 50 characters."
					})
				);
			break;
			case "App.Model.Tippee.Notes.TooLong":
				return(
					as422({
						type: error.type,
						message: "Please keep your tippee notes under 300 characters."
					})
				);
			break;
			case "App.Model.Tippee.NotFound":
				return( as404() );
			break;
			case "App.Model.Tippee.Occupation.SuspiciousEncoding":
				return(
					as400({
						type: error.type,
						message: "Your tippee occupation contains encoded characters. This might be an indication of malicious intent. If someone asked you to paste-in this value, do not trust it."
					})
				);
			break;
			case "App.Model.Tippee.Occupation.TooLong":
				return(
					as422({
						type: error.type,
						message: "Please keep your tippee occupation under 50 characters."
					})
				);
			break;
			// Anything not handled by an explicit case becomes a generic 500 response.
			default:
				return( as500() );
			break;
		}

	}

	// ---
	// PRIVATE METHODS.
	// ---

	/**
	* I generate a 400 response object for the given error attributes.
	*/
	private struct function as400( struct errorAttributes = {} ) {

		return( getGeneric400Response().append( errorAttributes ) );

	}


	/**
	* I generate a 403 response object for the given error attributes.
	*/
	private struct function as403( struct errorAttributes = {} ) {

		return( getGeneric403Response().append( errorAttributes ) );

	}


	/**
	* I generate a 404 response object for the given error attributes.
	*/
	private struct function as404( struct errorAttributes = {} ) {

		return( getGeneric404Response().append( errorAttributes ) );

	}


	/**
	* I generate a 422 response object for the given error attributes.
	*/
	private struct function as422( struct errorAttributes = {} ) {

		return( getGeneric422Response().append( errorAttributes ) );

	}


	/**
	* I generate a 500 response object for the given error attributes.
	*/
	private struct function as500( struct errorAttributes = {} ) {

		return( getGeneric500Response().append( errorAttributes ) );

	}

}
