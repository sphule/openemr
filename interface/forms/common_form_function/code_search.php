<?
include_once("../../globals.php");
include_once("../../../custom/code_types.inc.php");
include_once("$srcdir/sql.inc");

//the maximum number of records to pull out with the search:
$M = 30;

//the number of records to display before starting a second column:
$N = 15;

$form_name = $_REQUEST['form_name'];
$code_type = $_REQUEST['code_type'];

$thispage = "${rootdir}/forms/common_form_function/code_search.php?form_name=$form_name";
?>

<html>
<head>
<link rel=stylesheet href="<?echo $css_body;?>" type="text/css">


<style type="text/css">

	ul#tabnav { /* general settings */
	        text-align: left; /* set to left, right or center */
	        margin: 1em 0 1em 0; /* set margins as desired */
	        font: bold 11px verdana, arial, sans-serif; /* set font as desired */
	        border-bottom: 1px solid #66c; /* set border COLOR as desired */
	        list-style-type: none;
	        padding: 3px 10px 3px 10px; /* THIRD number must change with respect to padding-top (X) below */
	}

	ul#tabnav li {
		display: inline;
	}

	ul#tabnav li a { /* settings for all tab links */
	        padding: 3px 4px; /* set padding (tab size) as desired; FIRST number must change with respect to padding-top (X) above */
	        border: 1px solid #66c; /* set border COLOR as desired; usually matches border color specified in #tabnav */
	        background-color: #ccf; /* set unselected tab background color as desired */
	        color: #666; /* set unselected tab link color as desired */
	        margin-right: 0px; /* set additional spacing between tabs as desired */
	        text-decoration: none;
	        border-bottom: none;
	}
	body#prev_dx ul#tabnav li#prev_dx_tab a, body#search ul#tabnav li#search_tab a {
		background-color: #fff;
		color: #666;
	}
	
	ul#tabnav a:hover { /* settings for hover effect */
	        background: #fff; /* set desired hover color */
	}
	div#contents {
	        border-bottom: 1px solid #66c; /* set border COLOR as desired */
	}

	tr.prev_dx_code td {
		background-color: #EEEEEE;
		color: black;
		cursor: pointer;
	}
	tr.prev_dx_code:hover td {
		background-color: #FFC211;
		text-weight: bold;
		cursor: pointer;
	}
</style>

<script language="javascript">
function return_code (code_type, code_id, code_num, code_text, code_mod, code_units, code_fee) {
	// Return the variable to calling window
	// use id=-1 to indicate that this is new and should be inserted (does not have a record to update)
	opener.document.<?=$form_name;?>.nosave_add_code_type.value  = code_type;
	opener.document.<?=$form_name;?>.nosave_add_code_id.value    = -1;//code_id;
	opener.document.<?=$form_name;?>.nosave_add_code_num.value   = code_num;
	opener.document.<?=$form_name;?>.nosave_add_code_text.value  = code_text;
	opener.document.<?=$form_name;?>.nosave_add_code_mod.value   = code_mod;
	opener.document.<?=$form_name;?>.nosave_add_code_units.value = code_units;
	opener.document.<?=$form_name;?>.nosave_add_code_fee.value   = code_fee;
	// trigger button's onblur, to tell form to update itself
	opener.document.<?=$form_name;?>.nosave_add_code.focus();
	opener.document.<?=$form_name;?>.nosave_add_code.blur();
	// Close this window
	//window.self.close();
}

function return_copay () {
	var amtfield = document.search_form.amt;
	var amt = amtfield.value;
	var amt_formatted;

	// cheap attempt to enforce format
	if(amt.indexOf(".") < 0)
		amt_formatted = amt + ".00";
	else	amt_formatted = amt;

	return_code ("COPAY", -1, amt_formatted, "copay", '', '', 0-amtfield.value);

	amtfield.value = '';

	// Close this window
	window.self.close();
}

