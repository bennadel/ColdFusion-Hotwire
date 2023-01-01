component
	output = false
	hint = "I provide helper / utility methods that are intended to be used in template rendering."
	{

	/**
	* Boolean attributes either exist or they don't; and, when they exist, they don't have
	* any explicit value. This method either returns the attribute name if the condition
	* is met or returns the empty string.
	*/
	public string function encodeBooleanAttribute(
		required string attributeName,
		required boolean attributeCondition
		) {

		if ( attributeCondition ) {

			return( encodeForHtml( attributeName ) );

		}

		return( "" );

	}


	/**
	* I format the given tip amount (in cents) as a dollar amount without a decimal place.
	* Ain't nobody tipping cents, yo!
	*/
	public string function tipFormat( required numeric amountInCents )
		cachedWithin = "request"
		{

		return( "$" & numberFormat( fix( amountInCents / 100 ) ) );

	}

}
