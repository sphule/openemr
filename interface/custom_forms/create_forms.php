<?php

/*************************START : INCLUDE STATEMENTS ********************/
include_once(dirname(__file__)."/../globals.php");
require_once 'class.eyemysqladap.inc.php';
require_once 'class.eyedatagrid.inc.php';
/*************************END : INCLUDE STATEMENTS *********************/

$attributes				= array();
$attributesForms		= array();
$attributesCheckForms	= array();
$attributesFormsNew		= array();
$formsAcl				= array();

$sql					= "SELECT * from csf_attributes where attr_status ='y'";
$res					= sqlStatement($sql);

function array_remove_element($arr, $val){
	foreach ($arr as $key => $value){
		if ($arr[$key] == $val){
			unset($arr[$key]);
		}
	}
	return $arr = array_values($arr);
}

while($row = sqlFetchArray($res)){ 
	$attributes[]=$row; 
}

$SubmitName			= "addnewform";
$SubmitValue		= "Save";

if(isset($_GET["id"]) && !empty($_GET["id"])){

	$sql = "SELECT * from csf_forms WHERE	form_id =	\"".  $_GET['id'] ."\"";
	$res = sqlStatement($sql);	
	$rowPrev = sqlFetchArray($res);

	$sql = "SELECT attr_id,form_attr_checked from csf_forms_attributes WHERE	form_attr_active='y' and form_id =	\"".  $_GET['id'] ."\"";
	$res = sqlStatement($sql);	
	$cnt = 1;
	while ($rowAttr = sqlFetchArray($res)){
		$attributesForms[]		=	$rowAttr['attr_id'];
		$attributesCheckForms[]	=	$rowAttr['attr_id'];
		
		if($rowAttr['form_attr_checked'] == 1){
			$checkArray[] = "mycheck_".	$cnt;
			
		}
		$cnt = $cnt + 1;
	}
	$attributeCounter = count($attributesCheckForms);

	$sql = "SELECT groupid from csf_acl WHERE	form_id =	\"".  $_GET['id'] ."\"";
	$res = sqlStatement($sql);	

	while ($rowAcl = sqlFetchArray($res)){
		$formsAcl[]=$rowAcl['groupid'];
	}
		
	$SubmitName = "updateform";
	$SubmitValue = "Update";

	if(isset($_GET['page'])){	
		$pageaction = "page=".$_GET['page']."&";
	}else{
		$pageaction = "";
	}
	
	
}
if(isset($attributesForms)){
	if(!empty($attributesForms) && count($attributesForms) > 10){
		$rowToShow = count($attributesForms);
	}else{
		$rowToShow = 10;
	}
}
else{
	$rowToShow = 10;
}

