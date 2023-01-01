component
	output = false
	hint = "I provide helper / utility methods that are intended to be used in template rendering."
	{

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
