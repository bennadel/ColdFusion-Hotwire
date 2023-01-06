
// Import vendor modules.
import * as Turbo from "@hotwired/turbo";

// ----------------------------------------------------------------------------------- //
// ----------------------------------------------------------------------------------- //

document.addEventListener(
	"turbo:load",
	( event ) => {
		console.log( "turbo:load event" );
	}
);
document.addEventListener(
	"turbo:before-visit",
	( event ) => {
		console.log( "turbo:before-visit event" );
	}
);
document.addEventListener(
	"turbo:before-fetch-request",
	( event ) => {
		console.log( "turbo:before-fetch-request event" );
	}
);
document.addEventListener(
	"turbo:before-render",
	( event ) => {
		console.log( "turbo:before-render event" );
	}
);
