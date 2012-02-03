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

// global variables
$symptoms;
$symptoms_default;
$quality;
$quality_defaults;
$severity;
$severity_defaults;
$duration;
$duration_defaults;
$timing;
$timing_defaults;
$context;
$context_defaults;
$followup_units;
$followup_increment;

/**
 * This function establishes variables needed by the form pages
 */
function init() {
	global $symptoms, $symptoms_default, $quality, $quality_defaults, $severity, $severity_defaults;
	global $duration, $duration_defaults, $timing, $timing_defaults, $context, $context_defaults;
	global $followup_units, $followup_increment;
	
	/*
	* The arrays used by both the form and report
	*/
	$physical_exam = array();
	$physical_exam["const"]["name"] = "Constitutional - appearance";
	$physical_exam["const"]["fields"]["exam_const_tpr"] = "No acute distress";
	$physical_exam["const"]["fields"]["exam_const_well_nourished"] = "Well nourished, developed";
	$physical_exam["const"]["fields"]["exam_const_well_groomed"] = "Well groomed";
	
	$physical_exam["eyes"]["name"] = "Eyes";
	$physical_exam["eyes"]["fields"]["exam_eyes_perla"] = "PERLA";
	$physical_exam["eyes"]["fields"]["exam_eyes_conjunctiva"] = "Conjunctiva/lids normal";
	
	$physical_exam["ent"]["name"] = "ENT mouth, gums, etc";
	$physical_exam["ent"]["fields"]["exam_ent_gums_pink"] = "Gums/mucosa pink";
	$physical_exam["ent"]["fields"]["exam_ent_dentures"] = "No oral lesions";
	$physical_exam["ent"]["fields"]["exam_ent_no_cerumen"] = "No cerumen";
	$physical_exam["ent"]["fields"]["exam_ent_hearing"] = "Hearing normal";
	
	$physical_exam["neck"]["name"] = "Neck -- thyroid";
	$physical_exam["neck"]["fields"]["exam_neck_supple"] = "Supple, no masses";
	$physical_exam["neck"]["fields"]["exam_neck_thyroid"] = "Thyroid normal";
	
	$physical_exam["resp"]["name"] = "Respiratory -- effort";
	$physical_exam["resp"]["fields"]["exam_resp_lungs_cta"] = "Lungs CTA bilaterally";
	$physical_exam["resp"]["fields"]["exam_resp_normal_effort"] = "Normal effort, no wheezing or rhonch";
	
	$physical_exam["cardio"]["name"] = "Cardiovascular";
	$physical_exam["cardio"]["fields"]["exam_cardio_rsr_no_murmur"] = "No murmur";
	$physical_exam["cardio"]["fields"]["exam_cardio_pedal_pulses"] = "Normal S1, S2";
	$physical_exam["cardio"]["fields"]["exam_cardio_edema"] = "No rubs, normal pulses throughout";
	$physical_exam["cardio"]["fields"]["exam_cardio_carotid"] = "No carotid bruits";
	$physical_exam["cardio"]["fields"]["exam_cardio_edema"] = "No Peripheral Edema";
	
	$physical_exam["chest"]["name"] = "Chest/breasts";
	$physical_exam["chest"]["fields"]["exam_chest_masses"] = "No masses";
	$physical_exam["chest"]["fields"]["exam_chest_symmetrical"] = "Symmetrical";
	
	$physical_exam["gi"]["name"] = "GI - abdomen";
	$physical_exam["gi"]["fields"]["exam_gi_masses"] = "No masses";
	$physical_exam["gi"]["fields"]["exam_gi_tenderness"] = "No tenderness";
	$physical_exam["gi"]["fields"]["exam_gi_hernia"] = "No hernia";
	$physical_exam["gi"]["fields"]["exam_gi_liver"] = "Liver &amp; spleen normal";
	
	$physical_exam["gumale"]["name"] = "GU Male";
	$physical_exam["gumale"]["fields"]["exam_gumale_prostate"] = "Prostate not enlarged";
	$physical_exam["gumale"]["fields"]["exam_gumale_masses"] = "No masses/tenderness";
	$physical_exam["gumale"]["fields"]["exam_gumale_scrotum"] = "No testicular mass";
	
	$physical_exam["gufemale"]["name"] = "GU Female";
	$physical_exam["gufemale"]["fields"]["exam_gufemale_genitalia"] = "Gen. App. genitalia normal";
	$physical_exam["gufemale"]["fields"]["exam_gufemale_masses"] = "No masses/tenderness";
	$physical_exam["gufemale"]["fields"]["exam_gufemale_bladder"] = "Bladder not distended";
	$physical_exam["gufemale"]["fields"]["exam_gufemale_cervix"] = "No discharge";
	
	$physical_exam["lymph"]["name"] = "Lymphatic";
	$physical_exam["lymph"]["fields"]["exam_lymph_axillary"] = "No Axillary Adenopathy";
	$physical_exam["lymph"]["fields"]["exam_lymph_groin"] = "No Groin Adenopathy";
	
	$physical_exam["musc"]["name"] = "Musculoskeletal";
	$physical_exam["musc"]["fields"]["exam_musc_gait"] = "Normal gait";
	$physical_exam["musc"]["fields"]["exam_musc_digits"] = "Digits/nails normal";
	$physical_exam["musc"]["fields"]["exam_musc_head_neck"] = "Head and neck normal";
	$physical_exam["musc"]["fields"]["exam_musc_spine"] = "Spine, ribs, pelvis normal";
	$physical_exam["musc"]["fields"]["exam_musc_ru_extremity"] = "RU Extremity normal";
	$physical_exam["musc"]["fields"]["exam_musc_rl_extremity"] = "RL Extremity normal";
	$physical_exam["musc"]["fields"]["exam_musc_lu_extremity"] = "LU Extremity normal";
	$physical_exam["musc"]["fields"]["exam_musc_ll_extremity"] = "LL extremity normal";
	$physical_exam["musc"]["fields"]["exam_musc_str"] = "Muscle str/tone normal";
	$physical_exam["musc"]["fields"]["exam_musc_tenderness"] = "No tenderness, masses";
	
	$physical_exam["skin"]["name"] = "Skin";
	$physical_exam["skin"]["fields"]["exam_skin_rash"] = "No rashes/lesions";
	$physical_exam["skin"]["fields"]["exam_skin_induration"] = "No induration, tenting";
	
	$physical_exam["neuro"]["name"] = "Neurologic";
	$physical_exam["neuro"]["fields"]["exam_neuro_cranial_nerves"] = "Cranial nerves normal";
	$physical_exam["neuro"]["fields"]["exam_neuro_tendon_reflexes"] = "Deep tendon reflexes normal";
	$physical_exam["neuro"]["fields"]["exam_neuro_sensation"] = "Sensation Normal";
	
	$physical_exam["psych"]["name"] = "Psychiatric";
	$physical_exam["psych"]["fields"]["exam_psych_memory"] = "Memory Intact";
	$physical_exam["psych"]["fields"]["exam_psych_mood"] = "Mood &amp; affect normal";
	
	$GLOBALS["physical_exam"] = $physical_exam;
	
	
	$bold_fields["exam_gufemale_genitalia"] = true;
	$bold_fields["exam_lymph_nodes"] = true;
	$bold_fields["exam_musc_gait"] = true;
	$bold_fields["exam_skin_rash"] = true;
	$bold_fields["exam_neuro_cranial_nerves"] = true;
	$bold_fields["exam_psych_memory"] = true;
	
	$GLOBALS["bold_fields"] = $bold_fields;
	
	// Symptoms menu : "Display String" => "option_value"
	$symptoms = array(
		"None Selected" => "",
		"Back Pain" => "back pain",
		"Headache" => "headache",
		"Cough/Congestion" => "cough/congestion",
		"Chest Pain" => "chest pain",
		"SOB" => "sob",
		"Weakness" => "weakness",
		"Depression" => "depression",
		"Abdominal Pain" => "abdominal pain",
		"Other" => "other"
	);
	if(empty($_POST["hpi_location"]) || $_POST["hpi_location"]=="None Selected") { // None Selected
		$symptoms_default = "";
	} else if(!empty($symptoms[$_POST["hpi_location"]])) { // normal
		$symptoms_default = $symptoms[$_POST["hpi_location"]];
	} else { // other
		$symptoms_default = "other";
	}
	$_POST["nosave_hpi_location_text"] = ($symptoms_default=="other") ? $_POST["hpi_location"] : "";

	// Quality menu : "Display String" => "option_value"
	$quality = array(
		"Sharp" => "sharp",
	    "Dull" => "dull",
	    "Burning" => "burning",
	    "Tingling" => "tingling",
	    "Shooting" => "shooting",
	    "Throbbing" => "throbbing",
	    "Aching" => "aching"
	);
	$quality_defaults = $_POST["hpi_quality"];
	
	// Severity menu : "Display String" => "option_value"
	$severity = array(
		"None Selected" => "",
		"mild" => "mild",
		"moderate" => "moderate",
		"severe" => "severe",
		"N/A" => "na"
	);
	$severity_defaults = $_POST["hpi_severity"];
	
	// Duration menu : "Display String" => "option_value"
	$duration = array(
		"None Selected" => "",
		"Hours" => "hours",
		"Days" => "days",
		"Weeks" => "weeks",
		"Months" => "months",
		"Years" => "years",
		"N/A" => "na"
	);
	$duration_defaults = $_POST["hpi_duration"];
	
	// Timing menu : "Display String" => "option_value"
	$timing = array(
		"None Selected" => "",
		"Gradual" => "gradual",
		"Sudden" => "sudden",
		"Intermittent" => "intermittent",
		"N/A" => "na"
	);
	$timing_defaults = $_POST["hpi_timing"];
	
	// Context menu : "Display String" => "option_value"
	$context = array(
		"None Selected" => "",
		"Yes" => "yes",
		"No" => "no",
		"N/A" => "na"
	);
	$context_defaults = $_POST["hpi_context"];

	$followup_units = $_POST["followup_units"];
	$followup_increment = $_POST["followup_increment"];
}
init();

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
 * Enter description here...
 *
 */
