<?
require_once($GLOBALS['incdir']."/globals.php");
require_once($GLOBALS['srcdir']."/calendar.inc");
require_once($GLOBALS['srcdir']."/lists.inc");
require_once($GLOBALS['srcdir']."/forms.inc");
require_once($GLOBALS['incdir']."/forms/common_form_function/common_functions.php");
require_once($GLOBALS['srcdir']."/classes/Prescription.class.php");
require_once($GLOBALS['srcdir']."/classes/Patient.class.php");
require_once($GLOBALS['srcdir']."/functions.php");

$FORM_DIR = "progress_note1";
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
	<title>Progress Note</title>
	
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/DOM.js"></script>
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/dialog.js"></script>
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/overlib_mini.js"></script>
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/calendar.js"></script>
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/textformat.js"></script>
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/form_validate.js"></script>
	<? require_once($GLOBALS['webserver_root']."/interface/forms/progress_note1/progress_note1.js.php"); ?>
	<link rel="stylesheet" href="<?php echo $css_header; ?>" type="text/css">
	<link rel=stylesheet href="<?echo $css_body;?>" type="text/css">
	<link rel=stylesheet href="<?=$GLOBALS['webroot']?>/interface/forms/common_form_function/common.css" type="text/css">
	
	<style type="text/css" title="mystyles" media="all">
		<!--
		.textarea_expanded { width: 100%; height: 100%; }
		-->
	</style>
</head>
<? //echo $top_bg_line;?>
<body class="body_top" topmargin='0' rightmargin='0' leftmargin='2' bottommargin='0' marginwidth='2' marginheight='0' onload="update_hpi_location();">
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
	$MAIN_TABLE_NAME = "form_progress_note1";
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
	$save_button = "<button name=\"nosave_submit_only\" value=\"Save\" onclick=\"javascript: update_hpi_location(); this.form.submit()\" >Save Form</button>";
	$sign_button = "<button name=\"nosave_submit_and_sign\" onclick=\"javascript:if 
(validate(this.form,required_fields)) {sign_and_submit(this.form);} return false;\" >Sign and 
Submit</button>";
}
?>



<form method='post' action="<?echo $rootdir?>/forms/progress_note1/save.php" name='exam' id='exam' >

<script language="javascript">
<!--
// This array defines which fields are required
required_fields = new Array(
 new Array(     'date_of_service',	'nonempty',		"Please enter the date of service.\n"),
 new Array(     'chief_complaint',	'nonempty',		"Please enter patient's chief complaint.\n"),
// new Array(     'hpi_notes',		'nonempty',		"Please enter details on the History of Present Illness (HPI), or 'n/a' if not applicable.\n"),
// new Array(     'ros_notes',		'nonempty',		"Please enter details on the review of symptoms (ROS), or 'n/a' if not applicable.\n"),
// new Array(     'exam_notes',		'nonempty',		"Please enter details on the exam, or 'n/a' if not applicable.\n"),
 new Array(     'impressions_notes',	'nonempty',		"Please describe your impressions and plan\n")
// new Array(     'plan_notes',		'nonempty',		"Please describe your plan for treatment.\n")
// new Array(     'followup_notes',	'nonempty',		"Please describe the planned followup.\n")
)

//-->
</script>
<script language="javascript">
<!--

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

//-->
</script>


<input type='hidden' name='nosave_mode' value='<?=$mode;?>'>
<input type='hidden' name='nosave_form_id' value='<?=($mode != "new") ? "$form_id":"";?>'>
<input type='hidden' name='encounter' value='<?=$encounter;?>'>
<input type='hidden' name='pid' value='<?=$pid;?>'>

<table "width=90%" align="center" cellpadding="0" cellspacing="10">
<tr>
	<td bgcolor="black" align=center colspan=2>
		<span class=bold><font color=white>PROGRESS NOTE</font></span>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<span class=bold><a class='text' 
href='<?=$GLOBALS['webroot']?>/interface/patient_file/encounter/encounter_top.php'><font 
color=white><?=$tback;?></font></a></span>
	</td>
