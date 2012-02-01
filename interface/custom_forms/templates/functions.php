<?php
/**
 * functions.php  
 * Functions and variables used in the Progress Note form
 * 
 * @package PACKAGE
 * @name $Source$
 * @version $Revision$
 * @date $Date$
 * 
 * @copyright Copyright &copy; 2005, The Possibility Forge, Inc.
 * @license http://www.gnu.org/copyleft/gpl.html GNU Public License
 * @author $Author$
 */

include_once($GLOBALS['srcdir']."/patient.inc");



/**
 * Enter description here...
 *
 * @param unknown_type $maintblname
 * @param unknown_type $form_id
 * @return unknown
 */
function formExists($maintblname, $form_id) {
	$sql="select id, pid, encounter, signed_user, signed_tstamp from ${maintblname}_header where id=$form_id";
	$stmt=sqlStatement($sql);
	$num=0;
	$pid="";
	$form_signed = false;
	while($row=sqlFetchArray($stmt)) {
		$num++;
		$pid = $row['pid'];
		$signed_user = $row['signed_user'];
		$signed_tstamp = $row['signed_tstamp'];
	}

	return ($num < 1) ? false : true;
}

/**
 * Enter description here...
 *
 * @param unknown_type $maintblname
 * @param unknown_type $form_id
 * @return unknown
 */
function getFormArray($maintblname, $form_id) {

	// get the text fields
	$sql  = "select a.note, b.name from ${maintblname}_txt a";
	$sql .= " LEFT JOIN ${maintblname}_txt_cat b ON a.fk_${maintblname}_txt_cat = b.id";
	$sql .= " WHERE a.fk_${maintblname}_header=$form_id";
	$stmt=sqlStatement($sql);
	while($row=sqlFetchArray($stmt)) {
		if(!empty($formArray[$row['name']])) {
			// this key already exists .: it is an array
			if(is_array($formArray[$row['name']])) {
				$tmpVar = $formArray[$row['name']];
			} else {
				$tmpVar[] = $formArray[$row['name']];
			}
				$tmpVar[] = $row['note'];
				$formArray[$row['name']] = $tmpVar;
		} else {
			$formArray[$row['name']] = $row['note'];
		}
	}

	// get the checkbox fields
	$sql  = "select b.name from ${maintblname}_cb_sel a";
	$sql .= " LEFT JOIN ${maintblname}_cb_flds b ON a.fk_${maintblname}_cb_flds = b.id";
	$sql .= " WHERE a.fk_${maintblname}_header=$form_id";
	$stmt=sqlStatement($sql);
	while($row=sqlFetchArray($stmt)) {
		$formArray[$row['name']] = 1;
	}
	
	return $formArray;
}

/**
 * This function persists a form field.  If the value is an array
 * the function recurses for each member.
 *
 * @param mixed $key - the name of the field
 * @param mixed $value - the value of the field
 * @param text maintblname - name of the form table
 * @param text form_id - identifier of the form
 * @global testing - whether to display the debugging strings
 * @global SHOW_CATEGORIES - whether to show the categories list
 * @return the results of the insert statement
 */
