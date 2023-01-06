
import * as Turbo from "@hotwired/turbo";

document.addEventListener("turbo:load", function() {
	console.log( "turbo:load event" );
});
document.addEventListener("turbo:before-visit", function() {
	console.log( "turbo:before-visit event" );
});
document.addEventListener("turbo:before-fetch-request", function() {
	console.log( "turbo:before-fetch-request event" );
});
document.addEventListener("turbo:before-render", function() {
	console.log( "turbo:before-render event" );
});
