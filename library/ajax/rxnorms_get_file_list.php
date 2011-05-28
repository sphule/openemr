<?php
/*******************************************************************/
// Copyright (C) 2008 Phyaura, LLC <info@phyaura.com>
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
/*******************************************************************/
// This will refresh the ndc file list
/*******************************************************************/

include_once("../../interface/globals.php");
include_once("{$GLOBALS['srcdir']}/rxnorms_capture.inc");
//echo $GLOBALS['srcdir'];
if(!$rx) return;
//print_r($rx_info);
$display_files = array();
//echo $dir;
if( is_dir($dir) && $handle = opendir($dir)) {
    while (false !== ($filename = readdir($handle))) {
        if ($filename != "." && $filename != ".." && substr($filename,0,5) != "load_" )
        {
          $lfilename = strtolower($filename);
           $file = $dir."/".$filename;
           $check = explode(".",$lfilename);
           if( in_array($check[0],array_keys($rx_info)) )
               $display_files[] = "<tr><td>&nbsp;</td><td>".$rx_info[$check[0]]['filename']."</td><td>".filesize($file)."</td><td>".@date("Y-m-d H:i:s",filemtime($file))."</td></tr>\n";
        }
    }
    closedir($handle);
}
?>
        <table cellspacing='0' align='center'>
          <tr class='ndc_head'>
		  <th>&nbsp;</th>
            <th>File data</th>
            <th>Size</th>
            <th>Last Updated</th>
          </tr>
<?php
$button='';
if(count($display_files)==9)
{
	$button='<tr><td colspan="4" height="25" align="center"><div id="loader_span"  ></div></td></tr><tr><td colspan="4" align="center"><input type="button" name="load_script" id="load_script" value="Load" ></td></tr>';
}
if (!empty($display_files)) {
   foreach( $display_files as $row ) {
       echo $row;
   }
   echo $button;
}
?>
        </table>