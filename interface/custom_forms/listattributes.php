<?php

/*************************START : INCLUDE STATEMENTS ********************/
include_once(dirname(__file__)."/../globals.php");
require_once 'class.eyemysqladap.inc.php';
require_once 'class.eyedatagrid.inc.php';
/*************************END : INCLUDE STATEMENTS *********************/

if(isset($_POST["addnewattr"])){

	$_POST['attr_name']	= trim($_POST['attr_name']);

	$sql = "SELECT count(*) as count from csf_attributes
			WHERE attr_name		=	\"".  (!empty($_POST['attr_name']) ? $_POST['attr_name'] : '')	."\"";

	$res = sqlStatement($sql);

	$row = sqlFetchArray($res);

	if($row['count'] > 0){
		
		$_GET['error']		= "true";
		$_GET['response']	= "This Attribute Name is already used, Please enter another name";
		
		$row['attr_name']	= (!empty($_POST['attr_name']) ? $_POST['attr_name'] : '');
		$row['attr_type']	= (!empty($_POST['attr_type']) ? $_POST['attr_type'] : '');
		$row['attr_max_length']	= (!empty($_POST['attr_max_length']) ? $_POST['attr_max_length'] : '');
		$row['attr_required']	= (!empty($_POST['attr_required']) ? $_POST['attr_required'] : '');
		$row['attr_validation']	= (!empty($_POST['attr_validation']) ? $_POST['attr_validation'] : '');
		$row['attr_relational']	= (!empty($_POST['attr_relational']) ? $_POST['attr_relational'] : '');
		$row['attr_relational_table']	= (!empty($_POST['attr_relational_table']) ? $_POST['attr_relational_table'] : '');
		$row['attr_relational_col']	= (!empty($_POST['attr_relational_col']) ? $_POST['attr_relational_col'] : '');
		$row['attr_status']	= (!empty($_POST['attr_status']) ? $_POST['attr_status'] : '');
		include_once("create_attribute.php");
		exit();		
	}

	$sql = "INSERT INTO csf_attributes
			SET			attr_name				=	\"".  (!empty($_POST['attr_name']) ? $_POST['attr_name'] : '')	."\",
						attr_display_label		=	\"".  (!empty($_POST['attr_display_label']) ? $_POST['attr_display_label'] : '')	."\",
						attr_type				=	\"".  (!empty($_POST['attr_type']) ? $_POST['attr_type'] : '') ."\",";

					if(!empty($_POST['attr_max_length'])  || $_POST['attr_max_length'] == "0"){

						$sql .="attr_max_length			=	  ".  $_POST['attr_max_length'] .",";
					}
					if(isset($_POST['attr_select_options']) && !empty($_POST['attr_select_options'])){
							
							$sql .="attr_select_options			=	  \"".  $_POST['attr_select_options'] ."\",";
						
					}
					
			$sql .="attr_required			=	\"".  (!empty($_POST['attr_required']) ? $_POST['attr_required'] : 'n')	 ."\",
					attr_validation			=	\"".  (!empty($_POST['attr_validation']) ? $_POST['attr_validation'] : '') ."\",
					attr_relational			=	\"".  (!empty($_POST['attr_relational']) ? $_POST['attr_relational'] : '') ."\",
					attr_relational_table	=	\"".  (!empty($_POST['attr_relational_table']) ? $_POST['attr_relational_table'] : '') ."\",
					attr_relational_col		=	\"".  (!empty($_POST['attr_relational_col']) ? $_POST['attr_relational_col'] : '') ."\",
					attr_fixed_text			=	\"".  (!empty($_POST['attr_fixed_text']) ? $_POST['attr_fixed_text'] : '') ."\",
					attr_status				=	\"".  (!empty($_POST['attr_status']) ? $_POST['attr_status'] : 'n')	."\",
					attr_label_show			=	\"".  (!empty($_POST['attr_label_show']) ? $_POST['attr_label_show'] : 'y')	 ."\",
					attr_html				=   \"".  htmlspecialchars($_POST['attr_html']) ."\",
					attr_validation_script	=   \"".  htmlspecialchars(addslashes($_POST['attr_validation_script'])) ."\",
					create_date				=	now(),
					modify_date				=	now()";

	$res			= sqlStatement($sql);
	//$lastinertedid	= sqlLastID();

	if($GLOBALS['lastidado'] >0)
		$lastinertedid = $GLOBALS['lastidado'];
	else
		$lastinertedid	=	mysql_insert_id($GLOBALS['dbh']); // last id
	
	
	if(empty($lastinertedid)) {
		echo "<b>Error: attribute id was not available; failed to save form.</b><p>";
		exit(1);
	}

	$sql			= "Update csf_attributes SET attr_index = ".$lastinertedid." Where attr_id = ".$lastinertedid;
	$res			= sqlStatement($sql);

	if($res){
		
		$sql = "ALTER TABLE csf_form_data ADD COLUMN `attribute_".$lastinertedid."` longtext";
		$res = sqlStatement($sql);

		$response = xl("Attribute Record Saved Successfully");
		$success = true;
	}

}
else if(isset($_POST["updateattr"])){
	
	$_POST['attr_name']	= trim($_POST['attr_name']);echo $_POST['attr_max_length'];
	
	$sql = "	UPDATE	csf_attributes 
				SET		attr_name				=	\"".  (!empty($_POST['attr_name']) ? $_POST['attr_name'] : '')	."\",
						attr_display_label		=	\"".  (!empty($_POST['attr_display_label']) ? $_POST['attr_display_label'] : '')	."\",
						attr_type				=	\"".  (!empty($_POST['attr_type']) ? $_POST['attr_type'] : '') ."\",";
						
						if(!empty($_POST['attr_max_length']) || $_POST['attr_max_length'] == "0"){
							
							$sql .="attr_max_length			=	  ".  $_POST['attr_max_length'] .",";

						}
						
						if(isset($_POST['attr_select_options']) && !empty($_POST['attr_select_options'])){
							
							$sql .="attr_select_options			=	  \"".  $_POST['attr_select_options'] ."\",";
						
						}
						
				$sql .="attr_required			=	\"".  (!empty($_POST['attr_required']) ? $_POST['attr_required'] : 'n')	 ."\",
						attr_validation			=	\"".  (!empty($_POST['attr_validation']) ? $_POST['attr_validation'] : '') ."\",
						attr_relational			=	\"".  (!empty($_POST['attr_relational']) ? $_POST['attr_relational'] : '') ."\",
						attr_relational_table	=	\"".  (!empty($_POST['attr_relational_table']) ? $_POST['attr_relational_table'] : '') ."\",
						attr_relational_col		=	\"".  (!empty($_POST['attr_relational_col']) ? $_POST['attr_relational_col'] : '') ."\",
						attr_fixed_text			=	\"".  (!empty($_POST['attr_fixed_text']) ? $_POST['attr_fixed_text'] : '') ."\",
						attr_status				=	\"".  (!empty($_POST['attr_status']) ? $_POST['attr_status'] : 'n')	."\",
						attr_label_show			=	\"".  (!empty($_POST['attr_label_show']) ? $_POST['attr_label_show'] : 'y')	 ."\",
						attr_html				=   \"".  htmlspecialchars($_POST['attr_html']) ."\",
						attr_validation_script	=   \"".  htmlspecialchars(addslashes($_POST['attr_validation_script'])) ."\",
						create_date				=	now(),
						modify_date				=	now()
				WHERE	attr_id					=	".$_POST['attr_id'];

	$res = sqlStatement($sql);

	if($res){
		$response = xl("Attribute Record Updated successfully");
		$success = true;
	}
}
else if(isset($_GET['id']) && !empty($_GET['id']))
{
	$sql = "UPDATE	csf_attributes 
			SET		attr_status				=	\"".  $_GET['attrs'] ."\",
					modify_date				=	now()
			WHERE	attr_id					=	".$_GET['id'];

	$res = sqlStatement($sql);

	if($res){
		$sql = "UPDATE	csf_forms_attributes SET	form_attr_active		=	\"".  $_GET['attrs'] ."\",
													modified_date			=	now()
											 WHERE	attr_id					=	".$_GET['id'];

		$res = sqlStatement($sql);
		$response = xl("Attribute Record Updated successfully");
		$success = true;
	}
}
else if(isset($_GET['prev']) && !empty($_GET['prev']))
{
	$sql = "SELECT attr_html FROM csf_attributes WHERE attr_id	=	".$_GET['prev'];
	$res = sqlStatement($sql);
	$rowPrev = sqlFetchArray($res);	
}