function physical_exam_output_all_html() {
	global $physical_exam;
	foreach($physical_exam as $section=>$sectionData) {
		if($section == "musc") {
			physical_exam_output_section_musc_html($section);
		} else {
			physical_exam_output_section_html($section);
		}
	}
}

/**
 * Enter description here...
 *
 * @param unknown_type $field
 * @param unknown_type $name
 */
function physical_exam_output_section_field_html($field, $name=null) {
	global $bold_fields;
	if($name == null) {
		$name = physical_exam_get_field_name($field);
	}
	if($bold_fields[$field]) {
		$name = "<span class=\"bold\">" . $name . "</class>";
	}
	?>
 <td class="response"><?=$name?></td>
 <td class="response"><input <? prev_checkbox($field); ?> /></td>
	<?
	}

/**
 * Enter description here...
 *
 * @param unknown_type $section
 */
function physical_exam_output_section_html($section) {
	global $physical_exam, $textarea_style;
	$name = physical_exam_get_section_name($section);
	$num = count($physical_exam[$section]['fields']);

	if(!is_array($physical_exam[$section]['fields'])) {
		return;
	}

	$first=true;
	foreach($physical_exam[$section]['fields'] as $field=>$fieldName) {
		echo " <tr>\n";
		if($first) {
			echo "  <td class=\"response\" rowspan=" . $num . ">" . $name . "</td>\n";
		}
		physical_exam_output_section_field_html($field, $fieldName);
		if($first) {
			$first=false;
			echo "  <td class=\"response\" rowspan=" . $num . " valign=\"top\">";
			prev_textarea("exam_" . $section . "_notes", $textarea_style);
			echo "</td>\n";
		}
		echo " </tr>\n";
	}
}