function return_other () {
	var code = document.search_form.code.value;
	var text = document.search_form.text.value;
	var codefield = document.search_form.code;
	var textfield = document.search_form.text;
	var amtfield = document.search_form.amt;
	var amt = amtfield.value;
	var amt_formatted;

	// cheap attempt to enforce format
	if(amt.indexOf(".") < 0)
		amt_formatted = amt + ".00";
	else	amt_formatted = amt;

	return_code ("OTHER", -1, code, text, '', '', amt_formatted);

	amtfield.value = '';
	codefield.value = '';
	textfield.value = '';

	// Close this window
	window.self.close();
}

</script>
<title>Add Codes</title>
</head>
<?php 
	$tab = $_REQUEST['tab'] ? $_REQUEST['tab'] : 'prev_dx';
?>
<body id='<?php echo $tab?>' <?echo $bottom_bg_line;?> topmargin=0 rightmargin=0 leftmargin=2 bottommargin=0 marginwidth=2 marginheight=0>


<div>
	<ul id="tabnav">
		<li id="prev_dx_tab"><a href='<?php echo $thispage ?>&tab=prev_dx'>Previous Diagnoses</a></li>
		<li id="search_tab"><a href="<?php echo $thispage ?>&tab=search">Search Codes</a></li>
	</ul>
</div>
<?php
if ($tab == 'prev_dx'):
?>		

<div name='prev_dx'>
<table>
<tr><td valign=top>
<?php 
	// grab in two ways:
	$sql = sprintf("
		select distinct 
		       b.code_type,
		       b.code,
		       b.code_text,
			   date(( select (max(bx.date)) 
				   from billing bx
				  where bx.pid = b.pid
				    and bx.encounter < %d
				    and bx.code_type in ('ICD9')
				    and bx.code = b.code )) as maxdate
		  from billing b
		 where b.pid = %d
		   and b.encounter < %d
		   and b.code_type in ('ICD9')
		 order by b.date desc
	", 
		$encounter,	
		$pid,
		$encounter
	);
	
	if ($res = sqlStatement($sql) ) {
		for($iter=0; $row=sqlFetchArray($res); $iter++) {
			$result[$iter] = $row;
		}
		$count = 0;
		$total = 0;

		if ($result) {
			echo "<table>";
			echo "<tr>
				<td colspan=2><span class=text>Click on a code to add it to the encounter</span></td>
				<td><span class=text>Last Dx'd</span></td>
				</tr>
				";
			foreach ($result as $row) {
				
				$id	= $row['id'];
				$num	= $row['code'];
				$text	= $row['code_text'];
				$mod	= $row['modifier'];
				$units	= $row['units'];
				$fee	= $row['fee'];
				$code_type = $row['code_type'];
				
				echo "<tr class='prev_dx_code' 
					onclick='return_code (\"$code_type\", \"$id\", \"$num\", \"$text\", \"$modifier\", \"$units\", \"$fee\");'>";
				echo "<td class=text>". $num ."&nbsp;". $mod ."</td>";
				echo "<td class=text>". $text ."</td>";
				echo "<td>". $row['maxdate'] ."</td>";
				echo "</tr>";
							
			}
		}
	}
?>
</td></tr>
</table>
</div>
<?php 
elseif ($tab == 'search'):
?>
<table border=0 cellspacing=0 cellpadding=0 height=100% width=100%>
<tr>
<td background="<?echo $linepic;?>" width=7 height=100%>
&nbsp;
</td>
<td valign=top>

<form name='search_form' method='post' action='<?=$thispage;?>&tab=search<? if($code_type) echo "&code_type=$code_type"; ?>'>
<input type=hidden name=mode value="search">

