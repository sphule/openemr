<?php
include_once("../../globals.php");
include_once("$srcdir/forms.inc");
include_once("$webserver_root/interface/print_fieldset.func.php");
?>
<html>
<head>
	<title>Report Summary :: Progress Note</title>
	<script language="Javascript" src="<?=$web_root?>/interface/open_close.js"></script>
	<link rel=stylesheet href="<?=$web_root?>/interface/open_close.css" type="text/css">
	<link rel=stylesheet href="<?=$web_root?>/interface/fieldset_section.css" type="text/css">
</head>
<body>
<?
printFieldsetHead("Progress Note");

// display the form report
include_once($GLOBALS['incdir'] . "/forms/progress_note1/report.php");
progress_note1_report( $_GET["pid"], $_GET["encounter"], null, $_GET["form_id"]);

printFieldsetFoot();

?>
</body>
</html>