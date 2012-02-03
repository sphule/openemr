<?
include_once("../../globals.php");
include_once("$srcdir/forms.inc");
include_once("../common_form_function/common_functions.php");

if(!$pid) {
        $pid = $nosave_pid;
        if(!$pid) {
                echo "Error: No patient selected!<br>";
                exit(1);
        }
}

if(!$encounter) {
        echo "Error: No patient encounter selected!<br>";
        exit(1);
}

$num=0;
$form_id = $_POST['form_id'];
$maintblname = $_POST['maintblname'];
if($form_id) {
        $sql="select id from ${maintblname}_header where id=$form_id and pid=$pid";
        $stmt=sqlStatement($sql);
        while($row=sqlFetchArray($stmt)) {
                $num++;
        }
}

if($num < 1 || $form_id < 0) {
	echo "ERROR: Invalid form id: $form_id<br>";
	exit(1);
}

foreach ($_POST as $key => $value) {
	// checkboxes should be 1 or 0, not "on" or "off"
	if(preg_match("/^cb_/", $key)) {
	        if($value == "on")
        	        $_POST["$key"] = 1;
	        else if($value == "off")
        	        $_POST["$key"] = 0;
	}
        $_POST["$key"] = str_replace("\\'", "'", $_POST["$key"]);
        $_POST["$key"] = str_replace("\\\\", "", $_POST["$key"]);
}


$encounter = $_POST['encounter'];
unset ($_POST['encounter']);

$pid = $_POST['pid'];
unset ($_POST['pid']);

$form_dir = $_POST['form_dir'];

$maintblname = $_POST['maintblname'];
$table = $_POST['table'];
$table_cat = $_POST['table_cat'];



// make sure the "addendum" field name exists

//$table_cat = "${maintblname}_txt_cat";
$name = "addendum";
$sql="select id from $table_cat where name='$name' limit 1";
$stmt=sqlStatement($sql);
$addendum_cat_id=-1;
while($row=sqlFetchArray($stmt)) {
	$addendum_cat_id=$row['id'];
}
if($addendum_cat_id < 0) { // wasn't found
	$sql = "INSERT INTO $table_cat (id, name) VALUES (NULL, \"$name\");";
	$stmt=sqlStatement($sql);

	$sql="select id from $table_cat where name='$name' limit 1";
	$stmt=sqlStatement($sql);
	$oldfld_id=-1;
	while($row=sqlFetchArray($stmt)) {
		$addendum_cat_id=$row['id'];
	}
}

// get information on user submitting this note

$provider_results = sqlQuery("select fname, lname, now() as tstamp from users where username='" . $_SESSION{"authUser"} . "'");
$note_username = $provider_results{"fname"}.' '.$provider_results{"lname"};
$note_tstamp = $provider_results{"tstamp"};


$note=$_POST["addendum_note"];
if($note == "") {
	//return_to_encounter($encounter, "Cannot submit an empty note!");

	echo "Error: Cannot submit an empty note!";
	include("$srcdir/../interface/forms/$form_dir/view.php");

	exit(0);
}

$note = "$note

Addendum/Late Entry Note added by $note_username, $note_tstamp";


//$table = "${maintblname}_txt";
$sql = "INSERT INTO $table (id, fk_${maintblname}_header, fk_$table_cat, note) VALUES (NULL, $form_id, $addendum_cat_id, \"$note\");";
sqlStatement($sql);


//return_to_encounter($encounter);
//exit(0);

include("$srcdir/../interface/forms/$form_dir/view.php");

?>