<?
if($code_type == "") {

?>
<div class="bold" name='code_search'>
	&nbsp;<br/>
	&nbsp;<br/>
	&nbsp;<br/>
	&nbsp;<br/>
	&nbsp;<br/>
	<center>
	<p><a href="<?=$thispage;?>&code_type=CPT4&tab=search">CPT4</a></p>
	<p><a href="<?=$thispage;?>&code_type=HCPCS&tab=search">HCPCS</a></p>
	<p><a href="<?=$thispage;?>&code_type=ICD9&tab=search">ICD9</a></p>
	<p><a href="<?=$thispage;?>&code_type=copay&tab=search">Copay</a></p>
	<p><a href="<?=$thispage;?>&code_type=other&tab=search">Other</a></p>
	</center>
	</div>
	
	<!-- end mra section -->
	
	<?
	
	} else if($code_type == "copay") { // if code_type
	
	?>
	
	<a class="title" href="<?echo $thispage?>&tab=search">Copay <span class="bold">(back)</span></a>
	<br/>
	
	$<input type="text" name="amt" id="amt" value=""/>&nbsp;
	
	<button type="button" onclick="return_copay();">Add</button>
	
	<?
	
	} else if($code_type == "other") { // if code_type
	
	?>
	
	<a class="title" href="<?echo $thispage?>&tab=search">Other <span class="bold">(back)</span></a>
	<br/>
	
	<table>
	<tr>
	<td>Code</td><td>Description</td><td>Fee</td>
	</tr>
	<td><input type="text" name="code" id="code" value=""/></td>
	<td><input type="text" name="text" id="text" value=""/></td>
	<td>$<input type="text" name="amt"  id="amt"  value=""/></td>
	</tr>
	</table><br/>
	<button type="button" onclick="return_other();">Add</button>
	
	<?
	
	} else {
	?>
	
	
	<a class="title" href="<?echo $thispage?>&tab=search"><? echo $code_type ?> Codes <span class="bold">(back)</span></a>
	<br>
	
	<input type=entry size=15 name=text><a href="javascript:document.search_form.submit();" class="text">Search</a>
	</form>
	
	<?php
	if (isset($_POST["mode"]) && $_POST["mode"] == "search") {
		$sql = "select * from codes where (code_text like '%" . $_POST["text"] .
			"%' or code like '%" . $_POST["text"] . "%') and code_type = '" .
			$code_types[$code_type]['id'] . "' order by code limit " . ($M + 1);
	
		if ($res = sqlStatement($sql) ) {
			for($iter=0; $row=sqlFetchArray($res); $iter++)
			{
				$result[$iter] = $row;
			}
	?>
	
	<table><tr><td valign=top>
	<?php
			$count = 0;
			$total = 0;
	
			if ($result) {
				echo "<span class=text>Click on a code to add it to the encounter</span><br/>";
				foreach ($result as $row) {
					if ($count == $N) {
						echo "</td><td valign=top>\n";
						$count = 0;
					}
	
					$id	= $row['id'];
					$num	= $row['code'];
					$text	= $row['code_text'];
					$mod	= $row['modifier'];
					$units	= $row['units'];
					$fee	= $row['fee'];
	
					echo "<u><a class='text' href=\"#\" onclick='return_code (\"$code_type\", \"$id\", \"$num\", \"$text\", \"$modifier\", \"$units\", \"$fee\");'>"
						."<b>" . ${num} . "&nbsp;" . ${mod}
						."</b>" . " " . ${text}
						."</a></u><br>\n";
			
					$count++;
					$total++;
					if ($total == $M) {
						echo "</span><span class=alert>Some codes were not displayed.\n";
						break;
					}
				}
			}
	?>
	</td></tr></table>
	<?
		}
	}
	
	} // else code_type
	?>
	
	</td>
	</tr>
	
	</table>
</div>
<?php 
endif;
?>

<?php 
$query = "SELECT licTable.license_content FROM mmfemr_license as licTable,mmfemr_license_type as licTypeTable " .
      "WHERE (licTable.license_type = licTypeTable.license_type_id) AND licTypeTable.license_type_status=1"  ;
    
$res = sqlStatement($query);
    while ($row = sqlFetchArray($res)) {
      $content = stripslashes($row['license_content']);
    }
    echo $content;
      ?>


</body>
</html>
