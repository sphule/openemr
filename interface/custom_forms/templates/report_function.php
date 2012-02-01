_report( $pid, $encounter, $cols, $form_id) {
?>
	<table border=0>
<?
	
	$sql = "SELECT attr_id from csf_forms_attributes where form_id = ".$form_id;													
	$res = sqlStatement($sql);	

	$attributeArray = array();
	$i =0;
	while($row = sqlFetchArray($res)){

		$attributeArray[$i] = $row['attr_id'];
			$i =$i + 1 ;
	}

	$sql="	SELECT	* FROM	csf_form_data a, csf_forms b WHERE	a.form_id = b.form_id AND a.form_id = ".$form_id." and a.encounter=".$encounter;

	$stmt = sqlStatement($sql);
     while($row = sqlFetchArray($stmt)) {

		foreach($row as $key => $val){

			$str = str_split($key, 9);

			if($str[0] == "attribute"){

				$strN		=	explode("_", $str[1]);
				$response = in_array($strN[1],$attributeArray);
				if($response == 1){
				$sql		=	"SELECT	case attr_display_label when  '' then attr_name when (NULL) then attr_name else attr_display_label end as `attr_name`,attr_type FROM	csf_attributes WHERE attr_id = ".$strN[1];
				$stmt		=	sqlStatement($sql);
				$rowAttr	=	sqlFetchArray($stmt);
				$attrName	=	$rowAttr['attr_name'];
				if($rowAttr['attr_type'] != 'f'){
				?>

					<tr>
						<td valign="top" class=bold><?=$rowAttr['attr_name']?>:</td>
						<td valign="top" class=small><?=nl2br($row[$key])?></span></td>
					</tr>
				<?php
				}
					}
				}
		}		      
    }
?>	
</table>
<? } # end report function ?>