// Load the database adapter
$db = new EyeMySQLAdap($sqlconf['host'], $sqlconf['login'], $sqlconf['pass'], $sqlconf['dbase']);

// Load the datagrid class
$x = new EyeDataGrid($db);

//attr_html as `HTML View`
$x->setQuery("	attr_id as `ID`,
				case attr_display_label when  '' then attr_name when (NULL) then attr_name else attr_display_label end as `Name`, 
				case attr_type when 't' then 'Text Box' when 's' then 'Select Box' when 'a' then 'Text Area' when 'd' then 'Date' when 'f' then 'Free Text' when 'c' then 'Check Box' when 'r' then 'Radio Button' end as `Type`, 
				case attr_status when 'y' then 'Active' else 'Not Active' end as Status, create_date as `Create Date`", 
				"csf_attributes");

if(isset($_GET['page'])){
	$strPage = "page=".$_GET['page']."&";
}
else{
	$strPage = "";
}
if(isset($_GET['order'])){
	$strOrder = "order =".$_GET['order']."&";
}
else{
	$strOrder = "";
}
// Add a row selector
$x->addRowSelect("showAttriutePreview('%ID%')");

// Add create control
$x->showCreateButton("create_attribute.php",  "href", 'Add New Attribute');

// Add standard control
$x->addStandardControl(EyeDataGrid::STDCTRL_EDIT, "create_attribute.php?".$strPage."id=%ID%","href");
$x->addStandardControl(EyeDataGrid::STDCTRL_ACTIVATE, "listattributes.php?".$strPage."attrs=y&id=%ID%","href");
$x->addStandardControl(EyeDataGrid::STDCTRL_DEACTIVATE, "listattributes.php?".$strPage."attrs=n&id=%ID%","href");
$x->hidePageSelectList(true);	

