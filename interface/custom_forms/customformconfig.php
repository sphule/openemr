<?php
//
// The webserver_root and web_root are now automatically collected.
// If not working, can set manually below.
// Auto collect the full absolute directory path for openemr.
$customform_root = dirname(dirname(__FILE__));
if (IS_WINDOWS) {
 //convert windows path separators
 $customform_root = str_replace("\\","/",$customform_root); 
}
// Auto collect the relative html path, i.e. what you would type into the web
// browser after the server address to get to OpenEMR.
$custom_form_root = substr($customform_root, strlen($_SERVER['DOCUMENT_ROOT']));
// Ensure web_root starts with a path separator
if (preg_match("/^[^\/]/",$custom_form_root)) {
 $custom_form_root = "/".$custom_form_root;
}
// Root directory, relative to the webserver root:
$GLOBALS['customdir'] = "$web_root/interface";

?>
