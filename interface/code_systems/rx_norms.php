<?php
/*******************************************************
This file allows the user to manage the NDC directory
Download archive, create tables, load data
View filesize, table cont and the date/time of the last updates
********************************************************/

//SANITIZE ALL ESCAPES
$sanitize_all_escapes=true;
//

//STOP FAKE REGISTER GLOBALS
$fake_register_globals=false;
//

require_once("../../interface/globals.php");
require_once("$srcdir/sql.inc");
require_once("$srcdir/rxnorms_capture.inc");

?>
<html>
<head>
<?php html_header_show();?>
<title><?php echo htmlspecialchars( xl('RxNorm'), ENT_NOQUOTES); ?></title>
<link rel="stylesheet" href='<?php echo $css_header ?>' type='text/css'>

<style>
td, input, select, textarea {
 font-family: Arial, Helvetica, sans-serif;
 font-size: 10pt;
}

div.section {
 border: solid;
 border-width: 1px;
 border-color: #0000ff;
 margin: 0 0 0 10pt;
 padding: 5pt;
}
</style>

<style type="text/css" title="mystyles" media="all">
<!--
td {
    vertical-align:Top;
    font-size:8pt;
    font-family:helvetica;
}
input {
    font-size:8pt;
    font-family:helvetica;
}
select {
    font-size:8pt;
    font-family:helvetica;
}
textarea {
    font-size:8pt;
    font-family:helvetica;
}
div.ndc {
    vertical-align:Top;
}
div.ndc table {
    vertical-align:Top;
    horizontal-align:Center;
}
div.ndc td {
    vertical-align:Top;
    horizontal-align:Center;
}
div.header {
    margin:0px;
    padding:3px;
    text-align:Left;
    background:#fff;
    border:solid 1px #c3c3c3;
    font-size:10pt;
    font-family:helvetica;
}
div.file_list,#list_heading {
    margin:0px;
    width:394px;
    padding:4px;
    horizontal-align:Center;
    vertical-align:Top;
    text-align:Left;
    background:#fff;
    border-top:solid 1px #c3c3c3;
    border-left:solid 1px #c3c3c3;
    border-right:solid 1px #c3c3c3;
    font-size:10pt;
    font-family:helvetica;
}
div.file_list {
    background:#ffd;
    vertical-align:Top;
    horizontal-align:Center;
    
    border-bottom:solid 1px #c3c3c3;
}
div.file_list tr {
    background:#ddd;
    font-size:9pt;
    font-family:helvetica;
}
div.file_list th {
    background:#ddd;
    vertical-align:Top;
    padding-top:2px;
    padding-bottom:2px;
    padding-left:6px;
    padding-right:6px;
    font-size:9pt;
    font-family:helvetica;
}
div.file_list td {
    border-top: 1px solid #ddd;
    background:#fff;
    vertical-align:Top;
    padding-top:2px;
    padding-bottom:2px;
    padding-left:6px;
    padding-right:6px;
    font-size:9pt;
    font-family:helvetica;
}
div.file_select,div.file_heading {
    margin:0px;
    width:346px;
    padding:4px;
    vertical-align:Top;
    text-align:Left;
    background:#fff;
    border-top:solid 1px #c3c3c3;
    border-left:solid 1px #c3c3c3;
    border-right:solid 1px #c3c3c3;
    font-size:10pt;
    font-family:helvetica;
}
div.file_select{
    background:#ffd;
    vertical-align:Top;
    height:145px;
    border-bottom:solid 1px #c3c3c3;
}
div.file_select tr {
    background:#ddd;
    font-size:9pt;
    font-family:helvetica;
}

div.file_select th {
    background:#ddd;
    vertical-align:Top;
    padding-top:2px;
    padding-bottom:2px;
    padding-left:6px;
    padding-right:6px;
    font-size:9pt;
    font-family:helvetica;
}
div.file_select td {
    //border-top: 1px solid #ddd;
    background:#ffd;
    vertical-align:Top;
    padding-top:2px;
    padding-bottom:2px;
    padding-left:6px;
    padding-right:6px;
    font-size:9pt;
    font-family:helvetica;
}
div.file_results,.results_heading{
    margin:0px;
    width:346px;
    padding:4px;
    vertical-align:Top;
    text-align:Left;
    background:#fff;
    border-top:solid 1px #c3c3c3;
    border-left:solid 1px #c3c3c3;
    border-right:solid 1px #c3c3c3;
    font-size:10pt;
    font-family:helvetica;
    display:none;
}
div.file_results
{
    background:#ffd;
    vertical-align:Top;
    height:73px;
    border-bottom:solid 1px #c3c3c3;
    //display:none;
}
div.file_results tr {
    background:#ddd;
    font-size:9pt;
    font-family:helvetica;
}
div.file_results th {
    background:#ddd;
    vertical-align:Top;
    padding-top:2px;
    padding-bottom:2px;
    padding-left:6px;
    padding-right:6px;
    font-size:9pt;
    font-family:helvetica;
}
div.file_results td {
    //border-top: 1px solid #ddd;
    background:#ffd;
    vertical-align:Top;
    padding-top:2px;
    padding-bottom:2px;
    padding-left:6px;
    padding-right:6px;
    font-size:9pt;
    font-family:helvetica;
}
div.update_results {
    font-size:8pt;
    font-family:helvetica;
}
#data_load {
    vertical-align:middle;
}