</tr>
<tr>
	<td class=bold>Patient Name:</span> <?= $patient->get_name_full() ?></td>
	<td class=bold>Provider:</span> <?= $provider->get_name_display()?></td>
</tr>
<tr>
	<td colspan="2">
		<span class=required>Date of Service:</span>
		
		<input <? prev_textbox("date_of_service", date('Y-m-d')); ?> size='10'
		    title='Date of Service'
		    onkeyup='datekeyup(this,mypcc)' onblur='dateblur(this,mypcc)' />
		<a href="javascript:<? if($form_signed == false) { ?> show_calendar('exam.date_of_service')  <? } else { ?>alert('You cannot change a form once it is signed'); <? }  ?>"
		    title="Click here to choose a date"
		    ><img src='<?=$GLOBALS['rootdir'];?>/pic/show_calendar.gif' align='absbottom' width='24' height='22' border='0' alt='[?\]'></a>
		<br/>
		<span class=required>Chief Complaint:</span> <br>
		<?
		$formResult = getFormByEncounter($pid, $encounter, "*", "New Patient Encounter");
		$encResult = getFormInfoById($formResult[0]["id"]);
		?>
		<? prev_textarea("chief_complaint", "cols='40' rows='2' wrap='virtual' style='width:100%'",$encResult["reason"]); ?> <br>
	</td>
</tr>
<tr>
<td colspan=2>
	<table border=0 width="100%">
	<tr>
		<td><hr/></td>
		<td class="response" width="1%"><? echo $save_button; ?> <!--<button name="nosave_submit_only" value="Save" onclick="javascript:this.form.submit()" >Save Form</button>--></td>
		<td><hr/></td>
	</tr>
	</table>
</td>
</tr>
<tr>
	<td width="50%" valign="top">
	<!-- Left column -->

<fieldset class ="section_body">
	<legend class="section_title">HPI - History of Present Illness</legend>

	<table border="0" cellspacing="0">
	<tr>
		<td valign="top" class="response"><span class=bold>Symptoms</span></td>
		<td valign="top" class="response">
			<input type="hidden" name="hpi_location" id="hpi_location" value="<?= $_POST["hpi_location"] ?>"/>
			<? prev_dropdown("nosave_hpi_location_menu", $symptoms, $symptoms_default, "onchange=\"update_hpi_location()\""); ?>
			<div name="div_hpi_location_text" id="div_hpi_location_text" style="visibility:hidden; display: none">
			<br/>
				<input type="text" name="nosave_hpi_location_text" value="<?= $_POST["nosave_hpi_location_text"]; ?>"<?= ($form_signed === true)?" disabled":"" ?> size=25 onchange="update_hpi_location()" onblur="update_hpi_location()" maxlength=50 />
		   		<a onclick="javascript:document.forms['exam'].nosave_hpi_location_text.value=''; return false;"><u>Clear</u></a>
			</div>
			<script type="text/javascript"><?= ($symptoms_default=="other") ? "document.forms['exam'].nosave_hpi_location_menu.selectedIndex=".(count($symptoms)-1)."; update_hpi_location();" : "" ?></script>
		</td>
	</tr>
	<tr>
		<td valign="top" class="response"><span class=bold>Quality</span></td>
		<td valign="top" class="response">Select all that apply:<br/>
			<? menu("hpi_quality[]", $quality, $quality_defaults, "", 5, true); ?>
		</td>
	</tr>
	<tr>
		<td valign="top" class="response"><span class=bold>Severity</span></td>
		<td valign="top" class="response" nowrap>
			<? menu("hpi_severity", $severity, $severity_defaults, "", 1, false); ?>
		</td>
	</tr>
	<tr>
		<td valign="top" class="response"><span class=bold>Duration</span></td>
		<td valign="top" class="response" nowrap>
			<input <? prev_textbox("hpi_duration_amt"); ?> size=3 />
			<? menu("hpi_duration", $duration, $duration_defaults, "", 1, false); ?>
		</td>
	</tr>
	<tr>
		<td valign="top" class="response"><span class=bold>Timing</span></td>
		<td valign="top" class="response">
			<? menu("hpi_timing", $timing, $timing_defaults, "", 1, false); ?>
		</td>
	</tr>
	<tr>
		<td valign="top" class="response"><span class=bold>Context</span></td>
		<td valign="top" class="response">
			<input <? prev_textbox("hpi_context_text"); ?> size=10 style="width:100%" /><br/>
			Aggravated by activity?
			<? menu("hpi_context", $context, $context_defaults, "", 1, false); ?>
		</td>
	</tr>
	<tr>
		<td valign="top" class="response"><span class=bold>Modifying Factors</span></td>
		<td valign="top" class="response">
			<input <? prev_textbox("hpi_modifying_factors"); ?> size=40 />
		</td>
	</tr>
	<tr>
		<td valign="top" class="response"><span class=bold>Associated symptoms</span></td>
		<td valign="top" class="response">
			<input <? prev_textbox("hpi_associated_symptoms"); ?> size=40 />
		</td>
	</tr>
	<tr>
		<td colspan="2" class="response">
			<span class=bold>Additional HPI:</span><br>
			<? prev_textarea("hpi_notes", "cols='40' rows='5' wrap='virtual' style='width:100%'"); ?>
		</td>
	</tr>
	</table>
