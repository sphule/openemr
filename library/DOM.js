
// Set up the DOM finder code.
// try to be merciful to older browsers by checking for what's available.
// 

var DOMsupported = 0;
var standardDOMsupported = 0;
var netscapeDOMsupported = 0;

if (document.getElementById) {
	standardDOMsupported = 1;
	DOMsupported = 1;
}
else {
	browserVersion = parseInt(navigator.appVersion);
	if ((navigator.appName.indexOf('Netscape') != -1) && (browserVersion == 4)) {
		netscapeDOMsupported = 1;
		DOMsupported = 1;
	}
}

function findDOM(objectId) {
	if (standardDOMsupported) {
		return (document.getElementById(objectId));
	}
	if (netscapeDOMsupported) {
		return (document.layers[objectId]);
	}
	return null;
}

function findDOMStyle(objectId) {
	if (standardDOMsupported)
		return document.getElementById(objectId).style;
	if (netscapeDOMsupported)
		return document.layers[objectId];
	return null;
}