function saveField($key, $value, $maintblname, $form_id) {

	global $testing;
	global $SHOW_CATEGORIES;
	$SHOW_ARRAYS = false;
	$SHOW_QUERIES = false;
	$testing = (empty($testing)) ? false : $testing ;
	if($testing) { print("<ul>\n"); }
	
	// skip values we don't want to save
	if(		preg_match("/^nosave_/", $key)
		||  $value=="None Selected"
		||  empty($value)
	) {
		if($testing) { print("<li>skipping $key</li>\n"); }
		if($testing) { print("</ul>\n"); }
		return true;
	}
	
	if(is_array($value)) {

		if($testing) { print("    <li>ARRAY: ($key=");($SHOW_ARRAYS)? print_r($value):print($value); print(")</li>\n"); }
		foreach($value as $recurseKey => $recurseValue) {
			
			if(!empty($recurseValue) && !empty($recurseValue[0])) {
				$newKey = (is_numeric($recurseKey)) ? $key : $recurseKey ;
				if(!saveField($newKey, $recurseValue, $maintblname, $form_id)) {
					if($testing) { print("</ul>\n"); }
					return false;
				}
			}
		}
		
	} else if(preg_match("/^cb_/", $key)) { // this is a checkbox

		if($testing) { print("    <li>CHECKBOX: ($key=$value)</li>\n"); }
		if($value == "0" || !$value) {
			// skip checkboxes that aren't checked
			echo "<!-- WARNING: $key($value) empty -->\n";
			if($testing) { print("</ul>\n"); }
			return true;
		}

		// get checkbox field names
		$categories = array();
		$sql="select id, name from ${maintblname}_cb_flds";
		$stmt=sqlStatement($sql);
		while($row=sqlFetchArray($stmt)) {
		    $categories[$row['name']] = $row['id'];
		}
		if($testing && $SHOW_CATEGORIES) { print("\n categories:<br>\n<pre>\n"); print_r($categories); print("\n</pre><br>\n"); }
		
		$name = preg_replace("/^cb_/", "", $key); // strip off the wart
		$table = "${maintblname}_cb_sel";
		$field_id = $categories[$name];
		if($field_id == "") {
			echo "<!-- WARNING: Field $key lookup failed and could not be saved! -->\n";
			if($testing) { print("</ul>\n"); }
			return true;
		}
		$sql = "INSERT INTO $table (id, fk_${maintblname}_header, fk_${maintblname}_cb_flds) VALUES (NULL, $form_id, $field_id);";

	} else { // this is a text field

		if($testing) { print("    <li>TEXTFIELD: ($key=$value)</li>\n"); }
		if(empty($value)) {
			// skip empty fields
			echo "<!-- WARNING: $key($value) empty -->\n";
			if($testing) { print("</ul>\n"); }
			return true;
		}

		// get text field names
		$categories = array();
		$sql="select id, name from ${maintblname}_txt_cat";
		$stmt=sqlStatement($sql);
		while($row=sqlFetchArray($stmt)) {
			$categories[$row['name']] = $row['id'];
		}
		if($testing && $SHOW_CATEGORIES) { print("\n categories:<br>\n<pre>\n"); print_r($categories); print("\n</pre><br>\n"); }
		
		$name = $key;
		$table = "${maintblname}_txt";
		$field_id = $categories[$name];
		if($field_id == "") {
			print("<li><ul><li><pre>");print_r($text_categories);print("</pre></li></ul></li>");
			echo "<!-- WARNING: Field $key lookup failed and could not be saved! -->\n";
			if($testing) { print("</ul>\n"); }
			return true;
		}
		if($field_id == "addendum") {
			if($testing) { print("</ul>\n"); }
			return true; // skip these, they are retrieved elsewhere
		}

		$sql = "INSERT INTO $table (id, fk_${maintblname}_header, fk_${maintblname}_txt_cat, note) VALUES (NULL, $form_id, $field_id, \"$value\");";

	}

	if($testing && $SHOW_QUERIES) { print("<li><ul><li><em>sql:$sql</em></li></ul></li>\n"); }
	if($testing) { print("</ul>\n"); }
	return (!empty($sql)) ? sqlStatement($sql) : true ;
}




/**
 * This function display a formatted view of the POST array
 */
function displayAllFields() {
	echo "	<table border=1 width=500>";
	
	$key_count = 0;
	foreach ($_POST as $key => $value) {
		$key_count++;
		?><tr><td <? if(preg_match("/^nosave_/", $key)) { echo "bgcolor=gray"; } ?> ><?=$key;?></td><td><?=$value;?></td></tr><?
	}
	?>
	</table>
	<span class=bold>Total Keys: </span><?echo $key_count;?><br>
	
	
	<?
	if(!empty($_POST['nosave_code'])) {
		foreach($_POST['nosave_code'] as $codenum => $codes) {
			echo "$codenum:<br/>";
			foreach($codes as $key => $value) {
				echo "$key -> $value<br/>";
			}
		}
	}
	if(!empty($_POST['nosave_code_original'])) {
		foreach($_POST['nosave_code_original'] as $codenum => $codes) {
			echo "$codenum:<br/>";
			foreach($codes as $key => $value) {
				echo "$key -> $value<br/>";
			}
		}
	}
}




// past problems
function buildPastProblemsNarrative($pid) {
	$sql = "select * from lists where pid=$pid and type='medical_problem'";
	$stmt = sqlStatement($sql);
	?>
<table cellpadding="0" cellspacing="0">
<? while($row=sqlFetchArray($stmt)) { ?>
	<tr>
		<td class='small' valign='top'><?= $row["title"] ?></td>
	</tr>
	<? } ?>
</table>

<?

return null;
}


?>
