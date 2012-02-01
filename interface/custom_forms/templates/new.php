<?
require_once($GLOBALS['incdir']."/globals.php");
require_once($GLOBALS['srcdir']."/calendar.inc");
require_once($GLOBALS['srcdir']."/lists.inc");
require_once($GLOBALS['srcdir']."/forms.inc");
require_once($GLOBALS['incdir']."/forms/common_form_function/common_functions.php");
require_once($GLOBALS['srcdir']."/classes/Prescription.class.php");
require_once($GLOBALS['srcdir']."/classes/Patient.class.php");
require_once(dirname(__FILE__)."/functions.php");

$FORM_DIR = "dictation";
print("<pre>");print_r($_GET);print_r($_SESSION);print("</pre>");

if($pid == "") {
       echo "ERROR: No patient id specified\n<br>";
       exit(1);
}
if($encounter == "") {
       echo "ERROR: No patient encounter specified\n<br>";
       exit(1);
}
$mode = ($form_id == "") ? $mode = "new" : $mode = "update";
$patient = new Patient($pid);
$provider = $patient->get_provider();
?>
<html>
<head>
	<title>Speech Dictation</title>
	
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/DOM.js"></script>
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/dialog.js"></script>
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/overlib_mini.js"></script>
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/calendar.js"></script>
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/textformat.js"></script>
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/form_validate.js"></script>
	<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar.js"></script>
	<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar_en.js"></script>
	<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar_setup.js"></script>
	<? require_once($GLOBALS['webserver_root']."/interface/forms/dictation/dictation.js.php"); ?>
	
	<link rel=stylesheet href="<?echo $css_body;?>" type="text/css">
	<link rel=stylesheet href="<?=$GLOBALS['webroot']?>/interface/forms/common_form_function/common.css" type="text/css">
	<style type="text/css" title="mystyles" media="all">
		<!--
		.textarea_expanded { width: 100%; height: 100%; }
		-->
	</style>
</head>
<body <?echo $top_bg_line;?> topmargin='0' rightmargin='0' leftmargin='2' bottommargin='0' marginwidth='2' marginheight='0'>
<!-- Required for the popup date selectors -->
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>


<?

if($form_signed === true) {
        $provider_results = sqlQuery("select fname,lname from users where id='" . $signed_user . "'");
        $signed_username = $provider_results{"fname"}.' '.$provider_results{"lname"};
?>
<table align="center" width="550">
<tr>
	<td align="center" colspan=2>
		
		<span class=bold>NO modifications may be made except by addendums.&nbsp;&nbsp;&nbsp;
		<!-- <a class='text' href='encounter_top.php'><?=$tback;?></a> -->
		<a class='text' href='<?=$GLOBALS['webroot']?>/interface/patient_file/encounter/encounter_top.php'><?=$tback;?></a>
		</span>
	
		<hr width=90% />
	</td>
</tr>
<?
	$MAIN_TABLE_NAME = "form_dictation";
	$table = "${MAIN_TABLE_NAME}_txt";
	$table_cat = "${MAIN_TABLE_NAME}_txt_cat";
	//$sql="select * from $table where name='$name' limit 1";
	$sql="select a.note as note from $table a, $table_cat b where a.fk_${MAIN_TABLE_NAME}_header=$form_id and b.id=a.fk_$table_cat and b.name=\"addendum\";";
	$stmt=sqlStatement($sql);
	$oldfld_id=-1;
	while($row=sqlFetchArray($stmt)) {
		echo "<tr><td align=\"center\">" . nl2br($row['note']) . "<br><hr width=60/></td></tr>";
	}
?>
	<tr>
	  <td>
		<form method='post' action="<?echo $rootdir?>/forms/common_form_function/addendum_save.php" name='addendum' id='addendum'>

		<span class=bold>Add Addendum/Late Entry Note:</span><br>
		<textarea name="addendum_note" cols='40' rows='2' wrap='virtual' style='width:100%'></textarea>
		<br>
		<input type="submit" name="submit_addendum" value="Submit" />
		<input type=hidden name="form_id" value="<?=$form_id;?>">
		<input type=hidden name="pid" value="<?=$pid;?>">
		<input type=hidden name="encounter" value="<?=$encounter;?>">
		<input type=hidden name="form_dir" value="<?=$FORM_DIR;?>">
		<input type=hidden name="maintblname" value="<?=$MAIN_TABLE_NAME;?>">
		<input type=hidden name="table" value="<?=$table;?>">
		<input type=hidden name="table_cat" value="<?=$table_cat;?>">

		</form>
	  </td>
	</tr>
	</table>
	<hr size=4 color="black"/><p/>
<?
	$save_button = "<button name=\"nosave_submit_only\" disabled >Save Form</button>";
	$sign_button = "<button name=\"nosave_submit_and_sign\" disabled >Sign and Submit</button>";
} else {
	$save_button = "<button name=\"nosave_submit_only\" value=\"Save\" onclick=\"this.form.submit()\" >Save Form</button>";
	$sign_button = "<button name=\"nosave_submit_and_sign\" onclick=\"sign_and_submit(this.form);\" >Sign and 
Submit</button>";
}
?>



<form method='post' action="<?echo $rootdir?>/forms/dictation/save.php" name='dictation' id='dictation' >


