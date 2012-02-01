<?php
/*************************INCLUDE STATEMENTS*********************/
include_once(dirname(__file__)."/../globals.php");
require 'class.eyemysqladap.inc.php';
require 'class.eyedatagrid.inc.php';

print("<pre>");print_r($_POST);print_r($_GET);print("</pre>");die;

if(isset($_POST["SaveForm"])){

	$sql = "INSERT INTO csf_form_data SET			form_attr_id	=	1,
													field1			=	\"".  $_POST['txt_t_Height']				."\",
													field2			=	\"".  $_POST['txt_t_Vitals']				."\",
													field3			=	\"".  $_POST['txt_t_Blood_Pressure']				."\",
													encounter_id	=	".	  $_SESSION['encounter']."
													create_date		=	now(),
													modified_date		=	now()";
	$res = sqlStatement($sql);	

	if($res){
		xl("Attribute Record Saved Successfully",'e');
	}
}
?>