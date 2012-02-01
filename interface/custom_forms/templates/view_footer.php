<table style='font-family:arial;font-size:14px;'><tr><td><table style="font-family:arial;font-size:14px;" cellspacing="2"><tbody>
<?php
$CurrentRow = 0;
while($row=sqlFetchArray($resFormAttr)) 
{	
	$rowindex	= 	$row['form_attr_row_index'];	
	$attrName	=	str_replace(" ","_",$row['attr_name']);
	$attrString =	"attribute_".$row['attr_id'];
	$attrData	=	$rowFormData[$attrString];
	if($row['attr_label_show'] == 'y'){

		if(!empty($row['attr_display_label'])){
			$attrDisplayName	=	"<td>".$row['attr_display_label']."</td>";
		}
		else{
			$attrDisplayName	=	"<td>".$row['attr_name']."</td>";				
		}	
			
	}
	else{
		$attrDisplayName	=	"";		
	}

	if($rowindex != $CurrentRow)
	{
			$CurrentRow = $rowindex;
			if($CurrentRow == 0)
			{
				echo "<tr>";
			}
			else
			{
				echo "</tr><tr>";
			}
			if($row['attr_type'] == 's')
			{
				if(!empty($row['attr_select_options'])){
					$options = "";
					$options = explode(",", $row['attr_select_options']);					
				}
				else{
					$sql		= "select id,concat(fname,' ',lname) as name from users";
					$resUser	= sqlStatement($sql);
					$options = "";
					$options = array();
					while($rowUser	= sqlFetchArray($resUser)){ 
						$options[] = $rowUser['name'];						
					}
					
				}
				echo $attrDisplayName;
				
?>				<td>
				<select id="<?=$attrName?>" name="<?=$attrName?>" style="width:180px;">				
<?php 				foreach($options as $val){
?>				
						<option value="<?php echo $val;?>"><?php echo $val;?></option>
<?php				} 
?>				
	<script>document.getElementById("<?=$attrName;?>").value = "<?=htmlspecialchars_decode($attrData);?>";</script>
<?php		}
			else if($row['attr_type'] == 'a')
			{ 
				echo $attrDisplayName;
?>				

				<td><textarea id="<?=$attrName?>" name="<?=$attrName?>" type="text" style='width:180px;'><?=htmlspecialchars_decode($attrData)?></textarea></td>
<?php		}
			else if($row['attr_type'] == 'f')
			{ 
?>
				<td><?=$row['attr_fixed_text'];?></td>
<?php		}
			else if($row['attr_type'] == 'c')
			{	
				$options = "";
				$options = explode(",", $row['attr_select_options']);
				echo $attrDisplayName;
?>				<td>
<?php			$k	=	1;
				foreach($options as $val){	
					$attrNameNew = $attrName ."_".$k;
					$optionsData = explode(",", $attrData);
					if(in_array($val, $optionsData)){
						$checked = "checked";	
					} else{
						$checked = "";
					}
					
?>				
					<input id="<?=$attrNameNew?>" name="<?=$attrNameNew?>" type="checkbox" value="<?=$val;?>" style='width:180px;' <?=$checked;?>><?=$val?>					
<?php			$k = $k + 1;
				}
?>				</td>
			
<?php		}
			else if($row['attr_type'] == 'r')
			{ 
				$options = "";
				$options = explode(",", $row['attr_select_options']);			
				echo $attrDisplayName;
?>				<td>
<?php			
				foreach($options as $val){	
?>				
					<input id="<?=$attrName?>" name="<?=$attrName?>" type="radio" value="<?=$val;?>" style='width:180px;' <?=($val == htmlspecialchars_decode($attrData) ? "checked" :'')?>><?=$val?>					
<?php				
				}
?>				</td>
<?php		}
			else if($row['attr_type'] == 'd')
			{ 
				echo $attrDisplayName;		
?>				
				<td><input id="<?=$attrName?>" name="<?=$attrName?>" type="text" readonly value="<?=$attrData;?>"  style='width:150px;' onkeyup='datekeyup(this,mypcc)' onblur='dateblur(this,mypcc)' title='yyyy-mm-dd'><img src='<?php echo $GLOBALS['webroot'] ?>/interface/pic/show_calendar.gif' align='absbottom' width='24' height='22' id='img_<?=$attrName?>' border='0' alt='[?]' style='cursor:pointer' title='Click here to choose a date' ></td>
<?php		}
			else
			{ 
				echo $attrDisplayName;
?>
				
				<td><input id="<?=$attrName?>" name="<?=$attrName?>" type="text" value="<?=htmlspecialchars_decode($attrData)?>" style='width:180px;'></td>
<?php		} 
		}
		else
		{
			if($row['attr_type'] == 's')
			{
				if(!empty($row['attr_select_options'])){
					$options = "";
					$options = explode(",", $row['attr_select_options']);					
				}
				else{
					$sql		= "select id,concat(fname,' ',lname) as name from users";
					$resUser	= sqlStatement($sql);
					$options	= array();
					$options	= "";
					while($rowUser	= sqlFetchArray($resUser)){ 
						$options[] = $rowUser['name'];						
					}
					
				}
				echo $attrDisplayName;
				
?>				<td>
				<select id="<?=$attrName?>" name="<?=$attrName?>" style="width:180px;">				
<?php 				foreach($options as $val){
?>				
						<option value="<?php echo $val;?>"><?php echo $val;?></option>
<?php				} 
?>				
	<script>document.getElementById("<?=$attrName;?>").value = "<?=htmlspecialchars_decode($attrData);?>";</script>
				
<?php		}
			else if($row['attr_type'] == 'a')
			{ 
				echo $attrDisplayName;
?>				
				<td><textarea id="<?=$attrName?>" name="<?=$attrName?>" type="text" style='width:180px;'><?=htmlspecialchars_decode($attrData)?></textarea></td>
<?php		}
			else if($row['attr_type'] == 'f')
			{ 
?>
				<td><?=$row['attr_fixed_text'];?></td>
<?php		}
			else if($row['attr_type'] == 'c')
			{	
				$options = "";
				$options = explode(",", $row['attr_select_options']);	
				echo $attrDisplayName;
?>				<td>
<?php			$k	=	1;
				foreach($options as $val){	
?>				
					<input id="<?=$attrName?>" name="<?=$attrName?>" type="checkbox" value="<?=$val;?>" style='width:180px;' <?=($val == htmlspecialchars_decode($attrData) ? "checked" :'')?>><?=$val?>					
<?php			$k = $k + 1;
				}
?>				</td>
			
<?php		}
			else if($row['attr_type'] == 'r')
			{ 
				$options = "";
				$options = explode(",", $row['attr_select_options']);			
				echo $attrDisplayName;
?>				<td>
<?php			
				foreach($options as $val){	
?>				
					<input id="<?=$attrName?>" name="<?=$attrName?>" type="radio" value="<?=$val;?>" style='width:180px;' <?=($val == htmlspecialchars_decode($attrData) ? "checked" :'')?>><?=$val?>					
<?php				
				}
?>				</td>
<?php		}	
			else if($row['attr_type'] == 'd')
			{ 
				echo $attrDisplayName;		
?>				
				<td><input id="<?=$attrName?>" name="<?=$attrName?>" type="text" readonly value="<?=$attrData;?>"  style='width:150px;' onkeyup='datekeyup(this,mypcc)' onblur='dateblur(this,mypcc)' title='yyyy-mm-dd'><img src='<?php echo $GLOBALS['webroot'] ?>/interface/pic/show_calendar.gif' align='absbottom' width='24' height='22' id='img_<?=$attrName?>' border='0' alt='[?]' style='cursor:pointer' title='Click here to choose a date' ></td>
<?php		}
			else
			{ 
				echo $attrDisplayName;
?>				
				<td><input id="<?=$attrName?>" name="<?=$attrName?>" type="text" value="<?=htmlspecialchars_decode($attrData)?>" style='width:180px;'></td>
<?php		} 
		}
}
?>
<tr style="font-size:14px;"><td colspan="2"><div id="tableDiv" style="display: inline; "><table border="1" width="100%" cellpadding="4"><tbody><tr style="border:1px solid;font-size:15px;color:#bc1212"><td colspan="2" align="center">Attribute Properties</td></tr><tr><td>Name</td><td>Value</td></tr><tr style="font-size:12px;"><td>Required</td><td>Yes</td></tr><tr style="font-size:12px;"><td>Max Length</td><td>10</td></tr><tr style="font-size:12px;"><td>Input validation</td><td>numeric</td></tr></tbody></table></div></td></tr></tbody></table></td></tr><tr><td colspan='2'><input type='submit' name='UpdateForm' value='Update & Submit'></td></tr></table> <input type='hidden' name='form_id' value='<?=$form_id;?>'></form></td></tr></table>
</body>
</html>


