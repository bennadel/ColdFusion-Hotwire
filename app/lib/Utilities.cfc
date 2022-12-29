component
	output = false
	hint = "I provide a hodgepodge of utility methods."
	{

	/**
	* I return the current UTC timestamp.
	*/
	public date function utcNow() {

		return( dateConvert( "local2utc", now() ) );

	}

}
