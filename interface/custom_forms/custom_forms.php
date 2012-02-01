<?php

/*************************START : INCLUDE STATEMENTS ********************/
include_once(dirname(__file__)."/../globals.php");
require_once 'class.eyemysqladap.inc.php';
require_once 'class.eyedatagrid.inc.php';
/*************************END : INCLUDE STATEMENTS *********************/

function createDirectoryStructure($formNameInput, $formIdInput, $formHTMLInput,$formDir)
{
	$formName		=	$formNameInput;
	$templatePath	=	$GLOBALS['webserver_root']."/interface/custom_forms/templates/";
	$path			=	$GLOBALS['webserver_root'] ."/interface/forms/". $formDir;
		
	/*$sql			=	"select form_html from csf_forms where form_id	= ".$formIdInput;
	$res			=	sqlStatement($sql);
	$row			=	sqlFetchArray($res);
	$formHTML		=	htmlspecialchars_decode($row['form_html']);*/

	$formHTML		=	htmlspecialchars_decode($formHTMLInput);
	if($_POST['form_active'] == 'y') {
		$formstate = 1;
	}
	else {
		$formstate = 0;
	}
	
	if(is_dir($path))
	{
		
		/** Create Info.txt **/
		createInfoTxt($path, $formName,$formDir);

		/** Create new.php **/
		createNewPHP($path, $formName, $templatePath,$formHTML,$formDir);

		/** Create view.php **/
		createViewPHP($path, $formName, $templatePath,$formDir);
		/** Create save.php **/
		createSavePHP($path, $formName, $templatePath,$formDir);

		/** Create report.php **/
		createReportPHP($path, $formName, $templatePath,$formDir);

		/** Create view_summary.php **/
		createViewSummaryPHP($path, $formName, $templatePath,$formDir);

		/** Create view_summary.php **/
		createFunctionsPHP($path, $formName, $templatePath,$formDir);

		/** Create js.php **/
		createjsPHP($path, $formName, $templatePath,$formDir);

		/** Create delete.php **/
		createDeletePHP($path, $formName, $templatePath,$formDir);
		$sql = "update registry set `state` = $formstate where 	`directory` = ". "'". $formDir . "'";
		$res		= sqlStatement($sql);	
		$response	= "Success: Directory structure updated successfully";
		$success	= true;

	}
	else
	{	
		if(mkdir($path, 0777))
		{
			/** Create Info.txt **/
			createInfoTxt($path, $formName,$formDir);

			/** Create new.php **/
			createNewPHP($path, $formName, $templatePath, $formHTML,$formDir);

			/** Create view.php **/
			createViewPHP($path, $formName, $templatePath,$formDir);

			/** Create save.php **/
			createSavePHP($path, $formName, $templatePath,$formDir);

			/** Create report.php **/
			createReportPHP($path, $formName, $templatePath,$formDir);

			/** Create view_summary.php **/
			createViewSummaryPHP($path, $formName, $templatePath,$formDir);

			/** Create view_summary.php **/
			createFunctionsPHP($path, $formName, $templatePath,$formDir);

			/** Create js.php **/
			createjsPHP($path, $formName, $templatePath,$formDir);

			/** Create delete.php **/
			createDeletePHP($path, $formName, $templatePath,$formDir);
			
			$sqlRegistry = "select * from registry where `directory`			="."'"	. $formDir.	"'";
			$resRegistry = sqlQuery($sqlRegistry);
			
			if($resRegistry['directory']=='') {
				$sql		= "INSERT INTO `registry`	 SET	`name`				=	\"". $formName	."\",
																`state`				=	1,
																`directory`			=	\"". $formDir	."\",
																`sql_run`			=	1,
																`unpackaged`		=	1,
																`date`				=	now(),
																`category`			=   'Custom Forms'";
				$res		= sqlStatement($sql);
			}
			
			$response	= "Success: Directory structure created successfully";
			$success	= true;
		}
		else
		{
			$response	= "Error: error in directory structure creation";
			$error		= true;
		}
	}
}
function createInfoTxt($path, $formName,$formDir)
{
	$file				= $path. '/info.txt';
	$content			= $formName;
	file_put_contents($file, $content, LOCK_EX);
}
function createNewPHP($path, $formName, $templatePath, $formHtml,$formDir)
{
	$file					= $path. '/new.php';
	$fileJS					= $path. "/".$formName.'.js.php';

	/** Get Header **/
	$templateFilePath		 = $templatePath."header.php";
	$contentHeaderString	 = file_get_contents($templateFilePath,true);
	$contentHeaderString	.= " <table 'width=90%' align='center' cellpadding='0' cellspacing='10'><tr><td bgcolor='black' align=center colspan=2><span class=bold><font color=white>".$formName ."</font></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=bold><a class='text' href='".$GLOBALS['webroot']."/interface/patient_file/encounter/encounter_top.php'><font color=white>(Back)</font></a></span></td></tr><tr><td colspan=2>";
	
	$tableHeaderClose = "</td></tr></table><?php include_once('".$fileJS."');?>";
	
	/** Get Footer **/
	$templateFilePath		 = $templatePath."footer.php";
	$contentFooterString	 = file_get_contents($templateFilePath,true);
	
	/** Get Body **/
	$contentBody			 = stripslashes($formHtml);

	/** Final Content **/
	$content				 = $contentHeaderString . "\n" .$contentBody . $tableHeaderClose ."\n" .$contentFooterString;

	file_put_contents($file, $content, LOCK_EX);
	
}
function createViewPHP($path, $formName, $templatePath,$formDir)
{
	$fileView			= $path. '/view.php';

	$fileJS				= $path. "/".$formName.'.js.php';

	$file				= $path. '/view_header.php';
	$templateFilePath	= $templatePath."view_header.php";
	$contentHeaderString= file_get_contents($templateFilePath,true);

	$file				  = $path. '/view_footer.php';
	$templateFilePath	  = $templatePath."view_footer.php";
	
	$contentFooterString  =  file_get_contents($templateFilePath,true);
	$contentFooterString  .="<?php include_once('".$fileJS."');?>";

	$contentBody = " <body  class=body_top onload = 'showPrev();'><table 'width=90%' align='center' cellpadding='0' cellspacing='10'><tr><td bgcolor='black' align=center colspan=2><span class=bold><font color=white>".$formName."</font></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class=bold><a class='text' href='".$GLOBALS['webroot']."/interface/patient_file/encounter/encounter_top.php'><font color=white>(Back)</font></a></span></td></tr><tr><td colspan=2><form name='".$formName."' action='".$GLOBALS['webroot']."/interface/forms/".$formDir."/save.php?update=1' method='POST' onsubmit='return validateForm();'>";
	
	$content			= $contentHeaderString.stripslashes($contentBody).$contentFooterString;	
	file_put_contents($fileView, $content, LOCK_EX);
}
function createSavePHP($path, $formName, $templatePath,$formDir)
{
	$file				= $path. '/save.php';
	$templateFilePath	= $templatePath."save.php";
	$contentString		= file_get_contents($templateFilePath,true);
	$content			= $contentString;
	file_put_contents($file, $content, LOCK_EX);
}
function createReportPHP($path, $formName, $templatePath,$formDir)
{
	$file				= $path. '/report.php';
	$templateFilePath	= $templatePath."report.php";
	$contentString		= file_get_contents($templateFilePath,true);

	$reportFunction		= " function ".$formDir;

	$templateFilePath		= $templatePath."report_function.php";
	$contentfunctionString	= file_get_contents($templateFilePath,true);

	$content			= $contentString . $reportFunction . $contentfunctionString;
	file_put_contents($file, $content, LOCK_EX);
}
function createViewSummaryPHP($path, $formName, $templatePath,$formDir)
{
	$file				= $path. '/view_summary.php';
	$templateFilePath	= $templatePath."view_summary.php";
	$contentString		= file_get_contents($templateFilePath,true);
	$content			= $contentString;
	file_put_contents($file, $content, LOCK_EX);
}
function createjsPHP($path, $formName, $templatePath,$formDir)
{
	$file				= $path. "/".$formName.'.js.php';
	$templateFilePath	= $templatePath."js.php";
	$stringValidation	= "<script> function trim(stringToTrim) {	return stringToTrim.replace(/^\s+|\s+$/g,\"\");	} ";
	$stringValidation	.= " function validateForm(){";
	
	if(isset($_POST['form_attr_count']) && $_POST['form_attr_count'] > 0)
	{
		for($i=1;$i<=$_POST['form_attr_count'];$i++)
		{
			$selectedId = "form_attrb_".$i;
			
			if(!empty($_POST[$selectedId]))
			{
				$sql = "select attr_validation_script,attr_name,attr_type from csf_attributes where attr_id = " . $_POST[$selectedId];
				$res = sqlStatement($sql);
				$row = sqlFetchArray($res);

				$stringValidation .= stripslashes(htmlspecialchars_decode($row['attr_validation_script']));

				if($row['attr_type'] == 'd'){
					$stringValidationDate .= "imgname = \"img_".str_replace(" ","_",$row['attr_name'])."\"; Calendar.setup({inputField:\"" .str_replace(" ","_",$row['attr_name']). "\", ifFormat:'%Y-%m-%d', button:imgname});	";			
				}
			}			
		}
	}
	$stringValidation .=	" }";
	$stringValidation .=	$stringValidationDate ." </script>";
	
	$contentString		= file_get_contents($templateFilePath,true);
	$content			= $stringValidation;
	file_put_contents($file, $content, LOCK_EX);
}
function createFunctionsPHP($path, $formName, $templatePath,$formDir)
{
	$file				= $path. "/functions.php";
	$templateFilePath	= $templatePath."functions.php";
	$contentString		= file_get_contents($templateFilePath,true);
	$content			= $contentString;
	file_put_contents($file, $content, LOCK_EX);
}
function createDeletePHP($path, $formName, $templatePath,$formDir)
{
	$file				= $path. "/delete.php";
	$templateFilePath	= $templatePath."delete.php";
	$contentString		= file_get_contents($templateFilePath,true);
	$content			= $contentString;
	file_put_contents($file, $content, LOCK_EX);
}

