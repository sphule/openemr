<?
include_once("../../globals.php");
require_once($GLOBALS['srcdir']."/functions.php");
include_once($GLOBALS['srcdir']."/calendar.inc");
require_once($GLOBALS['srcdir']."/acl.inc");
include_once("../../patient_file/history/history.inc.php");
include_once("$srcdir/options.inc.php");


function progress_note1_report( $pid, $encounter, $cols, $form_id) {
	
	// establish some variables
	$maintblname="form_progress_note1";
	$formArray = getFormArray($maintblname, $form_id);
	$history = getHistoryResult($pid);

	$sql="select p.id, 
	             p.pid, 
	             p.encounter, 
	             p.signed_user, 
	             p.signed_tstamp ,
	             f.date,
		     f.user
	        from ${maintblname}_header p
	        left join forms f on (
	              f.form_id = p.id
  	          and f.pid = p.pid and f.form_name = 'Progress Note Type 1'
	        )
	       where p.id = $form_id";
	$row=sqlFetchArray(sqlStatement($sql));
	$created_tstamp = $row['date'];
	$created_user = $row['user'];
	$signed_user = $row['signed_user'];
	$signed_tstamp = $row['signed_tstamp'];
	
	if (!isset($encounter)) $encounter = $row['encounter'];
	
	if($signed_user != "" && $signed_tstamp != "") {
		$form_signed = true;
	    $provider_results = sqlQuery("select fname,lname from users where id='" . $signed_user . "'");
	    $signed_username = $provider_results{"fname"}.' '.$provider_results{"lname"};
	}
	if($created_user != "" && $created_tstamp != "") {
		$created_results = sqlQuery("select fname,lname from users where username='". $created_user ."'");
		$created_username = $created_results{"fname"}.' '.$created_results{"lname"};
	}

	
	// make sure we know the form ID and that the form exists.
	if(!formExists($maintblname, $form_id)) {
		echo "Error: No form with that ID ($form_id)<br>";
		return;
	}
	
	
	// combine impression and plan if legacy data exists
	if(strlen($formArray['plan_notes']) > 0) {
		$formArray['impressions_notes'] .= "\n\n" . $formArray['plan_notes'];
	}
	?>
	
	
	
	
	<table border=0>
<?
        $sql="
		select a.note as note 
 		 from form_progress_note1_txt a, 
		      form_progress_note1_txt_cat b 
		where a.fk_form_progress_note1_header = $form_id 
		  and b.id = a.fk_form_progress_note1_txt_cat and b.name=\"addendum\";
	";
        $stmt = sqlStatement($sql);
        $oldfld_id = -1;
        while($row = sqlFetchArray($stmt)) {
                echo "<tr><td colspan=2 align=\"center\">" . nl2br($row['note']) . "<br><hr width=60/></td></tr>";
        }
?>

		
		<tr>
			<td valign="top" class=bold>Chief Complaint:</span></td>
			<td valign="top" class=small><?=nl2br($formArray['chief_complaint'])?></span></td>
		</tr>
		<tr>
			<td valign="top" class=bold>HPI:</span></td>
			<td valign="top" class=small><?=nl2br(buildHPINarrative($formArray))?></span></td>
		</tr>
		<?php // Past Diagnoses section removed per bug #411 by whimmel 15sep2010 // ?>
 		<tr>
			<td valign="top" class=bold>Past Medical Problems:</span></td>
			<td valign="top" class=small><?= buildPastProblemsNarrative($pid, $created_tstamp) ?></td>
		</tr>
		<tr>
			<td valign="top" class=bold>Allergies:</span></td>
			<td valign="top" class=small><?= buildAllergiesNarrative($pid, $created_tstamp) ?></td>
		</tr>
		<tr>
			<td valign="top" class=bold>Medications:</span></td>
			<td valign="top" class=small><?= buildMedicationsNarrative($pid, $created_tstamp) ?></td>
		</tr>
 		<tr>
			<td valign="top" class=bold>Past Surgeries:</span></td>
			<td valign="top" class=small><?= buildPastSurgeriesNarrative($pid, $created_tstamp) ?></td>
		</tr>
 		<tr>
			<td valign="top" class=bold>Dental Issues:</span></td>
			<td valign="top" class=small><?= buildDentalIssuesNarrative($pid, $created_tstamp) ?></td>
		</tr>
 		<tr>
			<td valign="top" class=bold>Immunizations:</span></td>
			<td valign="top" class=small>
			
				
				<? //= buildImmunizationsNarrative($pid) ?>			
 <?php
	
  $sql = "select i1.id as id, i1.immunization_id as immunization_id,".
         " if (i1.administered_date, concat(i1.administered_date,' - '), substring(i1.note,1,20)) as immunization_data ".
         " from immunizations i1 ".
         " where i1.patient_id = $pid ".
         " order by i1.immunization_id, i1.administered_date desc";

  $result = sqlStatement($sql);

   while ($row=sqlFetchArray($result)){
    echo "&nbsp;&nbsp;";
    echo "<a class='link' target='";
    echo $GLOBALS['concurrent_layout'] ? "_parent" : "Main";
    echo "' href='../summary/immunizations.php?mode=edit&id=".$row['id']."' onclick='top.restoreSession()'>" .
    $row{'immunization_data'} .
   generate_display_field(array('data_type'=>'1','list_id'=>'immunizations'), $row['immunization_id']) .
    "</a><br>\n";
  }
?>	
		</td>
		</tr>
		<tr>
			<td valign="top" class=bold>Social History:</span></td>
			<td valign="top" class=small><?= buildsocialHistoryNarrative($history) ?></td>
		</tr>
		<tr>
			<td valign="top" class=bold>Family History:</span></td>
			<td valign="top" class=small><?= buildFamilyHistoryNarrative($history) ?></td>
		</tr>
		<tr>
			<td valign="top" class=bold>Review of Systems:</span></td>
			<td valign="top" class=small>
				<?
					if(!empty($formArray["ros_ros_initial_reviewed"])) { print("ROS reviewed from intial intake and changes are noted<br/>\n"); }
					if(!empty($formArray["ros_ros_prior_reviewed"])) { print("Prior ROS checks reviewed and changes are noted"); }
				?>
			</td>
		</tr>
		<?  if(strlen($formArray['ros_notes']) > 0) { ?>
		<tr>
			<td valign="top" class=small>ROS Details:</td>
			<td valign="top" class=small><?=nl2br($formArray['ros_notes'])?></span></td>
		</tr>
		<? } ?>

		<tr>
			<td valign="top" class=bold>Vitals:</span></td>
			<td valign="top" class=small>
<?
	$auth_notes_a  = acl_check('encounters', 'notes_a');
	$auth_notes    = acl_check('encounters', 'notes');
	$auth_relaxed  = acl_check('encounters', 'relaxed');
	
	if ($result = getFormByEncounter($pid, $encounter, "id, date, form_id, form_name,formdir,user,encounter","Vitals")) {
		
		// This encounter has vitals form(s)
		foreach ($result as $vital) {
			print("<p>\n");
			if(	($vital["form_name"] == "Vitals") 
				&&
				(		($auth_notes_a)
					||	($auth_relaxed)
					||	($auth_notes    &&    $vital['user'] == $_SESSION['authUser']) 
				)
			) {
				// Use the form's $form_version for display.
				include_once($GLOBALS['incdir'] . "/forms/vitals/report.php");
				vitals_report($pid, $vital['encounter'], 2, $vital['form_id']);
			}
			print("</p>\n");
		}
	}
?>
			</td>
		</tr>
		<tr>
			<td valign="top" class=bold>Physical Exam:</td>
			<td valign="top" class=small><?= buildPhysicalExamNarrative($formArray) ?></td>
		</tr>
		<tr>
			<td valign="top" class=bold>Impressions and Plan:</span></td>
			<td valign="top" class=small><?=nl2br($formArray['impressions_notes'])?></span></td>
		</tr>
		<? // if(strlen($followup) > 0) { ?>
		<tr>
			<td valign="top" class=bold>Followup:</span></td>
			<td valign="top"><?= buildFollowupNarrative($formArray) ?></td>
		</tr>
		<tr>
			<td colspan=2 class=bold>
				<? if($form_signed === true) { ?>
					Form has been signed by<br/><?= $signed_username ?>, <?= $signed_tstamp ?>
				<? } else { ?>
					<span class=required><i>Form has not been signed</i></span>
				<? } ?>
		 	</td>
		</tr>
		<tr>
			<td colspan=2 class=bold>
				Form was created by<br/><?= $created_username ?>, <?= $created_tstamp ?>
			</td>
		</tr>
		<? // } ?>
	</table>
<? } # end report function ?>
