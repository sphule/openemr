<?
include_once("../../globals.php");
include_once("$srcdir/../interface/forms/common_form_function/common_functions.php");
require_once($GLOBALS['incdir']."/globals.php");
require_once($GLOBALS['srcdir']."/calendar.inc");
require_once($GLOBALS['srcdir']."/lists.inc");
require_once($GLOBALS['srcdir']."/forms.inc");
require_once($GLOBALS['incdir']."/forms/common_form_function/common_functions.php");
require_once($GLOBALS['srcdir']."/classes/Prescription.class.php");
require_once($GLOBALS['srcdir']."/classes/Patient.class.php");
require_once(dirname(__FILE__)."/functions.php");

$id = $form_id = (!empty($_GET['id'])) ? $_GET['id'] : $form_id ;

// First, make sure we know the form ID and that the form exists.

if($form_id == "") {
	$form_id = $id;
	if($form_id == "") {
		echo "Error: No form ID specified<br>";
		exit(1);
	}
}

$sql			= "	SELECT		forms.form_name, attr.attr_id, attr.attr_name, attr.attr_type, attr.attr_html,
								formattr.form_attr_row_index,attr.attr_fixed_text,attr.attr_select_options,
								attr.attr_label_show,attr.attr_display_label  
					FROM		csf_forms forms 
					INNER JOIN	csf_forms_attributes formattr on forms.form_id = formattr.form_id 
					INNER JOIN	csf_attributes attr on attr.attr_id = formattr.attr_id
					WHERE		forms.form_id = ".$form_id." order by formattr.form_attr_id	";				

$resFormAttr	= sqlStatement($sql);	

$sql			=	"select * from csf_form_data where form_id=".$form_id ." and encounter = ". $_SESSION['encounter'];
$stmt			=	sqlStatement($sql);
$rowFormData	=	sqlFetchArray($stmt);

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
	<link rel="stylesheet" href="<?php echo $css_header; ?>" type="text/css">
</head>



