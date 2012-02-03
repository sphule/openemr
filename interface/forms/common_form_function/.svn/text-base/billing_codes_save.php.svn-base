<?

/*

	Billing Codes Save



	This file should be included at the end of a form's save.php.

	It recieves the billing codes in the format of "nosave_" variables, so the form it's attached
	to knows to not bother with those values itself.

	The billing codes are sent through post as an array:
	nosave_code
		code1
		  type (CPT, COPAY, etc)
		  id  (-1 if a new code, otherwise already in system)
		  num (code #)
		  text (code description)
		  mod
		  units
		  fee
		code2
		  .
		  .
		  .

	nosave_code_original has the same format.

	code_original should hold the codes that were in the system when the user loaded the form,
	and code should hold whatever codes exist after the user is done modifying them (either
	by adding or deleting, etc).

	The first step is to remove any common entries between the new and the old arrays (things 
	that haven't changed).  Once we do that, anything left in the new array must be added,
	and everything left in the old array must be deleted (if it's in the old but not the new,
	the user removed it).  We remove first, then add, since the user may have removed a code,
	and then submitted the same code slightly modified (changed copay amount, etc).
*/


	include_once("../common_form_function/common_functions.php");
	include_once("$srcdir/billing.inc");

	$newbilling = $_POST['nosave_code'];
	$oldbilling = $_POST['nosave_code_original'];

	// remove common entries (things that haven't changed).
	// this will tell us what the user changed.
	if(!empty($newbilling) && !empty($oldbilling)) { // both are set
	 foreach ($newbilling as $codenum => $codes) {
		// if it's in both arrays, we don't care about it.
		foreach ($oldbilling as $oldcodenum => $oldcodes) {
			$same = true;
			foreach ($oldbilling[$oldcodenum] as $key => $value) {
				if($oldbilling[$oldcodenum][$key] != $newbilling[$codenum][$key])
					$same=false;
			}
			if($same == true) {
				//echo "common removed (".$newbilling[$codenum][num].")<br/>";
				unset($newbilling[$codenum]);
				unset($oldbilling[$oldcodenum]);
			}
		}
	 }
	}

	// codes left in $oldbilling must be deleted

	if(!empty($oldbilling)) {
	 echo "<p/>";
	// echo "Delete Codes: <br/>";

	 foreach($oldbilling as $codenum => $codes) {
		//echo "$codenum:<br/>";
		//foreach($codes as $key => $value) {
		//	echo "$key -> $value<br/>";
		//}
		$type	=$codes['type'];
		$id	=$codes['id'];
		$code	=$codes['num'];
		$text	=$codes['text'];
		$mod	=$codes['mod'];
		$units	=$codes['units'];
		$fee	=$codes['fee'];

		deleteBilling($id);
	 }
	}


	// codes in $newbilling need to be added

	if(!empty($newbilling)) {
	// echo "Add Codes: <br/>";
	 foreach($newbilling as $codenum => $codes) {

		$type	=$codes['type'];
		$id	=$codes['id'];
		$code	=$codes['num'];
		$text	=$codes['text'];
		$mod	=$codes['mod'];
		$units	=$codes['units'];
		$fee	=$codes['fee'];

		//echo "$codenum:<br/>";
		//foreach($codes as $key => $value) {
		//	echo "$key -> $value<br/>";
		//}
		if (strtolower($type) == "copay") {
			addBilling($encounter, $type, sprintf("%01.2f", $code), $text, $pid, $userauthorized,$_SESSION['authUserID'],$modifier,$units,sprintf("%01.2f", 0 - $code));
		}
		elseif (strtolower($type) == "other") {
			addBilling($encounter, $type, $code, $text, $pid, $userauthorized,$_SESSION['authUserID'],$modifier,$units,sprintf("%01.2f", $fee));
		}
		else { // most codes go here
			addBilling($encounter, $type, $code, $text, $pid, $userauthorized,$_SESSION['authUserID'],$modifier,$units,$fee);
		}

	 }
	}

?>