/**
 * special function to handle the Musculoskeletal section
 *
 * @param unknown_type $section
 */
function physical_exam_output_section_musc_html($section) {
	global $physical_exam, $textarea_style;
	$name = physical_exam_get_section_name($section);
	$num = count($physical_exam[$section]['fields']) + 1;

	if(!is_array($physical_exam[$section]['fields'])) {
		return;
	}

	$first=true;
	$firstRom=true;
	foreach($physical_exam[$section]['fields'] as $field=>$fieldName) {
		if($field != "exam_musc_gait" && $field != "exam_musc_digits") {
			$fieldName = "&nbsp;&nbsp;&nbsp;&nbsp;" . $fieldName;
			if($firstRom) {
				$firstRom = false;
				?>
<tr>
 <td class="response" colspan=2>ROM: (normal if checked)</td>
</tr>
<?
			}
		}
		echo " <tr>\n";
		if($first) {
			echo "  <td class=\"response\" rowspan=" . $num . ">" . $name . "</td>\n";
		}
		physical_exam_output_section_field_html($field, $fieldName);
		if($first) {
			$first=false;
			echo "  <td class=\"response\" rowspan=" . $num . " valign=\"top\">";
			prev_textarea("exam_" . $section . "_notes", $textarea_style);
			echo "</td>\n";
		}
		echo " </tr>\n";
	}
}
			
