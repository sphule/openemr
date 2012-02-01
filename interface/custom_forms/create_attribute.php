<?php

/*************************START : INCLUDE STATEMENTS ********************/
include_once(dirname(__file__)."/../globals.php");
require_once 'class.eyemysqladap.inc.php';
require_once 'class.eyedatagrid.inc.php';
/*************************END : INCLUDE STATEMENTS *********************/

$SubmitName		= "addnewattr";
$SubmitValue	= "Save";

$sql		= "select id,concat(fname,' ',lname) as name from users";
$resUser	= sqlStatement($sql);
while($rowUser	= sqlFetchArray($resUser)){ 
	$StringHTMLUser .= "<option value='".$rowUser['name']."'>".$rowUser['name']."</option>";
}

$sql		= "select id,concat(fname,' ',lname)  as name from patient_data";
$resPatient	= sqlStatement($sql);

while($rowPatient = sqlFetchArray($resPatient)){ 
	$StringHTMLPatient .= "<option value='".$rowPatient['name']."'>".$rowPatient['name']."</option>";
}

if(isset($_GET["id"]) && !empty($_GET["id"]))
{
	$sql			= "SELECT * from csf_attributes WHERE	attr_id =	\"".  $_GET['id'] ."\"";
	$res			= sqlStatement($sql);	
	$rowPrev		= sqlFetchArray($res);
	$SubmitName		= "updateattr";
	$SubmitValue	= "Update";
	
	if(!empty($rowPrev['attr_select_options'])){
		
		$arraySelectOptions		= explode(",",$rowPrev['attr_select_options']);
		$attr_select_options	= $rowPrev['attr_select_options'];	
		
	}
	if(isset($_GET['page'])){	
		$pageaction = "page=".$_GET['page']."&";
	}else{
		$pageaction = "";
	}
	
}

?>

