<?
include_once(dirname(__file__)."/../../custom_forms/customformconfig.php");
include_once($customform_root."/globals.php");

/**
 * Updates the fields in the checkbox and text lookup tables (for example, you need to fill them for the first time, or have added a field).
 * This function can be run every time a form is submitted to automatically insert new fields if found.
 *
 * @param text $maintblname - prefix or main part of table name
 * @param text $cbtablename - appended to $maintblname to produce the full name of the checkbox table
 * @param text $txttablename - appended to $maintblname to produce the full name of the text table
 */
function update_table_fields($maintblname, $cbtablename, $txttablename) {
	
	// save each field in the $_POST array
	foreach ($_POST as $key => $value) {
		if(preg_match("/^nosave_/", $key)) { // skip values we don't want to save
			continue;
		}

		if(preg_match("/^cb_/", $key)) { // checkbox (field with 'cb_')
			$name = preg_replace("/^cb_/", "", $key); // strip off the extra junk
			$table = "${maintblname}${cbtablename}";
		} else { // not a checkbox (field with 'cb_')
			$name = $key;
			$table = "${maintblname}${txttablename}";
		}

		$sql="select id from $table where name='$name' limit 1";
		$stmt=sqlStatement($sql);
		$oldfld_id=-1;
		while($row=sqlFetchArray($stmt)) {
			$oldfld_id=$row['id'];
		}
	
		// don't make duplicate inserts
		if($oldfld_id < 0) { // wasn't found
			$sql = "INSERT INTO $table (id, name) VALUES (NULL, \"$name\");";
		}
	
		sqlStatement($sql); // insert .: no need to get return value
	}

	$sql = "UPDATE ${maintblname}${cbtablename} SET code=id;";
	sqlStatement($sql); // update .: no need to get return value

	$sql = "UPDATE ${maintblname}${txttablename} SET code=id;";
	sqlStatement($sql); // update .: no need to get return value
}

function prev_textbox($fieldname, $default="") {
	global $mode;
	global $form_signed;
	echo " name=\"$fieldname\" value=\"";
	echo ($mode == "new") ? "$default" : $_POST["$fieldname"];
	echo "\" ";
	if($form_signed === true) {
		echo "disabled ";
	}
 }
function prev_textarea($fieldname, $options="", $default="") {
	global $mode;
	global $form_signed;
	echo "<textarea name=\"$fieldname\" $options ";
	if($form_signed === true) {
		echo "disabled ";
	}
	echo ">";
	echo ($mode == "new") ? "$default" : $_POST["$fieldname"];
	echo "</textarea>";
 }
 function prev_checkbox($fieldname) { // TODO add field: boolean default for checked
	global $mode;
	global $form_signed;
	echo " type=\"checkbox\" name=\"cb_$fieldname\" ";
	if($form_signed === true) {
		echo "disabled ";
	}
        if($mode == "new")
                return;
        if($_POST["cb_$fieldname"] == 1 || $_POST["cb_$fieldname"] == "on")
                echo "checked ";
 }
 function prev_radio($fieldname, $value, $default=false) {
	global $mode;
	global $form_signed;
	echo " type=\"radio\" name=\"$fieldname\" value=\"$value\" ";
	if($form_signed === true) {
		echo "disabled ";
	}
        if( ($mode != "new" && $_POST["$fieldname"] === $value) || ($mode == "new" && $default !== false) )
                echo "checked ";
 }

/**
 * This method proxies for the other menu creation functions
 *
 * @param text $fieldname - the name of the select menu
 * @param array(mixed=>mixed) $values - an associative array($key=>$val) of values to fill the options, where $key
 * 			is display string and $val is the value of the option.
 * @param mixed or array(mixed) $selected="" - the value(s) to mark as selected
 * @param text $options="" - attributes and flags added to the select tag.  This parameter is 
 * 			simply inserted as a string.
 * @param scalar $rows - the number of rows to display
 * @param bolean $multiple - whether multiple options can be selected
 * @global $mode - if this is 'new' the selected option is set to the option identified by $selected
 * @global $form_signed - if this is exactly equal to true the select menu is disabled
 * 
 * @return - nothing is returned
 */
function menu($fieldname, $values, $selected="", $options="", $rows=0, $multiple=false) {
	global $mode;
	global $form_signed;
	echo "<select name=\"$fieldname\"";
	if($form_signed === true) {
		echo " disabled";
	}
	if($rows > 1) {
		echo " size=\"$rows\"";
	}
	if($multiple) {
		echo " multiple=\"true\"";
	}
	if(!empty($options)) {
		echo " $options";
	}
	echo " >\n";
	foreach($values as $key=>$value) {
		echo "   <option value=\"$value\"";
		if(optionSelected($value,$selected)) {
			echo " selected";
		}
		echo ">$key</option>\n";
	}
	echo "</select>\n";
}

/**
 * This function determins if the current value exists in the selected
 *
 * @param mixed $value - the value of the current option
 * @param mixed or array(mixed) $selected - a value or an array of selected option values
 * @return true if this option should be selected
 */
function optionSelected($value, $selected="") {
	if(empty($value) || empty($selected)) {
		print(" A ");
		return false;
	} else if(is_array($selected) && in_array($value,$selected)) {
		print(" B (is_array($selected) && in_array($value,$selected)");
		return true;
	} else if($value == $selected) {
		print(" C ($value == $selected)");
		return true;
	} else {
		print(" D ");
		return false;
	}
}
 
/**
 * @see menu()
 */
function prev_dropdown($fieldname, $values, $selected="", $options="") {
	menu_select_one($fieldname, $values, $selected, $options);
}
 
/**
 * This function proxies to menu() with rows=0 multiple=false
 * @see menu()
 */
function menu_select_one($fieldname, $values, $selected="", $options="") {
	menu($fieldname, $values, $selected, $options, 0, false);
}
 

function return_to_encounter($enc, $msg="") {
	global $rootdir;
	echo "
	 <script language=\"Javascript\">
";
	if($msg != "") {
		echo "alert(\"$msg\");";
	}

	echo "
	   top.Main.location.href  = '$rootdir/patient_file/encounter/patient_encounter.php?set_encounter=' + $enc;
	 </script>
	";
}

function return_bottom_to_encounter($enc, $msg="") {
	global $rootdir;
	echo "
	 <script language=\"Javascript\">
";
	if($msg != "") {
		echo "alert(\"$msg\");";
	}

	echo "
	   location.href  = '$rootdir/patient_file/encounter/encounter_top.php?set_encounter=' + $enc;
	 </script>
	";
}
// function to uncerimoniously shove fields into $_POST to
// simulate passing them to new.php (which we deviously include
// in view.php instead of duplicating the html when viewing
// the form).

function stuff_into_post($fields, $ignore_list) {
	$ignore = array();
	foreach ($ignore_list as $i)
		$ignore[$i] = 1;

	foreach ($fields as $key=>$value) {
		if($ignore[$key])
			continue;
		$_POST[$key] = $value;
	}
}



?>