/**
 * Enter description here...
 *
 * @param unknown_type $section
 * @return unknown
 */
function physical_exam_get_section_name($section) {
	global $physical_exam;
	if($physical_exam[$section]["name"]) {
		return $physical_exam[$section]["name"];
	}
	return "UNKNOWN SECTION";
}

/**
 * Enter description here...
 *
 * @param unknown_type $field
 * @return unknown
 */
function physical_exam_get_field_name($field) {
	global $physical_exam;
	$section = physical_exam_get_section_from_field($field);
	if($physical_exam[$section][$field]) {
		return $physical_exam[$section][$field];
	}
	return "UNKNOWN FIELD";
}

/**
 * Enter description here...
 *
 * @param unknown_type $field
 * @return unknown
 */
function physical_exam_get_section_from_field($field) {
	if(preg_match("/exam_([^_]+)_(.+)/", $field, $groups)) {
		return $groups[1];
	}
	return false;
}

/**
 * Enter description here...
 *
 * @param unknown_type $results
 * @return unknown
 */
function buildPhysicalExamNarrative($results) {
	$sectionStrings = array();

	foreach($GLOBALS["physical_exam"] as $section=>$sectionData) {
		if(count($sectionData["fields"]) < 1) {
			continue;
		}
		
		$sectionName = $sectionData['name'];
		$sectionStr = "<tr><td class='small' valign='top'><em>" . $sectionName . "</em></td><td valign='top' class='small'>";
		$normalFields = array();

		foreach($sectionData["fields"] as $field => $fieldName) {
			if(isset($results[$field])) {
				$normalFields[] = $fieldName;
			}
		}
		$sectionNotesField = "exam_" . $section . "_notes";
		$sectionNotes = $results[$sectionNotesField];
		if(count($normalFields) > 0) {
			$sectionStr .= implode("; ", $normalFields);

			if(strlen($sectionNotes) > 0) {
				$sectionStr .= ".&nbsp;&nbsp;&nbsp;&nbsp;Notes: " . $sectionNotes;
			}
		} else if(strlen($sectionNotes) > 0) {
			$sectionStr .= $sectionNotes;
		}
		
		$sectionStr .= "</td></tr>";

		$sectionStrings[] = $sectionStr;
	}

	if(count($sectionStrings) > 0) {
		$str = "\n<table>\n" . implode("\n", $sectionStrings) . "\n</table>\n";
		return $str;
	}
	return "";
}

/**
 * build HPI narrative
 *
 * @param unknown_type $results
 * @return unknown
 */
