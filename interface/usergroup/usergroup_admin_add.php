<?php
require_once("../globals.php");
require_once("../../library/acl.inc");
require_once("$srcdir/sha1.js");
require_once("$srcdir/sql.inc");
require_once("$srcdir/formdata.inc.php");
require_once("$srcdir/options.inc.php");
require_once(dirname(__FILE__) . "/../../library/classes/WSProvider.class.php");

$alertmsg = '';

?>
<html>
<head>

<link rel="stylesheet" href="<?php echo $css_header;?>" type="text/css">
<link rel="stylesheet" href="<?php echo $css_header;?>" type="text/css">
<link rel="stylesheet" type="text/css" href="<?php echo $GLOBALS['webroot'] ?>/library/js/fancybox/jquery.fancybox-1.2.6.css" media="screen" />
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/dialog.js"></script>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/js/jquery.1.3.2.js"></script>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/js/common.js"></script>
<script type="text/javascript" src="<?php echo $GLOBALS['webroot'] ?>/library/js/fancybox/jquery.fancybox-1.2.6.js"></script>
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
		var re5digit=/^\d{5}$/ //regular expression defining a 5 digit number
		var re10digit=/^\d{10}$/ //regular expression defining a 10 digit number
		var renum1digit=/^([0-1])+\d{9}$/ ;
		var emailvalidation = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
		var restreetvalidation = /^([0-9])+\s([A-Za-z])+([\sA-Za-z])+$/;
		var javaScriptStatus = '<?php echo $GLOBALS['JAVA_SCRIPT_STATUS'];?>';

	//if (document.forms[0].rumple.value.length>0 && document.forms[0].stiltskin.value.length>0) {
			//} else {
		
		for(i = 0; i < document.forms[0].access_group.length; i++) { 
			 
	        if (document.forms[0].access_group.options[i].selected) {
		      
	                       if(document.forms[0].access_group.options[i].text =="Physicians" && javaScriptStatus =='1')
	                         {

	               		    
				if(document.getElementById('phy_suffix').value=='0') 
				{
					alert("Required field missing:Please select a suffix");
					return false;
				 }
				if(trimAll(document.getElementById('phy_street').value) == ""){
					alert("Required field missing: Please enter the Address");
					document.getElementById('phy_street').focus();
					return false;
				}
				if(document.getElementById('phy_street').value.search(restreetvalidation)==-1)
				{
				     alert("Invalid Input: Address should contain numbers and alphabets with space.\nFor example 304 Sterling Ave");
				     document.getElementById('phy_street').focus();
				     return false;
				}
				if(trimAll(document.getElementById('phy_city').value) == ""){
					alert("Required field missing: Please enter the city");
					document.getElementById('phy_city').focus();
					return false;
				}
				if(trimAll(document.getElementById('phy_zip').value) == ""){
					alert("Required field missing: Please enter the zip");
					document.getElementById('phy_zip').focus();
					return false;
				}    
				if(document.getElementById('phy_zip').value.search(re5digit)==-1) 
				{
					alert("Required field missing:Please enter a valid 5 digit number inside the zip");
					return false;
				 }
				if(document.getElementById('phy_state').value=='0') 
				{
					alert("Required field missing:Please select a state");
					return false;
				 }
				 
				if(trimAll(document.getElementById('phy_fax').value) == ""){
					alert("Required field missing: Please enter the value in fax");
					document.getElementById('phy_fax').focus();
					return false;
				}    
				
				if(document.getElementById('phy_fax').value.search(renum1digit)!=-1) 
				{
					alert("Required field missing:Number inside Fax should not start with number 1 or 0");    
						document.getElementById('phy_fax').focus();
					return false;
				}
				 if(document.getElementById('phy_fax').value.search(re10digit)==-1) 
				{
					alert("Required field missing:Please enter a valid 10 digit number inside fax ");
					return false;
				 }
				 
					if(trimAll(document.getElementById('phy_workphone1').value) == ""){
					alert("Required field missing: Please enter the value in workphone1");
					document.getElementById('phy_workphone1').focus();
					return false;
				}    
				 if(document.getElementById('phy_workphone1').value.search(renum1digit)!=-1) 
				{
					alert("Required field missing:Number inside workphone1 should not start with number 1 or 0");    
							document.getElementById('phy_workphone1').focus();
					return false;
				}
				 if(document.getElementById('phy_workphone1').value.search(re10digit)==-1) 
				{
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
					alert("Required field missing:Please select a sex");
					return false;
				 }

				 
				if(trimAll(document.getElementById('phy_npi').value) == ""){
					alert("Required field missing: Please enter the value in npi");
					document.getElementById('phy_npi').focus();
					return false;
				}    
				 if(document.getElementById('phy_npi').value.search(re10digit)==-1) 
				{
					alert("Required field missing:Please enter a valid 10 digit number inside npi");
					return false;
				 }
				   }//Physician loop

	                   }//if select2ed

		}//for loop closed
		if (document.forms[0].rumple.value.length<=0)
		{document.forms[0].rumple.focus();document.forms[0].rumple.style.backgroundColor="red";return false;}
		if (document.forms[0].stiltskin.value.length<=0)
		{document.forms[0].stiltskin.focus();document.forms[0].stiltskin.style.backgroundColor="red";return false;}
		top.restoreSession();

		//Checking if secure password is enabled or disabled.
		//If it is enabled and entered password is a weak password, alert the user to enter strong password.
		if(document.new_user.secure_pwd.value == 1){
			var password = trim(document.new_user.stiltskin.value);
			if(password != "") {
				var pwdresult = passwordvalidate(password);
				if(pwdresult == 0){
					alert("<?php echo xl('The password must be at least eight characters, and should'); echo '\n'; echo xl('contain at least three of the four following items:'); echo '\n'; echo xl('A number'); echo '\n'; echo xl('A lowercase letter'); echo '\n'; echo xl('An uppercase letter'); echo '\n'; echo xl('A special character');echo '('; echo xl('not a letter or number'); echo ').'; echo '\n'; echo xl('For example:'); echo ' healthCare@09'; ?>");
					return false;
				}
			}
		} //secure_pwd if ends here
		// ViCareplus : As per NIST standard, SHA1 encryption algorithm is used		
		document.forms[0].newauthPass.value=SHA1(document.forms[0].stiltskin.value);
		document.forms[0].stiltskin.value='';
		document.forms[0].submit();
		
	//}	
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
<span class="title"><?php xl('Add User','e'); ?></span>&nbsp;</td>
<td>
<a class="css_button" name='form_save' id='form_save' href='#' onclick="return submitform()">
	<span><?php xl('Save','e');?></span></a>