</fieldset>
<br/>

</td>




<!-- Right column -->
<td valign="top">

<fieldset class ="section_body">
	<legend class="section_title">PFSH - Prior Family & Social History</legend>

	 <table width="100%" border=0 cellspacing=0>
	 <tr>
	  	<td class="response" align="center" colspan="2"><input type='button' <? if($form_signed === true) echo " disabled "; ?> onclick='view_history("<?php echo 'progress_note';?>")' value='View/Edit History'/></center></td>
	</tr>
	<tr>
	 	<td class="response"><input <? prev_checkbox("pfsh_reviewed_history"); ?> /></td>
	 	<td class="response">Pt history reviewed/updated and is accurate</td>
	</tr>
	</table>
</fieldset>
<br/>



<fieldset class ="section_body">
	<legend class="section_title">ROS - Review of Symptoms</legend>

	<table width="100%" border=0 cellspacing=0>
	<tr>
		<td class="response" colspan=2>
			<?
			$form_ros_id = find_ros_id_for_encounter($encounter);
			if($form_ros_id > 0) {
				$form_edit_new = "Edit";
			} else {
				$form_edit_new = "New";
			}
			
			function find_ros_id_for_encounter($encounter) {
				$db = $GLOBALS['adodb']['db'];
			
			$sql = "SELECT form_id as id FROM forms WHERE formdir='ros' AND encounter = " . mysql_real_escape_string($encounter);
			
			$results = $db->Execute($sql);
			
			if (!$results) {
				$err = $db->ErrorMsg();
				echo "Note: Error while searching for ros form: " . $err . "<br/>\n";
			}
			
			// just grab the first id, whatever that ends up being.
			// later we may want to grab all of them
			if(!$results->EOF) {
				return $results->fields['id'];
			} else {
				return 0; // no results
				}
			}
			?>
			<center><input type='button' <? if($form_signed === true) echo " disabled "; ?> onclick='view_edit_ros1(<?=$form_ros_id?>,"progress_note")' value='<?=$form_edit_new?> ROS Form'/></center>
	 	</td>
	</tr>
	<tr>
		<td class="response"><input <? prev_checkbox("ros_ros_initial_reviewed"); ?> /></td>
		<td class="response">ROS reviewed from intial intake and changes are noted</td>
	</tr>
	<tr>
		<td class="response"><input <? prev_checkbox("ros_ros_prior_reviewed"); ?> /></td>
		<td class="response">Prior ROS checks reviewed and changes are noted</td>
	</tr>
	<tr>
		<td class="response" colspan="2">
			<br/>
			<center><span class=bold>Narrative Note</span></center>
			<span class=small>(Written as answers to questions, i.e. 'Patient states' or 'Patient complains of')</span><br>
			<? prev_textarea("ros_notes", "cols='40' rows='5' wrap='virtual' style='width:100%'"); ?>
		</td>
	</tr>
	</table>
