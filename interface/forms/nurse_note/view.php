<?
 include_once("../../globals.php");
// include_once("../common_form_function/common_functions.php");
 include_once("$srcdir/../interface/forms/common_form_function/common_functions.php");

global $testing;
$testing = (empty($testing)) ? false : $testing ;
 
unset($_POST); // we need to ensure that this is empty to handle multiples (arrays)
$id = $form_id = (!empty($_GET['id'])) ? $_GET['id'] : $form_id ;

// First, make sure we know the form ID and that the form exists.

if($form_id == "") {
	$form_id = $id;
	if($form_id == "") {
		echo "Error: No form ID specified<br>";
		exit(1);
	}
}

$MAIN_TABLE_NAME = "form_nurse_note";

$sql="select id, pid, encounter, signed_user, signed_tstamp from ${MAIN_TABLE_NAME}_header where id=$form_id";
$stmt=sqlStatement($sql);
$num=0;
$pid="";
$form_signed = false;
while($row=sqlFetchArray($stmt)) {
	$num++;
	$pid = $row['pid'];
	$encounter = $row['encounter'];
	$signed_user = $row['signed_user'];
	$signed_tstamp = $row['signed_tstamp'];
}

if($num < 1) {
	echo "Error: No form with that ID ($form_id)<br>";
	exit(1);
}
if($pid == "") {
	echo "Error: No patient selected!<br>";
	exit(1);
}

if($signed_user != "" && $signed_tstamp != "")
	$form_signed = true;

// now that we have the formalities out of the way, we can start loading information.

//echo "form_id=$form_id<br>";

$sql  = "select a.note as value, b.name as name from ${MAIN_TABLE_NAME}_txt a, ${MAIN_TABLE_NAME}_txt_cat b";
$sql .= " where a.fk_${MAIN_TABLE_NAME}_header=$form_id and a.fk_${MAIN_TABLE_NAME}_txt_cat = b.id";
$stmt=sqlStatement($sql);
while($row=sqlFetchArray($stmt)) {
	$key = $row['name'];
	$value = $row['value'];
	if($testing) { print("$key = $value<br>"); }
	
	if(!empty($_POST[$key])) {
		// this key already exists .: it is an array
		if(is_array($_POST[$key])) {
			$tmpVar = $_POST[$key];
		} else {
			$tmpVar[] = $_POST[$key];
		}
			$tmpVar[] = $value;
			$_POST[$key] = $tmpVar;
	} else {
		$_POST[$key] = $value;
	}
}


// Test print
if($testing) {
	echo "Key/value pairs:<br>";
	foreach ($_POST as $key=>$value) {
		print_r($key);
		print(" = ");
		print_r($value);
		print("<br>");
	}
}




// now include new.php to bring in the form that will read the values we set and display the form.

include ("new.php");

?>