function buildHPINarrative($results) {
	$hpi = "";

	// Symptoms (location)
	if(!empty($results['hpi_location'])) {
		$hpi .= " " . $results['hpi_location'] . ".";
	}

	// Quality
	$qualities = $results["hpi_quality"];
	$qualityString = "";
	$numQualities = count($qualities);
	for($curQuality = 0; $curQuality < $numQualities; $curQuality++) {
		if(strlen($qualityString) > 0) {
			$qualityString .= ", ";
			if($curQuality == $numQualities-1) {
				// this is the next-to-last quality
				$qualityString .= "and ";
			}
			$qualityString .= (is_array($qualities)) ? $qualities[$curQuality] : $qualities;
		} else {
			$qualityString .= ucwords((is_array($qualities)) ? $qualities[$curQuality] : $qualities);
		}
	}
	if(strlen($qualityString) > 0) {
		$hpi .= "  " . $qualityString . " in quality.";
	}
	
	// Severity
	if($results['hpi_severity'] && $results['hpi_severity'] != "n/a") {
		$hpi .= "  Severity is " . $results['hpi_severity'] . ".";
	}
	
	//Timing
	if($results['hpi_timing'] && $results['hpi_timing'] != "n/a") {
		$hpi .= "  Timing is " . $results['hpi_timing'] . ".";
	}
	
	// Duration
	if($results['hpi_duration']) {
		$hpi .= $results['hpi_duration_amt'] . " " . strtolower($results['hpi_duration']) . " duration.";
	}
	
	// Context
	if(!empty($results['hpi_context_text'])) {
		$hpi .= "  Context " . $results['hpi_context_text'] . ".";
	}
	if($results['hpi_context'] == "yes") {
		$hpi .= "  Condition is aggravated by activity.";
	} else if($results['hpi_context'] == "no") {
		$hpi .= "  Condition is not aggravated by activity.";
	} else if($results['hpi_context'] == "na") {
		$hpi .= "  Activity does not affect this condition.";
	} // ignore if set to '' (None Selected)

	// Modifying Factors	
	if(!empty($results['hpi_modifying_factors'])) {
		$hpi .= "  Modifying factors include " . $results['hpi_modifying_factors'] . ".";
	}
	
	// Associated Symptoms
	if(!empty($results['hpi_associated_symptoms'])) {
		$hpi .= "  Associated symptoms include " . $results['hpi_associated_symptoms'] . ".";
	}
	
	// Additional HPI Notes
	if(strlen($results['hpi_notes']) > 0) {
		if(strlen($hpi) > 0) {
			$hpi .= "<br/>" . $results['hpi_notes'];
		} else {
			$hpi .= $results['hpi_notes'];
		}
	}
	
	return $hpi;
}

// build followup narrative
function buildFollowupNarrative($results) {
	$followup = "";
	if($results['followup_units'] != "" && $results['followup_units'] != "unspecified" && $results['followup_increment'] != "" && $results['followup_increment'] != "unspecified") {
		$followup .= "<span class=bold>Follow up in " . $results['followup_units'] . " " . $results['followup_increment'] . ".</span>";
	}
	if($results['followup_notes']) {
		if(strlen($followup) > 0) {
			$followup .= "&nbsp;&nbsp;&nbsp;&nbsp;<span class=bold>Comments:</span> ";
		} else {
			$followup .= "<span class=bold>Follow up comments:</span> ";
		}
		$followup .= "<span class=small>" . $results['followup_notes'] . "</span>";
	}
	
	return $followup;
}

// get history
function getHistoryResult($pid) {
	$historyResult = getHistoryData($pid);
	if (!is_array($historyResult)) {
		newHistoryData($pid);
		$historyResult = getHistoryData($pid);
	}
	
	return $historyResult;
}

// past diagnoses (ICD9s)
function buildPastdiagnosesNarrative($pid, $encounter=NULL) {
	$where = "";
	if ($encounter) $where .= " and encounter < $encounter";
	
	$sql = "
		select DISTINCT 
				code,
				code_text 
		 from billing 
		where pid = $pid 
		  and code_type = 'ICD9'
		  $where 
		order by date desc
		";
	$stmt = sqlStatement($sql);
	?>
	<table cellpadding="0" cellspacing="0">
	<? while($row=sqlFetchArray($stmt)) { ?>
	<tr>
		<td class='small' valign='top'><?= $row["code"] ?></td>
	<td class='small' valign='top'>&nbsp;&nbsp;</td>
	<td class='small' valign='top'><?= $row["code_text"] ?></td>
	</tr>
	<? } ?>
	</table>

	<?

	return null;
}