// Apply a function to a row
function returnSomething($lastname)
{
	return strrev($lastname);
}

//$x->setColumnType('LastName', EyeDataGrid::TYPE_FUNCTION, 'returnSomething', '%LastName%');

?>
<html>
	<head>
		<title><?php xl("Custom Forms","e"); ?></title>		
		<link rel="STYLESHEET" type="text/css" href="table.css" >
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
		<script  src="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
		<script  src="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxGrid/codebase/dhtmlxgrid.js"></script>        
		<script  src="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>
		<script  src="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxDataProcessor/codebase/dhtmlxdataprocessor.js"></script>
		<script  src="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxGrid/codebase/ext/dhtmlxgrid_drag.js"></script>
		<script  src="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxGrid/codebase/ext/dhtmlxgrid_pgn.js"></script>
		<script  src="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/dhtmlxtabbar.js"></script>	
		<script>
			function showAttriutePreview(id){
				location.href = "listattributes.php?<?=$strPage?><?=$strOrderprev?>prev="+id;							
			}
			function showPrev(){
				document.getElementById('PreviewAttrb').innerHTML = "<?php echo addslashes(htmlspecialchars_decode($rowPrev['attr_html'])); ?>";
				document.getElementById('tableDiv').style.display ="inline"; 
			}
		</script>
	</head>
	<?php 
		if(isset($_GET['prev'])){
	?>		<body onload="showPrev();">
	<?php } else {?>
			<body>
	<?php }?>

		<h2 style='float:left;width:15%;height:30px;margin:0px;'><?php xl("Custom Forms","e"); ?></h2>

		<div style='float:left;width:83%;padding-left:6px;height:30px;margin:0px;'>
			<?php if($error){ ?>
			<div class="errorMsg">
				<?php echo $response;?>
			</div>
			<?php }else if($success){ ?>
			<div class="successfullMsg">
				<?php echo $response;;?>
			</div>
			<?php } ?>
		</div>
		<div style="width:60%;float:left;height:100%;">
			<div class="dhx_tabbar_zone dhx_tabbar_zone_dhx_skyblue">
				<div style="height: 24px; top: 0px;" class="dhx_tablist_zone">
					<div style="height: 26px; top: 0px; z-index: 10;" class="dhx_tabbar_row">
						<a href='custom_forms.php' style='text-decoration:none;color:#000;'>
						<div style="width: 200px; height: 26px; top: 0px; left: 5px;" tab_id="a1" class="dhx_tab_element dhx_tab_element_inactive">
							<span style ='margin-top:4px;font-family:arial;font-size:14px;'>Forms</span>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -185px; top: 0px; width: 3px; left: 0px;"></div>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -275px; top: 0px; width: 3px; right: 0px;"></div>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -230px; top: 0px; width: 194px; left: 3px;"></div>
						</div>
						</a>
						<a href='listattributes.php' style='text-decoration:none;color:#000;'>
						<div style="width: 200px; height: 26px; top: 0px; left: 204px;" tab_id="a2" class="dhx_tab_element dhx_tab_element_active">
							<span style ='margin-top:4px;font-family:arial;font-size:14px;'>Attributes</span>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -185px; top: 0px; width: 3px; left: 0px;"></div>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -275px; top: 0px; width: 3px; right: 0px;"></div>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -230px; top: 0px; width: 194px; left: 3px;"></div>
						</div>
						</a>
					</div>
				</div>
				<div style="background-color: white; width: 100%; top: 24px;border:none;" class="dhx_tabcontent_zone">
					<div tab_id="a1" style="overflow: auto; width: 100%; height: 100%;">
						<div style="background-color: white;width:100%  height: 100%;" id="dhxMainCont" class="dhxcont_main_content"><?php	$x->printTable();	?></div>
					</div>					
				</div>				
			</div>			
		</div>
		
		<div style="width:1%;float:left;">&nbsp;</div>	
		<div style="width:37%;float:left;">
			<div class="dhx_tabbar_zone dhx_tabbar_zone_dhx_skyblue">
				<div style="height: 24px; top: 0px;" class="dhx_tablist_zone">
					<div style="height: 26px; top: 0px; z-index: 10;" class="dhx_tabbar_row">
						<div style="height: 26px; top: 0px; left: 5px;" tab_id="a1" class="dhx_tab_element dhx_tab_element_inactive">
							<span>Preview</span>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -185px; top: 0px; width: 3px; left: 0px;">
							</div>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -275px; top: 0px; width: 3px; right: 0px;">
							</div>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -230px; top: 0px; width: 100%; left: 3px;"></div>
						</div>						
					</div>
				</div>
				<div style="background-color: #ECF0F4; width: 99%; height:87%; top: 24px;" class="dhx_tabcontent_zone">
					<div tab_id="a1" style="overflow: hidden;position: absolute; top: 0px; left: 0px; z-index: -1;">
						<div id="dhxMainCont" class="dhxcont_main_content">
							<div id="PreviewAttrb"></div>
						</div>
						<div id="dhxContBlocker" class="dhxcont_content_blocker" style="display: none;"></div>
					</div>
					
				</div>				
			</div>
			
		</div>
	</body>
</html>
