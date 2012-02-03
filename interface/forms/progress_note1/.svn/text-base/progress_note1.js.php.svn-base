<script type="text/javascript">
 var mypcc = '<? echo $GLOBALS['phone_country_code'] ?>';


/*********/
// add new issue
function new_issue(id) {
	//dlgopen('<?echo $rootdir?>/patient_file/summary/add_edit_issue.php?issue=' + id, '_blank', 500, 450);
	//dlgopen('<?echo $rootdir?>/patient_file/problem_encounter.php', '_blank', 700, 450);
	dlgopen('<?echo $rootdir?>/patient_file/summary/stats_full.php?active=all', '_blank', 700, 450);
}
/*********/
//add new issue
function new_issue1(id,flag) {
	//dlgopen('<?echo $rootdir?>/patient_file/summary/add_edit_issue.php?issue=' + id, '_blank', 500, 450);
	//dlgopen('<?echo $rootdir?>/patient_file/problem_encounter.php', '_blank', 700, 450);
	dlgopen('<?echo $rootdir?>/patient_file/summary/stats_full.php?active=all&flagtype='+flag, '_blank', 700, 450);
	
}
// view issues
function view_issue() {
 dlgopen('<?echo $rootdir?>/patient_file/summary/stats_full.php?active=all', '_blank', 750, 450);
}
// add new vitals
function new_vital(id,flag) {

 dlgopen('<?echo $rootdir?>/patient_file/encounter/load_form.php?formname=vitals&flagtype='+flag, '_blank', 400, 450);
}

// view/edit history
function view_history(flag) {
 dlgopen('<?echo $rootdir?>/patient_file/history/history_full.php?flagvalue='+flag, '_blank', 750, 450);
}

// view/edit ros
function view_edit_ros(id) {
 var url = '<?echo $rootdir?>/patient_file/encounter/view_form.php?formname=ros';
 if(id > 0) {
 	url += '&id=' + id;
 }
 dlgopen(url, '_blank', 750, 450);
}

// view/edit ros
function view_edit_ros1(id,flag) {
 var url = '<?echo $rootdir?>/patient_file/encounter/view_form.php?formname=ros&flagvalue=' + flag;
 if(id > 0) {
 	url += '&id=' + id;
 }
 dlgopen(url, '_blank', 750, 450);
}



/**
 * update the hidden field for hpi_location
 *
 * nosave_hpi_location_menu	- the select menu
 * nosave_hpi_location_text	- the div
 * hpi_location 			- the hidden field
 */
function update_hpi_location() {
	var frm=document.forms['exam'];
	var divstyle = findDOMStyle("div_hpi_location_text");
	var form_signed = <? echo ($form_signed === true) ? "true":"false"; ?>;
	var selectedOpt = frm.nosave_hpi_location_menu.options[frm.nosave_hpi_location_menu.selectedIndex];

//alert('form:'+frm+'\noption index:'+frm.nosave_hpi_location_menu.selectedIndex+'\noption:'+selectedOpt+'\noption value:'+selectedOpt.value+'\noption text:'+selectedOpt.text);
	if(selectedOpt.text==="other" || selectedOpt.text==="Other") {
		// alert("o/Other is selected");

		frm.nosave_hpi_location_text.disabled = (form_signed == false) ? false : true;
		divstyle.visibility = 'visible';
		divstyle.display = 'inline';
		frm.hpi_location.value=frm.nosave_hpi_location_text.value;

	} else {
		// alert("o/Other is NOT selected");

		frm.nosave_hpi_location_text.disabled = true;
		divstyle.visibility = 'hidden';
		divstyle.display = 'none';
		frm.hpi_location.value=selectedOpt.text;

	}
	
	//alert(frm.hpi_location.value);
}


/**
 * Sign form if user clicks button, has filled all required fields, and chooses "yes"
 */
 
function sign_and_submit(frm) {

 update_hpi_location();

 // make sure they're not forgetting a required field
 if(!validate(frm, required_fields))
	return false;
// alert("sign_and_submit valid");

 // make sure they know what they're doing
 if(!confirm("Are you sure you want to sign the form?\n\nWhen you sign the form, your name and time of signing will be recorded as an\nelectronic signature, and the form cannot be modified further except by addendums.\n\nIf you are sure you want to sign, click OK.  Otherwise click Cancel."))
	return false;
 //frm.nosave_sign_valid.value=1;
 frm.nosave_sign_valid.value=1;

 frm.submit();
 
 return true;
}


function toencounter(enc) {
 top.Title.location.href = '<?echo $rootdir?>/patient_file/encounter/encounter_title.php?set_encounter='   + enc;
 top.Main.location.href  = '<?echo $rootdir?>/patient_file/encounter/patient_encounter.php?set_encounter=' + enc;
}

 function check_all_exam_normal(checkall, form_name, validation) {
 	form_name = (form_name == null || form_name == '') ? 'exam' : form_name ;
 	validation = (validation == null || validation == '') ? /^cb_exam_/ : validation ;
	var frm=document.forms[form_name];
	var len=frm.elements.length;
	for(i=0; i<len; i++) {

		// do not check these exceptions
		// Chest/breasts: cb_exam_chest_masses, cb_exam_chest_symmetrical
		// GU Male: cb_exam_gumale_prostate, exam_gumale_notes, cb_exam_gumale_masses, cb_exam_gumale_scrotum
		// GU Female: cb_exam_gufemale_genitalia, exam_gufemale_notes, cb_exam_gufemale_masses, cb_exam_gufemale_bladder, cb_exam_gufemale_cervix
		var exceptions = new Array("cb_exam_chest_masses", "cb_exam_chest_symmetrical", 
			"cb_exam_gumale_prostate", "exam_gumale_notes", "cb_exam_gumale_masses", 
			"cb_exam_gumale_scrotum", "cb_exam_gufemale_genitalia", "exam_gufemale_notes",
			"cb_exam_gufemale_masses", "cb_exam_gufemale_bladder", "cb_exam_gufemale_cervix"
		);
								
		var isException = false;
		for(ex=0; ex<exceptions.length; ex++) {
			if (frm.elements[i].name == exceptions[ex]) { 
				isException = true;
				break;
			}
		}
		if(isException) { continue; }
		if (validation.test(frm.elements[i].name)) {
			frm.elements[i].checked=checkall;
		}
	}
 }

</script>