<a class="css_button large_button" id='cancel' href='#'>
	<span class='css_button_span large_button_span'><?php xl('Cancel','e');?></span>
</a>
</td></tr></table>

<span style="margin-left: 370px;color:#000000;font-family:Tahoma,Arial,Helvetica,sans-serif;font-size:11px;font-weight:normal;line-height:16px;">
<?php if($GLOBALS['JAVA_SCRIPT_STATUS']==1) {?>* Required when creating a physician account <?php }?>
</span>

<br><br>

<table border=0>

<tr><td valign=top>
<form name='new_user' method='post'  target="_parent" action="usergroup_admin.php"
 onsubmit='return top.restoreSession()'>
<input type=hidden name=mode value=new_user>
<input type=hidden name=secure_pwd value="<?php echo $GLOBALS['secure_password']; ?>">
<span class="bold">&nbsp;</span>
</td><td>
<table border=0 cellpadding=0 cellspacing=4 style="width:650px;">
<tr>
<td style="width:150px;"><span class="text"><?php xl('Username','e'); ?>: </span></td><td  style="width:220px;"><input type=entry name=rumple style="width:120px;"> <span class="mandatory">&nbsp;*</span></td>
<td style="width:150px;"><span class="text"><?php xl('Password','e'); ?>: </span></td><td style="width:250px;"><input type="entry" style="width:120px;" name=stiltskin><span class="mandatory">&nbsp;*</span></td>
</tr>
<tr>
<td><span class="text"<?php if ($GLOBALS['disable_non_default_groups']) echo " style='display:none'"; ?>><?php xl('Groupname','e'); ?>: </span></td>
<td>
<select name=groupname<?php if ($GLOBALS['disable_non_default_groups']) echo " style='display:none'"; ?>>
<?php
$res = sqlStatement("select distinct name from groups");
$result2 = array();
for ($iter = 0;$row = sqlFetchArray($res);$iter++)
  $result2[$iter] = $row;
