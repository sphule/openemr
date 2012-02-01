<script type="text/javascript">
 var mypcc = '<? echo $GLOBALS['phone_country_code'] ?>';



/**
 * Sign form if user clicks button, has filled all required fields, and chooses "yes"
 */
 
function sign_and_submit(frm) {

// update_hpi_location();

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



</script>