if(isset($_POST["addnewform"]))
{	
	$_POST['form_name'] = trim($_POST['form_name']);
	
	$sql = "SELECT count(*) as count from csf_forms
			WHERE form_name		=	\"".  (!empty($_POST['form_name']) ? $_POST['form_name'] : '')	."\"";

	$res = sqlStatement($sql);

	$row = sqlFetchArray($res);
	
	if($row['count'] > 0){
		
		$_GET['error']		= "true";
		$_GET['response']	= "This Form Name is already used, Please enter another name";
		
		$row['form_name']	= (!empty($_POST['form_name']) ? $_POST['form_name'] : '');
		$row['form_active']	= (!empty($_POST['form_active']) ? $_POST['form_active'] : '');
		
		include_once("create_forms.php");
		exit();		
	}
	
	$sql		= " INSERT INTO csf_forms	 
					SET			form_name				=	\"".  $_POST['form_name']				."\",
								form_active				=	\"".  $_POST['form_active']				."\",
								form_html				=	\"". htmlspecialchars($_POST['form_html']) ."\",
								create_date				=	now(),
								modified_date			=	now()";

	$res		= sqlStatement($sql);

	//$lastinertedid	= sqlLastID();

	if($GLOBALS['lastidado'] >0)
		$lastinertedid = $GLOBALS['lastidado'];
	else
		$lastinertedid	=	mysql_insert_id($GLOBALS['dbh']); // last id
	
	echo $lastinertedid;
	if(empty($lastinertedid)) {
		echo "<b>Error: form id was not available; failed to save form.</b><p>";
		exit(1);
	}
	

	$StringHTML		= $_POST['form_html']." <input type='hidden' name='form_id' value='".$lastinertedid."'></form>";

	$sql			 = "UPDATE		csf_forms	 
						SET			form_html	=	\"". htmlspecialchars($StringHTML) ."\" 
						WHERE		form_id		= 	".$lastinertedid;

	$res			= sqlStatement($sql);

	$values			= $_POST['groupid'];

	if(!empty($values)){
	
		foreach ($values as $group){
	 		$sql = "INSERT INTO csf_acl SET form_id = " . $lastinertedid .",groupid	= " . $group;
			$res = sqlStatement($sql);
		}
	}
    
	if(isset($_POST['form_attr_count']) && $_POST['form_attr_count'] > 0)
	{
		for($i=1;$i<=$_POST['form_attr_count'];$i++)
		{
			$selectedId = "form_attrb_".$i;
			$checkId	= "mycheck_".$i;
			$stringCheck = "";

			if($i == 1){
				$k = 1;
				$stringCheck = ",form_attr_row_index = 1";
 			}
			else
			{
				if(isset($_POST[$checkId])){
					
					$stringCheck .= ",form_attr_row_index = ".$k.",form_attr_checked = 1";
				}
				else{
					$k = $k + 1;
					$stringCheck .= ",form_attr_row_index = ".$k;
				}
			}
			
			if(!empty($_POST[$selectedId]))
			{
			 	$sql = "INSERT INTO csf_forms_attributes SET form_id =  ".$lastinertedid." ,attr_id	= " . $_POST[$selectedId].$stringCheck;
				$res = sqlStatement($sql);
			}			
		}
	}
	
	if($res)
	{
		createDirectoryStructure($_POST['form_name'], $lastinertedid, htmlspecialchars_decode($StringHTML),str_replace(" ","_",$_POST['form_name']));
		$response = xl("Form Record Saved Successfully");
		$success = true;
	}
}
else if(isset($_POST["updateform"]))
{
	$_POST['form_name'] = trim($_POST['form_name']);

	$sql	= "Update	csf_forms	SET		form_name				=	\"".  $_POST['form_name']				."\",
											form_active				=	\"".  $_POST['form_active']				."\",
											form_html				=	\"". htmlspecialchars($_POST['form_html']) ."\",
											modified_date			=	now()
									where	form_id					=	".$_POST['form_id'];

	$res	= sqlStatement($sql);

	$values	= $_POST['groupid'];
 
	$sql	= "delete from csf_acl where form_id = " . $_POST['form_id'] ;
	$res	= sqlStatement($sql);

	$sql	= "delete from csf_forms_attributes where form_id = " . $_POST['form_id'] ;
	$res	= sqlStatement($sql);

	if(!empty($values)){
		foreach ($values as $group){
			$sql = "INSERT INTO csf_acl SET form_id = ". $_POST['form_id'] ." , groupid	= " . $group;
			$res = sqlStatement($sql);
		}
    }
	if(isset($_POST['form_attr_count']) && $_POST['form_attr_count'] > 0)
	{	
		for($i=1;$i<=$_POST['form_attr_count'];$i++)
		{

			$selectedId = "form_attrb_".$i;
			$checkId	= "mycheck_".$i;
			$stringCheck = "";
	
			if($i == 1){
				$k = 1;
				$stringCheck = ",form_attr_row_index = 1";
 			}
			else
			{
				if(isset($_POST[$checkId])){
					$stringCheck .= ",form_attr_row_index = ".$k.",form_attr_checked = 1";
				}
				else{
					$k = $k + 1;
					$stringCheck .= ",form_attr_row_index = ".$k;
				}
			}
			
			if(!empty($_POST[$selectedId]))
			{
			 	$sql = "INSERT INTO csf_forms_attributes SET form_id = ".$_POST['form_id']." ,attr_id	= " . $_POST[$selectedId].$stringCheck;
				$res = sqlStatement($sql);
			}		
		}
	}
	$StringHTML		= $_POST['form_html']." <input type='hidden' name='form_id' value='".$_POST['form_id']."'></form>";

	if($res)
	{
		createDirectoryStructure($_POST['form_name'],$_POST['form_id'], htmlspecialchars_decode($StringHTML),str_replace(" ","_",$_POST['form_name']));
		$response = xl("Form Record Updated successfully");
		$success = true;
	}
}
else if(isset($_GET['id']) && !empty($_GET['id']))
{
	
	$sql = "Update csf_forms SET	form_active				=	\"".  $_GET['forms']				."\",
									modified_date			=	now()
							 where	form_id					=	".$_GET['id'];

	$res = sqlStatement($sql);

	if($_GET['forms'] == 'y')
	{
		$state = '1';
	}
	else
	{
		$state = '0';
	}
	$sql = "Update registry SET	state = ".$state."  where name = (select form_name from csf_forms where form_id =".$_GET['id'].")";

	$res = sqlStatement($sql);

	if($res){
		$response = xl("Form Record Updated successfully");
		$success = true;
	}
}
else if(isset($_GET['prev']) && !empty($_GET['prev']))
{
	$sql = "select form_html from csf_forms where form_id	=	".$_GET['prev'];
	$res = sqlStatement($sql);
	$rowPrev = sqlFetchArray($res);	
}
else if(isset($_GET['popup']) && !empty($_GET['frm']))
{
	$sql = "select form_html from csf_forms where form_id	=	".$_GET['frm'];
	$res = sqlStatement($sql);
	$row = sqlFetchArray($res);	
	echo htmlspecialchars_decode($row['form_html']);
	echo "<input type='text' name='formid' value='1'>";
	exit;
}


