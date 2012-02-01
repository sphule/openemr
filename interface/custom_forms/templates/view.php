<?
include_once("../../globals.php");
include_once("$srcdir/../interface/forms/common_form_function/common_functions.php");
require_once($GLOBALS['incdir']."/globals.php");
require_once($GLOBALS['srcdir']."/calendar.inc");
require_once($GLOBALS['srcdir']."/lists.inc");
require_once($GLOBALS['srcdir']."/forms.inc");
require_once($GLOBALS['incdir']."/forms/common_form_function/common_functions.php");
require_once($GLOBALS['srcdir']."/classes/Prescription.class.php");
require_once($GLOBALS['srcdir']."/classes/Patient.class.php");
require_once(dirname(__FILE__)."/functions.php");

$id = $form_id = (!empty($_GET['id'])) ? $_GET['id'] : $form_id ;

// First, make sure we know the form ID and that the form exists.

if($form_id == "") {
	$form_id = $id;
	if($form_id == "") {
		echo "Error: No form ID specified<br>";
		exit(1);
	}
}
$sql = "SELECT attr_id from csf_forms_attributes where form_id = ".$form_id;													
$res = sqlStatement($sql);	

$attributeArray = array();
$i =0;
while($row = sqlFetchArray($res)){

	$attributeArray[$i] = $row['attr_id'];
		$i =$i + 1 ;
}

$sql="select * from csf_form_data where form_id=".$form_id ." and encounter = ". $_SESSION['encounter'];
$stmt=sqlStatement($sql);

?>
<html>
<head>
	<title></title>	
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/DOM.js"></script>
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/dialog.js"></script>
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/overlib_mini.js"></script>
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/calendar.js"></script>
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/textformat.js"></script>
	<script type="text/javascript" src="<?=$GLOBALS['webroot']?>/library/form_validate.js"></script>
	<script>
		function showPrev(){
			objs = document.getElementsByTagName("DIV");
			
			for (var i=0; i<objs.length; i++) {
				if (objs[i].id == "tableDiv"){
					objs[i].style.display = "none";
				}				
			}				
		}
	</script>
	<link rel=stylesheet href="<?echo $css_body;?>" type="text/css">
	<link rel=stylesheet href="<?=$GLOBALS['webroot']?>/interface/forms/common_form_function/common.css" type="text/css">
</head>
<body onload = "showPrev();selectShow();"><table 'width=90%' align='center' cellpadding='0' cellspacing='10'><tr><td bgcolor='black' align=center colspan=2><span class=bold><font color=white>Form1</font></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=bold><a class='text' href='/interface/patient_file/encounter/encounter_top.php'><font color=white>Back</font></a></span></td></tr><tr><td colspan=2>
<form name='Form1' action='/interface/forms/Form1/save.php?update=1' method='POST'><table style='font-family:arial;font-size:14px;'><tr><td><table style="font-family:arial;font-size:14px;" cellspacing="2"><tbody>
<?php
while($row=sqlFetchArray($stmt)) {	
	
	foreach($row as $key => $val){

			$str = str_split($key, 9);

			if($str[0] == "attribute"){
				

				$strN		=	explode("_", $str[1]);
				
				$response = in_array($strN[1],$attributeArray);
				if($response == 1){
				$sql		=	"SELECT	attr_id,attr_name,attr_type,attr_html FROM	csf_attributes WHERE	attr_id = ".$strN[1];
				$stmt		=	sqlStatement($sql);
				$rowAttr	=	sqlFetchArray($stmt);
				$attrName	=	str_replace(" ","_",$rowAttr['attr_name']);
				
				?>

					<tr>
						<?php if($rowAttr['attr_type'] == 's'){?>
								<td><?=htmlspecialchars_decode($rowAttr['attr_html']);?></td>
								<script>
									function selectShow(){
										document.getElementById("<?=$attrName;?>").value = "<?=$row[$key];?>";
									}
								</script>
						<?php }else if($rowAttr['attr_type'] == 'a'){ ?>
								<td><?=$rowAttr['attr_name']?>:</td>
								<td><textarea id="<?=$attrName?>" name="<?=$attrName?>" type="text"><?=nl2br($row[$key])?></textarea></td>
						<?php }else{ ?>
								<td><?=$rowAttr['attr_name']?>:</td>
								<td><input id="<?=$attrName?>" name="<?=$attrName?>" type="text" value="<?=nl2br($row[$key])?>"></td>
						<?php } ?> 
					</tr>
				<?php
				}
			}
		}	

	}
?>
<tr style="font-size:14px;"><td colspan="2"><div id="tableDiv" style="display: inline; "><table border="1" width="100%" cellpadding="4"><tbody><tr style="border:1px solid;font-size:15px;color:#bc1212"><td colspan="2" align="center">Attribute Properties</td></tr><tr><td>Name</td><td>Value</td></tr><tr style="font-size:12px;"><td>Required</td><td>Yes</td></tr><tr style="font-size:12px;"><td>Max Length</td><td>10</td></tr><tr style="font-size:12px;"><td>Input validation</td><td>numeric</td></tr></tbody></table></div></td></tr></tbody></table></td></tr><tr><td colspan='2'><input type='submit' name='UpdateForm' value='Update Form Data'></td></tr></table> <input type='hidden' name='form_id' value='<?=$form_id;?>'></form></td></tr></table>
</body>
</html>


