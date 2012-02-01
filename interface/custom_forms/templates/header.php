<?php
require_once($GLOBALS['incdir']."/globals.php");
require_once($GLOBALS['srcdir']."/calendar.inc");
require_once($GLOBALS['srcdir']."/lists.inc");
require_once($GLOBALS['srcdir']."/forms.inc");
require_once($GLOBALS['incdir']."/forms/common_form_function/common_functions.php");
require_once($GLOBALS['srcdir']."/classes/Prescription.class.php");
require_once($GLOBALS['srcdir']."/classes/Patient.class.php");
require_once(dirname(__FILE__)."/functions.php");
if(isset($_GET['formname']) && isset($_SESSION['encounter'])){

	$sql	=	"select * from csf_forms where form_name=\"".str_replace("_"," ",$_GET['formname'])."\"";
	$stmt	=	sqlStatement($sql);
	$row	=	sqlFetchArray($stmt);

	$_GET['id'] = $row['form_id'];
	
	$sql	=	"select * from csf_form_data where form_id=".$row['form_id']." and encounter = ".$_SESSION['encounter'];
	$stmt	=	sqlStatement($sql);
	$row	=	sqlFetchArray($stmt);

	if(!empty($row['form_data_id'])){
		include("view.php");
		exit();
	}
}
?>
<html>
<head>
	<title></title>	
	<style type="text/css">@import url(<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar.css);</style>
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/DOM.js"></script>
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/dialog.js"></script>
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/overlib_mini.js"></script>
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/calendar.js"></script>
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/textformat.js"></script>
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/form_validate.js"></script>
	<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar.js"></script>
	<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar_en.js"></script>
	<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar_setup.js"></script>

	<script>
		var mypcc = '1';
		function showPrev(){
			objs = document.getElementsByTagName("DIV");
			
			for (var i=0; i<objs.length; i++) {
				if (objs[i].id == "tableDiv"){
					objs[i].style.display = "none";
				}				
			}				
		}
	</script>
	<link rel=stylesheet href="<?echo $css_body;?>" type="text/css">
	<link rel=stylesheet href="<?=$GLOBALS['webroot']?>/interface/forms/common_form_function/common.css" type="text/css">
</head>
<body onload = "showPrev();">
