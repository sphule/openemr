<?

/*
  Billing Codes

	This module allows the user to add or delete billing codes right in the form.  The
	code here expects the form to function much like the Podiatry Note and Progress Note
	it was created for, but will work in other forms if the conditions are right (see
	below).

	Javascript and PHP are used together to allow mostly client-side functionality, so 
	the user doesn't have to re-submit the form with each change.  However, the user's
	changes will not be saved unless the entire form is saved (and the user is told this
	after making the first change).  For this reason, make sure your form can be saved
	and re-saved (updated) many times without problems.

	When the user wants to add a code, a new window pops up so that the php-based 
	search can function independently from the main window where the form is held (to
	avoid losing any unsaved information in the form).  When the user clicks a code,
	the new window refers to its parent and tells it to add the code client-side
	(adding it to hidden fields in the form and then triggering an event to have
	acted upon).

	The billing display and the hidden fields that will be submitted with the form
	are all dynamically generated & updated as the user makes changes, simply by
	modifying the code in several div tags.


	The billing code information is passed by POST as an array.  The array name starts
	with "nosave_" to indicate that the form should not save those variables on its
	own (this is common in the forms the module was written in).


	To add this module to a form:
	1) Add this to your view/new page, probably near the end but before </form>:

<?
 $form_tag_name = "exam"; // set this to the name/id of your form tag!
 include_once("$srcdir/../interface/forms/phyauraforms_common/billing_codes_display.php");
?>

	2) Add this to your save page, again probably near the end (within php's <? and ?> tags):

 // Insert all new billing codes, delete removed ones
 include_once("$srcdir/../interface/forms/phyauraforms_common/billing_codes_save.php");

	3) Add this to your form page's header:

<script type="text/javascript" src="../../../library/DOM.js"></script>


	4) Make sure the following variables are set or not set as needed:
	 a) $form_tag_name - The name/id of the form (<form name="exam" id="exam" method=....>). If
	this is not set properly, the user cannot add billing codes!
	 b) $form_signed - If this is set to true, the billing code modification will disable (it 
	assumes the form is digitally signed and should not be modifiable; note that the billing 
	codes will update if another page changes them i.e. the encounter page)
	 c) $save_button - This variable should hold the html tag for a button, link, icon etc the 
	user can click to save the form.  If this is empty, it's not critical, but it's convenient 
	for the user.


*/

 include_once("$srcdir/../interface/forms/common_form_function/common_functions.php");
 include_once("$srcdir/billing.inc");
	// First build arrays of codes, separated into categories

	$codes = array();
	if ($result = getBillingByEncounter($pid,$encounter,"*") ) {

		foreach ($result as $row) {
			$code_type=$row["code_type"];

			$codes[$code_type][] = array($row["id"], $row["code"], $row["code_text"], $row['modifier'], $row['units'], $row['fee']);
		}
	}
	//else {
	//	echo "No billing codes specified\n";
	//}


	// Now create the javascript to maintain the display and hidden fields
?>

<script language="javascript">

	billing_changed = false;

	codes = new Array();

<?	// create the billing codes array in javascript
	//$first_codetype=1;
	foreach ($codes as $code_type => $codelist) {

		if(count($codelist) < 1)
			continue; // skip empty categories

		//if(!$first_codetype) {
		//	echo ",\n";
		//}
		//else $first_codetype=0;
		echo "	codes['$code_type'] = new Array(\n";

		$first_codenum=1;
		foreach ($codelist as $code_arr) {
			$code_id    = $code_arr[0];
			$code_num   = $code_arr[1];
			$code_text  = $code_arr[2];
			$code_mod   = $code_arr[3];
			$code_units = $code_arr[4];
			$code_fee   = $code_arr[5];
			if(!$first_codenum) {
				echo ",\n";
			}
			else $first_codenum=0;

			echo "		new Array('$code_id', '$code_num', '$code_text', '$code_mod', '$code_units', '$code_fee')";
		}
		echo "\n	);\n\n";
	}