</fieldset>
<br/>




<fieldset class ="section_body">
	<legend class="section_title">Medication</legend>
	<?
		// grab info on medication
	
		$prescriptions = array();
		$sql="select id from prescriptions where patient_id=$pid and active=1";
		$stmt=sqlStatement($sql);
		while($row=sqlFetchArray($stmt)) {
			$prescriptions[] = new Prescription($row['id']);
		}
	
		$med_default="";
		$mednum=0;
		foreach($prescriptions as $p) {
			if($mednum > 0) $med_default .= "\n";
			$med_default .= $p->get_drug().":\n";
			$med_default .= "dosage:   ".$p->get_dosage_display()."\n";
			$med_default .= "quantity: ".$p->get_quantity().", ";
			$med_default .= "size: ".$p->get_size()." ".$p->get_unit_display()."\n";
			$med_default .= "route:    ".$p->route_array[$p->get_route()]."\n";
			$mednum++;
		}
		if(!$form_signed) // we want to automatically update medication each time the form is loaded/saved (until form is signed)
			$_POST['medication'] = $med_default;
	?>
	
	<table border=0 cellspacing=0 width=100%>
	<tr>
		<td class="response">
			<span class=bold>Medication</span><br>
			<?php if($form_signed === true) { ?>
			<input type='button' onclick="new_issue1(0,'progress_note')" value='Edit Medications/Issues' disabled/><br>
			<?php } 
			else { ?> 
		 	 <input type='button' onclick="new_issue1(0,'progress_note')" value='Edit Medications/Issues'/><br>
			<?php } ?>
			<input <? prev_checkbox("reviewed_on_pt_mars"); ?> >Reviewed on pt medication lists</input><br>
		</td>
	</tr>
	</table>
</fieldset>

</td>
</tr>

<tr>
<td colspan=2>
	<table border=0 width="100%">
	<tr>
		<td><hr/></td>
		<td class="response" width="1%"><? echo $save_button; ?> <!--<button name="nosave_submit_only" value="Save" onclick="javascript:this.form.submit()" >Save Form</button>--></td>
		<td><hr/></td>
	</tr>
	</table>
</td>
</tr>


<!-- vitals list -->
<tr>
 <td colspan=2 align="center">
  <table border=0 width="100%">
  <td><input type='button' <? if($form_signed === true) echo " disabled "; ?> onclick="new_vital(0,'progress_note')" value='Take Vitals'/></td>
<?

function getVitalsHorizontal() {
	global $pid, $encounter;
	$db = $GLOBALS['adodb']['db'];
	
	$id = null;
	// grab in two ways:
	// First grab vitals from this encoutner
	$sql = "SELECT form_id as id FROM forms WHERE formdir='vitals' AND encounter = " . mysql_real_escape_string($encounter);
	// then grab vitals that are on this date but not this encounter
//	$sql.= " UNION SELECT v.id FROM form_encounter e LEFT JOIN form_vitals v ON SUBSTRING(e.date,1,10) = SUBSTRING(v.date,1,10) WHERE activity=1 AND e.encounter = " . mysql_real_escape_string($encounter);
	
	$results = $db->Execute($sql);

	if (!$results) {
		$err = $db->ErrorMsg();
		echo "Note: Error while searching for vitals: " . $err . "<br/>\n";
	}

	// just grab the first id, whatever that ends up being.
	// later we may want to grab all of them
	if(!$results->EOF) {
		$id = $results->fields['id'];
	} else {
		return false; // no results, quit now
	}
	
	if(!is_numeric($id)) {
		return false; // how did we get something non-numeric?  Maybe blank...
	}

	echo "<td>&nbsp;&nbsp;&nbsp;&nbsp;";
	// this is easier
	require_once(dirname(__FILE__) . "/../vitals/report.php");
	vitals_report($pid, $encounter, 1000, $id);
	echo "</td>";

	return true;
}

