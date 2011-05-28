<?php
/*******************************************************************/
// Copyright (C) 2008 Phyaura, LLC <info@phyaura.com>
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
/*******************************************************************/
// This file is included in the ndc file/data processing scripts
/*******************************************************************/

// Set path constants
$rxnormsPATH = $GLOBALS['fileroot']."/contrib/rxnorms";
$dir = $rxnormsPATH."/rrf";
$dirScripts = $rxnormsPATH."/scripts/mysql";

$rx_info = array();
$rx_info['rxnatomarchive'] = array('title' => "Archive Data", 'dir' => "$dir", 'origin' => "RXNATOMARCHIVE.RRF", 'filename' => "RXNATOMARCHIVE.RRF", 'table' => "rxnatomarchive", 'required' => 0);
$rx_info['rxnconso'] = array('title' => "Concept Names and Sources", 'dir' => "$dir", 'origin' => "RXNCONSO.RRF", 'filename' => "RXNCONSO.RRF", 'table' => "rxnconso",	'required' => 1);
$rx_info['rxncui'] = array('title' => "Retired RXCUI Data", 'dir' => "$dir", 'origin' => "RXNCUI.RRF", 'filename' => "RXNCUI.RRF", 'table' => "rxncui", 'required' => 1);
$rx_info['rxncuichanges'] = array('title' => "Concept Changes", 'dir' => "$dir", 'origin' => "RXNCUICHANGES.RRF", 'filename' => "RXNCUICHANGES.RRF", 'table' => "rxncuichanges", 'required' => 1);
$rx_info['rxndoc'] = array('title' => "Documentation for Abbreviated Values", 'dir' => "$dir", 'origin' => "RXNDOC.RRF", 'filename' => "RXNDOC.RRF", 'table' => "rxndoc", 'required' => 1);
$rx_info['rxnrel'] = array('title' => "Relationships", 'dir' => "$dir", 'origin' => "RXNREL.RRF", 'filename' => "RXNREL.RRF", 'table' => "rxnrel", 'required' => 1);
$rx_info['rxnsab'] = array('title' => "Source Information", 'dir' => "$dir", 'origin' => "RXNSAB.RRF", 'filename' => "RXNSAB.RRF", 'table' => "rxnsab", 'required' => 0);
$rx_info['rxnsat'] = array('title' => "Simple Concept and Atom Attributes", 'dir' => "$dir", 'origin' => "RXNSAT.RRF", 'filename' => "RXNSAT.RRF", 'table' => "rxnsat", 'required' => 0);
$rx_info['rxnsty'] = array('title' => "Semantic Types ", 'dir' => "$dir", 'origin' => "RXNSTY.RRF", 'filename' => "RXNSTY.RRF", 'table' => "rxnsty", 'required' => 1);

// get ndc table list
$list_tables_rx = array();
$result = sqlStatement("SHOW TABLES LIKE 'rx%'");
while($row=sqlFetchArray($result)) {
    //echo "Table: {$row[0]}<br>\n";
    $list_tables_rx[] = $row[0];
}

$load_exists = false;
$rx_files = array();
if( is_dir($dir) && $handle = opendir($dir)) {
    while (false !== ($filename = readdir($handle))) {
        if( substr($filename,0,5) == "load_" ) {
            $load_exists = true;
        }elseif( $filename != "." && $filename != ".." )
        {
           $lfilename = strtolower($filename);
           $check = explode(".",$lfilename);
           if( in_array($check[0],array_keys($rx_info)) )
           $rx_files[$filename] = $rx_info[$check[0]]['title'];
        }
    }
    closedir($handle);
   //$ndc_files['ndc_code_list'] = $ndc_info['ndc_code_list']['title'];
}
?>