// social history
function buildSocialHistoryNarrative($stmt) {
	$row=$stmt;

	if(!empty($row["coffee"])) { echo "Coffee is ".$row["coffee"]." used. &nbsp;"; }
	print("Tobacco: ".$row{"tobacco_num"}." ".$row{"tobacco_num_type"}." per ");
	print($row{"tobacco_per_type"}." for ".$row{"tobacco_duration"}." ");
	print($row{"tobacco_duration_type"}.". &nbsp;");
	if(!empty($row["tobacco"])) { echo "Tobacco is ".$row["tobacco"]." used. &nbsp;"; }
	if(!empty($row["alcohol"])) { echo "Alcohol is ".$row["alcohol"]." used. &nbsp;"; }
	if(!empty($row["sleep_patterns"])) { echo "Hours of sleep recieved is ".$row["sleep_patterns"].". &nbsp;"; }
	if(!empty($row["exercise_patterns"])) { echo "Exercise is ".$row["exercise_patterns"]." taken. &nbsp;"; }
	if(!empty($row["seatbelt_use"])) { echo "Seatbelts are ".$row["seatbelt_use"]." used. &nbsp;"; }
	if(!empty($row["counseling"])) { echo "Counseling has ".($row["counseling"]=="yes") ? "" : "never"." been received. &nbsp;"; }
	if(!empty($row["hazardous_activities"])) { echo "Hazardous activities are ".$row["hazardous_activities"]." participated in. &nbsp;"; }
}

