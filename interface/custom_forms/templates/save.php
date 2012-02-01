<?php
/*************************INCLUDE STATEMENTS*********************/
include_once("../../globals.php");


	/*foreach($_POST as $key => $value){
	
		if($key != 'SaveForm' && $key != 'form_id'){
		
			$attrName	=	str_replace("_"," ",$key);
			$sql = "SELECT attr_index from csf_attributes where	attr_name =	'". $attrName ."'";												
			$res = sqlStatement($sql);	
			$row = sqlFetchArray($res);

			$insertString .= " , attribute_". $row['attr_index'] ." = '". $value ."'";

		}
		
	}*/

	$sql = "SELECT attr_index,attr_name,attr_type,attr_select_options from csf_attributes a, csf_forms_attributes b where	a.attr_id = b.attr_id and b.form_id = ".$_POST['form_id'];													
	$res = sqlStatement($sql);		

	while($row = sqlFetchArray($res)){

				$attrName =	str_replace(" ","_",$row['attr_name']);
							
				if($row['attr_type'] == 'c'){
					
					$options = explode(",", $row['attr_select_options']);
					
					$i = 1;
					$attributeValue = "";
					
					foreach($options as $val){
						
						$postAttributeName = $attrName."_".$i;

						if(isset($_POST[$postAttributeName])){
							
							$attributeValue .= htmlspecialchars($_POST[$postAttributeName]).",";	
							
						}
						
						$i = $i + 1;
						
					}
					if(!empty($attributeValue)){
						
						$attributeValue = substr($attributeValue,0, -1);
					}
					
					$insertString .= " , attribute_". $row['attr_index'] ." = \"". htmlspecialchars($attributeValue) ."\"";
					
				}
				else
				{
					$insertString .= " , attribute_". $row['attr_index'] ." = \"". htmlspecialchars($_POST[$attrName]) ."\"";
				}	
						

	}

	if(isset($_POST["SaveForm"])){
		
		$sql = "INSERT INTO csf_form_data SET	form_id			=	".$_POST['form_id'].",
												create_date		=	now(),
												modified_date	=	now(),
												encounter		=	".$_SESSION['encounter'];

		$sql = $sql.$insertString.";";
														
		$res = sqlStatement($sql);
		
		$sqlForm = "SELECT * from csf_forms where form_id = ".$_POST['form_id'];
		$resForm = sqlStatement($sqlForm);
		$rowForm = sqlFetchArray($resForm);

		if($res){

			$sql			 = "INSERT INTO forms	 
								SET			`form_name`				=	\"".	$rowForm['form_name']	 ."\",
											`encounter`				=	".		$_SESSION['encounter'] .",
											`form_id`				=	".		$_POST['form_id'].",
											`pid`					=	".		$_SESSION['pid'] .",
											`user`					=	\"".	$_SESSION['authUser'] ."\",
											`groupname`				=	'Default',
											`authorized`			=	1,
											`date`					=   now(),
											`formdir`				=	\"".	str_replace(" ","_",$rowForm['form_name'])."\"";
			$res			= sqlStatement($sql);

			
		}
	}
	else if(isset($_POST["UpdateForm"])){ 

		$sql = "UPDATE csf_form_data SET	modified_date	=	now()";
												

		$sql = $sql.$insertString." WHERE form_id	=	".$_POST['form_id']." and encounter		=	".$_SESSION['encounter'];
														
		$res = sqlStatement($sql);
		
		
	}


echo "<font color=red>form saved</font><br>";

include("view.php");
?>
