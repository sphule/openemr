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
//ini_set('display_errors',1);
include_once("../../interface/globals.php");
include_once("{$GLOBALS['srcdir']}/sql.inc");
include_once("{$GLOBALS['srcdir']}/rxnorms_capture.inc");
//echo $GLOBALS['srcdir'];
if(!$rx) return;


$display_files = array();
//echo $dir;
set_time_limit(0);
ini_set('memory_limit', '150M');
//$mysqli = new mysqli($host, $login, $pass, $dbase);

//if (mysqli_connect_errno()) {
  //  printf("Connect failed: %s\n", mysqli_connect_error());
    //exit();
//}

 $file = file_get_contents($dir.'/Table_scripts_mysql_rxn.sql', true);
 $data = file_get_contents($dir.'/Load_scripts_mysql_rxn_win.sql', true);
 $indexes = file_get_contents($dir.'/Indexes_mysql_rxn.sql', true);
 
	
	/*
	$file_array=explode(";",$file.$indexes);
 
	$file_names_array=explode(",",$file_names);
  foreach($file_names_array as $file_n){
	$file_without_dot=explode(".",$file_n);
	foreach($file_array as $file_name){
		if(strpos($file_name,$file_without_dot[0]))	{
		$new_array_store[]=$file_name;
		
		}
		
	
	}
  }
  
  */
  //$final_structure_query=implode(";",$new_array_store);
//echo $final_structure_query;
  //print_r($new_array_store);
 
 /**
 * Creating the structure  for table and applying indexes
 **/
 //sqlQuery
 
 $file_array=explode(";",$file);
 
 foreach($file_array as $val){
	 if(trim($val)!='')
	 {
		sqlStatement($val);
	 }
 
 }
 
 $indexes_array=explode(";",$indexes);

 foreach($indexes_array as $val1){
 	 if(trim($val1)!='')
	 {
		sqlStatement($val1);
	 }

 
 }
 


$data=explode(";",$data);

	foreach($data as $val)
	{
		
		
		foreach($rx_info as $key => $value)
		{
		 	$file_name= $value['origin'];
			$replacement=$dir."/".$file_name;
			
			$pattern='/'.$file_name.'/';
			if(strpos($val,$file_name))	{
				 $val1[]=	str_replace($file_name,$replacement,$val);
			}		
		}
		
	
	
	}



	
	foreach($val1 as $val){
		if(trim($val)!='')	{
			sqlStatement($val);
		}
	}
	
	
	
	

/* close connection */

 

?>