<script language="javascript">

	required_fields = new Array(
						new Array('dictation_notes',	'nonempty',		"Please describe the dictation notes"));
	
	/*
	Auto Save Forms-
	By steinmann (editor.downloadtube@gmail.com) based on code from Downloadtube.com

	Major changes by Matthew Excell: mexcell@possibilityforge.com for openEMR

	For full source code, 100's more DHTML scripts, and Terms Of Use,
	visit http://www.downloadtube.com
	*/
	
	autosave = (function(){
		var d=document;
		var i=d.getElementsByTagName('input');
		var t=d.getElementsByTagName('textarea');
		var f=d.getElementsByTagName('form');
		var s=d.getElementsByTagName('select');
		var newi=new Array();
		var c=new Array();
		for(j=0;j<i.length;j++){
			if(i[j].type=='text'){
				newi.push(i[j]);
			}
			if(i[j].type=='checkbox'){
				c.push(i[j]);
			}
		}
		i=newi;
		var box;
		var boxtext;
		var j;
		var e=new Array();
		var eo;
		var saving;

	function start(){
		for(j=0;j<f.length;j++){
			f[j].addEventListener("submit",clear,false);
		}
		for(j=0;j<i.length;j++){
			i[j].addEventListener("keyup",prepsave,false);
		}
		for(j=0;j<t.length;j++){
			t[j].addEventListener("keyup",prepsave,false);
		}
		for(j=0;j<s.length;j++){
			s[j].addEventListener("change",prepsave,false);
		}
		for(j=0;j<c.length;j++){
			c[j].addEventListener("click",prepsave,false);
		}
		offer_repopulate();
	}

	function clear(){
		var today=new Date();
		var expiry=new Date(today.getTime()-30*24*60*60*1000);
		d.cookie="FormsSavedData<?php echo $form_id ?><?php echo $form_signed ?>=; expires="+expiry.toGMTString()+"; path=/";
	}

	function getCookie(name){
		var re=new RegExp(name+"=([^;]+)");
		var value=re.exec(d.cookie);
		return(value!=null)?unescape(value[1]):false;
	}

	function setCookie(name,value){
		var today=new Date();
		var expiry=new Date(today.getTime()+4*60*60*1000);
		d.cookie=name+"="+escape(value)+";expires="+expiry.toGMTString()+"; path=/";
	}

	function prepsave(){
		clearInterval(saving);
		saving=setInterval(savedata,500);
	}

	function savedata(){
		e=new Array();
		for(j=0;j<i.length;j++){
			e.push(i[j].value.toString());
		}
		for(j=0;j<t.length;j++){
			e.push(t[j].value.toString());
		}
		for(j=0;j<s.length;j++){
			e.push(s[j].value.toString());
		}
		for(j=0;j<c.length;j++){
			e.push(c[j].value.toString());
		}
		setCookie('FormsSavedData<?php echo $form_id ?><?php echo $form_signed ?>',e.join("|"));
		clearInterval(saving);
	}

	function repopulate(){
		eo=getCookie('FormsSavedData<?php echo $form_id ?><?php echo $form_signed ?>').split("|");
		for(j=0;j<i.length;j++){
			i[j].value=eo.shift();
		}
		for(j=0;j<t.length;j++){
			t[j].value=eo.shift();
		}
		for(j=0;j<s.length;j++){
			s[j].value=eo.shift();
		}
		for(j=0;j<c.length;j++){
			c[j].value=eo.shift();
		}
	}

	function offer_repopulate(){
		if(getCookie('FormsSavedData<?php echo $form_id ?><?php echo $form_signed ?>')){
			box=d.createElement("div");
			box.setAttribute("style","cursor: pointer; "+"position: absolute; "+"top: 20px; "+"right: 20px; "+"background-color: #fee; "+"color: #f00; "+"border: 1px dotted #f00; "+"padding: 3px 8px;");
			d.body.appendChild(box);
			box.addEventListener("click",repopulate,false);
			boxtext=d.createTextNode('Repopulate Form');
			box.appendChild(boxtext);
		}
	}

	window.addEventListener("load",start,false);
	} )();


</script>


<input type='hidden' name='nosave_mode' value='<?=$mode;?>'>
<input type='hidden' name='nosave_form_id' value='<?=($mode != "new") ? "$form_id":"";?>'>
<input type='hidden' name='encounter' value='<?=$encounter;?>'>
<input type='hidden' name='pid' value='<?=$pid;?>'>

<table "width=90%" align="center" cellpadding="0" cellspacing="10">
<tr>
	<td bgcolor="black" align=center colspan=2>
		<span class=bold><font color=white>DICTATION NOTE</font></span>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<span class=bold><a class='text' 
href='<?=$GLOBALS['webroot']?>/interface/patient_file/encounter/encounter_top.php'><font 
color=white><?=$tback;?></font></a></span>
	</td>
</tr>


<tr>
 <!-- bottom section without columns -->
 <td class="response" colspan=2>
 <span class=required>NOTES:</span><br>
 <?
	// if there's old historic data from the deleted plan_notes field, add it to the impressions_notes.  That field value will be deleted next time the form is saved, but the data will then be in impressions anyway.
	// if the form is signed, then this will display right anyway.
	if(strlen($_POST['plan_notes']) > 0) {
		$_POST['dictation_notes'] .= "\n\n" . $_POST['plan_notes'];
	}
 
 ?>
 <? prev_textarea("dictation_notes", "cols='40' rows='5' wrap='virtual' style='width:100%'"); ?> <p>


 
</td>
</tr>
<tr>
	<td colspan="2">
		<table cellpadding="0" cellspacing="0">
			<td><hr/></td>
			<td class="response" width="1%" nowrap>
				<? echo $save_button . "\n" . $sign_button . "\n"; ?>
				<input type="hidden" name="nosave_sign_valid" value=""/>
			</td>
			<td><hr/></td>
		</table>
	</td>
</tr>


<?php if($form_signed === true) { ?>
	<tr>
		<td align="center" colspan=2>
			<span class=required>NOTICE: Form has been signed by <br><?=$signed_username;?>, <?=$signed_tstamp;?></span><br>
			</span>
		
			<hr width=90% />
		</td>
	</tr>
<?php } ?>
</table>

</form>
</body>
</html>