// social history
function buildFamilyHistoryNarrative($stmt) {
	$row=$stmt;

	if(!empty($row["relatives_cancer"])) { echo "Cancer: ".$row["relatives_cancer"]." &nbsp;"; }
	if(!empty($row["relatives_tuberculosis"])) { echo "Tuberculosis: ".$row["relatives_tuberculosis"]." &nbsp;"; }
	if(!empty($row["relatives_diabetes"])) { echo "Diabetes: ".$row["relatives_diabetes"]." &nbsp;"; }
	if(!empty($row["relatives_high_blood_pressure"])) { echo "High Blood Pressure: ".$row["relatives_high_blood_pressure"]." &nbsp;"; }
	if(!empty($row["relatives_heart_problems"])) { echo "Heart Problems: ".$row["relatives_heart_problems"]." &nbsp;"; }
	if(!empty($row["relatives_storke"])) { echo "Stroke: ".$row["relatives_storke"]." &nbsp;"; }
	if(!empty($row["relatives_epilepsy"])) { echo "Epilepsy: ".$row["relatives_epilepsy"]." &nbsp;"; }
	if(!empty($row["relatives_mental_illness"])) { echo "Mental Illness: ".$row["relatives_mental_illness"]." &nbsp;"; }
	if(!empty($row["relatives_suicide"])) { echo "Suicide: ".$row["relatives_suicide"]." &nbsp;"; }
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
function buildPastProblemsNarrative($pid, $date = null) {
	if ($date) $where = "
		and ((   begdate is null and enddate is null and date('$date') >= date )
		   or(   begdate is null and date('$date') < enddate )
		   or(   enddate is null and date('$date') >= begdate)
		   or(   date('$date') between begdate and enddate ))
	 ";
	$sql = "select * from lists where pid=$pid and type='medical_problem'". $where;
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

// allergies
function buildAllergiesNarrative($pid, $date = null) {
	if ($date) $where = "
		and ((   begdate is null and enddate is null and date('$date') >= date )
		   or(   begdate is null and date('$date') < enddate )
		   or(   enddate is null and date('$date') >= begdate)
		   or(   date('$date') between begdate and enddate ))
	 ";
	$sql = "select * from lists where pid=$pid and type='allergy'". $where;
	$stmt = sqlStatement($sql);
	?>
<table cellpadding="0" cellspacing="0">
<? while($row=sqlFetchArray($stmt)) { ?>
	<tr>
		<td class='small' valign='top'><?= $row["diagnosis"] ?></td>
		<td class='small' valign='top'>&nbsp;&nbsp;</td>
		<td class='small' valign='top'><?= $row["title"] ?></td>
	</tr>
	<? } ?>
</table>

<?

return null;
}

// medications
function buildMedicationsNarrative($pid, $date = null) {
	if ($date) $where = "
		and ((   begdate is null and enddate is null and date('$date') >= date )
		   or(   begdate is null and date('$date') < enddate )
		   or(   enddate is null and date('$date') >= begdate)
		   or(   date('$date') between begdate and enddate ))
	 ";
	$sql = "select * from lists where pid=$pid and type='medication' ". $where;
	$stmt = sqlStatement($sql);
	?>
<table cellpadding="0" cellspacing="0">
<? while($row=sqlFetchArray($stmt)) { ?>
	<tr>
<!--
			<td class='small' valign='top'><?= $row["diagnosis"] ?></td>
			<td class='small' valign='top'>&nbsp;&nbsp;</td>
-->
			<td class='small' valign='top'><?= $row["title"] ?></td>
	</tr>
	<? } ?>
</table>

<?

return null;
}

// past surgeries
function buildPastSurgeriesNarrative($pid, $date = null) {
	if ($date) $where = "
		and ((   begdate is null and enddate is null and date('$date') >= date )
		   or(   begdate is null and date('$date') < enddate )
		   or(   enddate is null and date('$date') >= begdate)
		   or(   date('$date') between begdate and enddate ))
	 ";
	$sql = "select * from lists where pid=$pid and type='surgery'". $where;
	$stmt = sqlStatement($sql);
	?>
<table cellpadding="0" cellspacing="0">
<? while($row=sqlFetchArray($stmt)) { ?>
	<tr>
		<td class='small' valign='top'><?= $row["diagnosis"] ?></td>
		<td class='small' valign='top'>&nbsp;&nbsp;</td>
		<td class='small' valign='top'><?= $row["title"] ?></td>
	</tr>
	<? } ?>
</table>

<?

return null;
}

// past dental issues
function buildDentalIssuesNarrative($pid, $date = null) {
	if ($date) $where = "
		and ((   begdate is null and enddate is null and date('$date') >= date )
		   or(   begdate is null and date('$date') < enddate )
		   or(   enddate is null and date('$date') >= begdate)
		   or(   date('$date') between begdate and enddate ))
	 ";
	$sql = "select * from lists where pid=$pid and type='dental'". $where;
	$stmt = sqlStatement($sql);
	?>
<table cellpadding="0" cellspacing="0">
<? while($row=sqlFetchArray($stmt)) { ?>
	<tr>
		<td class='small' valign='top'><?= $row["diagnosis"] ?></td>
		<td class='small' valign='top'>&nbsp;&nbsp;</td>
		<td class='small' valign='top'><?= $row["title"] ?></td>
	</tr>
	<? } ?>
</table>

<?

return null;
}

// past immunizations
function buildImmunizationsNarrative($pid) {
	//$sql = "select id,immunization_id from immunizations LEFT JOIN immunizations on immunizations.id=immunizations.immunization_id where patient_id=$pid";
	//$sql = "select id,name,immunization_id,patient_id  from immunizations where patient_id=$pid AND immunizations.id=immunizations.immunization_id ";
	//$stmt = sqlStatement($sql);

	
				
	
  /*$sql = "select i1.id as id, i1.immunization_id as immunization_id,".
         " if (i1.administered_date, concat(i1.administered_date,' - '), substring(i1.note,1,20)) as immunization_data ".
         " from immunizations i1 ".
         " where i1.patient_id = $pid ".
         " group by i1.immunization_id desc";
   //$stmt = sqlStatement($sql);*/
  //print_r($stmt);
  
  
?>
	
	
<table cellpadding="0" cellspacing="0">
<? while($row=sqlFetchArray($stmt)) { ?>
	<tr>
		<td class='small' valign='top'><?= $row["name"] ?></td>
	</tr>
	<? } ?>
</table>

<?

return null;
}

?>