foreach ($result2 as $iter) {
  print "<option value='".$iter{"name"}."'>" . $iter{"name"} . "</option>\n";
}
?>
</select></td>
<td><span class="text"><?php xl('Provider','e'); ?>: </span></td><td>
 <input type='checkbox' name='authorized' value='1' onclick='authorized_clicked()' />
 &nbsp;&nbsp;<span class='text'><?php xl('Calendar','e'); ?>:
 <input type='checkbox' name='calendar' disabled />
</td>
</tr>
<tr>
<td><span class="text"><?php xl('First Name','e'); ?>: </span></td><td><input type=entry name='fname' style="width:120px;"></td>
<td><span class="text"><?php xl('Middle Name','e'); ?>: </span></td><td><input type=entry name='mname' style="width:120px;"></td>
</tr>
<tr>
<td><span class="text"><?php xl('Last Name','e'); ?>: </span></td><td><input type=entry name='lname' style="width:120px;"></td>
<td><span class="text"><?php xl('Default Facility','e'); ?>: </span></td><td><select style="width:120px;" name=facility_id>
<?php
$fres = sqlStatement("select * from facility where service_location != 0 order by name");
if ($fres) {
  for ($iter = 0;$frow = sqlFetchArray($fres);$iter++)
    $result[$iter] = $frow;
  foreach($result as $iter) {
?>
<option value="<?php echo $iter{id};?>"><?php echo $iter{name};?></option>
<?php
  }
}
?>
</select></td>
</tr>
<tr>
		<td><span class="text"><?php xl('Address','e'); ?>: <?php if($GLOBALS['JAVA_SCRIPT_STATUS']==1) {?>* <?php }?></span></td>
		<td><input type="entry" name="phy_street" id="phy_street" size="20">
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
							<input type="entry" name="phy_street2" id="phy_street2" size="20" >
						</td>
						<td>
							<span class="text">
								<?php xl('City','e'); ?>: <?php if($GLOBALS['JAVA_SCRIPT_STATUS']==1) {?>* <?php }?>
							</span>
						</td>
						<td>
							<input type="entry" name="phy_city" id ="phy_city" size="20" >
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
							<input type="entry" name="phy_phone" id="phy_phone" maxlength="10"  size="20" >
						</td>
						<td>
							<span class="text">
								<?php xl('Fax','e'); ?>: <?php if($GLOBALS['JAVA_SCRIPT_STATUS']==1) {?>* <?php }?>
							</span>
						</td>
						<td>
							<input type="entry" maxlength="10" name="phy_fax" id = "phy_fax" size="20" >
						</td>
					</tr>	
					<tr>
						<td>
							<span class="text">
								<?php xl('Work Phone1','e'); ?>: <?php if($GLOBALS['JAVA_SCRIPT_STATUS']==1) {?>* <?php }?>
							</span>
						</td>
						<td>
							<input type="entry" name="phy_workphone1" maxlength="10" id="phy_workphone1" size="20" value="<?php echo $iter['phonew1']; ?>">
						</td>
						<td>
							<span class="text">
								<?php xl('Work Phone2','e'); ?>: 
							</span>
						</td>
						<td>
							<input type="entry" name="phy_workphone2" maxlength="10" id="phy_workphone2" size="20" value="<?php echo $iter['phonew2']; ?>">
						</td>
					</tr>
					<tr>
						<td>
							<span class="text">
								<?php xl('Home Phone','e'); ?>: 
							</span>
						</td>
						<td>
							<input type="entry" name="phy_homephone" id="phy_homephone" maxlength="10" size="20" value="<?php echo $iter['phonecell']; ?>">
						</td>
						<td>
							<span class="text">
								<?php xl('Email','e'); ?>: 
							</span>
						</td>
						<td>
							<input type="entry"  name="phy_email" id ="phy_email" size="20" maxlength="25" value="<?php echo $iter['email']; ?>">
						</td>
					</tr>
					<tr>
						<td>
							<span class="text">
								<?php xl('License Number','e'); ?>: 
							</span>
						</td>
						<td>
							<input type="entry" name="phy_licenseNo" maxlength="10" id="phy_licenseNo" value="<?php echo $iter['licenseNo'];?>" size="20">
						</td>
						<td>
							<span class="text">
								<?php xl('NPI','e'); ?>: <?php if($GLOBALS['JAVA_SCRIPT_STATUS']==1) {?>* <?php }?>
							</span>
						</td>
						<td>
							<input type="text" name="phy_npi" id="phy_npi" size="20" value="<?php echo $iter['npi']?>" maxlength="10">
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
								<option value="Male">Male</option>
								<option value="Female" >Female</option>									
							</select>
						</td>
					</tr>