/* include header file */
include("header.php");
?>
	<style>
	#AttributeFormPrev td {
		border-width:1px;
		font-family:arial;
	}
	
	</style>
	<script type="text/javascript">
		function fncInputNumericValuesOnly(x)
        {
			var txt = document.getElementById(x).value;
			if(txt.length > 1){
				txt = txt.substr(0,1);
				if(!((txt >= 'a' && txt <= 'z') || (txt >= 'A' && txt <= 'Z')))
					return false;
			}
        }
		function validate(){
		
			if(trim(document.getElementById('form_name').value) == ''){
				alert("Required Fields Missing: Please enter the Form Name");
				return false;
			}
			else{

				regExpString = /^[a-zA-Z0-9 ]*$/;

				if(!regExpString.test(document.getElementById('form_name').value)){
					alert("Invalid Input - Form Name: Please use Alpha numeric");
					return false;
								
				}
				else{ 					
					
					if(fncInputNumericValuesOnly('form_name') == false){
						alert("Invalid Input - Form Name: Please don't use number as first character");
						return false;
					}
				}
			}
			
			countAttribute	=	"<?php echo count($attributes);?>";
			k=0;
			for(i=1;i<=countAttribute;i++){
							
				selectId = "form_attrb_" + i;				
				if(document.getElementById(selectId).value != ""){
					k=1;
				}
			}
			if(k==0){
				alert("Required Fields Missing: Please choose at least one attribute for the Form");
				return false;
			}
			
			/*if(document.getElementById('groupid').value == ''){
				alert("Required Fields Missing: Please Choose the Form Access");
				return false;
			}*/
			if(document.getElementById('form_active').value == ''){
				alert("Required Fields Missing: Please enter the Form Status");
				return false;
			}
			showFormPreview();
			return true;
		}
		
		function checkattribute(selectid){
			
			selectBoxId		=	"form_attrb_" + selectid;

			selectBoxVal	=	document.getElementById(selectBoxId).value;

			countAttribute	=	"<?php echo count($attributes);?>";
			
			for(i=1; i<countAttribute; i++){
				if(i != selectid){
					prevSelectBoxId		=	"form_attrb_" + i;
					prevSelectBoxVal	=	document.getElementById(prevSelectBoxId).value;

					if(prevSelectBoxVal == selectBoxVal && selectBoxVal != ""){
						alert("You have already added this attribute to the form, Please choose different attribute");
						document.getElementById(selectBoxId).value = "";
						return false;					
					}
				}
			}
			countAttribute	=	"<?php echo count($attributes);?>";
			for(k=1;k<=countAttribute; k ++){
				divId = "PrevAttribute_" + k;
				if(document.getElementById(divId) != null){
					document.getElementById(divId).style.visibility = "hidden";
					document.getElementById(divId).style.display = "none";
				}
				
			}
			divId = "PrevAttribute_" + selectBoxVal;
			document.getElementById(divId).style.visibility = "visible";
			document.getElementById(divId).style.display = "inline";
			document.getElementById('PreviewForm').innerHTML = "";
			objs = document.getElementsByTagName("DIV");
			
			for (var i=0; i<objs.length; i++) {
				if (objs[i].id == "tableDiv")
				{
					objs[i].style.display = "inline";
				}
				
			}		

		}
		function trim(stringToTrim) {
			return stringToTrim.replace(/^\s+|\s+$/g,"");
		}
		function showFormPreview()
		{
			var StringHTML;
			var countOnForm;
			var formName;
			var action;

			formName		= trim(document.getElementById("form_name").value);
			action			= "<?echo $rootdir?>/forms/" + formName.replace(/ /g, "_") +"/save.php";
			countOnForm		= 0;
			countAttribute	=	"<?php echo count($attributes);?>";
			StringHTML		= "<form name='" + formName +"' action='" + action + "' method='POST'  onsubmit='return validateForm();'><table style='font-family:arial;font-size:14px;'><tr>";
			
			for(i=1; i<=countAttribute;i++)
			{
				selectBoxId		= "form_attrb_" + i;
				selectBoxVal	= document.getElementById(selectBoxId).value;

				checkBoxId		= "mycheck_" + i;
				checkBox		= document.getElementById(checkBoxId);

				divId			= "PrevAttribute_" + selectBoxVal;

				if(selectBoxVal != "" && i == 1)
				{
					countOnForm = countOnForm + 1;
					StringHTML +="<td style='width:300px;'>"+ trim(document.getElementById(divId).innerHTML) + "</td>";				
				}
				else if(selectBoxVal != "" && i != 1)
				{
					countOnForm = countOnForm + 1;
					if(checkBox.checked == true)
					{
						StringHTML +="<td>" + trim(document.getElementById(divId).innerHTML) + "</td>";
					} 
					else
					{
						StringHTML +="</tr><tr><td>" + trim(document.getElementById(divId).innerHTML) + "</td>";
					}
				}
			
			}
			StringHTML += "</tr><tr><td colspan='2'><input type='submit' id='SaveForm' name='SaveForm' value='Save Form Data'></td></tr></table></td></tr></tbody></table>";
			
			document.getElementById('PreviewForm').innerHTML	=	trim(StringHTML);
			document.getElementById('form_html').value			=	trim(StringHTML);
			document.getElementById('form_attr_count').value	=	countOnForm;
			
			objs = document.getElementsByTagName("DIV");
			
			for (var i=0; i<objs.length; i++) {
				if (objs[i].id == "tableDiv")
				{
					objs[i].style.display = "none";
				}
				
			}
			for(k=1;k<=countAttribute; k ++){
				divId = "PrevAttribute_" + k;
				//objs = document.getElementsByTagName(divId);
				if(document.getElementById(divId) != null){
					document.getElementById(divId).style.visibility = "hidden";
					document.getElementById(divId).style.display = "none";
				}
			}
			//document.getElementById('AttributeFormPrev').innerHTML	= "";
			document.getElementById('SaveForm').style.display = "none";

		}
		function showattrRow(){

			countAttribute	=	"<?php echo count($attributes);?>";
			
			if(document.getElementById('rowshow').value == ""){
				startCount = 10;
				if(parseInt(startCount) + 3 <= parseInt(countAttribute)){
					document.getElementById('rowshow').value = parseInt(startCount) + 3;
				}
				else
				{
					document.getElementById('rowshow').value = parseInt(countAttribute);
				}
				endCount = document.getElementById('rowshow').value;
			}
			else{
				
				startCount	= document.getElementById('rowshow').value;

				if(startCount < 10){
					startCount = 10;
				}

				if(parseInt(startCount) + 3 <= parseInt(countAttribute)){
					document.getElementById('rowshow').value = parseInt(startCount) + 3;
				}
				else
				{
					document.getElementById('rowshow').value = parseInt(countAttribute);
				}
				endCount = document.getElementById('rowshow').value;
			}
			
			for(i=startCount;i<=endCount;i++){							
				
					trId = "attrRow_" + i;
					document.getElementById(trId).style.visibility = "visible";
					document.getElementById(trId).style.display = "";
				
			}
			if(endCount == countAttribute){
				document.getElementById('Moretr').style.display = "none";
			}
		}
	</script>

	</head>
	<body>
		<div>
			<h2 style="float:left;width:15%;height:30px;margin:0px;"><?php xl("Custom Forms","e"); ?></h2>
			<div style="float:left;width:83%;padding-left:6px;height:30px;margin:0px;"></div>
		</div>
		<div style="float:left;width:60%;height:90%;">
			<div class="dhx_tabbar_zone dhx_tabbar_zone_dhx_skyblue">
				<div style="height: 24px; top: 0px;" class="dhx_tablist_zone">
					<div style="height: 26px; top: 0px; z-index: 10;" class="dhx_tabbar_row">
						<a href='custom_forms.php' style='text-decoration:none;color:#000;'>
						<div style="width: 200px; height: 26px; top: 0px; left: 5px;" tab_id="a1" class="dhx_tab_element dhx_tab_element_active">
							<span style ='margin-top:4px;font-family:arial;font-size:14px;'><?php xl("Forms","e"); ?></span>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -185px; top: 0px; width: 3px; left: 0px;"></div>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -275px; top: 0px; width: 3px; right: 0px;"></div>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -230px; top: 0px; width: 194px; left: 3px;"></div>
						</div>
						</a>
						<a href='listattributes.php' style='text-decoration:none;color:#000;'>
						<div style="width: 200px; height: 26px; top: 0px; left: 204px;" tab_id="a2" class="dhx_tab_element dhx_tab_element_inactive">
							<span style ='margin-top:4px;font-family:arial;font-size:14px;'><?php xl("Attributes","e"); ?></span>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -185px; top: 0px; width: 3px; left: 0px;"></div>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -275px; top: 0px; width: 3px; right: 0px;"></div>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -230px; top: 0px; width: 194px; left: 3px;"></div>
						</div>
						</a>
					</div>
				</div>
				<div style="background-color: #fff; width: 100%; height:100%; top: 24px;" class="dhx_tabcontent_zone">
					<div tab_id="a1" style="overflow:auto; width:100%; height: 100%;">
						<div style="background-color: white;width:100%;height: 100%;overflow:auto;" id="dhxMainCont" class="dhxcont_main_content">
							<!-- Div Start : Header Row -->
							<div class="headerrow">				
								<form name="createForm" id="createForm" method="post" action="custom_forms.php?<?=$pageaction;?>" onsubmit='showFormPreview();return validate();'>
								<input type='hidden' name='form_html' id='form_html'>
								<input type='hidden' name='form_attr_count' id='form_attr_count'>
								<input type='hidden' name='form_id' id='form_id' value="<?=(isset($_GET['id']) ? $_GET['id'] : '')?>">
								<!-- Div Start : Grid Create Form -->
								<div id="gridboxCreatAttr" class="gridbox gridbox_dhx_skyblue">	
								
									<!-- Div Start : Grid XHDR -->
									<div style="overflow: hidden; width: 100%; height: 26px; position: relative;" class="xhdr">
										<table cellspacing="0" cellpadding="0" style="width: 100%; table-layout: fixed; margin-right: 20px; padding-right: 20px;" class="hdr">
										<tbody>
											<tr style="height: auto;"><th style="height: 0px; width: 100%;"></th></tr>
											<tr><td style="cursor: default;font-family:arial;font-size:14px;"><div class="hdrcell"><?=(isset($_GET['id']) ? xl("Edit Form","e") : xl("Create Form","e"))?></div></td></tr>
										</tbody>
										</table>
									</div>
									<!-- Div End : Grid XHDR -->

									<div style="overflow: auto; width: 100%; font:arial; font-size:14px;" class="objbox">
										<table cellspacing="4" style="width: 100%; table-layout: fixed;" class="obj row20px">
											<tbody>
											<tr>
												<td style='width:15%;vertical-align:top;font-family:arial;font-size:11px;'><?php xl("Name","e"); ?></td>
												<td style='width:84%;padding-left:5px;'>
													<input type='text' name='form_name' id='form_name' maxlength=100 
													style="width:150px;"
													value="<?= (isset($rowPrev['form_name']) ? $rowPrev['form_name'] : '')?>" <?= (isset($rowPrev['form_name']) && !isset($_GET['error']) ? 'readonly' : '')?>>
												</td>
											</tr>
											<tr>
												<td style='width:15%;vertical-align:top;font-family:arial;font-size:11px;'><?php xl("Choose Attributes","e"); ?></td>
												<td style='width:84%;'>
													<table>
													<tr>
														<td style='width:42%;vertical-align:top;padding-left:0px;'>
															<div class="gridbox gridbox_dhx_skyblue" id="gridbox2" style="overflow: auto; background-color: white; cursor: default;">
																<div class="xhdr" style="overflow: hidden; width: 100%; height: 25px; position: relative;">
																	<table class="hdr" style="width: 100%; table-layout: fixed; margin-right: 20px; " cellpadding="0" cellspacing="0">
																	<tbody>
																		<tr style="height: auto;">
																			<th style="height: 0px; width: 70%;"></th>
																			<th style="height: 0px; width: 29%;"></th>
																		</tr>
																		<tr>
																			<td style="vertical-align: middle;padding-left:10px;font-family:arial;font-size:11px;">
																				<?php xl("Attribute Name","e"); ?>
																			</td>
																			<td style="vertical-align: middle;font-family:arial;font-size:11px;">
																				<?php xl("Same Row","e"); ?>
																			</td>
																		</tr>
																	</tbody>
																	</table>
																</div>
																<div class="objbox" style="height: 175px; overflow: auto; width: 100%;">
																	<table class="obj row20px" style="width: 100%; table-layout: fixed;" cellpadding="0" cellspacing="0">
																	<tbody>
																		<tr style="height: auto;">
																			<th style="width: 82%;"></th>
																			<th style="width: 18%;"></th>
																		</tr>	
																		<?php 
																			
																			$i=1;	
																			$j=0;
																			
																			foreach($attributes as $row){
																				
																				if($i % 2 == 0)
																				{
																					$class = "odd_dhx_skyblue";
																				}
																				else
																				{
																					$class = "ev_dhx_skyblue";
																				}	
																		?>

																		<tr id="attrRow_<?=$i?>"  class="<?=$class?>" 
																		 style="height:29px;width:200px;<?=(($i > $rowToShow) ? "visibility:hidden;display:none;" : '')?>" >
																			<td style='width:82%;' valign="middle" align="left">
																				<select name="form_attrb_<?=$i?>" id="form_attrb_<?=$i?>" 
																					onchange='checkattribute("<?=$i?>");'  style='width:140px;'>
																					<option value=''>- <?php xl("select","e"); ?> -</option>
																					<?php
																					$j=0;
																					
																					foreach($attributes as $row){
																						
																					?>
																						<option value="<?=$row['attr_id'];?>" <?=(($row['attr_id'] == $attributesForms[0]) && $j== 0 ? 'selected' : '')?>>
																						<?=$row['attr_name'];?></option>

																					<?php 
																						if($j == 0 && ($row['attr_id'] == $attributesForms[0])){
																							
																							$j = 1;
																																																$attributesForms =  array_remove_element($attributesForms, $attributesForms[0]); 
																							
																						}		
																					}

												
																					//$attributesForms = array_slice($attributesForms, 1);
																					//array_shift($attributesForms);

																					
																					?>
																				</select>
																				
																			</td>
																			<td style='width: 18%;'>
																			
		<input type="checkbox" name="mycheck_<?=$i;?>" id="mycheck_<?=$i;?>" style="width:20px;padding:0px;margin:0px;" <?=(($i == 1) ? 'disabled' : '') ;?>"  <?=((isset($checkArray) && in_array("mycheck_".$i,$checkArray)) ? 'checked' : '') ?>/>
																			</td>
																		</tr>
																		<?php
																		if($i == count($attributes) && $i >$rowToShow){
																		?>
																			<tr id="Moretr">
																				<td colspan='2' align='right' style='font-family:arial;text-decoration:underline;cursor:pointer;cursor:hand;' onclick='showattrRow();'>Add More Attributes</td></tr>
																		<?php
																		}
																		?>	
																		<?php 
																			
																				$i	=	$i + 1;
																				
																				
																				
																			}
																		?>	
																	</tbody>
																	</table>
																</div>
															</div>
														</td>
														<td style='width:58%;'>
															<div class="gridbox gridbox_dhx_skyblue" id="gridbox3" style=" height: 198px; background-color: white; cursor: default;">
																<div class="xhdr" style=" width: 100%; height: 25px; position: relative;">
																  <img src="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxGrid/codebase/imgs/sort_desc.gif" style="display: none; position: absolute;">
																<table class="hdr" style="width: 100%; table-layout: fixed; " cellpadding="0" cellspacing="0">
																<tbody>
																<tr style="height: auto;" class="odd_dhx_skyblue">
																<th style="height: 0px;font-family:arial;font-size:11px;"><?php xl("Attribute Details","e"); ?></th>
																</tr>
																</tbody>
																</table>
																</div>
																<div style="width:99%;height:172px;overflow-y:auto;" id="AttributeFormPrev">
																<?php 

																$j=1;

																foreach($attributes as $row)
																{ 
																?>
																	<div id="PrevAttribute_<?=$row['attr_id']?>" class="objbox" style="display:none;">
																		<?=htmlspecialchars_decode($row['attr_html']);?>
																	</div>
																<?php 
																	$j= $j + 1;
																} 
																?>
																</div>
															</div>
														</td>
													</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td style='width:15%;vertical-align:top;font-family:arial;font-size:11px;'><?php xl("Access Control","e"); ?></td>
												<td style='width:84%;padding-left:5px;'>
												<select name="groupid[]" id="groupid[]" multiple="true" style="width:150px;">
													<option value='5' <?=(in_array('5',$formsAcl) ? 'selected' : '')?>><?php xl("Accounting","e"); ?></option>
													<option value='1' selected><?php xl("Administrators","e"); ?></option>
													<option value='2' <?=(in_array('2',$formsAcl) ? 'selected' : '')?>><?php xl("Physicians","e"); ?></option>
													<option value='3' <?=(in_array('3',$formsAcl) ? 'selected' : '')?>><?php xl("Clinicians","e"); ?></option>
													<!--option value='4' <?=(in_array('4',$formsAcl) ? 'selected' : '')?>><?php xl("Front Office","e"); ?></option-->
												</select>
												</td>
											</tr>
											<tr>
												<td style='width:15%;vertical-align:top;font-family:arial;font-size:11px;'><?php xl("Status","e"); ?></td>
												<td style='width:84%;padding-left:5px;'>
												<select name='form_active' id='form_active' style="width:150px;">
													<option value='y' <?= (isset($rowPrev['form_active']) && $rowPrev['form_active'] == 'y' ? 'selected' : '')?>><?php xl("Active","e"); ?></option>
													<option value='n' <?= (isset($rowPrev['form_active']) && $rowPrev['form_active'] == 'n' ? 'selected' : '')?>><?php xl("Not Active","e"); ?></option>
												</select>
												</td>
											</tr>
											<tr>
												<td colspan=2 style='padding-left:127px;'><br>
													<input type='submit' name="<?=$SubmitName?>"  value="<?=$SubmitValue?>"		style='width:90px'/>
													<input type='button' name='previewform' value='Preview' style='width:90px'
													onclick='showFormPreview();'/>
													<input type='button' name='cancelform'  value='Cancel'	style='width:90px' 
													onclick = 'javascript:form.submit();'/>
													
												</td>
											</tr>
											<tr>
												<td style='width:20%;vertical-align:middle;'>&nbsp;</td>
												<td style='width:90%'>&nbsp;</td>
											</tr>
											</tbody>
										</table>
									</div><input type='hidden' name='rowshow' id='rowshow' value = "<?=(isset($attributeCounter) ? $attributeCounter : '')?>">						
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
							<div style="background-image: url(<?php echo $GLOBALS['web_root']; ?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -185px; top: 0px; width: 3px; left: 0px;">
							</div>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -275px; top: 0px; width: 3px; right: 0px;">
							</div>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -230px; top: 0px; width: 100%; left: 3px;"></div>
						</div>						
					</div>
				</div>				
				<div style="background-color: #ECF0F4; overflow:auto;height:87%; width: 99%; top: 24px;" class="dhx_tabcontent_zone">
					<div tab_id="a1" style="overflow: auto;position: absolute; top: 0px; left: 0px; z-index: -1;">
						<div id="dhxMainCont" class="dhxcont_main_content">
							<div id="PreviewForm"></div>
						</div>
						<div id="dhxContBlocker" class="dhxcont_content_blocker" style="display: none;"></div>
					</div>					
				</div>				
			</div>			
		</div>	
	</body>
</html>