<html>
	<head>
		<title><?php xl("Custom Forms","e"); ?></title>
		<link href="table.css" rel="stylesheet" type="text/css">
		<link rel="STYLESHEET" type="text/css" href="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/dhtmlxtabbar.css">
		<link rel="STYLESHEET" type="text/css" href="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxGrid/codebase/dhtmlxgrid.css">
		<link rel="STYLESHEET" type="text/css" href="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxGrid/codebase/skins/dhtmlxgrid_dhx_skyblue.css">
		<style>
		.errorMsg {
			margin:0 3px;
			background:#ffdae0 url(images/errorMsg.png) left center no-repeat;
			border:#bd221e 1px solid;
			vertical-align:top;
			padding:4px 5px 4px 28px;
			color:#1d0010;
		}
		.successfullMsg {
			margin:0 3px;
			background:#f5fdf2 url(images/successMsg.png) left center no-repeat;
			border:#839b82 1px solid;
			vertical-align:top;
			padding:4px 5px 4px 28px;
			color:#33422b;
		}
		</style>
		<style type="text/css">@import url(<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar.css);</style>
		<script  src="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
		<script  src="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxGrid/codebase/dhtmlxgrid.js"></script>        
		<script  src="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>
		<script  src="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxDataProcessor/codebase/dhtmlxdataprocessor.js"></script>
		<script  src="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxGrid/codebase/ext/dhtmlxgrid_drag.js"></script>
		<script  src="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxGrid/codebase/ext/dhtmlxgrid_pgn.js"></script>
		<script  src="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/dhtmlxtabbar.js"></script>
		<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar.js"></script>
		<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar_en.js"></script>
		<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/dynarch_calendar_setup.js"></script>

		<script type="text/javascript">	
		 var mypcc = '1';
		function fncInputNumericValuesOnly(x)
		{
			var txt = document.getElementById(x).value;
			if(txt.length > 1){
				txt = txt.substr(0,1);
				if(!((txt >= 'a' && txt <= 'z') || (txt >= 'A' && txt <= 'Z')))
					return false;
			}
		}
		function validate()
		{
			if(trim(document.getElementById('attr_name').value) == ''){
				alert("Required Fields Missing: Please enter the Attribute Name");
				return false;
			}else{

				regExpString = /^[a-zA-Z0-9\'\- ]*$/;

				if(!regExpString.test(document.getElementById('attr_name').value)){
					alert("Invalid Input - Attribute Name: Please use Alpha numeric and may contain Single quotes");
					return false;
								
				}
				else{ 					
					
					if(fncInputNumericValuesOnly('attr_name') == false){
						alert("Invalid Input - Attribute Name: Please don't use number as first character");
						return false;
					}
				}
			}
			if(document.getElementById('attr_type').value == ''){
				alert("Required Fields Missing: Please enter the Attribute Type");
				return false;
			}
			else if(document.getElementById('attr_type').value =='c' || document.getElementById('attr_type').value =='r' ){

				if(document.getElementById('attr_select_options').value == ''){
						alert("Required Fields Missing: Please define at least one option.");
						return false;
					}
			}
			else{
				if(document.getElementById('attr_type').value == 's' && document.getElementById('attr_relational').value == ''){
					alert("Required Fields Missing: Please select the Is Relational field");
					return false;
				}else if(document.getElementById('attr_relational').value == 'y'){

					if(document.getElementById('attr_relational_table').value == ''){
						alert("Required Fields Missing: Please select the Relational table");
						return false;
					}else{
						if(document.getElementById('attr_relational_col').value == ''){
							alert("Required Fields Missing: Please select the Relational Column");
							return false;
						}
					}
				}else if(document.getElementById('attr_relational').value == 'n'){
					
					if(document.getElementById('attr_select_options').value == ''){
						alert("Required Fields Missing: Please define at least one option for the select box");
						return false;
					}
				}
			}
			if(document.getElementById('attr_max_length').value != ''){
				regExpString = /^[0-9]*$/;
				if(!regExpString.test(document.getElementById('attr_max_length').value)){
					alert("Invalid Input -Max Length: Please use numeric only");
					return false;
				}
			}
			if(document.getElementById('attr_status').value == ''){
				alert("Required Fields Missing: Please enter the Attribute Status");
				return false;
			}
			return true;
		}
		function validateOnAdd(){

			regExpString = /^[a-zA-Z0-9]*$/;

			if(!regExpString.test(document.getElementById('attr_option_txt').value)){
				alert("Invalid Input - : Please use Alpha numeric only");
				return false;
							
			}
			return true;
		}
		function createscriptValidation(attrType,attrName){
			
			var stringValidation = "";
			var attrNameVal;
		
			str			= trim(document.getElementById('attr_name').value);
			
			attrNameVal = str.replace(/ /g, "_");

			/*if(attrType == 'd'){
				stringValidation = "imgname = \"img_" + attrName + "\"; Calendar.setup({inputField:\"" + attrName + "\", ifFormat:'%Y-%m-%d', button:imgname});	";
			}*/
			
			if(document.getElementById('attr_required').value == 'y'){
			
				stringValidation += "if(trim(document.getElementById(\"" + attrNameVal + "\").value) == ''){ alert(\"Required Field Missing: Please enter the value for " + document.getElementById('attr_name').value + "\"); document.getElementById(\"" + attrNameVal + "\").focus(); return false;}"; 
			}
			if(document.getElementById('attr_max_length').value != ''){

				maxLength	= document.getElementById('attr_max_length').value;
				attrLength	= document.getElementById('attr_name').value.length;

				stringValidation += "if(document.getElementById(\"" + attrNameVal + "\").value.length > " + maxLength + "){ alert(\"The " + document.getElementById('attr_name').value + " length should not be more than " + maxLength + "\"); document.getElementById(\"" + attrNameVal + "\").focus(); return false;}"; 
			}
			if(document.getElementById('attr_validation').value != ''){
			
				validationValue = document.getElementById('attr_validation').value;
				
				if(validationValue == 'numeric'){
					validationValue = "Number(Numeric)";
					regExpString = " regExp = /^[0-9 ]*$/;"; 
				} 
				else if(validationValue == 'character'){	
					validationValue = "Character";
					regExpString = " regExp = /^[A-Za-z ]*$/;";	
				} 
				else if(validationValue == 'alphanum'){	
					validationValue = "Alpha Numeric ";
					regExpString = " regExp = /^[0-9a-zA-Z ]*$/;";	
				}
				else if(validationValue == 'date'){	
					validationValue = "Date [Format - mm/dd/yyyy]";
					regExpString = " regExp = /^\\d{1,2}\\/\\d{1,2}\\/\\d{4}$/;";
				}					
				if(regExpString != ""){
					stringValidation  += regExpString + " if ((document.getElementById(\"" + attrNameVal + "\").value != '') && !regExp.test(document.getElementById(\"" + attrNameVal + "\").value)) { alert(\"Please enter valid " + validationValue + " value for  " + document.getElementById('attr_name').value + "\");	document.getElementById(\"" + attrNameVal + "\").focus(); return false;}";
				}
			}
			if(stringValidation != ""){
				document.getElementById('attr_validation_script').value	=	stringValidation;
			}				
		}
		function onclickcal(elementid){	
			imgname = "img_"+ elementid;			
			Calendar.setup({inputField:elementid, ifFormat:'%Y-%m-%d', button:imgname});	
		}
		
		function showAttriutePreview(submit){
		
			var StringHTML;
			var required;
			var inputVal;
			var stringValidation	= "";
			var attrType			= "n/a";			
			var attrNameVal;
			var StringSelect		= "";
			var maxLength			= "n/a";
			var attrValidation		= "n/a";
			var attrDisplayLabel	= "";

			str = trim(document.getElementById('attr_name').value);
			attrNameVal = str.replace(/ /g, "_");

			if(document.getElementById('attr_label_show').checked == false){
				if(document.getElementById('attr_display_label').value == ""){
					attrDisplayLabel	= document.getElementById('attr_name').value;
				}else{
					attrDisplayLabel	= document.getElementById('attr_display_label').value;
				}	
			}else{
				attrDisplayLabel = "";
			}

			if(document.getElementById('attr_type').value == 's'){
				attrType = "Select Box";
			}else if(document.getElementById('attr_type').value == 't'){
				attrType = "Text Box";
			}else if(document.getElementById('attr_type').value == 'a'){
				attrType = "Text Area";
			}else if(document.getElementById('attr_type').value == 'f'){
				attrType = "Fixed Text";
			}else if(document.getElementById('attr_type').value == 'd'){
				attrType = "Date";
			}else if(document.getElementById('attr_type').value == 'c'){
				attrType = "Check Box";
			}else if(document.getElementById('attr_type').value == 'r'){
				attrType = "Radio Button";
			}				
			
			
			if(document.getElementById('attr_required').value == 'y'){
				required = 'Yes';
				inputVal = 'Yes';
			}else{
				required = 'No';
				inputVal = 'No';
			}
			
			if(document.getElementById('attr_max_length').value != "" ){
				maxLength = document.getElementById('attr_max_length').value;
			}
			
			if(document.getElementById('attr_validation').value != "" ){
				attrValidation = document.getElementById('attr_validation').value;
			}
			
			StringHTML = "<table style='font-family:arial;font-size:14px;width:90%' cellspacing='2'><tr style='bgcolor:#fff;'>";

			if(document.getElementById('attr_label_show').checked == false){

				if(document.getElementById('attr_type').value != 'f'){
	
					StringHTML += "<td style='width:25%;border-width:0px;'>" + attrDisplayLabel + "</td></td><td style='width:75%;border-width:0px;'>"; 
				}
				else{
					StringHTML += "<td colspan='2' style='padding:10px;width:75%;border-width:0px;'>"; 
				}
			}
			else{
				StringHTML += "<td colspan='2' style='padding:10px;width:75%;border-width:0px;'>"; 
			}
			
			if(document.getElementById('attr_type').value == 't'){			
				StringHTML += "<input id=\"" + attrNameVal + "\" name=\"" + attrNameVal +"\" type='text'>";			
			}
			else if(document.getElementById('attr_type').value == 's'){
				if(document.getElementById('attr_relational').value == 'y'){
					StringHTML += "<select id=\"" + attrNameVal +"\" name=\"" + attrNameVal +"\">";
					if(document.getElementById('attr_relational_table').value == 'users'){						
						StringHTML += "<?=$StringHTMLUser;?>";						
					}else if(document.getElementById('attr_relational_table').value == 'patient_data'){
						StringHTML += "<?=$StringHTMLPatient;?>";												
					}
					StringHTML += "</select>";
				}
				else if(document.getElementById('attr_relational').value == 'n'){
					
					StringHTML += "<select id=\"" + attrNameVal +"\" name=\"" + attrNameVal +"\">";

					var selBox = document.getElementById("attr_list_option");

					for(i=0;i<selBox.options.length;i++){ 
						StringHTML += "<option value='"+ selBox[i].value + "'>"+ selBox[i].value + "</option>";
						
						StringSelect += selBox[i].value;
						
						if(i != (parseInt(selBox.options.length) -1)){
							StringSelect += ","; 
						}
					}
					StringHTML += "</select>";
				}
			}
			else if(document.getElementById('attr_type').value == 'a')
			{
				StringHTML += "<textarea id=\"" + attrNameVal +"\" name=\"" + attrNameVal +"\" row='3' col='4'></textarea>";
			} 
			else if(document.getElementById('attr_type').value == 'f')
			{
				StringHTML += document.getElementById('attr_fixed_text').value;
			} 		
			else if(document.getElementById('attr_type').value == 'c')
			{
				var chkBox = document.getElementById("attr_list_option");
				var j=1;

				for(i=0;i<chkBox.options.length;i++){ 

					
					StringHTML += "<input id=\"" + attrNameVal + "_" + j + "\" name=\"" + attrNameVal + "_" + j + "\"  style='width:20px;' type='checkbox' size='2' value=\""+ chkBox[i].value + "\">";

					StringHTML += chkBox[i].value;

					StringSelect += chkBox[i].value;
						
					if(i != (parseInt(chkBox.options.length) -1)){
						StringSelect += ","; 
					}
					j	=	j + 1;
				}
				
			} 
			else if(document.getElementById('attr_type').value == 'r')
			{
				var rdyBox = document.getElementById("attr_list_option");

				for(i=0;i<rdyBox.options.length;i++){ 
					
					StringHTML += "<input id=\"" + attrNameVal +"\" name=\"" + attrNameVal +"\" type='radio' style='width:20px;' value=\""+ rdyBox[i].value + "\">"+ rdyBox[i].value;

					StringSelect += rdyBox[i].value;
						
					if(i != (parseInt(rdyBox.options.length) -1)){
						StringSelect += ","; 
					}
				}				
				
			} 
			else if(document.getElementById('attr_type').value == 'd')
			{
				StringHTML +=  "<input style='width:150px;' readonly type='text' id=\"" + attrNameVal + "\" name=\"" + attrNameVal +"\" onkeyup='datekeyup(this,mypcc)' onblur='dateblur(this,mypcc)' title='yyyy-mm-dd'><img src='<?php echo $GLOBALS['webroot'] ?>/interface/pic/show_calendar.gif' align='absbottom' width='24' height='22' id='img_" + attrNameVal + "' border='0' alt='[?]' style='cursor:pointer' title='Click here to choose a date' >";			
			} 
							
			StringHTML +=	"</td></tr><tr style='font-size:14px;'><td colspan='2' style='border-width:0px;'><div id='tableDiv' style='display:none;'><table border='1' width='300px' cellpadding='4'><tr style='border:1px solid;font-size:15px;color:#bc1212;background-color:#FFF;'><td colspan='2' align='center'>Attribute Properties</td></tr><tr style='background-color:#CEE4FF;'><td width='140px' style='text-align:center;'><b>Name</b></td><td style='text-align:center;'><b>Value</b></td></tr><tr style='font-size:12px;background-color:#E3EFFF;'><td >Type</td><td>&nbsp;" + attrType + "</td></tr><tr style='font-size:12px;background-color:#FFF;'><td >Required</td><td>&nbsp;" + required + "</td></tr><tr style='font-size:12px;background-color:#E3EFFF;'><td>Max Length</td><td>&nbsp;" + maxLength + "</td></tr><tr style='font-size:12px;background-color:#FFF;'><td>Input validation</td><td>&nbsp;" + attrValidation + "</td></tr></table></div></td></tr></table>";

			if(submit == 'submit'){
				document.getElementById('PreviewAttrb').style.visibility ='hidden';
			}else{
				document.getElementById('PreviewAttrb').style.visibility ='visible';
			}
			document.getElementById('PreviewAttrb').innerHTML	 =  StringHTML;
			document.getElementById('tableDiv').style.display	 =  "inline";
			document.getElementById('attr_html').value			 =	StringHTML;			
			document.getElementById('attr_select_options').value =  StringSelect;
			attrType = document.getElementById('attr_type').value;
			createscriptValidation(attrType,attrNameVal);
		}

		function creatColDRP(){				
			if(document.getElementById('attr_relational_table').value == 'users'){
				document.getElementById('attr_relational_col').value = "userid";												
			}else if(document.getElementById('attr_relational_table').value == 'patient_data'){
				document.getElementById('attr_relational_col').value = "patientid";
			}
		}
		
		function selectPopulate(){		
			<?php
				$i = 0;
				if(isset($arraySelectOptions)){
					foreach($arraySelectOptions as $option){
			?>		
						document.getElementById('attr_list_option').options["<?=$i?>"] = new Option("<?=$option;?>","<?=$option;?>");
			<?php
						$i = $i + 1;	
					}
				}
			?>		
		}

		function showforselect()
		{				
			if(document.getElementById('attr_type').value == 's')
			{					
				document.getElementById('attr_relational').disabled			= false;
				document.getElementById('attr_relational_table').disabled	= false;
				document.getElementById('attr_relational_col').disabled		= false;
				document.getElementById('attr_list_option').disabled		= false;
				document.getElementById('attr_option_txt').disabled			= false;
				document.getElementById('attr_required').disabled			= false;
				document.getElementById('attr_max_length').disabled			= true;
				document.getElementById('attr_validation').disabled			= true;
				document.getElementById('attr_fixed_text').disabled			= true;
				document.getElementById('attr_fixed_text').value			= "";
			
				showForRelational();
				if(document.getElementById('attr_relational').value == 'n'){
					selectPopulate();
				}
			}
			else if(document.getElementById('attr_type').value == 't' || document.getElementById('attr_type').value == 'a')
			{					
				document.getElementById('attr_relational').disabled			= true;
				document.getElementById('attr_relational_table').disabled	= true;
				document.getElementById('attr_relational_col').disabled		= true;
				document.getElementById('attr_max_length').disabled			= false;
				document.getElementById('attr_validation').disabled			= false;
				document.getElementById('attr_required').disabled			= false;
				document.getElementById('attr_list_option').disabled		= true;
				document.getElementById('attr_option_txt').disabled			= true;
				document.getElementById('attr_fixed_text').disabled			= true;

				document.getElementById('attr_relational').value			= "";
				document.getElementById('attr_relational_table').value		= "";
				document.getElementById('attr_relational_col').value		= "";
				document.getElementById('attr_fixed_text').value			= "";
				removeOptions('attr_list_option');
			}	
			else if(document.getElementById('attr_type').value == 'f')
			{					
				document.getElementById('attr_relational').disabled			= true;
				document.getElementById('attr_relational_table').disabled	= true;
				document.getElementById('attr_relational_col').disabled		= true;
				document.getElementById('attr_max_length').disabled			= true;
				document.getElementById('attr_validation').disabled			= true;
				document.getElementById('attr_list_option').disabled		= true;
				document.getElementById('attr_option_txt').disabled			= true;
				document.getElementById('attr_fixed_text').disabled			= false;
				document.getElementById('attr_required').disabled			= true;

				document.getElementById('attr_relational').value			= "";
				document.getElementById('attr_relational_table').value		= "";
				document.getElementById('attr_relational_col').value		= "";
				document.getElementById('attr_max_length').value			= "";
				document.getElementById('attr_validation').value			= "";
				document.getElementById('attr_required').value				= "n";
				removeOptions('attr_list_option');
			}	
			else if(document.getElementById('attr_type').value == 'c' || document.getElementById('attr_type').value == 'r')
			{					
				document.getElementById('attr_relational').disabled			= true;
				document.getElementById('attr_relational_table').disabled	= true;
				document.getElementById('attr_relational_col').disabled		= true;
				document.getElementById('attr_max_length').disabled			= true;
				document.getElementById('attr_validation').disabled			= true;
				document.getElementById('attr_fixed_text').disabled			= true;

				document.getElementById('attr_required').disabled			= false;				
				document.getElementById('attr_list_option').disabled		= false;
				document.getElementById('attr_option_txt').disabled			= false;
				
				document.getElementById('attr_relational').value			= "";
				document.getElementById('attr_relational_table').value		= "";
				document.getElementById('attr_relational_col').value		= "";
				document.getElementById('attr_max_length').value			= "";
				document.getElementById('attr_validation').value			= "";
				document.getElementById('attr_fixed_text').value			= "";
				<?php	if(!isset($arraySelectOptions)){ ?>
							removeOptions('attr_list_option');
				<?php	}else{ ?>
						selectPopulate();
				<?php	} ?>
			}	
			else
			{					
				document.getElementById('attr_relational').disabled			= true;
				document.getElementById('attr_relational_table').disabled	= true;
				document.getElementById('attr_relational_col').disabled		= true;
				document.getElementById('attr_max_length').disabled			= true;
				document.getElementById('attr_validation').disabled			= true;
				document.getElementById('attr_list_option').disabled		= true;
				document.getElementById('attr_option_txt').disabled			= true;
				document.getElementById('attr_fixed_text').disabled			= true;
				document.getElementById('attr_required').disabled			= false;

				document.getElementById('attr_relational').value			= "";
				document.getElementById('attr_relational_table').value		= "";
				document.getElementById('attr_relational_col').value		= "";
				document.getElementById('attr_fixed_text').value			= "";

				removeOptions('attr_list_option');
			}	
			
		}
		function showForRelational()
		{				
			if(document.getElementById('attr_relational').value == 'y')
			{					
				document.getElementById('attr_relational_table').disabled	= false;
				document.getElementById('attr_relational_col').disabled		= false;
				
				document.getElementById('attr_list_option').disabled		= true;
				document.getElementById('attr_option_txt').disabled			= true;

				document.getElementById('attr_max_length').value			= "";
				document.getElementById('attr_validation').value			= "";				
				
				removeOptions('attr_list_option');
				document.getElementById('attr_option_txt').value			= "";

			}
			else if(document.getElementById('attr_relational').value == 'n')
			{					
				
				document.getElementById('attr_relational_table').disabled	= true;
				document.getElementById('attr_relational_col').disabled		= true;
				
				document.getElementById('attr_list_option').disabled		= false;
				document.getElementById('attr_option_txt').disabled			= false;
				
				document.getElementById('attr_max_length').value			= "";
				document.getElementById('attr_validation').value			= "";
				
				
				document.getElementById('attr_relational_table').value		= "";
				document.getElementById('attr_relational_col').value		= "";
			}
			else
			{
				document.getElementById('attr_relational_table').disabled	= true;
				document.getElementById('attr_relational_col').disabled		= true;
				
				document.getElementById('attr_list_option').disabled		= true;
				document.getElementById('attr_option_txt').disabled			= true;
			}	
					
		}
		function showForOptions(){
			if(document.getElementById('attr_relational').value == 'y')
			{
				document.getElementById('relTab').style.display				= "inline";
				document.getElementById('relTabCol').style.display			= "inline";
			}
			else
			{
				document.getElementById('relTab').style.display				= "none";
				document.getElementById('relTabCol').style.display			= "none";
			}			
		}
		function trim(stringToTrim) {
			return stringToTrim.replace(/^\s+|\s+$/g,"");
		}
		
		function addToList()
		{
		  	
			var txtBox = document.getElementById("attr_option_txt");
			var selBox = document.getElementById("attr_list_option");
			//responseValidate	=	validateOnAdd();
			responseValidate = true;
			if(responseValidate){
				txtBoxVal = txtBox.value; 
				if(trim(txtBoxVal) != ""){
					selBox.options[selBox.options.length] = new Option(txtBoxVal, txtBoxVal, false, true);				
				}	
			}
			txtBox.value = "";
			selBox.selectedIndex = "";

		}

		function removeFromList()
		{
			var selBox = document.getElementById("attr_list_option");
			selBox.remove(selBox.selectedIndex);
		}


		function removeOptions(elementId){
			var selBox = document.getElementById(elementId);
			selBox.length = 0;			
		}
		
		function MoveItem(ctrlSource, ctrlTarget) {
			var Source = document.getElementById(ctrlSource);
			var Target = document.getElementById(ctrlTarget);

			if ((Source != null) && (Target != null)) {
				while ( Source.options.selectedIndex >= 0 ) {
					var newOption = new Option(); // Create a new instance of ListItem
					newOption.text = Source.options[Source.options.selectedIndex].text;
					newOption.value = Source.options[Source.options.selectedIndex].value;
					
					Target.options[Target.length] = newOption; //Append the item in Target
					Source.remove(Source.options.selectedIndex);  //Remove the item from Source
				}
			}
		}

		function clickCheckBox(){
			if(document.getElementById("attr_label_show").checked == true)
			{
				document.getElementById("attr_display_label").value = "";
				document.getElementById("attr_display_label").disabled = true;
			}
			else
			{
				document.getElementById("attr_display_label").disabled = false;
			}
		}
		</script>
	</head>
	<body onload='showforselect();'>
		<h2 style='float:left;width:15%;height:30px;margin:0px;'><?php xl("Custom Forms","e"); ?></h2>
		<div style='float:left;width:83%;padding-left:6px;height:30px;margin:0px;'>
			<?php if(isset($error) || isset($_GET['error'])){ ?>
			<div class="errorMsg">
				<?=(isset($response) ? $response : (isset($_GET['response']) ? $_GET['response'] : ''))?>
			</div>
			<?php }else if(isset($success)  || isset($_GET['success'])){ ?>
			<div class="successfullMsg">
				<?=(isset($response) ? $response : (isset($_GET['response']) ? $_GET['response'] : ''))?>
			</div>
			<?php } ?>
		</div>
		<div style="width:60%;float:left;height:90%;">
			<div class="dhx_tabbar_zone dhx_tabbar_zone_dhx_skyblue">
				<div style="height: 24px; top: 0px;" class="dhx_tablist_zone">
					<div style="height: 26px; top: 0px; z-index: 10;" class="dhx_tabbar_row">
						<a href='custom_forms.php' style='text-decoration:none;color:#000;'>
						<div style="width: 200px; height: 26px; top: 0px; left: 5px;" tab_id="a1" class="dhx_tab_element dhx_tab_element_inactive">
							<span style ='margin-top:4px;font-family:arial;font-size:14px;'><?php xl("Forms","e"); ?></span>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -185px; top: 0px; width: 3px; left: 0px;"></div>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -275px; top: 0px; width: 3px; right: 0px;"></div>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -230px; top: 0px; width: 194px; left: 3px;"></div>
						</div>
						</a>
						<a href='listattributes.php' style='text-decoration:none;color:#000;'>
						<div style="width: 200px; height: 26px; top: 0px; left: 204px;" tab_id="a2" class="dhx_tab_element dhx_tab_element_active">
							<span style ='margin-top:4px;font-family:arial;font-size:14px;'><?php xl("Attributes","e"); ?></span>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -185px; top: 0px; width: 3px; left: 0px;"></div>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -275px; top: 0px; width: 3px; right: 0px;"></div>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -230px; top: 0px; width: 194px; left: 3px;"></div>
						</div>
						</a>
					</div>
				</div>
				<div style="background-color: white; width: 100%; top: 24px;border:none;" class="dhx_tabcontent_zone">
					<div tab_id="a1" style="width: 100%; height: 100%;">
						<div style="background-color: white;width:100%  height: 100%;" id="dhxMainCont" class="dhxcont_main_content">
							<!-- Div Start : Header Row -->
							<div class="headerrow">				
							<form name="createAttrb" id="createAttrb" method="post" action="listattributes.php?<?=$pageaction;?>" onsubmit="showAttriutePreview('submit');return validate();">
								<input type='hidden' name='attr_html' id='attr_html'>
								<input type='hidden' name='attr_validation_script' id='attr_validation_script'>
								<input type='hidden' name='attr_select_options' id='attr_select_options' value="<?=(isset($attr_select_options) ? $attr_select_options : '')?>">								
								<input type='hidden' name='attr_id' id='attr_id' value="<?=(isset($_GET['id']) ? $_GET['id'] : '')?>">
								
								<!-- Div Start : Grid Create Form -->
								<div id="gridboxCreatAttr" class="gridbox gridbox_dhx_skyblue">	
								
									<!-- Div Start : Grid XHDR -->
									<div style="overflow: hidden; width: 100%; height: 26px; position: relative;" class="xhdr">

										<table cellspacing="0" cellpadding="0" style="width: 100%; table-layout: fixed; margin-right: 20px; padding-right: 20px;" class="hdr">
										<tbody>
											<tr style="height: auto;">
												<th style="height: 0px; width: 100%;"></th>
											</tr>
											<tr>
												<td style="cursor: default;font-family:arial;font-size:14px;">
													<div class="hdrcell">
														<?=(isset($_GET['id']) ? xl("Edit Attribute","e") : xl("Create Attribute","e"))?>
													</div>
												</td>
											</tr>
										</tbody>
										</table>
									</div>
									<!-- Div End : Grid XHDR -->

									<div style="overflow:auto;height:79%;width: 100%; font:arial; font-size:14px;" class="objbox">
										<table style='width:100%;border-spacing:0px;' cellpadding="4">
											<tbody>	
											<tr>
												<td style='width:18%;'>&nbsp;</td>
												<td style='width:30%;'>&nbsp;</td>
												<td style='width:18%;'>&nbsp;</td>
												<td style='width:21%;'>&nbsp;</td>
												<td style='width:13%;'>&nbsp;</td>
											</tr>
											<tr>
												<td style='padding-left:8px;'><?php xl("Internal Name","e"); ?></td>
												<td>
													<input type='text' name='attr_name' id='attr_name' 
														maxlength=30 
														value="<?= (isset($rowPrev['attr_name']) ? $rowPrev['attr_name'] : '')?>" <?= (isset($rowPrev['attr_name']) && !isset($_GET['error']) ? 'readonly' : '')?>>
												</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
											</tr>
											<tr>
												<td style='padding-left:8px;'><?php xl("Display Caption","e"); ?></td>
												<td>
													<input type='text' name='attr_display_label' id='attr_display_label' 
													maxlength=30 value="<?= (isset($rowPrev['attr_display_label']) ? $rowPrev['attr_display_label'] : '')?>">
												</td>
												<td colspan="2">
													<input type="checkbox" name="attr_label_show" id="attr_label_show" value="n" style ="margin-left:0px;vertical-align:middle;width:15px;" <?=(($rowPrev['attr_label_show'] == 'n') ? "checked" : '')?> onclick="clickCheckBox();">
													<span style="margin:2px;vertical-align:middle;"> 
														<?php xl("Hide Caption","e"); ?> [<?php xl("Display Attribute Control Only","e"); ?>]
													<span> 
												</td>
												
												<td>&nbsp;</td>
											</tr>
											<tr>
												<td style='padding-left:8px;'><?php xl("Type","e"); ?></td>
												<td>
													<select name='attr_type' id='attr_type' onchange="showforselect();">
															<option value="">- <?php xl("select","e"); ?> -</option>
															<option value="t" <?= (isset($rowPrev['attr_type']) && $rowPrev['attr_type'] == 't' ? 'selected' : '')?> ><?php xl("Text Box","e"); ?></option>
															<option value="a" <?= (isset($rowPrev['attr_type']) && $rowPrev['attr_type'] == 'a' ? 'selected' : '')?> ><?php xl("Text Area","e"); ?></option>
															<option value="s" <?= (isset($rowPrev['attr_type']) && $rowPrev['attr_type'] == 's' ? 'selected' : '')?> ><?php xl("Select Box","e"); ?></option>
															<option value="d" <?= (isset($rowPrev['attr_type']) && $rowPrev['attr_type'] == 'd' ? 'selected' : '')?> ><?php xl("Date","e"); ?></option>
															<option value="f" <?= (isset($rowPrev['attr_type']) && $rowPrev['attr_type'] == 'f' ? 'selected' : '')?> ><?php xl("Fixed Text","e"); ?></option>
															<option value="c" <?= (isset($rowPrev['attr_type']) && $rowPrev['attr_type'] == 'c' ? 'selected' : '')?> ><?php xl("Check Box","e"); ?></option>
															<option value="r" <?= (isset($rowPrev['attr_type']) && $rowPrev['attr_type'] == 'r' ? 'selected' : '')?> ><?php xl("Radio Button","e"); ?></option>
													</select>
												</td>
												<td>Fixed Text</td>
												<td><input type="text" id="attr_fixed_text" name="attr_fixed_text" value="<?= (isset($rowPrev['attr_fixed_text']) ? $rowPrev['attr_fixed_text'] : '')?>"></td>
												<td>&nbsp;</td>
											</tr>
											<tr>
												<td style='padding-left:8px;'><?php xl("Is Relational","e"); ?></td>
												<td>
													<select name='attr_relational' id='attr_relational' onchange='showForRelational();'>
														<option value=''>- <?=xl("select","e");?> -</option>
														<option value='y' <?= (isset($rowPrev['attr_relational']) && $rowPrev['attr_relational'] == 'y' ? 'selected' : '')?>><?php xl("Yes","e"); ?></option>
														<option value='n' <?= (isset($rowPrev['attr_relational']) && $rowPrev['attr_relational'] == 'n' ? 'selected' : '')?>><?php xl("Define my own options","e"); ?></option>
													</select></td>
												<td><?php xl("Define Options","e"); ?></td>
												<td><input type='text' name='attr_option_txt' id='attr_option_txt'></td>
												<td>
													<input type='button' name='attr_option_btn' id='attr_option_btn' value="Add" onclick="addToList();" style="width:80px;height:24px;">
												</td>
											</tr>
											<tr>
												<td style='padding-left:8px;'><?php xl("Max Length","e"); ?></td>
												<td>
													<input type='text' name='attr_max_length' id='attr_max_length' 
																		maxlength=11 value="<?= (isset($rowPrev['attr_max_length']) ? $rowPrev['attr_max_length'] : '')?>"></td>
												<td>&nbsp;</td>
												<td ROWSPAN=2>
													<select name='attr_list_option[]' id='attr_list_option' multiple="true" style="height:60px;"></select>
												</td>
												<td><input type='button' name='attr_list_btn' id='attr_list_btn' value="Remove" style="width:80px;height:24px;" onclick="removeFromList();"></td>
											</tr>
											<tr>
												<td style='padding-left:8px;'><?php xl("Input Validations","e"); ?></td>
												<td>
													<select name='attr_validation' id='attr_validation'>
														<option value="">- <?php xl("select","e"); ?> -</option>
														<option value="numeric" <?= (isset($rowPrev['attr_validation']) && $rowPrev['attr_validation'] == 'numeric' ? 'selected' : '')?>><?php xl("Numeric","e"); ?></option>
														<option value="character" <?= (isset($rowPrev['attr_validation']) && $rowPrev['attr_validation'] == 'character' ? 'selected' : '')?>><?php xl("Character","e"); ?></option>
														<option value="alphanum" <?= (isset($rowPrev['attr_validation']) && $rowPrev['attr_validation'] == 'alphanum' ? 'selected' : '')?>><?php xl("Alpha Numeric","e"); ?></option>
														<!--option value="date" <?= (isset($rowPrev['attr_validation']) && $rowPrev['attr_validation'] == 'date' ? 'selected' : '')?>><?php xl("Date Format (mm/dd/yyyy)","e"); ?></option-->
													</select>
												</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
											</tr>
											<tr>
												<td style='padding-left:8px;'><?php xl("Required","e"); ?></td>
												<td>
													<select name='attr_required' id='attr_required' >
														<option value='n' <?= (isset($rowPrev['attr_required']) && $rowPrev['attr_required'] == 'n' ? 'selected' : '')?>><?php xl("No","e"); ?></option>
														<option value='y' <?= (isset($rowPrev['attr_required']) && $rowPrev['attr_required'] == 'y' ? 'selected' : '')?>><?php xl("Yes","e"); ?></option>												
													</select>	
												</td>
												<td><?php xl("Relational Table","e"); ?></td>
												<td>
													<select name='attr_relational_table' id='attr_relational_table' 
															 onchange='creatColDRP();'>
															<option value="">- <?php xl("select","e"); ?> -</option>
															<option value='users' <?= (isset($rowPrev['attr_relational_table']) && $rowPrev['attr_relational_table'] == 'users' ? 'selected' : '')?>>Users</option>
															<option value='patient_data' <?= (isset($rowPrev['attr_relational_table']) && $rowPrev['attr_relational_table'] == 'patient_data' ? 'selected' : '')?>>Patient_Data</option>
													</select></td>
												<td style='width:20%;'>&nbsp;</td>
											</tr>
											<tr>
												<td style='padding-left:8px;'><?php xl("Status","e"); ?></td>
												<td>
													<select name='attr_status' id='attr_status' >
															<option value='y' <?= (isset($rowPrev['attr_status']) && $rowPrev['attr_status'] == 'y' ? 'selected' : '')?>><?php xl("Active","e"); ?></option>
															<option value='n' <?= (isset($rowPrev['attr_status']) && $rowPrev['attr_status'] == 'n' ? 'selected' : '')?>><?php xl("Not Active","e"); ?></option>
														</select>	
												</td>
												<td><?php xl("Relational Column","e"); ?></td>
												<td>
													<select name='attr_relational_col' id='attr_relational_col' >
															<option value="">- <?php xl("select","e"); ?> -</option>
															
															<option value='userid'  <?= (isset($rowPrev['attr_relational_table']) && $rowPrev['attr_relational_table'] == 'users' ? 'selected' : '')?>>Users Name</option>
															<option value='patientid'  <?= (isset($rowPrev['attr_relational_table']) && $rowPrev['attr_relational_table'] == 'patient_data' ? 'selected' : '')?>>Patient Name</option>
														</select></td>
												<td>&nbsp;</td>
											</tr>											
											<tr>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
											</tr>
											<tr>
												<td>&nbsp;</td>
												<td colspan="3">
													<input type='submit' name="<?=$SubmitName?>"  value="<?=$SubmitValue?>"	style='width:90px'/>
													<input type='button' name='previewattr' value='Preview' style='width:90px' onclick='showAttriutePreview();'/>
													<input type='button' name='cancelattr'  value='Cancel'	style='width:90px' 
													onclick = 'javascript:form.submit();'/>
												</td>												
											</tr>
											
											<tr>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
											</tr>
											</tbody>
										</table>
									</div>										
								</div>
								</form>
							</div>	
						</div>
					</div>					
				</div>				
			</div>			
		</div>
		<div style="width:1%;float:left;">&nbsp;</div>	
		<div style="width:37%;float:left;height:90%;">
			<div class="dhx_tabbar_zone dhx_tabbar_zone_dhx_skyblue">&nbsp;
				<div style="height: 24px; top: 0px;" class="dhx_tablist_zone">
					<div style="height: 26px; top: 0px; z-index: 10;" class="dhx_tabbar_row">
						<div style="height: 26px; top: 0px; left: 5px;" tab_id="a1" class="dhx_tab_element dhx_tab_element_inactive">
							<span><?php xl("Preview","e"); ?></span>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -185px; top: 0px; width: 3px; left: 0px;">
							</div>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -275px; top: 0px; width: 3px; right: 0px;">
							</div>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -230px; top: 0px; width: 100%; left: 3px;"></div>
						</div>						
					</div>
				</div>
				
				<div style="background-color: #ECF0F4; height:88%; width: 99%; top: 24px;" class="dhx_tabcontent_zone">
					<div tab_id="a1" style="overflow: hidden;position: absolute; top: 0px; left: 0px; z-index: -1;">
						<div id="dhxMainCont" class="dhxcont_main_content">
							<div id="PreviewAttrb">	</div>
						</div>
						<div id="dhxContBlocker" class="dhxcont_content_blocker" style="display: none;"></div>
					</div>					
				</div>
				
			</div>
			
		</div>
	
	</body>
</html>
