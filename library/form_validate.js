/*    Sand Dollar Studio, Inc.
 *
 * $RCSfile$
 * $Revision$
 * $Date$
 * $Source$
 * $Author$ bryan@sanddollarstudio.com
 *
 *    sanddollarstudio.com
 */

/************************************************************************/
// NAME: validate
//
// PARAMETERS : 
//	- frm:		is a form object
//	- reqFlds:	an array in the following form
//			[	['variable_name', 'validation_type', 'Error_Message.\n']
//				['variable_name', 'validation_type', 'Error_Message.\n']
//				['variable_name', 'validation_type', 'Error_Message.\n']	]
//	
// RETURNED VALUE :
//	- NONE
// 
// Validation Types:
//	- nonempty
//	- number
//	- email
//	- phone
//	- Regular Expression (this will be regular expression such as '/\w/')
//
//	Update 1.2:
//		Now the function returns true or false instead of submitting the form.
//
/************************************************************************/

function validate_and_submit(frm,reqFlds) {
	if(validate(frm,reqFlds)) {
		frm.submit();
		return true;
	}
	return false;
}


function validate(frm,reqFlds) {
	var error_message = '';
	
//	alert("1");
	for (var cur_el = 0; cur_el < reqFlds.length; cur_el++) {
		
		var field_value = eval('frm.'+reqFlds[cur_el][0]+'.value');
		var validation = reqFlds[cur_el][1];
		var message = reqFlds[cur_el][2];
		
		switch(validation) {
			case "nonempty" :
							validation = /./;
							error_message += validate_regular_expression(field_value,validation,message);
							break;
			case "number" :
							validation = /\d/;
							error_message += validate_regular_expression(field_value,validation,message);
							break;
			case "email" :
							validation = /^[a-zA-Z0-9][\._a-zA-Z0-9]*@[a-zA-Z][\._a-zA-Z0-9]*\.[a-zA-Z0-9]+/;
							error_message += validate_regular_expression(field_value,validation,message);
							break;
			case "phone2" :
							validation = /^(\(?\d\d\d\)?(-| )?)?\d\d\d-? ?\d\d\d\d$/;
							error_message += validate_regular_expression(field_value,validation,message);
							break;
			case "phone" :
							validation = /^\(?\d\d\d\)?-? ?\d\d\d-? ?\d\d\d\d$/;
							//validation = /^\d\d\d\-\d\d\d-\d\d\d\d/;
							//validation = /^\(?\d\d\d\)?-? ?\d\d\d-? ?\d\d\d\d$/;
							error_message += validate_regular_expression(field_value,validation,message);
							break;
			default :
							var validation = new RegExp(validation);
							error_message += validate_regular_expression(field_value,validation,message);
							break;
		}
	}
	
	if (error_message == '') {
		return true;
	} else {
		alert(error_message);
		return false;
	}
}



/************************************************************************/
// NAME: validate_regular_expression
//
// PARAMETERS : 
//	- field_value:	contents of the field to be validated
//	- validation:	the regular expression to check against
//	- message:		error message for field
//	
// RETURNED VALUE :
//	- string containing all error messages on field that did not pass thier regular exression
// 
/************************************************************************/

function validate_regular_expression(field_value,validation,message) {
	var errors = '';

	if(!validation.test(field_value)) {
		errors += message;
	}
	return errors;
}