?>

	function build_original_codes_list() {
		div_fields  = findDOM('cptcode_fields_original');

		var fields_html = "";

		var totalcodes=0;

		for(code_type in codes) {
			numcodes=0;
			for(code_i in codes[code_type]) {
				if(codes[code_type][code_i][0] !== null)
					numcodes++;
			}

			if(numcodes < 1)
				continue;

			for(code_i in codes[code_type]) {
				var code_id     = codes[code_type][code_i][0];
				var code_num    = codes[code_type][code_i][1];
				var code_text   = codes[code_type][code_i][2];
				var code_mod    = codes[code_type][code_i][3];
				var code_units  = codes[code_type][code_i][4];
				var code_fee    = codes[code_type][code_i][5];
				if(code_id == null) continue;

				fields_html += build_code_hidden_fields("code_original", totalcodes, code_type, code_id, code_num, code_text, code_mod, code_units, code_fee);

				totalcodes++;
			}
		}

		//alert("testing " + totalcodes);

		div_fields.innerHTML = fields_html;
		//div_fields.innerHTML = html2entities(fields_html) + fields_html;
	}

	function update_code_list() {
		var div_fields  = findDOM('cptcode_fields');
		var div_display = findDOM('cptcode_display');

		var form_signed = <? if($form_signed) echo "true"; else echo "false"; ?>;

		var fields_html = "";
		var display_html;
		if(form_signed === false)
			display_html = "<font size=2>Click the trash can for codes you wish to delete</font>";
		else
			display_html = "";
		var first;
		var numcodes;
		var totalcodes=0;

		if(billing_changed == true) {
			display_html += "<br/><span class=required>Note: Changes will not be saved until form is saved.</span><br/><? echo addslashes($save_button); ?>";
		}

		display_html += "<table border=1 width=\"90%\">";

		for(code_type in codes) {
			//if(code == "DELETED_CODES")
			//	continue;

			numcodes=0;
			for(code_i in codes[code_type]) {
				if(codes[code_type][code_i][0] !== null)
					numcodes++;
			}

			if(numcodes < 1)
				continue;

			display_html += "<tr>\n"
			+ "  <td rowspan=" + numcodes + " width=100>" + code_type + "</td>\n";

			first=true;
			for(code_i in codes[code_type]) {
				var code_id     = codes[code_type][code_i][0];
				var code_num    = codes[code_type][code_i][1];
				var code_text   = codes[code_type][code_i][2];
				var code_mod    = codes[code_type][code_i][3];
				var code_units  = codes[code_type][code_i][4];
				var code_fee    = codes[code_type][code_i][5];
				if(code_id == null) continue;

				if(first)
					first=false;
				else
					display_html += "<tr>\n";
				if(form_signed === false)
					display_html += "  <td width=10><a title=\"Delete this code\" onclick=\"delete_code('" + code_id + "', '" + code_type + "')\" ><img border=0 src=\"<?=$GLOBALS['rootdir'];?>/../images/trash.png\"/></a></td>\n";
				//display_html += "  <td width=80><strong>" + code_num + "(" + code_id + ")</strong></td>\n";
				display_html += "  <td width=80><strong>" + code_num + "</strong></td>\n";
				display_html += "  <td>" + code_text + " ";
				if(code_mod != "" && code_mod != 0)
					display_html += "  <i>modifier</i>: " + code_mod;
				if(code_fee != "" && code_fee != 0)
					display_html += "  <i>fee</i>: $ " + code_fee;
				display_html += "</td>\n";
				+ "</tr>\n";

				fields_html += build_code_hidden_fields("code", totalcodes, code_type, code_id, code_num, code_text, code_mod, code_units, code_fee);

				totalcodes++;
			}
		}

		if(totalcodes == 0) {
			display_html += "<tr><td align=\"center\"><hr color=\"yellow\"/>No codes currently selected<hr color=\"yellow\"/></td></tr>";
		}

		display_html += "</table>";

		// submit button
		display_html += "<button type=\"button\" name=\"nosave_add_code\" id=\"nosave_add_code\" onclick=\"user_click_add_code()\" <? if($form_signed) echo "disabled=true";  ?> onblur=\"check_user_added_code()\" >Add Codes...</button>"

		if(billing_changed == true) {
			display_html += "<p/><span class=required>Note: Changes will not be saved until form is saved.</span></font><br/><? echo addslashes($save_button); ?><p/>";
		}

		div_fields.innerHTML = fields_html;
		//div_fields.innerHTML = html2entities(fields_html) + fields_html;

		div_display.innerHTML = display_html;
	}

	function build_code_hidden_fields(prefix, totalcodes, code_type, code_id, code_num, code_text, code_mod, code_units, code_fee) {
		var fields_html = "";
		fields_html += "<input type=\"hidden\" name=\"nosave_" + prefix + "[" + totalcodes + "][type]\"  value=\"" + code_type + "\" />\n";
		fields_html += "<input type=\"hidden\" name=\"nosave_" + prefix + "[" + totalcodes + "][id]\"    value=\"" + code_id + "\" />\n";
		fields_html += "<input type=\"hidden\" name=\"nosave_" + prefix + "[" + totalcodes + "][num]\"   value=\"" + code_num + "\" />\n";
		fields_html += "<input type=\"hidden\" name=\"nosave_" + prefix + "[" + totalcodes + "][text]\"  value=\"" + code_text + "\" />\n";
		if(code_mod != "")
			fields_html += "<input type=\"hidden\" name=\"nosave_" + prefix + "[" + totalcodes + "][mod]\"   value=\"" + code_mod + "\" />\n";
		if(code_units != "")
			fields_html += "<input type=\"hidden\" name=\"nosave_" + prefix + "[" + totalcodes + "][units]\" value=\"" + code_units + "\" />\n";
		if(code_fee != "")
			fields_html += "<input type=\"hidden\" name=\"nosave_" + prefix + "[" + totalcodes + "][fee]\"   value=\"" + code_fee + "\" />\n";
		return fields_html;
	}


	function delete_code(code_id, code_type) {

		if(!confirm("Are you sure you want to delete this code?")) return;

		//var deleted_type = 'DELETED_CODES';
		//if(codes[deleted_type] == null)
		//	codes[deleted_type] = new Array();

		for(code_i in codes[code_type]) {
			if(codes[code_type][code_i][0] === code_id) {
				//if(codes[code_type][code_i][0] != -1) { // not a newly added code
				//	codes[deleted_type][code_i] = new Array();
				//	for(i in codes[code_type][code_i]) {
				//		codes[deleted_type][code_i][i] = codes[code_type][code_i][i];
				//	}
				//	//alert("Updated deleted codes: " + codes[deleted_type][code_i][1]);
				//}
				codes[code_type][code_i][0] = null;
				billing_changed = true;
				update_code_list();
				return;
			}
		}
		alert("Warning: Code not found");
	}

	function add_code(code_type, code_id, code_num, code_text, code_mod, code_units, code_fee) {
		if(codes[code_type] == null) {
			codes[code_type] = new Array();
			billing_changed = true;
		}
		else {
			// check if code already exists
			for(code_i in codes[code_type]) {
				if(codes[code_type][code_i][1] === code_num) {
					if(code_id != -1 || code_num == codes[code_type][code_i][1]) {
						// found code, quit
						alert("You can only add each code once (" + code_num + " is a duplicate)");
						// update?
						//codes[code_type][code_i][0] = code_id;
						//codes[code_type][code_i][1] = code_num;
						//codes[code_type][code_i][2] = code_text;
						//codes[code_type][code_i][3] = code_mod;
						//codes[code_type][code_i][4] = code_units;
						//codes[code_type][code_i][5] = code_fee;
						//billing_changed = true;
						return;
					}
				}
			}
		}

		codes[code_type].push(new Array(code_id, code_num, code_text, code_mod, code_units, code_fee));
		billing_changed = true;

		update_code_list();
	}

	function user_click_add_code() {
		codePopup=window.open('<?echo $rootdir?>/forms/common_form_function/code_search.php?form_name=<?=$form_tag_name;?>', 'codePopup', 'width=700,height=600,menubar=no,titlebar=no,left = 825,top = 400,scrollbars=yes,location=no,toolbar=no');
		codePopup.opener=self;
	}

	function check_user_added_code() {
		var type	= document.<?=$form_tag_name;?>.nosave_add_code_type;
		var id		= document.<?=$form_tag_name;?>.nosave_add_code_id;
		var num		= document.<?=$form_tag_name;?>.nosave_add_code_num;
		var text	= document.<?=$form_tag_name;?>.nosave_add_code_text;
		var mod		= document.<?=$form_tag_name;?>.nosave_add_code_mod;
		var units	= document.<?=$form_tag_name;?>.nosave_add_code_units;
		var fee		= document.<?=$form_tag_name;?>.nosave_add_code_fee;

		// do nothing if not set
		if(num.value == "") {
			// quit silently, must be empty
			return;
		}
		if(type.value == "") {
			alert("Warning: code type not recieved");
			return;
		}
		if(text.value == "") {
			alert("Warning: code text not recieved");
			return;
		}

//		alert("id=" + id.value + ", num=" + num.value + ", text=" + text.value + ", type=" + type.value);

		// add the code
		add_code(type.value, id.value, num.value, text.value, mod.value, units.value, fee.value);

		// clear the hidden fields
		type.value	="";
		id.value	="";
		num.value	="";
		text.value	="";
		mod.value	="";
		units.value	="";
		fee.value	="";
	}


