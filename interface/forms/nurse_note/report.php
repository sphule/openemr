<?
include_once("../../globals.php");
require_once($GLOBALS["fileroot"]."/library/functions.php");
include_once($GLOBALS['srcdir']."/calendar.inc");
require_once($GLOBALS['srcdir']."/acl.inc");
include_once("../../patient_file/history/history.inc.php");
include_once("$srcdir/options.inc.php");


function nurse_note_report( $pid, $encounter, $cols, $form_id) {
	
	// establish some variables
	$maintblname="form_nurse_note";
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
  	          and f.pid = p.pid  and f.form_name = 'Nurses Note'
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
	

?>
	
	
	
	<table border=0>
<?
        $sql="
		select a.note as note 
 		 from form_nurse_note_txt a, 
		      form_nurse_note_txt_cat b 
		where a.fk_form_nurse_note_header = $form_id 
		  and b.id = a.fk_form_nurse_note_txt_cat and b.name=\"addendum\";
	";
        $stmt = sqlStatement($sql);
        $oldfld_id = -1;
        while($row = sqlFetchArray($stmt)) {
                echo "<tr><td colspan=2 align=\"center\">" . nl2br($row['note']) . "<br><hr width=60/></td></tr>";
        }
?>

		
		<?  if(strlen($formArray['nurses_notes']) > 0) { ?>
		<tr>
			<td valign="top" width="10%" class=bold>Notes:</td>
			<td valign="top" width="88%" class=small><?=nl2br($formArray['nurses_notes'])?></span></td>
		</tr>
		<? } ?>

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
	</table>
<? } # end report function ?>
