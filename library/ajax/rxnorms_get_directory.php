<?php
/*******************************************************************/
// Copyright (C) 2008 Phyaura, LLC <info@phyaura.com>
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
/*******************************************************************/
// This file allows pulls down and installs the archive file
//  The archive is uncompressed, and the db tables are created if they don't already exist
/*******************************************************************/

include_once("../../interface/globals.php");
include_once("{$GLOBALS['srcdir']}/sql.inc");
include_once("{$GLOBALS['srcdir']}/rxnorms_capture.inc");
include_once("{$GLOBALS['srcdir']}/formdata.inc.php");

if(!$rxnorms) return;
//if(!$GLOBALS['ndc_zip_url']) return;


//$GLOBALS['rxnorms_fileurl']="http://download.nlm.nih.gov/umls/kss/rxnorm/RxNorm_full_05022011.zip";

$source_directry_for_rxnorms_files=$GLOBALS['rxnorms_fileurl'];

$dir = $GLOBALS['fileroot']."/contrib/rxnorms";
$dest = $GLOBALS['fileroot']."/contrib/rxnorms/RxNorm_full_05022011.zip";
if( !is_dir($dir) )
    @mkdir($dir,0777,1);

if(!file_exists($dest))
{
   $error = 'Archieve Not found';
} else {
    if( !file_exists($dest))
      $error = " : File does not exist";
    else
     // if( !chmod($dest,0777)) {
      //  $error = " : Not able to move to Destination (not writable)";
      //}else{
				$zip = new ZipArchive;
				//$dir=".";
				//if( !is_dir($dir) )
					//@mkdir($dir,0777,1);
				if ($zip->open($dest) === TRUE) {
					$zip->extractTo($dir); //extract  zip archive content to rxnorms folder.
					$zip->close();
					//echo 'ok'; // content extracted.
				} else {
					 $error = "Not able to open Archive";
				}
				
				$pathtoscan=$dir."/scripts/mysql/";
				$destination=$dir."/rrf/";
				$list_of_files=scandir($pathtoscan); // read the files from directry and copy them to seprate folder
				$flag=false;
				foreach($list_of_files as $file_names){
					if($file_names=='.' or $file_names=='..'){
					}else{
						if(!copy($pathtoscan.$file_names,$destination.$file_names)){
							$flag=true;
						}
					}
				}	
				if($flag==false)
				{
					 $success = "Completed Successfully";
				}
			
	   
	   
	   
     // }
}
if( $error )
    echo "<b>".$error."</b>";
else
		 echo "<i>".$success."</i>";
?>