</script>


<table border=0 align="center" width="100%"> <tr><td align="center">


<p><span class=title>Current <? echo ($GLOBALS['phone_country_code'] == '1') ? 'Billing' : 'Coding' ?></span>

<!-- &nbsp;<span class=required>Under Construction</span> -->

</p>
<p>

<!-- Where the form input fields are stored -->
<div id="cptcode_fields" name="cptcode_fields">
</div>

<!-- Where the form input field originals are stored -->
<div id="cptcode_fields_original" name="cptcode_fields_original">
</div>

<!-- Where the codes are displayed -->
<div id="cptcode_display" name="cptcode_display">
</div>

<!-- fields to recieve code selected in other window -->
<input type="hidden" name="nosave_add_code_type"  id="nosave_add_code_type"  value=""/>
<input type="hidden" name="nosave_add_code_id"    id="nosave_add_code_id"    value=""/>
<input type="hidden" name="nosave_add_code_num"   id="nosave_add_code_num"   value=""/>
<input type="hidden" name="nosave_add_code_text"  id="nosave_add_code_text"  value=""/>
<input type="hidden" name="nosave_add_code_mod"   id="nosave_add_code_mod"   value=""/>
<input type="hidden" name="nosave_add_code_units" id="nosave_add_code_units" value=""/>
<input type="hidden" name="nosave_add_code_fee"   id="nosave_add_code_fee"   value=""/>

<!-- test buttons
<br/>
<button type="button" onclick="add_code('TESTING1', '9197', '91983.3', '1 This code is for testing purposes only', '', '', '')" >test add 1</button>
<button type="button" onclick="add_code('CPT4',     '9198', '91983.4', '2 This code is for testing purposes only', '', '', '')" >test add 2</button>
-->



</td></tr></table>
</form>

<script language="javascript">
	// initialize the display and fields
	update_code_list();

	build_original_codes_list();

</script>

