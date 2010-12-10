<?php
include_once("../../globals.php");

require_once($GLOBALS['fileroot'] . "/library/classes/CheckPrescribe.class.php");
    	$obj        =  new CheckPrescribe();
        $countPracticeID = $obj->checkCount();
        
?>

<html>
<head>
<?php html_header_show();?>
<title><?php xl('Prescriptions','e'); ?></title>
</head>
<frameset cols="15%,*">
 <frame src="rx_left.php" name="RxLeft" scrolling="auto">
 <?php 
 if($countPracticeID == 0)
 {
	 ?>
<frame src="<?php echo $GLOBALS['webroot'] ?>/controller.php?prescription&list&id=<?php echo $pid ?>"  name="RxRight" scrolling="auto">
<?php
 }
 
 else if($countPracticeID >0)
{

	?>

 <frame src="<?php echo $GLOBALS['webroot'] ?>/controller.php?prescription&list&id=<?php echo $pid ?>&noedit=1"  name="RxRight" scrolling="auto">
 <?php
}
?>

</frameset><noframes></noframes>
</html>