<tr>
<td><span class="text"><?php xl('Federal Tax ID','e'); ?>: </span></td><td><input type=entry name='federaltaxid' style="width:120px;"></td>
<td><span class="text"><?php xl('Federal Drug ID','e'); ?>: </span></td><td><input type=entry name='federaldrugid' style="width:120px;"></td>
</tr>
<tr>
<td><span class="text"><?php xl('UPIN','e'); ?>: </span></td><td><input type="entry" name="upin" style="width:120px;"></td>
<td class='text'><?php xl('See Authorizations','e'); ?>: </td>
<td><select name="see_auth" style="width:120px;">
<?php
 foreach (array(1 => xl('None'), 2 => xl('Only Mine'), 3 => xl('All')) as $key => $value)
 {
  echo " <option value='$key'";
  echo ">$value</option>\n";
 }
?>
</select></td>

<tr>
<td><span class="text"><?php xl('Job Description','e'); ?>: </span></td><td><input type="entry" name="specialty" style="width:120px;"></td>
</tr>

<!-- (CHEMED) Calendar UI preference -->
<tr>
<td><span class="text"><?php xl('Taxonomy','e'); ?>: </span></td>
<td><input type="entry" name="taxonomy" style="width:120px;" value="207Q00000X"></td>
<td><span class="text"><?php xl('Calendar UI','e'); ?>: </span></td><td><select name="cal_ui" style="width:120px;">
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
  '', '');
?>
 </td>
 <td class="text"><?php xl('Invoice Refno Pool','e'); ?>: </td>
 <td class='text'>
<?php
echo generate_select_list('irnpool', 'irnpool', '',
  xl('Invoice reference number pool, if used'));
?>
 </td>
</tr>
<?php } ?>

