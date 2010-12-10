<?php
include_once("../../globals.php");
require_once($GLOBALS['fileroot'] . "/library/classes/CheckPrescribe.class.php");
?>
<html>
<head>
<?php html_header_show();?>
<link rel="stylesheet" href="<?php echo $css_header;?>" type="text/css">
</head>
<body class="body_top">

<span class="title"><?php xl('Prescriptions','e'); ?></span>
<?php 
   $obj            = new CheckPrescribe();
  $countPracticeID = $obj->checkCount(); 
		
  if($countPracticeID == 0)
 {
 ?>
	 <table border="0">
	<tr height="20px">
	<td>
	<a href="<?php echo $GLOBALS['webroot']?>/controller.php?prescription&list&id=<?php echo $pid?>"  target='RxRight' class="css_button" onclick="top.restoreSession()">
	<span><?php xl('List', 'e');?></span></a>
	<a href="<?php echo $GLOBALS['webroot']?>/controller.php?prescription&edit&id=&pid=<?php echo $pid?>"  target='RxRight' class="css_button" onclick="top.restoreSession()">
	<span><?php xl('Add','e');?></span></a>
	</td>
	</tr>
	</table>
<?php  	
 } 
 
 else if($countPracticeID > 0)
{
 ?>
<table border="0">
<tr height="20px">
<td>
<a  href="<?php echo $GLOBALS['webroot']?>/controller.php?prescription&list&id=<?php echo $pid?>&noedit=1"  target='RxRight' class="css_button" onclick="top.restoreSession()">
<span><?php xl('List', 'e');?></span></a>
<a  href="<?php echo $GLOBALS['webroot']?>/controller.php?prescription&editprescribe&id=&pid=<?php echo $pid?>"  target='RxRight' class="css_button" onclick="top.restoreSession()">
<span><?php xl('e-Prescribe','e'); ?></span></a>
</td>
</tr>
</table>
<?php	 
}
?>
</body>
</html>
