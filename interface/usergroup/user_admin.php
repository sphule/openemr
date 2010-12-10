<?php
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
require_once("../globals.php");
require_once("../../library/acl.inc");
require_once("$srcdir/sha1.js");
require_once("$srcdir/sql.inc");
require_once("$srcdir/calendar.inc");
require_once("$srcdir/formdata.inc.php");
require_once("$srcdir/options.inc.php");
require_once(dirname(__FILE__) . "/../../library/classes/WSProvider.class.php");

if (!$_GET["id"] || !acl_check('admin', 'users'))
  exit();

if ($_GET["mode"] == "update") {
  if ($_GET["username"]) {
    // $tqvar = addslashes(trim($_GET["username"]));
    $tqvar = trim(formData('username','G'));
    $user_data = mysql_fetch_array(sqlStatement("select * from users where id={$_GET["id"]}"));
    sqlStatement("update users set username='$tqvar' where id={$_GET["id"]}");
    sqlStatement("update groups set user='$tqvar' where user='". $user_data["username"]  ."'");
    //echo "query was: " ."update groups set user='$tqvar' where user='". $user_data["username"]  ."'" ;
  }
  if (isset($_GET["taxid"]) || $_GET["taxid"] == '' )  {
    $tqvar = formData('taxid','G');
    sqlStatement("update users set federaltaxid='$tqvar' where id={$_GET["id"]}");
  }
  if (isset($_GET["drugid"]) || $_GET["drugid"] == '') {
    $tqvar = formData('drugid','G');
    sqlStatement("update users set federaldrugid='$tqvar' where id={$_GET["id"]}");
  }
  if (isset($_GET["upin"]) || $_GET["upin"] =='' ) {
    $tqvar = formData('upin','G');
    sqlStatement("update users set upin='$tqvar' where id={$_GET["id"]}");
  }

  if (isset($_GET["phy_suffix"]) || $_GET["phy_suffix"] == '') {
    $tqvar = formData('phy_suffix','G');


    sqlStatement("update users set suffix='$tqvar' where id='".$_GET["id"]."'");
  }

  if (isset($_GET["phy_licenseNo"]) || $_GET["phy_licenseNo"] == '') {
    $tqvar = formData('phy_licenseNo','G');
    sqlStatement("update users set licenseNo='$tqvar' where id='".$_GET["id"]."'");
  }


   if (isset($_GET["phy_city"]) || $_GET["phy_city"] == '') {
    $tqvar = formData('phy_city','G');
    sqlStatement("update users set city='$tqvar' where id='".$_GET["id"]."'");
  }

    if (isset($_GET["phy_homephone"]) || $_GET["phy_homephone"] == '') {
    $tqvar = formData('phy_homephone','G');
    sqlStatement("update users set phonecell='$tqvar' where id='".$_GET["id"]."'");
  }
  


if (isset($_GET["phy_sex"]) || $_GET["phy_sex"] =='')
{

   $tqvar = $_GET["phy_sex"];

    if($tqvar == 'Male')
	  {
		  $sexvar = '1';
	  }
    if($tqvar == 'Female')
	  {
		  $sexvar = '0';
	  }

    sqlStatement("update users set sex='".$sexvar."' where id='".$_GET["id"]."'");
  }  

  if (isset($_GET["phy_email"]) || $_GET["phy_email"] == '') {
    $tqvar = formData('phy_email','G');
    sqlStatement("update users set email='$tqvar' where id='".$_GET["id"]."'");
  }
  if (isset($_GET["phy_street"]) ||  $_GET["phy_street"] == '') {
    $tqvar = formData('phy_street','G');
    sqlStatement("update users set street='$tqvar' where id='".$_GET["id"]."'");
	 }
	 if (isset($_GET["phy_street2"]) ||  $_GET["phy_street2"] == '') {
    $tqvar = formData('phy_street2','G');
    sqlStatement("update users set street2='$tqvar' where id='".$_GET["id"]."'");
  }

  if (isset($_GET["phy_state"]) || $_GET["phy_state"] == '') {
    $tqvar = formData('phy_state','G');
    sqlStatement("update users set state='$tqvar' where id='".$_GET["id"]."'");
  }
  if (isset($_GET["phy_zip"]) || $_GET["phy_zip"] == '')   {
    $tqvar = formData('phy_zip','G');
    sqlStatement("update users set zip='$tqvar' where id='".$_GET["id"]."'");
  }

  if (isset($_GET["phy_phone"]) || $_GET["phy_phone"] == '') {
    $tqvar = formData('phy_phone','G');
    sqlStatement("update users set phone='$tqvar' where id='".$_GET["id"]."'");
  }
  if (isset($_GET["phy_fax"]) || $_GET["phy_fax"] == '') {
    $tqvar = formData('phy_fax','G');
    sqlStatement("update users set fax='$tqvar' where id='".$_GET["id"]."'");
  }
    if (isset($_GET["phy_workphone1"]) || $_GET["phy_workphone1"] == '') {
    $tqvar = formData('phy_workphone1','G');
    sqlStatement("update users set phonew1='$tqvar' where id='".$_GET["id"]."'");
  }
  if (isset($_GET["phy_workphone2"]) || $_GET["phy_workphone2"] =='') {
    $tqvar = formData('phy_workphone2','G');
    sqlStatement("update users set phonew2='$tqvar' where id='".$_GET["id"]."'");
  }

    if (isset($_GET["deanumber"]) || $_GET["deanumber"] == '') {
    $tqvar = formData('deanumber','G');
    sqlStatement("update users set dea='$tqvar' where id='".$_GET["id"]."'");
  }
  
  if (isset($_GET["npi"]) || $_GET["phy_npi"] == '') {
    $tqvar = formData('npi','G');
    sqlStatement("update users set npi='$tqvar' where id={$_GET["id"]}");
  }
  if (isset($_GET["taxonomy"]) || $_GET["taxonomy"] == '') {
    $tqvar = formData('taxonomy','G');
    sqlStatement("update users set taxonomy = '$tqvar' where id= {$_GET["id"]}");
  }
  if (isset($_GET["lname"]) || $_GET["lname"] == '') {
    $tqvar = formData('lname','G');
    sqlStatement("update users set lname='$tqvar' where id={$_GET["id"]}");
  }
  if (isset($_GET["job"]) || $_GET["job"] =='')  {
    $tqvar = formData('job','G');
    sqlStatement("update users set specialty='$tqvar' where id={$_GET["id"]}");
  }
  if (isset($_GET["mname"]) || $_GET["mname"] == '') {
          $tqvar = formData('mname','G');
          sqlStatement("update users set mname='$tqvar' where id={$_GET["id"]}");
  }
  if (isset($_GET["facility_id"]) || $_GET["facility_id"] == '') {
          $tqvar = formData('facility_id','G');
          sqlStatement("update users set facility_id = '$tqvar' where id = {$_GET["id"]}");
          //(CHEMED) Update facility name when changing the id
          sqlStatement("UPDATE users, facility SET users.facility = facility.name WHERE facility.id = '$tqvar' AND users.id = {$_GET["id"]}");
          //END (CHEMED)
  }
  if ($GLOBALS['restrict_user_facility'] && $_GET["schedule_facility"]) {
	  sqlStatement("delete from users_facility
	    where tablename='users'
	    and table_id={$_GET["id"]}
	    and facility_id not in (" . implode(",", $_GET['schedule_facility']) . ")");
	  foreach($_GET["schedule_facility"] as $tqvar) {
      sqlStatement("replace into users_facility set
		    facility_id = '$tqvar',
		    tablename='users',
		    table_id = {$_GET["id"]}");
    }
  }
  if (isset($_GET["fname"]) || $_GET["fname"] == '')  {
          $tqvar = formData('fname','G');
          sqlStatement("update users set fname='$tqvar' where id={$_GET["id"]}");
  }
  //(CHEMED) Calendar UI preference
  if ($_GET["cal_ui"]) {
          $tqvar = formData('cal_ui','G');
          sqlStatement("update users set cal_ui = '$tqvar' where id = {$_GET["id"]}");

          // added by bgm to set this session variable if the current user has edited
	  //   their own settings
	  if ($_SESSION['authId'] == $_GET["id"]) {
	    $_SESSION['cal_ui'] = $tqvar;
	  }
  }
  //END (CHEMED) Calendar UI preference

  if (isset($_GET['default_warehouse'])) {
    sqlStatement("UPDATE users SET default_warehouse = '" .
      formData('default_warehouse','G') .
      "' WHERE id = '" . formData('id','G') . "'");
  }

  if (isset($_GET['irnpool'])) {
    sqlStatement("UPDATE users SET irnpool = '" .
      formData('irnpool','G') .
      "' WHERE id = '" . formData('id','G') . "'");
  }

  if ($_GET["newauthPass"] && $_GET["newauthPass"] != "d41d8cd98f00b204e9800998ecf8427e") { // account for empty
    $tqvar = formData('newauthPass','G');
    sqlStatement("update users set password='$tqvar' where id={$_GET["id"]}");
  }

  // for relay health single sign-on
  if (isset($_GET["ssi_relayhealth"]) || $_GET["ssi_relayhealth"] == '') {
    $tqvar = formData('ssi_relayhealth','G');
    sqlStatement("update users set ssi_relayhealth = '$tqvar' where id = {$_GET["id"]}");
  }

  $tqvar  = $_GET["authorized"] ? 1 : 0;
  $actvar = $_GET["active"]     ? 1 : 0;
  $calvar = $_GET["calendar"]   ? 1 : 0;

  sqlStatement("UPDATE users SET authorized = $tqvar, active = $actvar, " .
    "calendar = $calvar, see_auth = '" . $_GET['see_auth'] . "' WHERE " .
    "id = {$_GET["id"]}");

  if (isset($_GET["comments"]) || $_GET["comments"] == '') {
    $tqvar = formData('comments','G');
    sqlStatement("update users set info = '$tqvar' where id = {$_GET["id"]}");
  }

  if (isset($phpgacl_location) && acl_check('admin', 'acl')) {
    // Set the access control group of user
    $user_data = mysql_fetch_array(sqlStatement("select username from users where id={$_GET["id"]}"));
    set_user_aro($_GET['access_group'], $user_data["username"],
      formData('fname','G'), formData('mname','G'), formData('lname','G'));
  }

  $ws = new WSProvider($_GET['id']);

  /*Dont move usergroup_admin (1).php just close window
  // On a successful update, return to the users list.
  include("usergroup_admin.php");
  exit(0);
  */  	echo '
<script type="text/javascript">
<!--
parent.$.fn.fancybox.close();
//-->
</script>

	';
}

$res = sqlStatement("select * from users where id={$_GET["id"]}");
for ($iter = 0;$row = sqlFetchArray($res);$iter++)
                $result[$iter] = $row;
$iter = $result[0];

///
if (isset($_POST["mode"])) {
  	echo '
<script type="text/javascript">
<!--
parent.$.fn.fancybox.close();
//-->
</script>

	';
}
///

?>

<html>
<head>

<link rel="stylesheet" href="<?php echo $css_header; ?>" type="text/css">
<script type="text/javascript" src="../../library/dialog.js"></script>
<script type="text/javascript" src="../../library/js/jquery.1.3.2.js"></script>
<script type="text/javascript" src="../../library/js/common.js"></script>
<script src="checkpwd_validation.js" type="text/javascript"></script>

<script language="JavaScript">
function trimAll(sString)
{
	while (sString.substring(0,1) == ' ')
	{
		sString = sString.substring(1, sString.length);
	}
	while (sString.substring(sString.length-1, sString.length) == ' ')
	{
		sString = sString.substring(0,sString.length-1);
	}
	return sString;
} 

function aphanumeric(alphane) {
          
            var numaric = alphane;
            for(var j=0; j<numaric.length; j++)
            {
                var alphaa = numaric.charAt(j);
                var hh = alphaa.charCodeAt(0);
               if(((hh > 47 && hh<58) || (hh > 64 && hh<91) || (hh > 96 && hh<123)) && alphane.length == 9)
                {
       
                }
                else
                {
                    return false;
                }
            }
            return true;
}

function submitform() {
	top.restoreSession();
	var re5digit=/^\d{5}$/ //regular expression defining a 5 digit number
	var renum1digit=/^([0-1])+\d{9}$/ ;
	var re10digit=/^\d{10}$/ //regular expression defining a 10 digit number
	var emailvalidation = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
	var restreetvalidation = /^([0-9])+\s([A-Za-z])+([\sA-Za-z])+$/;
	var javaScriptStatus = '<?php echo $GLOBALS['JAVA_SCRIPT_STATUS'];?>';

	var flag=0;
	if(document.forms[0].clearPass.value!="")
	{
		//Checking for the strong password if the 'secure password' feature is enabled
		if(document.forms[0].secure_pwd.value == 1)
		{
			var pwdresult = passwordvalidate(document.forms[0].clearPass.value);
			if(pwdresult == 0) {
				flag=1;
				alert("<?php echo xl('The password must be at least eight characters, and should'); echo '\n'; echo xl('contain at least three of the four following items:'); echo '\n'; echo xl('A number'); echo '\n'; echo xl('A lowercase letter'); echo '\n'; echo xl('An uppercase letter'); echo '\n'; echo xl('A special character');echo '('; echo xl('not a letter or number'); echo ').'; echo '\n'; echo xl('For example:'); echo ' healthCare@09'; ?>");
				return false;
			}
		}
		//Checking for password history if the 'password history' feature is enabled.
		if(document.forms[0].pwd_history.value == 1){
			// ViCareplus : As per NIST standard, the SHA1 encryption algorithm is used
			var p  = SHA1(document.forms[0].clearPass.value);
			var p1 = document.forms[0].pwd.value;
			var p2 = document.forms[0].pwd_history1.value;
			var p3 = document.forms[0].pwd_history2.value;
			if((p == p1) || (p == p2) || (p == p3))
			{
				flag=1;
				document.getElementById('error_message').innerHTML="<?php xl('Recent three passwords are not allowed.',e) ?>";
				return false;
			}
		}

	}//If pwd null ends here
	//Request to reset the user password if the user was deactived once the password expired.
	if((document.forms[0].pwd_expires.value != 0) && (document.forms[0].clearPass.value == "")) {
		if((document.forms[0].user_type.value != "Emergency Login") && (document.forms[0].pre_active.value == 0) && (document.forms[0].active.checked == 1) && (document.forms[0].grace_time.value != "") && (document.forms[0].current_date.value) > (document.forms[0].grace_time.value))
		{
			flag=1;
			document.getElementById('error_message').innerHTML="<?php xl('Please reset the password.',e) ?>";
		}
	}
	var sel = getSelected(document.forms[0].access_group_id.options);
	for (var item in sel){       
            if(sel[item].value == "Emergency Login"){
                 document.forms[0].check_acl.value = 1; 
            }
          }

	for(i = 0; i < document.forms[0].access_group_id.length; i++)
	{ 
	   if (document.forms[0].access_group_id.options[i].selected)  
	   {
	     if(document.forms[0].access_group_id.options[i].text =="Physicians" && javaScriptStatus =='1')
	       {

    
			if(document.getElementById('phy_suffix').value=='0') 
			{
				flag == 1;
				alert("Required field missing:Please select a suffix");
				return false;
			 }
			if(trimAll(document.getElementById('phy_street').value) == ""){
				flag == 1;
				alert("Required field missing: Please enter the Address");
				document.getElementById('phy_street').focus();
				return false;
			}
			if(document.getElementById('phy_street').value.search(restreetvalidation)==-1)
			{
				 flag == 1;
				 alert("Invalid Input: Address should contain numbers and alphabets with space.\nFor example 304 Sterling Ave");
			     document.getElementById('phy_street').focus();
			     return false;
			}
			/*if(trimAll(document.getElementById('phy_street2').value) == ""){
				flag == 1;
				alert("Required field missing: Please enter the Address2");
				document.getElementById('phy_street2').focus();
				return false;
			}	*/			
			if(trimAll(document.getElementById('phy_city').value) == ""){
				flag == 1;
				alert("Required field missing: Please enter the city");
				document.getElementById('phy_city').focus();
				return false;
			}
			if(trimAll(document.getElementById('phy_zip').value) == ""){
				flag == 1;
				alert("Required field missing: Please enter the zip");
				document.getElementById('phy_zip').focus();
				return false;
			}    
			if(document.getElementById('phy_zip').value.search(re5digit)==-1) 
			{
				flag == 1;
				alert("Required field missing:Please enter a valid 5 digit number inside the zip");
				return false;
			 }
			if(document.getElementById('phy_state').value=='0') 
			{
				flag == 1;
				alert("Required field missing:Please select a state");
				return false;
			 }
			/*if(trimAll(document.getElementById('phy_phone').value) == ""){
				flag == 1;
				alert("Required field missing: Please enter the phone");
				document.getElementById('phy_phone').focus();
				return false;
			}    
			if(document.getElementById('phy_phone').value.search(renum1digit)!=-1) 
			{
				flag == 1;
				alert("Required field missing:Number inside phone should not start with number 1 or 0");    
				document.getElementById('phy_phone').focus();
				return false;
			}
			if(document.getElementById('phy_phone').value.search(re10digit)==-1) 
			{
				flag == 1;
				alert("Required field missing:Please enter a valid 10 digit number inside the phone ");
				document.getElementById('phy_phone').focus();
				return false;
			 }*/
			 
			if(trimAll(document.getElementById('phy_fax').value) == ""){
				flag == 1;
				alert("Required field missing: Please enter the value in fax");
				document.getElementById('phy_fax').focus();
				return false;
			}    
			
			if(document.getElementById('phy_fax').value.search(renum1digit)!=-1) 
			{
				flag == 1;
				alert("Required field missing:Number inside Fax should not start with number 1 or 0");    
				document.getElementById('phy_fax').focus();
				return false;
			}
			 if(document.getElementById('phy_fax').value.search(re10digit)==-1) 
			{
				flag == 1;
				alert("Required field missing:Please enter a valid 10 digit number inside fax ");
				return false;
			 }
			 
				if(trimAll(document.getElementById('phy_workphone1').value) == ""){
				flag == 1;
				alert("Required field missing: Please enter the value in workphone1");
				document.getElementById('phy_workphone1').focus();
				return false;
			}    
			 if(document.getElementById('phy_workphone1').value.search(renum1digit)!=-1) 
			{
				flag == 1;
				alert("Required field missing:Number inside workphone1 should not start with number 1 or 0");    
				document.getElementById('phy_workphone1').focus();
				return false;
			}
			 if(document.getElementById('phy_workphone1').value.search(re10digit)==-1) 
			{
				flag == 1;
				alert("Required field missing:Please enter a valid 10 digit number inside workphone1");
				document.getElementById('phy_workphone1').focus();
				return false;
			 }
			 if(trimAll(document.getElementById('phy_email').value) != ""){
				 if(emailvalidation.test(document.getElementById('phy_email').value) == false) {
					alert("<?php xl('Required field missing:Please enter a valid email','e');?>");
					return false;
				 }
              }			  
			 if(document.getElementById('phy_sex').value=='') 
			{
				flag == 1;
				alert("Required field missing:Please select a sex");
				return false;
			 }

			 
			if(trimAll(document.getElementById('phy_npi').value) == ""){
				flag == 1;
				alert("Required field missing: Please enter the value in npi");
				document.getElementById('phy_npi').focus();
				return false;
			}    
			 if(document.getElementById('phy_npi').value.search(re10digit)==-1) 
			{
				flag == 1;	
				alert("Required field missing:Please enter a valid 10 digit number inside npi");
				return false;
			 }
			/* if(trimAll(document.getElementById('deanumber').value) == ""){
				flag == 1;
				alert("Required field missing: Please enter the value in deanumber");
				document.getElementById('deanumber').focus();
				return false;
			}    
			 
			if(!aphanumeric(document.getElementById('deanumber').value))
			{	
				flag == 1;
				alert('Required field missing:Please input valid alphanumeric value and the length should be of 9');
			    document.getElementById('deanumber').focus();             
				return false;
							
			} */   

           }//Physician loop

         }//if selected

	}//for loop closed
	if(flag == 0){
		// ViCareplus : As per NIST standard, SHA1 encryption algorithm is used
		document.forms[0].newauthPass.value=SHA1(document.forms[0].clearPass.value);document.forms[0].clearPass.value='';
		document.forms[0].submit();
		parent.$.fn.fancybox.close(); 
	}
}
//Getting the list of selected item in ACL
function getSelected(opt) {
         var selected = new Array();
            var index = 0;
            for (var intLoop = 0; intLoop < opt.length; intLoop++) {
               if ((opt[intLoop].selected) ||
                   (opt[intLoop].checked)) {
                  index = selected.length;
                  selected[index] = new Object;
                  selected[index].value = opt[intLoop].value;
                  selected[index].index = intLoop;
               }
            }
            return selected;
         }
function authorized_clicked() {
 var f = document.forms[0];
 f.calendar.disabled = !f.authorized.checked;
 f.calendar.checked  =  f.authorized.checked;
}

</script>

</head>
<body class="body_top">
<table><tr><td>
<span class="title"><?php xl('Edit User','e'); ?></span>&nbsp;
</td><td>
    <a class="css_button" name='form_save' id='form_save' href='#' onclick='return submitform()'> <span><?php xl('Save','e');?></span> </a>
	<a class="css_button" id='cancel' href='#'><span><?php xl('Cancel','e');?></span></a>
</td></tr>
</table>

<span style="margin-left: 370px;color:#000000;font-family:Tahoma,Arial,Helvetica,sans-serif;font-size:11px;font-weight:normal;line-height:16px;">
<?php if($GLOBALS['JAVA_SCRIPT_STATUS']==1) {?>* Required when creating a physician account <?php }?>
</span>

<br>
<FORM NAME="user_form" METHOD="GET" ACTION="usergroup_admin.php" target="_parent" onsubmit='return top.restoreSession()'>
<input type=hidden name="pwd_history" value="<? echo $GLOBALS['password_history']; ?>" >
<input type=hidden name="pwd_history1" value="<? echo $iter["pwd_history1"]; ?>" >
<input type=hidden name="pwd_history2" value="<? echo $iter["pwd_history2"]; ?>" >
<input type=hidden name="pwd" value="<? echo $iter["password"]; ?>" >

<input type=hidden name="pwd_expires" value="<? echo $GLOBALS['password_expiration_days']; ?>" >
<input type=hidden name="pre_active" value="<? echo $iter["active"]; ?>" >
<input type=hidden name="exp_date" value="<? echo $iter["pwd_expiration_date"]; ?>" >
<input type=hidden name="get_admin_id" value="<? echo $GLOBALS['Emergency_Login_email']; ?>" >
<input type=hidden name="admin_id" value="<? echo $GLOBALS['Emergency_Login_email_id']; ?>" >
<input type=hidden name="check_acl" value="">
<?php 
//Calculating the grace time 
$current_date = date("Y-m-d");
$password_exp=$iter["pwd_expiration_date"];
if($password_exp != "0000-00-00")
  {
    $grace_time1 = date("Y-m-d", strtotime($password_exp . "+".$GLOBALS['password_grace_time'] ."days"));
  }
?>
<input type=hidden name="current_date" value="<? echo strtotime($current_date); ?>" >
<input type=hidden name="grace_time" value="<? echo strtotime($grace_time1); ?>" >
<!--  Get the list ACL for the user -->
<?php
$acl_name=acl_get_group_titles($iter["username"]);
$bg_count=count($acl_name);
   for($i=0;$i<$bg_count;$i++){
      if($acl_name[$i] == "Emergency Login")
       $bg_name=$acl_name[$i];
      }
?>
<input type=hidden name="user_type" value="<? echo $bg_name; ?>" >

<TABLE border=0 cellpadding=0 cellspacing=4 style="width:660px;" >
<TR>
<TD style="width:180px;"><span class=text><?php xl('Username','e'); ?>: </span></TD><TD style="width:270px;"><input type=entry name=username style="width:150px;" value="<?php echo $iter["username"]; ?>" disabled></td>
<TD style="width:200px;"><span class=text><?php xl('Password','e'); ?>: </span></TD><TD class='text' style="width:280px;"><input type=entry name=clearPass style="width:150px;"  value=""><font class="mandatory">*</font></td>
</TR>

<TR height="30" style="valign:middle;">
<td><span class="text">&nbsp;</span></td><td>&nbsp;</td>
<td colspan="2"><span class=text><?php xl('Provider','e'); ?>:
 <input type="checkbox" name="authorized" onclick="authorized_clicked()"<?php
  if ($iter["authorized"]) echo " checked"; ?> />
 &nbsp;&nbsp;<span class='text'><?php xl('Calendar','e'); ?>:
 <input type="checkbox" name="calendar"<?php
  if ($iter["calendar"]) echo " checked";
  if (!$iter["authorized"]) echo " disabled"; ?> />
 &nbsp;&nbsp;<span class='text'><?php xl('Active','e'); ?>:
 <input type="checkbox" name="active"<?php if ($iter["active"]) echo " checked"; ?> />
</TD>
</TR>

<TR>
<TD><span class=text><?php xl('First Name','e'); ?>: </span></TD>
<TD><input type=entry name=fname style="width:150px;" value="<?php echo $iter["fname"]; ?>"></td>
<td><span class=text><?php xl('Middle Name','e'); ?>: </span></TD><td><input type=entry name=mname style="width:150px;"  value="<?php echo $iter["mname"]; ?>"></td>
</TR>

<TR>
<td><span class=text><?php xl('Last Name','e'); ?>: </span></td><td><input type=entry name=lname style="width:150px;"  value="<?php echo $iter["lname"]; ?>"></td>
<td><span class=text><?php xl('Default Facility','e'); ?>: </span></td><td><select name=facility_id style="width:150px;" >
<?php
$fres = sqlStatement("select * from facility where service_location != 0 order by name");
if ($fres) {
for ($iter2 = 0; $frow = sqlFetchArray($fres); $iter2++)
                $result[$iter2] = $frow;
foreach($result as $iter2) {
?>
  <option value="<?php echo $iter2['id']; ?>" <?php if ($iter['facility_id'] == $iter2['id']) echo "selected"; ?>><?php echo htmlspecialchars($iter2['name']); ?></option>
<?php
}
}
?>
</select></td>
</tr>
	<tr>
		<td><span class="text"><?php xl('Address','e'); ?>: <?php if($GLOBALS['JAVA_SCRIPT_STATUS']==1) {?>* <?php }?></span></td>
		<td><input type="entry" name="phy_street" id="phy_street" size="20" value="<?php echo $iter['street']; ?>">
		</td>
							<td>
							<span class="text">
								<?php xl('Suffix','e'); ?>: <?php if($GLOBALS['JAVA_SCRIPT_STATUS']==1) {?>* <?php }?>
							</span>
						</td>
						<td>
							<select name='phy_suffix' id='phy_suffix'>
								<option value="0">--Select--</option>
									<?php
									$erx_suff = sqlStatement("select id,name from erx_physician_suffix");
									$i =0;
									while($erx_suff_arr = sqlFetchArray($erx_suff))
									{
										$suffix['name'][$i]  = $erx_suff_arr['name'];
										$suffix['id'][$i]  = $erx_suff_arr['id'];

								                if($suffix['id'][$i] == $iter['suffix'])
										{
										  ?><option value="<?php echo $suffix['id'][$i];?>" selected="selected"><?php echo $suffix['name'][$i];?></option><?php
										}
										else
										{
											  ?><option value="<?php echo $suffix['id'][$i];?>"><?php echo $suffix['name'][$i];?></option><?php
										}

										$i++;
									}
									?>
							</select>
						</td>	
					</tr>			
					
					<tr>
						<td>
							<span class="text">
								<?php xl('Address2','e'); ?>: 
							</span>
						</td>
						<td>
							<input type="entry" name="phy_street2" id="phy_street2" size="20"  value="<?php echo $iter['street2']; ?>">
						</td>
						<td>
							<span class="text">
								<?php xl('City','e'); ?>: <?php if($GLOBALS['JAVA_SCRIPT_STATUS']==1) {?>* <?php }?>
							</span>
						</td>
						<td>
							<input type="entry" name="phy_city" id ="phy_city" size="20"  value="<?php echo $iter['city']; ?>">
						</td>
					</tr>
					<tr>
						<td>
							<span class="text">
								<?php xl('Zip','e'); ?>: <?php if($GLOBALS['JAVA_SCRIPT_STATUS']==1) {?>* <?php }?>
							</span>
						</td>
						<td>
							<input type="entry" name="phy_zip" maxlength="5" id="phy_zip" size="20"  value="<?php echo $iter['zip']; ?>">
						</td>
						<td>
							<span class="text">
								<?php xl('State','e'); ?>: <?php if($GLOBALS['JAVA_SCRIPT_STATUS']==1) {?>* <?php }?>
							</span>
						</td>
						<td>
							<select name="phy_state" id="phy_state">
								<option value="0">--Select--</option>
								<?php
								$state_res = sqlStatement("select title,option_id from list_options where list_id = 'state'");
								$i =0;
								while($state_arr = sqlFetchArray($state_res))
								{
									$main_arr[$i]  = $state_arr['title'];
									$optionid[$i]  = $state_arr['option_id'];
									$i++;
								}

								for($counter=0;$counter < count($main_arr);$counter++)
								{
									 if($optionid[$counter] == $iter["state"])
									{
								       ?>
								<option value="<?php echo $optionid[$counter]; ?>" selected="selected"><?php echo $main_arr[$counter];?></option>
								<?php
									}
									  else
									{
								       ?>
								<option value="<?php echo $optionid[$counter]; ?>"><?php echo $main_arr[$counter];?></option>
								<?php
									}
								}

								?>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<span class="text">
								<?php xl('Phone','e'); ?>: 
							</span>
						</td>
						<td>
							<input type="entry" name="phy_phone" id="phy_phone" maxlength="10"  size="20" value="<?php echo $iter['phone']; ?>">
						</td>
						<td>
							<span class="text">
								<?php xl('Fax','e'); ?>: <?php if($GLOBALS['JAVA_SCRIPT_STATUS']==1) {?>* <?php }?>
							</span>
						</td>
						<td>
							<input type="entry" maxlength="10" name="phy_fax" id = "phy_fax" size="20" value="<?php if( $iter['fax']!=0 ) { echo $iter['fax'];}?>">
						</td>
					</tr>	
					<tr>
						<td>
							<span class="text">
								<?php xl('Work Phone1','e'); ?>: <?php if($GLOBALS['JAVA_SCRIPT_STATUS']==1) {?>* <?php }?>
							</span>
						</td>
						<td>
							<input type="entry" name="phy_workphone1" maxlength="10" id="phy_workphone1" size="20" value="<?php if($iter['phonew1']!=0) {echo $iter['phonew1']; } ?>">
						</td>
						<td>
							<span class="text">
								<?php xl('Work Phone2','e'); ?>: 
							</span>
						</td>
						<td>
							<input type="entry" name="phy_workphone2" maxlength="10" id="phy_workphone2" size="20" value="<?php if($iter['phonew2']!=0) {echo $iter['phonew2'];} ?>">
						</td>
					</tr>
					<tr>
						<td>
							<span class="text">
								<?php xl('Home Phone','e'); ?>: 
							</span>
						</td>
						<td>
							<input type="entry" name="phy_homephone" id="phy_homephone" maxlength="10" size="20" value="<?php if($iter['phonecell']!=0) { echo $iter['phonecell']; } ?>">
						</td>
						<td>
							<span class="text">
								<?php xl('Email','e'); ?>: 
							</span>
						</td>
						<td>
							<input type="entry"  name="phy_email" id ="phy_email" size="20" maxlength="50" value="<?php echo $iter['email']; ?>">
						</td>
					</tr>
					<tr>
						<td>
							<span class="text">
								<?php xl('License Number','e'); ?>: 
							</span>
						</td>
						<td>
							<input type="entry" name="phy_licenseNo" maxlength="10" id="phy_licenseNo" value="<?php if($iter['licenseNo']!=0) {echo $iter['licenseNo'];}?>" size="20">
						</td>
						<td>
							<span class="text">
								<?php xl('NPI','e'); ?>: <?php if($GLOBALS['JAVA_SCRIPT_STATUS']==1) {?>* <?php }?>
							</span>
						</td>
						<td>
							<input type="text" name="phy_npi" id="phy_npi" size="20" value="<?php if($iter['npi']!=0) {echo $iter['npi'];}?>" maxlength="10">
						</td>
					</tr>
					<tr>
						<td>
							<span class="text">
								<?php xl('DEA Number','e'); ?>: 	
							</span>
						</td>
						<td>
							<input type="entry" maxlength="9" name="deanumber" id="deanumber" size="20" value="<?php echo $iter['dea']; ?>">
						</td>
						<td>
							<span class="text">
								<?php xl('Sex','e'); ?>: <?php if($GLOBALS['JAVA_SCRIPT_STATUS']==1) {?>* <?php }?>
							</span>	
						</td>
						<td>
							<select name="phy_sex" id="phy_sex">
								<option value="">--Select--</option>
									<?php 
									if($iter['sex'] == '1')
									{
									?>
								<option value="Male" selected="selected">Male</option>
								<option value="Female" >Female</option>
									<?php
									}  
									if($iter['sex'] == '0')
									{
									?>
								<option value="Male">Male</option>
								<option value="Female" selected="selected">Female</option>
									<?php
									}
									if($iter['sex'] == '')
									{
									?>
								<option value="Male">Male</option>
								<option value="Female" >Female</option>
									<?php
									}
									?>
							</select>
						</td>
					</tr>
<?php if ($GLOBALS['restrict_user_facility']) { ?>
<tr>
 <td colspan=2>&nbsp;</td>
 <td><span class=text><?php xl('Schedule Facilities:', 'e');?></td>
 <td>
  <select name="schedule_facility[]" multiple style="width:150px;" >
<?php
  $userFacilities = getUserFacilities($_GET['id']);
  $ufid = array();
  foreach($userFacilities as $uf)
    $ufid[] = $uf['id'];
  $fres = sqlStatement("select * from facility where service_location != 0 order by name");
  if ($fres) {
    while($frow = sqlFetchArray($fres)):
?>
   <option <?php echo in_array($frow['id'], $ufid) || $frow['id'] == $iter['facility_id'] ? "selected" : null ?>
      value="<?php echo $frow['id'] ?>"><?php echo htmlspecialchars($frow['name']) ?></option>
<?php
  endwhile;
}
?>
  </select>
 </td>
</tr>
<?php } ?>

<TR>
<TD><span class=text><?php xl('Federal Tax ID','e'); ?>: </span></TD><TD><input type=text name=taxid style="width:150px;"  value="<?php echo $iter["federaltaxid"]?>"></td>
<TD><span class=text><?php xl('Federal Drug ID','e'); ?>: </span></TD><TD><input type=text name=drugid style="width:150px;"  value="<?php echo $iter["federaldrugid"]?>"></td>
</TR>

<tr>
<td><span class="text"><?php xl('UPIN','e'); ?>: </span></td><td><input type="text" name="upin" style="width:150px;" value="<?php echo $iter["upin"]?>"></td>
<td class='text'><?php xl('See Authorizations','e'); ?>: </td>
<td><select name="see_auth" style="width:150px;" >
<?php
 foreach (array(1 => xl('None'), 2 => xl('Only Mine'), 3 => xl('All')) as $key => $value)
 {
  echo " <option value='$key'";
  if ($key == $iter['see_auth']) echo " selected";
  echo ">$value</option>\n";
 }
?>
</select></td>
</tr>

<tr>

<td><span class="text"><?php xl('Job Description','e'); ?>: </span></td><td><input type="text" name="job" style="width:150px;"  value="<?php echo $iter["specialty"]?>"></td>
</tr>

<?php if (!empty($GLOBALS['ssi']['rh'])) { ?>
<tr>
<td><span class="text"><?php xl('Relay Health ID', 'e'); ?>: </span></td>
<td><input type="password" name="ssi_relayhealth" style="width:150px;"  value="<?php echo $iter["ssi_relayhealth"]; ?>"></td>
</tr>
<?php } ?>

<!-- (CHEMED) Calendar UI preference -->
<tr>
<td><span class="text"><?php xl('Taxonomy','e'); ?>: </span></td>
<td><input type="text" name="taxonomy" style="width:150px;"  value="<?php echo $iter["taxonomy"]?>"></td>
<td><span class="text"><?php xl('Calendar UI','e'); ?>: </span></td><td><select name="cal_ui" style="width:150px;" >
<?php
 foreach (array(3 => xl('Outlook'), 1 => xl('Original'), 2 => xl('Fancy')) as $key => $value)
 {
  echo " <option value='$key'";
  if ($key == $iter['cal_ui']) echo " selected";
  echo ">$value</option>\n";
 }
?>
</select></td>
</tr>
<!-- END (CHEMED) Calendar UI preference -->

<?php if ($GLOBALS['inhouse_pharmacy']) { ?>
<tr>
 <td class="text"><?php xl('Default Warehouse','e'); ?>: </td>
 <td class='text'>
<?php
echo generate_select_list('default_warehouse', 'warehouse',
  $iter['default_warehouse'], '');
?>
 </td>
 <td class="text"><?php xl('Invoice Refno Pool','e'); ?>: </td>
 <td class='text'>
<?php
echo generate_select_list('irnpool', 'irnpool', $iter['irnpool'],
  xl('Invoice reference number pool, if used'));
?>
 </td>
</tr>
<?php } ?>

<?php
 // Collect the access control group of user
 if (isset($phpgacl_location) && acl_check('admin', 'acl')) {
?>
  <tr>
  <td class='text'><?php xl('Access Control','e'); ?>:</td>
  <td><select id="access_group_id" name="access_group[]" multiple style="width:150px;" >
  <?php
   $list_acl_groups = acl_get_group_title_list();
   $username_acl_groups = acl_get_group_titles($iter["username"]);
   foreach ($list_acl_groups as $value) {
    if (($username_acl_groups) && in_array($value,$username_acl_groups)) {
     // Modified 6-2009 by BM - Translate group name if applicable
     echo " <option value='$value' selected>" . xl_gacl_group($value) . "</option>\n";
    }
    else {
     // Modified 6-2009 by BM - Translate group name if applicable
     echo " <option value='$value'>" . xl_gacl_group($value) . "</option>\n";
    }
   }
  ?>
  </select></td>
  <td><span class=text><?php xl('Additional Info','e'); ?>:</span></td>
  <td><textarea style="width:150px;" name="comments" wrap=auto rows=4 cols=25><?php echo $iter["info"];?></textarea></td>

  </tr>
  <tr height="20" valign="bottom">
  <td colspan="4" class="text">
  <font class="mandatory">*</font> <?php xl('Leave blank to keep password unchanged.','e'); ?>
<!--
Display red alert if entered password matched one of last three passwords/Display red alert if user password was expired and the user was inactivated previously
-->
  <div class="redtext" id="error_message">&nbsp;</div>
  </td>
  </tr>
<?php
 }
?>
</table>

<INPUT TYPE="HIDDEN" NAME="id" VALUE="<?php echo $_GET["id"]; ?>">
<INPUT TYPE="HIDDEN" NAME="mode" VALUE="update">
<INPUT TYPE="HIDDEN" NAME="privatemode" VALUE="user_admin">
<INPUT TYPE="HIDDEN" NAME="newauthPass" VALUE="">
<INPUT TYPE="HIDDEN" NAME="secure_pwd" VALUE="<? echo $GLOBALS['secure_password']; ?>">
</FORM>
<script language="JavaScript">
$(document).ready(function(){
    $("#cancel").click(function() {
		  parent.$.fn.fancybox.close();
	 });

});
</script>
</BODY>

</HTML>

<?php
//  d41d8cd98f00b204e9800998ecf8427e == blank
?>