<?php
 // List the access control groups if phpgacl installed
 if (isset($phpgacl_location) && acl_check('admin', 'acl')) {
?>
  <tr>
  <td class='text'><?php xl('Access Control','e'); ?>:</td>
  <td><select name="access_group[]" id="access_group" multiple style="width:120px;">
  <?php
   $list_acl_groups = acl_get_group_title_list();
   $default_acl_group = 'Administrators';
   foreach ($list_acl_groups as $value) {
    if ($default_acl_group == $value) {
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
  <td><span class="text"><?php xl('Additional Info','e'); ?>: </span></td>
  <td><textarea name=info style="width:120px;" cols=27 rows=4 wrap=auto></textarea></td>

  </tr>
  <tr height="25"><td colspan="4">&nbsp;</td></tr>
<?php
 }
?>

</table>

<br>
<input type="hidden" name="newauthPass">
</form>
</td>

</tr>

<tr<?php if ($GLOBALS['disable_non_default_groups']) echo " style='display:none'"; ?>>

<td valign=top>
<form name='new_group' method='post' action="usergroup_admin.php"
 onsubmit='return top.restoreSession()'>
<br>
<input type=hidden name=mode value=new_group>
<span class="bold"><?php xl('New Group','e'); ?>:</span>
</td><td>
<span class="text"><?php xl('Groupname','e'); ?>: </span><input type=entry name=groupname size=10>
&nbsp;&nbsp;&nbsp;
<span class="text"><?php xl('Initial User','e'); ?>: </span>
<select name=rumple>
<?php
$res = sqlStatement("select distinct username from users where username != ''");
for ($iter = 0;$row = sqlFetchArray($res);$iter++)
  $result[$iter] = $row;
foreach ($result as $iter) {
  print "<option value='".$iter{"username"}."'>" . $iter{"username"} . "</option>\n";
}
?>
</select>
&nbsp;&nbsp;&nbsp;
<input type="submit" value=<?php xl('Save','e'); ?>>
</form>
</td>

</tr>

<tr <?php if ($GLOBALS['disable_non_default_groups']) echo " style='display:none'"; ?>>

<td valign=top>
<form name='new_group' method='post' action="usergroup_admin.php"
 onsubmit='return top.restoreSession()'>
<input type=hidden name=mode value=new_group>
<span class="bold"><?php xl('Add User To Group','e'); ?>:</span>
</td><td>
<span class="text">
<?php xl('User','e'); ?>
: </span>
<select name=rumple>
<?php
$res = sqlStatement("select distinct username from users where username != ''");
for ($iter = 0;$row = sqlFetchArray($res);$iter++)
  $result3[$iter] = $row;
foreach ($result3 as $iter) {
  print "<option value='".$iter{"username"}."'>" . $iter{"username"} . "</option>\n";
}
?>
</select>
&nbsp;&nbsp;&nbsp;
<span class="text"><?php xl('Groupname','e'); ?>: </span>
<select name=groupname>
<?php
$res = sqlStatement("select distinct name from groups");
$result2 = array();
for ($iter = 0;$row = sqlFetchArray($res);$iter++)
  $result2[$iter] = $row;
foreach ($result2 as $iter) {
  print "<option value='".$iter{"name"}."'>" . $iter{"name"} . "</option>\n";
}
?>
</select>
&nbsp;&nbsp;&nbsp;
<input type="submit" value=<?php xl('Add User To Group','e'); ?>>
</form>
</td>
</tr>

</table>

<?php
if (empty($GLOBALS['disable_non_default_groups'])) {
  $res = sqlStatement("select * from groups order by name");
  for ($iter = 0;$row = sqlFetchArray($res);$iter++)
    $result5[$iter] = $row;

  foreach ($result5 as $iter) {
    $grouplist{$iter{"name"}} .= $iter{"user"} .
      "(<a class='link_submit' href='usergroup_admin.php?mode=delete_group&id=" .
      $iter{"id"} . "' onclick='top.restoreSession()'>Remove</a>), ";
  }

  foreach ($grouplist as $groupname => $list) {
    print "<span class='bold'>" . $groupname . "</span><br>\n<span class='text'>" .
      substr($list,0,strlen($list)-2) . "</span><br>\n";
  }
}
?>

<script language="JavaScript">
<?php
  if ($alertmsg = trim($alertmsg)) {
    echo "alert('$alertmsg');\n";
  }
?>
$(document).ready(function(){
    $("#cancel").click(function() {
		  parent.$.fn.fancybox.close();
	 });

});
</script>
<table>

</table>

</body>
</html>