.tooltip {
  display:none;
  background:transparent url(../../images/tooltip/white.png);
  font-size:12px;
  height:50px;
  width:200px;
  padding:25px;
  color:#fff;
}



-->
</style>
<script type="text/javascript" src="../../library/js/jquery-1.4.3.min.js"></script>
<script language="JavaScript">
<?php require($GLOBALS['srcdir'] . "/restoreSession.php"); ?>

// Check for errors when the form is submitted.

</script>
</head>
<body class="body_top" style="padding-right:0.5em">
<div id='rx'>


<table>
  <tr>
    <td colspan='2'>
      <div class='header'><?php echo htmlspecialchars( xl('RxNorm'), ENT_NOQUOTES); ?></div>
    </td>
  </tr>
    <tr>
        <td rowspan='2'>
        <div id='list_heading' style="cursor:pointer;"><img src='../../images/downbtn.gif' id='file_update' border='0' align='left' valign='text' hspace='2' title='<?php echo htmlspecialchars( xl('It may take several minutes to download the files, create the tables and load the data.'), ENT_QUOTES); ?>' style='display:' /><img src='../../images/ajax-loader.gif' id='file_load' border='0' align='left' valign='text' hspace='2' style='display:none' /><?php echo htmlspecialchars( xl('Download Latest RxNorm Files'), ENT_NOQUOTES); ?><div id='list_result' style='display:inline'></div></div>
        <div class='file_list'></div>
		
    </td>
  </tr>
  <tr>
    <td>
      <div class='results_heading'>Results</div>
      <div class='file_results'></div>
    </td>
  </tr>
</table>

</div>

<script type="text/javascript">
   var success = " : <?php echo htmlspecialchars( xl('Completed Successfully'), ENT_QUOTES); ?>";
   var data_loading = "<img src='../../images/ajax-loader.gif' id='required_load' border='0' align='left' valign='text' hspace='1' style='display:none' /><?php echo htmlspecialchars( xl('Loading required data... this may take several minutes.'), ENT_QUOTES); ?>";
   var data_exists = "<?php echo htmlspecialchars( xl('Required data has been loaded.'), ENT_QUOTES); ?>";
   var data_error = "<?php echo htmlspecialchars( xl('Error loading required data...'), ENT_QUOTES); ?>";
   var error_response = "";
$(document).ready(function(){
  loadFileList();
  
 
  $("#file_update").click(function(){
    $("#file_update").hide();
    $("#file_load").show();
    $("#list_result").empty();
    htmlobj=$.ajax({
		url:"../../library/ajax/rxnorms_get_directory.php?rxnorms=true&time1=<?php echo htmlspecialchars(time(),ENT_QUOTES);?>",
		success:function(data){
			
		
			$("#list_heading").html(data);
			loadFileList();
			//salert(data)
			
		},
		
		error:function(qXHR, textStatus, errorThrown){
			alert("textStatus="+textStatus+" errorThrown= "+errorThrown)
		
		}
	   
	   
	});
  
	
   

});
$("#load_script").live("click",function(){

var name=new Array();

var confirm=window.confirm('<?php echo addslashes( xl('This process may take several minutes.. Please confirm.') ); ?>')
if(confirm)
	{
		loadscript();
	}
});
function loadscript(){

	var url="../../library/ajax/rxnorms_load_script_list.php?rx=true";
	$.ajax({
				url:url,
				beforeSend:function(){
				$("#loader_span").show();
							$("#loader_span").html("<img src='../../images/ajax-loader.gif' id='required_load' border='0' align='left' valign='text' hspace='1' style='display:block' /><?php echo htmlspecialchars( xl('Loading required data... this may take several minutes.'), ENT_QUOTES); ?>");	
							$("#load_script").attr("disabled", true);
							$("#load_script").val('Loading....');

										
				},
				success:function(data){
					//alert(data);
					$("#load_script").attr("disabled", false);
							$("#load_script").val('Load');

					$("#loader_span").html(success);	
					setTimeout(function(){
						$("#loader_span").fadeOut("slow");	
					},2000);
				}
	});

}
function loadFileList() {
    listobj=$.ajax({url:"../../library/ajax/rxnorms_get_file_list.php?rx=true",async:false});
  //  alert(listobj.responseText)
	$(".file_list").html(listobj.responseText);
} 
});
</script>
</body>
</html>