getVitalsHorizontal();

?>
  </tr>
  </table>
 </td>
</tr>


<tr>
 <!-- row 2 -->
 <td class="response" valign="top" colspan=2>

<?
	$textarea_style = "cols='40' rows='2' wrap='virtual' class=\"textarea_expanded\"";
	if($form_signed === true) {	
		$check_all_normal = "
			<span class=link>
			<a disabled=true; href='javascript:return false' >un-check all</a>
			</span>
			";
	}
	else {
		$check_all_normal = "
			<span class=link>
			<a disabled=true; href='javascript:check_all_exam_normal(false)' >un-check all</a>
			</span>
			";
	}
?>


 <table width="100%" height="100%" border=1 cellspacing=0>
 <tr>
 	<td class="response" colspan=4><span class=bold>Physical Exam</span></td>
 </tr>
 <tr>
  <td class="response" width="20%"><span class=bold>Body System</span></td>
  <td class="response" colspan=2 width="30%">

   <table width="100%" border=0 cellspacing=0>
   <tr>
   	<td class="response" align=left><span class=bold>Normal Findings</span></td>
   	<td class="response" align=right><span class=bold><?php echo $check_all_normal;?></span>
   	</td>
   </tr>
   </table>

  </td>
  <td width=10><span class=bold>See Note (Abnormal Findings)</span></td>
</tr>

<? physical_exam_output_all_html(); ?>

</table>
</td>
</tr>

<tr>
<td colspan=2>
	<table border=0 width="100%">
	<tr>
		<td><hr/></td>
		<td class="response" width="1%"><? echo $save_button; ?> <!--<button name="nosave_submit_only" value="Save" onclick="javascript:this.form.submit()" >Save Form</button>--></td>
		<td><hr/></td>
	</tr>
	</table>
</td>
</tr>
<tr>
<td colspan=2>
<fieldset class ="section_body">
	<legend class="section_title">Workflow</legend>

	<table width="100%" border=0 cellspacing=0>
	<tr>
		<td valign="top">
			<table width="100%" border=0 cellspacing=0>
				<tr>
					<td class="response"><input <?php prev_checkbox("wflow_old_records_reviewed"); ?> /></td>
					<td class="response">Old records reviewed</td>
				</tr>
				<tr>
					<td class="response"><input <?php prev_checkbox("wflow_labs_reviewed"); ?> /></td>
					<td class="response">Labs reviewed</td>
				</tr>
				<tr>
					<td class="response"><input <?php prev_checkbox("wflow_xrays_reviewed"); ?> /></td>
					<td class="response">X-Rays reviewed</td>
				</tr>
				<tr>
					<td class="response"><input <?php prev_checkbox("wflow_consultation_reviewed"); ?> /></td>
					<td class="response">Consultation report reviewed</td>
				</tr>
				<tr>
					<td class="response"><input <?php prev_checkbox("wflow_stress_echo_ekg_reviewed"); ?> /></td>
					<td class="response">Stress, echo, EKG reviewed</td>
				</tr>
				<tr>
					<td class="response"><input <?php prev_checkbox("wflow_consult_other_clinician"); ?> /></td>
					<td class="response">Consulted other clinician</td>
				</tr>
				<tr>
					<td class="response"><input <?php prev_checkbox("wflow_from_staff_or_family"); ?> /></td>
					<td class="response">Obtained information from staff or family</td>
				</tr>
			</table>
		</td>
		<td>
			<table width="100%" border=0 cellspacing=0>
				<tr>
					<td class="response"><input <?php prev_checkbox("wflow_labs_reviewed_with_pt"); ?> /></td>
					<td class="response">Labs reviewed with patient</td>
				</tr>
				<tr>
					<td class="response"><input <?php prev_checkbox("wflow_meds_with_patient"); ?> /></td>
					<td class="response">Meds reviewed with patient</td>
				</tr>
				<tr>
					<td class="response"><input <?php prev_checkbox("wflow_xrays_with_patient"); ?> /></td>
					<td class="response">X-Rays reviewed with patient</td>
				</tr>
				<tr>
					<td class="response"><input <?php prev_checkbox("wflow_colonoscopy_with_pt"); ?> /></td>
					<td class="response">Colonoscopy reviewed with patient</td>
				</tr>
				<tr>
					<td class="response"><input <?php prev_checkbox("wflow_pap_with_pt"); ?> /></td>
					<td class="response">PAP reviewed with patient</td>
				</tr>
				<tr>
					<td class="response"><input <?php prev_checkbox("wflow_echo_with_pt"); ?> /></td>
					<td class="response">Echo reviewed with patient</td>
				</tr>
				<tr>
					<td class="response"><input <?php prev_checkbox("wflow_ekg_with_pt"); ?> /></td>
					<td class="response">EKG reviewed with patient</td>
				</tr>
				<tr>
					<td class="response"><input <?php prev_checkbox("wflow_mammo_with_pt"); ?> /></td>
					<td class="response">Mammogram reviewed with patient</td>
				</tr>
				<tr>
					<td class="response"><input <?php prev_checkbox("wflow_stress_with_pt"); ?> /></td>
					<td class="response">Stress reviewed with patient</td>
				</tr>
				<tr>
					<td class="response"><input <?php prev_checkbox("wflow_hemoccults_with_pt"); ?> /></td>
					<td class="response">Hemoccults reviewed with patient</td>
				</tr>
			</table>
		</td>
	</tr>		
	</table>	
