<?
include_once("../../globals.php");
include_once("$srcdir/forms.inc");
include_once("../common_form_function/common_functions.php");
require_once("$srcdir/functions.php");

 
 

// Configuration variables
global $testing;
$MAIN_TABLE_NAME = "form_progress_note1";
$FORM_NAME_HR="Progress Note Type 1";
$FORM_DIR="progress_note1";
$AUTO_INSERT_FIELDS = true; // fill the cb_fields and text_category tables automatically either for first time or when fields are added
$DISPLAY_ALL_FIELDS = false; // show all the fields we've gotten from POST (except nosave_ ones)
$SHOW_CATEGORIES = false; // show the category lists

$testing = (empty($testing)) ? false : $testing ; // whether to diplay the debugging information or not
if($AUTO_INSERT_FIELDS) { update_table_fields($MAIN_TABLE_NAME, "_cb_flds", "_txt_cat"); }
if($DISPLAY_ALL_FIELDS) { displayAllFields(); }



// prepare a timestamp
list($nano, $sec) = explode(" ", microtime());
$nano = str_replace("0.", "", $nano);
$timestamp = "$sec"."$nano";

// check for required variables
$pid = $nosave_pid = $_POST['pid'];
unset($_POST['pid']);
if(empty($pid)) {
	echo "Error: No patient selected!<br>";
	exit(1);
}

$encounter = $_POST['encounter'];
unset($_POST['encounter']);
if(empty($encounter)) {
	echo "Error: No patient encounter selected!<br>";
	exit(1);
}

$form_id = $_POST["nosave_form_id"];

// exit if this form is already signed since we can't save a signed form
$updating = false;
if(!empty($form_id)) {
	$sql="select id, signed_user, signed_tstamp from ${MAIN_TABLE_NAME}_header where id=$form_id and pid=$pid";
	$stmt=sqlStatement($sql);
	//print_r($sql);
	while($row=sqlFetchArray($stmt)) {
		$updating = true;
		$signed_tstamp = $row['signed_tstamp'];
		$signed_user = $row['signed_user'];
	}
	
	// if document has been signed... quit immediately.
	if(!empty($signed_user) && !empty($signed_tstamp)) {
		$msg = "You cannot save or modify a form that has already been signed.";
		return_to_encounter($encounter, $msg);
		//exit(1);
		include("new.php");
		exit(1);
	}
}

// prepare to sign or not sign the form
if($_POST["nosave_sign_valid"] == 1) {
	// sign the form using current user
	$provider_results = sqlQuery("select id from users where username='" . $_SESSION["authUser"] . "'");
	$signed_user_val = "\"".$provider_results["id"]."\"";
	$signed_tstamp_val = "now()";
} else {
	// don't sign the form
	$signed_user_val = "NULL";
	$signed_tstamp_val = "NULL";
}

// save the header row
if(!$updating) {
	//echo "Inserting<br>";
	$date = "now()";
	$sql = "INSERT INTO ${MAIN_TABLE_NAME}_header (pid, encounter, date, tstamp, signed_user, signed_tstamp)";
	$sql .= " VALUES ($pid, $encounter, $date, $timestamp, $signed_user_val, $signed_tstamp_val)";
} else {
	//echo "Updating<br>";
	$sql = "UPDATE ${MAIN_TABLE_NAME}_header SET tstamp=$timestamp, signed_user=$signed_user_val";
	$sql .= ", signed_tstamp=$signed_tstamp_val where id=$form_id";
}

// make sure we got a form_id
unset($_POST["nosave_form_id"]);
if(empty($form_id) && $updating) {
	echo "Error: No form identified!<br>";
	exit(1);
}

// clean up the POST variables
foreach ($_POST as $key => $value) {
	// yes/no/NA options should be 1 or 0, not "on" or "off"
	if(preg_match("/^cb_/", $key)) {
		switch ($value) {
			case "on" : $_POST["$key"] = 1; break;
			case "off": $_POST["$key"] = 0; break;
		}
	}

	// manage escaped characters single quote (') and backslash (\)
	$_POST["$key"] = str_replace("\\'", "'", $_POST["$key"]);
    $_POST["$key"] = str_replace("\\\\", "", $_POST["$key"]);
}




// persist the form
if(sqlStatement($sql)) {
	if(!$updating) {
		// we just added a new form
		//$form_id = mysql_insert_id($GLOBALS['dbh']);
		if($GLOBALS['lastidado'] >0)
			$form_id = $GLOBALS['lastidado'];
		else
			$form_id=mysql_insert_id($GLOBALS['dbh']); // last id
		
		if(empty($form_id)) {
	    	echo "<b>Error: form id was not available; failed to save form.</b><p>";
			exit(1);
		} else {
			addForm($encounter, $FORM_NAME_HR, $form_id, $FORM_DIR, $pid, "1");
		}
	}
} else {
   	echo "<b>Error: failed to save form.</b><p>";
	exit(1);
}





// save the form data

// clean out the old data
// if we're updating, first remove all the checkboxes that are marked, then add in the ones that are there.
// we do this because the user may have checked new boxes and unchecked other boxes, and simply clearing and resetting
// them covers both.
if($updating) {
	$sql = "delete from ${MAIN_TABLE_NAME}_cb_sel where fk_${MAIN_TABLE_NAME}_header=$form_id";
	sqlStatement($sql);
	// we don't need to avoid deleting the "addendum" rows, since you can't save the form once you've signed it,
	// and you can't add addendums until you've signed it.
	$sql = "delete from ${MAIN_TABLE_NAME}_txt where fk_${MAIN_TABLE_NAME}_header=$form_id";
	sqlStatement($sql);
}

// persist the fields
echo "\n";
if(!saveField("POST", $_POST, $MAIN_TABLE_NAME, $form_id)) {
	echo "<b>Error: form field '$key' did not save.</b><p>";
	echo mysql_error();
	exit(1);
}

// Insert all new billing codes, delete removed ones
include_once("$srcdir/../interface/forms/common_form_function/billing_codes_save.php");




// Now print the form was saved or signed, and either re-display it or redirect to encounter
if($_POST["nosave_sign_valid"] == 1) {
	return_to_encounter($encounter, "Form signed!");
	//exit(1);
	//include("new.php");
	include("view.php");
	
	//include("$srcdir/../interface/patient_file/history/encounters.php");
	//include("$srcdir/../encounter/patient_file/encounter/forms.php");
	//include("$srcdir/interface/patient_file/encounter/new_form.php");
	
	//include("$srcdir/../interface/patient_file/encounter/encounter_top.php");
	
	exit(1);

}

echo "<font color=red>form saved</font><br>";
include("new.php");
?>
