<?php
/*******************************************************************/
// Copyright (C) 2008 Phyaura, LLC <info@phyaura.com>
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
/*******************************************************************/
// This search the NDC for a drug by name
// Returns a match list containing drug name, strength and
// unit as displayed also returns list id, ndc number and name
// as hidden values, the function calling this can then pull
// those hidden values out for use
/*******************************************************************/

include_once("../../interface/globals.php");
include_once("{$GLOBALS['srcdir']}/sql.inc");
include_once("{$GLOBALS['srcdir']}/formdata.inc.php");

$q = formData("q","G",true);
if (!trim($q)) return;

$drug = explode("  ",$q);
//$sql="SELECT list_id, CONCAT_WS('-',label_code,product_code) AS ndc, name, strength, unit FROM ndc_drug_list";
$sql="SELECT RXAUI as list_id, CODE AS ndc, STR as name FROM RXNCONSO ";
//AND SAB =  'RXNORM'
if($drug[0] != ""){
    $find = mysql_real_escape_string($drug[0]);
    $sql .= " WHERE STR LIKE '%$find%' and TTY IN('SCD','SBD')  ";
}
$sql .= "  group by STR ORDER BY STR limit 0,30";
//echo $sql;
$result = sqlStatement($sql);
while( $row = sqlFetchArray($result) ) {
       //$strength = explode(";",$row['strength']);
       //$unit = explode(";",$row['unit']);
       //$dose = implode("-",$strength)." ".$unit[0];

       echo $row['name']."  ".$dose."|".$row['list_id']."#".$row['ndc']."#".$row['name']."\n";
}
?>