</fieldset>

</td>

</tr>
<tr>
 <!-- bottom section without columns -->
 <td class="response" colspan=2>
 <span class=required>IMPRESSIONS AND PLAN:</span><br>
 <?
	// if there's old historic data from the deleted plan_notes field, add it to the impressions_notes.  That field value will be deleted next time the form is saved, but the data will then be in impressions anyway.
	// if the form is signed, then this will display right anyway.
	if(strlen($_POST['plan_notes']) > 0) {
		$_POST['impressions_notes'] .= "\n\n" . $_POST['plan_notes'];
	}
 
 ?>
 <? prev_textarea("impressions_notes", "cols='40' rows='5' wrap='virtual' style='width:100%'"); ?> <p>


 <span class=bold>Follow up in</span> <?
	$followup_units_a = array("unspecified"=>"");
	for($follow_i=1; $follow_i<=12; $follow_i++) {
		$followup_units_a[(string)$follow_i] = (string)$follow_i;
	}
	$followup_units_default = $followup_units_a[0];
//	prev_dropdown("followup_units", $followup_units, $followup_units_default);
	prev_dropdown("followup_units", $followup_units_a, $followup_units,$followup_units_default);
	
	echo " ";

	$followup_period_a = array("unspecified"=>"", "days"=>"days", "weeks"=>"weeks", "months"=>"months", "years"=>"years");
	$followup_period_default = $followup_period_a[0];
	prev_dropdown("followup_increment", $followup_period_a, $followup_increment,$followup_period_default);

?>&nbsp;&nbsp;&nbsp;&nbsp;Comments: <input <? prev_textbox("followup_notes"); ?> size=25/> <p>



 Was counseling/coordinating more than 50% of the time with patient?
 <input <? prev_radio("mostly_counseling", "1"); ?> >yes</input>
 <input <? prev_radio("mostly_counseling", "0"); ?> >no</input>
 <br>

 If YES, 
 Time In:  <input <? prev_textbox("time_in"); ?> size=25/> 
 Time Out: <input <? prev_textbox("time_out"); ?> size=25/>
 <br>

 Time Spent counseling or coordinating care:  <input <? prev_textbox("time_spent"); ?> size=25/> 


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

<tr>
	<td colspan="2">
		<?
		 $form_tag_name = "exam"; // set this to the name/id of your form tag!
		 include_once("$srcdir/../interface/forms/common_form_function/billing_codes_display.php");
		?>
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