// Load the database adapter
$db = new EyeMySQLAdap($sqlconf['host'], $sqlconf['login'], $sqlconf['pass'], $sqlconf['dbase']);

// Load the datagrid class
$x = new EyeDataGrid($db);

// Set the query
$x->setQuery("form_id as `ID`, form_name as `Name`,
				case form_active when 'y' then 'Active' else 'Not Active' end as Status, create_date as `Create Date` ", "csf_forms");

if(isset($_GET['page'])){
	$strPage = "page=".$_GET['page']."&";
}
else{
	$strPage = "";
}
if(isset($_GET['order'])){
	$strOrder = "order=".$_GET['order']."&";
}
else{
	$strOrder = "";
}

// Add a row selector
$x->addRowSelect("showFormPreview('%ID%')");

// Add create control
$x->showCreateButton("create_forms.php", "href", 'Add New Form');

// Add standard control
$x->addStandardControl(EyeDataGrid::STDCTRL_EDIT, "create_forms.php?".$strPage."id=%ID%","href");
$x->addStandardControl(EyeDataGrid::STDCTRL_ACTIVATE, "custom_forms.php?".$strPage.$strOrderprev."forms=y&id=%ID%","href");
$x->addStandardControl(EyeDataGrid::STDCTRL_DEACTIVATE, "custom_forms.php?".$strPage.$strOrderprev."forms=n&id=%ID%","href");
$x->hidePageSelectList(true);
// Apply a function to a row
function returnSomething($lastname)
{
	return strrev($lastname);
}
$x->setColumnType('LastName', EyeDataGrid::TYPE_FUNCTION, 'returnSomething', '%LastName%');

/* include header file */
include("header.php");

?>	
	<script>
		function showFormPreview(id){
			location.href = "custom_forms.php?<?=$strPage?><?=$strOrderprev?>prev="+id;							
		}
		function showPrev(){
			document.getElementById('PreviewForm').innerHTML = "<?php echo addslashes(htmlspecialchars_decode($rowPrev['form_html']));?>";
			objs = document.getElementsByTagName("DIV");
			
			for (var i=0; i<objs.length; i++) {
				if (objs[i].id == "tableDiv"){
					objs[i].style.display = "none";
				}				
			}
			document.getElementById('SaveForm').style.display = "none";
		}
	</script>
</head>
<?php	if(isset($_GET['prev'])){?>	<body onload="showPrev();"> <?php } else {?> <body>	<?php } ?>

		<h2 style='float:left;width:15%;height:30px;margin:0px;'><?php xl("Custom Forms","e"); ?></h2>

		<div style='float:left;width:83%;padding-left:6px;height:30px;margin:0px;'>
			<?php if($error){ ?>
			<div class="errorMsg">
				<?php echo $response;;?>
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
				<div style="background-color: white; width: 100%; top: 24px;border:none;" class="dhx_tabcontent_zone">
					<div tab_id="a1" style="overflow: auto; width: 100%; height: 100%;">
						<div style="background-color: white;width:100%  height: 100%;" id="dhxMainCont" class="dhxcont_main_content">
						<?php	$x->printTable();	?></div>
					</div>					
				</div>				
			</div>			
		</div>
		<div style="width:1%;float:left;">&nbsp;</div>	
		<div style="width:37%;float:left;">
			<div class="dhx_tabbar_zone dhx_tabbar_zone_dhx_skyblue">&nbsp;
				<div style="height: 24px; top: 0px;" class="dhx_tablist_zone">
					<div style="height: 26px; top: 0px; z-index: 10;" class="dhx_tabbar_row">
						<div style="height: 26px; top: 0px; left: 5px;" tab_id="a1" class="dhx_tab_element dhx_tab_element_inactive">
							<span>Preview</span>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -185px; top: 0px; width: 3px; left: 0px;"></div>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -275px; top: 0px; width: 3px; right: 0px;"></div>
							<div style="background-image: url(<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/imgs/dhx_skyblue/dhx_skyblue_top.gif); background-position: 0px -230px; top: 0px; width: 100%; left: 3px;"></div>
						</div>						
					</div>
				</div>
				<div style="background-color: #ECF0F4; height: 87%; overflow:auto;width: 99%; top: 24px;" class="dhx_tabcontent_zone">
					<div tab_id="a1" style="overflow: auto; position: absolute; top: 0px; left: 0px; z-index: -1;">
						<div id="dhxMainCont" class="dhxcont_main_content" >
							<div id="PreviewForm"></div>
						</div>						
					</div>					
				</div>				
			</div>
		</div>
	</body>
</html>
