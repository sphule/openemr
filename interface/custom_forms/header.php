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
		<script  src="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxGrid/codebase/dhtmlxcommon.js"></script>
		<script  src="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxGrid/codebase/dhtmlxgrid.js"></script>        
		<script  src="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxGrid/codebase/dhtmlxgridcell.js"></script>
		<script  src="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxDataProcessor/codebase/dhtmlxdataprocessor.js"></script>
		<script  src="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxGrid/codebase/ext/dhtmlxgrid_drag.js"></script>
		<script  src="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxGrid/codebase/ext/dhtmlxgrid_pgn.js"></script>
		<script  src="<?php echo $GLOBALS['web_root'];?>/library/dhtmlxSuite/dhtmlxTabbar/codebase/dhtmlxtabbar.js"></script>
