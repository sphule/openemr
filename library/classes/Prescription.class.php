<?php
require_once (dirname(__FILE__) . "/../sql.inc");
require_once (dirname(__FILE__) . "/../lists.inc");
require_once("ORDataObject.class.php");
require_once("Patient.class.php");
require_once("Person.class.php");
require_once("Provider.class.php");
require_once("Pharmacy.class.php");
require_once("NumberToText.class.php");
//below is required for the set_medication() function
require_once (dirname(__FILE__) . "/../formdata.inc.php");

// Below list of terms are deprecated, but we keep this list
//   to keep track of the official openemr drugs terms and
//   corresponding ID's for reference. Official is referring
//   to the default settings after installing OpenEMR.
//
// define('UNIT_BLANK',0);
// define('UNIT_MG',1);
// define('UNIT_MG_1CC',2);
// define('UNIT_MG_2CC',3);
// define('UNIT_MG_3CC',4);
// define('UNIT_MG_4CC',5);
// define('UNIT_MG_5CC',6);
// define('UNIT_MCG',7);
// define('UNIT_GRAMS',8);
//
// define('INTERVAL_BLANK',0);
// define('INTERVAL_BID',1);
// define('INTERVAL_TID',2);
// define('INTERVAL_QID',3);
// define('INTERVAL_Q_3H',4);
// define('INTERVAL_Q_4H',5);
// define('INTERVAL_Q_5H',6);
// define('INTERVAL_Q_6H',7);
// define('INTERVAL_Q_8H',8);
// define('INTERVAL_QD',9);
// define('INTERVAL_AC',10); // added May 2008
// define('INTERVAL_PC',11); // added May 2008
// define('INTERVAL_AM',12); // added May 2008
// define('INTERVAL_PM',13); // added May 2008
// define('INTERVAL_ANTE',14); // added May 2008
// define('INTERVAL_H',15); // added May 2008
// define('INTERVAL_HS',16); // added May 2008
// define('INTERVAL_PRN',17); // added May 2008
// define('INTERVAL_STAT',18); // added May 2008
//
// define('FORM_BLANK',0);
// define('FORM_SUSPENSION',1);
// define('FORM_TABLET',2);
// define('FORM_CAPSULE',3);
// define('FORM_SOLUTION',4);
// define('FORM_TSP',5);
// define('FORM_ML',6);
// define('FORM_UNITS',7);
// define('FORM_INHILATIONS',8);
// define('FORM_GTTS_DROPS',9);
// define('FORM_CR',10);
// define('FORM_OINT',11);
//
// define('ROUTE_BLANK',0);
// define("ROUTE_PER_ORIS", 1);
// define("ROUTE_PER_RECTUM", 2);
// define("ROUTE_TO_SKIN", 3);
// define("ROUTE_TO_AFFECTED_AREA", 4);
// define("ROUTE_SUBLINGUAL", 5);
// define("ROUTE_OS", 6);
// define("ROUTE_OD", 7);
// define("ROUTE_OU", 8);
// define("ROUTE_SQ", 9);
// define("ROUTE_IM", 10);
// define("ROUTE_IV", 11);
// define("ROUTE_PER_NOSTRIL", 12);
// define("ROUTE_B_EAR", 13);
// define("ROUTE_L_EAR", 14);
// define("ROUTE_R_EAR", 15);
//
// define('SUBSTITUTE_YES',1);
// define('SUBSTITUTE_NO',2);
//

// Added 7-2009 by BM to incorporate the units, forms, interval, route lists from list_options
//  This mechanism may only be temporary; will likely migrate changes more downstream to allow
//   users the options of using the addlist widgets and validation frunctions from options.inc.php
//   in the forms and output.
function load_drug_attributes($id) {
    $res = sqlStatement("SELECT * FROM list_options WHERE list_id = '$id' ORDER BY seq");
    while ($row = sqlFetchArray($res)) {
	if ($row['title'] == '') {
	 $arr[$row['option_id']] = ' ';
	}
	else {
         $arr[$row['option_id']] = xl_list_label($row['title']);
	}
    }
    return $arr;
}

/**
 * class Prescription
 *
 */
class Prescription extends ORDataObject {
    
    /**
     *
     * @access public
     */
    
    /**
     *
     * static
     */
    var $form_array;
    var $unit_array;
    var $route_array;
    var $interval_array;
    var $substitute_array;
    var $medication_array;
    var $refills_array;
    
    /**
     *
     * @access private
     */
    
    var $id;
    var $patient;
    var $pharmacist;
    var $date_added;
    var $date_modified;
    var $pharmacy;
    var $start_date;
    var $filled_date;
    var $provider;
    var $note;
    var $drug;
    var $form;
    var $dosage;
    var $quantity;
    var $size;
    var $unit;
    var $route;
    var $interval;
    var $substitute;
    var $refills;
    var $per_refill;
    var $medication;
	var $sig;

    var $drug_id;
    var $active;

    /**
    * Constructor sets all Prescription attributes to their default value
    */
    
    function Prescription($id= "", $_prefix = "") {
    
	// Modified 7-2009 by BM to load the arrays from the lists in lists_options.
	// Plan for this to only be temporary, hopefully have the lists used directly
	//  from forms in future to allow use of widgets etc.
        $this->route_array = load_drug_attributes('drug_route');        
        $this->form_array = load_drug_attributes('drug_form');
        $this->interval_array = load_drug_attributes('drug_interval');
	$this->unit_array = load_drug_attributes('drug_units');

        $this->substitute_array = array("",xl("substitution allowed"),
            xl ("do not substitute"));
    
        $this->medication_array = array(0 => xl('No'), 1 => xl('Yes'));
    
        $this->unit_array = array(" ",xl("mg"), xl("mg/1cc"), "", "", "",
            xl("mg/5cc"), xl ("mcg"));
    
        if (is_numeric($id)) { $this->id = $id; }
        else { $id = "";}

//			$this->unit = UNIT_MG;
        //$this->route = ROUTE_PER_ORIS;
        //$this->quantity = 1;
        //$this->size = 1;
        $this->refills = 0;
        //$this->form = FORM_TABLET;
        $this->substitute = false;
        $this->_prefix = $_prefix;
        $this->_table = "prescriptions";
        $this->pharmacy = new Pharmacy();
        $this->pharmacist = new Person();
        $this->provider = new Provider($_SESSION['authId']);
        $this->patient = new Patient();
        $this->start_date = date("Y-m-d");
        $this->date_added = date("Y-m-d");
        $this->date_modified = date("Y-m-d");
        $this->per_refill = 0;
        $this->note = "";
        
        $this->drug_id = 0;
        $this->active = 1;
        
        for($i=0;$i<21;$i++) {
            $this->refills_array[$i] = sprintf("%02d",$i);
        }

        if ($id != "") { $this->populate(); }
    }

    function persist() {
        $this->date_modified = date("Y-m-d");
        if ($this->id == "") { $this->date_added = date("Y-m-d"); }
        if (parent::persist()) { }
    }

    function populate() {
        parent::populate();
    }

    function toString($html = false) {
        $string .= "\n"
        	."ID: " . $this->id . "\n"
        	."Patient:" . $this->patient . "\n"
        	."Patient ID:" . $this->patient->id . "\n"
        	."Pharmacist: " . $this->pharmacist . "\n"
        	."Pharmacist ID: " . $this->pharmacist->id . "\n"
        	."Date Added: " . $this->date_added. "\n"
        	."Date Modified: " . $this->date_modified. "\n"
        	."Pharmacy: " . $this->pharmacy. "\n"
        	."Pharmacy ID:" . $this->pharmacy->id . "\n"
        	."Start Date: " . $this->start_date. "\n"
        	."Filled Date: " . $this->filled_date. "\n"
        	."Provider: " . $this->provider. "\n"
        	."Provider ID: " . $this->provider->id. "\n"
        	."Note: " . $this->note. "\n"
        	."Drug: " . $this->drug. "\n"
//        	."Form: " . $this->form_array[$this->form]. "\n"
	    	."Form: " . $this->form. "\n"
        	."Dosage: " . $this->dosage. "\n"
        	."Qty: " . $this->quantity. "\n"
        	."Size: " . $this->size. "\n"
//        	."Unit: " . $this->unit_array[$this->unit] . "\n"
            ."Unit: " . $this->unit . "\n"
//        	."Route: " . $this->route_array[$this->route] . "\n"
        	."Route: " . $this->route. "\n"
        	."Interval: " .$this->interval_array[$this->interval]. "\n"
        	."Substitute: " . $this->substitute_array[$this->substitute]. "\n"
        	."Refills: " . $this->refills. "\n"
        	."Per Refill: " . $this->per_refill . "\n"
        	."Drug ID: " . $this->drug_id . "\n"
        	."Active: " . $this->active;

        if ($html) { return nl2br($string); }
        else { return $string; }
    }

    function get_unit_display( $display_form="" ) {
    	return( $this->unit_array[$this->unit] );
    }

    function get_unit() {
        return $this->unit;
    }
    function set_unit($unit) {
    $this->unit = $unit; 
    }

    function set_id($id) {
        if (!empty($id) && is_numeric($id)) { $this->id = $id; }
    }
    function get_id() {
        return $this->id;
    }

    function get_dosage_display( $display_form="" ) {
        if( empty($this->form) && empty($this->interval) ) {
            return( $this->dosage );
        }
        else {
            return ($this->dosage . " " . xl('in') . " " . $this->form . " " . $this->interval_array[$this->interval]);
        } 
    }

    function set_dosage($dosage) {
    	$this->dosage = $dosage;
    }
    function get_dosage() {
        return $this->dosage;
    }

  function set_sig($sig) {
    	$this->sig = $sig;
    }
    function get_sig() {
        return $this->sig;
    }


    function set_form($form) {
//        if (is_numeric($form)) { $this->form = $form; }
$this->form = $form;
    }
    function get_form() {
        return $this->form;
    }
    
    function set_refills($refills) {
        if (is_numeric($refills)) { $this->refills = $refills; }
    }
    function get_refills() {
        return $this->refills;
    }

    function set_size($size) {
//        if (is_numeric($size)) { $this->size = $size; }
$this->size = $size; 
    }
    function get_size() {
        return $this->size;
    }

    function set_quantity($qty) {
    // if (is_numeric($qty)) {
        $this->quantity = $qty;
    // }
    }
    function get_quantity() {
        return $this->quantity;
    }
    
    function set_route($route) {
//        if (is_numeric($route)) { $this->route = $route; }
$this->route = $route; 
    }
    function get_route() {
        return $this->route;
    }
    
    function set_interval($interval) {
        if (is_numeric($interval)) { $this->interval = $interval; }
    }
    function get_interval() {
        return $this->interval;
    }

    function set_substitute($sub) {
        if (is_numeric($sub)) { $this->substitute = $sub; }
    }
    function get_substitute() {
        return $this->substitute;
    }

    function set_medication($med) {
        global $ISSUE_TYPES;

        $this->medication = $med;

        // Avoid making a mess if we are not using the "medication" issue type.
        if (isset($ISSUE_TYPES) && !$ISSUE_TYPES['medication']) return;
	
        //below statements are bypassing the persist() function and being used directly in database statements, hence need to use the functions in library/formdata.inc.php
	// they have already been run through populate() hence stripped of escapes, so now need to be escaped for database (add_escape_custom() function).
	
        //check if this drug is on the medication list
        $dataRow = sqlQuery("select id from lists where type = 'medication' and activity = 1 and (enddate is null or cast(now() as date) < enddate) and upper(trim(title)) = upper(trim('" . add_escape_custom($this->drug) . "')) and pid = " . add_escape_custom($this->patient->id) . ' limit 1');

        if ($med && !isset($dataRow['id'])){
            $dataRow = sqlQuery("select id from lists where type = 'medication' and activity = 0 and (enddate is null or cast(now() as date) < enddate) and upper(trim(title)) = upper(trim('" . add_escape_custom($this->drug) . "')) and pid = " . add_escape_custom($this->patient->id) . ' limit 1');

            if (!isset($dataRow['id'])){
                //add the record to the medication list
                sqlInsert("insert into lists(date,begdate,type,activity,pid,user,groupname,title) values (now(),cast(now() as date),'medication',1," . add_escape_custom($this->patient->id) . ",'" . $$_SESSION['authUser']. "','" . $$_SESSION['authProvider'] . "','" . add_escape_custom($this->drug) . "')");
            }
            else {
                $dataRow = sqlQuery('update lists set activity = 1'
                            . " ,user = '" . $$_SESSION['authUser']
                            . "', groupname = '" . $$_SESSION['authProvider'] . "' where id = " . $dataRow['id']);
            }
        }
        elseif (!$med && isset($dataRow['id'])) {
            //remove the drug from the medication list if it exists
            $dataRow = sqlQuery('update lists set activity = 0'
                            . " ,user = '" . $$_SESSION['authUser']
                            . "', groupname = '" . $$_SESSION['authProvider'] . "' where id = " . $dataRow['id']);
        }
    }

    function get_medication() {
        return $this->medication;
    }
    
    function set_per_refill($pr) {
        if (is_numeric($pr)) { $this->per_refill = $pr; }
    }
    function get_per_refill() {
        return $this->per_refill;
    }

    function set_patient_id($id) {
        if (is_numeric($id)) { $this->patient = new Patient($id); }
    }
    function get_patient_id() {
        return $this->patient->id;
    }

    function set_provider_id($id) {
        if (is_numeric($id)) { $this->provider = new Provider($id); }
    }
    function get_provider_id() {
        return $this->provider->id;
    }

    function set_provider($pobj) {
        if (get_class($pobj) == "provider") { $this->provider = $pobj; }
    }
    
    function set_pharmacy_id($id) {
        if (is_numeric($id)) { $this->pharmacy = new Pharmacy($id); }
    }
    function get_pharmacy_id() {
        return $this->pharmacy->id;
    }

    function set_pharmacist_id($id) {
        if (is_numeric($id)) { $this->pharmacist = new Person($id); }
    }
    function get_pharmacist() {
        return $this->pharmacist->id;
    }

    function get_start_date_y() {
        $ymd = split("-",$this->start_date);
        return $ymd[0];
    }
    function set_start_date_y($year) {
        if (is_numeric($year)) {
            $ymd = split("-",$this->start_date);
            $ymd[0] = $year;
            $this->start_date = $ymd[0] ."-" . $ymd[1] ."-" . $ymd[2];
        }
    }
    function get_start_date_m() {
        $ymd = split("-",$this->start_date);
        return $ymd[1];
    }
    function set_start_date_m($month) {
        if (is_numeric($month)) {
            $ymd = split("-",$this->start_date);
            $ymd[1] = $month;
            $this->start_date = $ymd[0] ."-" . $ymd[1] ."-" . $ymd[2];
        }
    }
    function get_start_date_d() {
        $ymd = split("-",$this->start_date);
        return $ymd[2];
    }
    function set_start_date_d($day) {
        if (is_numeric($day)) {
            $ymd = split("-",$this->start_date);
            $ymd[2] = $day;
            $this->start_date = $ymd[0] ."-" . $ymd[1] ."-" . $ymd[2];
        }
    }
    function get_start_date() {
        return $this->start_date;
    }
    function set_start_date($date) {
        return $this->start_date = $date;
    }

    function get_date_added() {
        return $this->date_added;
    }
    function set_date_added($date) {
        return $this->date_added = $date;
    }

    function get_date_modified() {
        return $this->date_modified;
    }
    function set_date_modified($date) {
        return $this->date_modified = $date;
    }

    function get_filled_date() {
        return $this->filled_date;
    }
    function set_filled_date($date) {
        return $this->filled_date = $date;
    }

    function set_note($note) {
        $this->note = $note;
    }
    function get_note() {
        return $this->note;
    }

    function set_drug($drug) {
        $this->drug = $drug;
    }
    function get_drug() {
        return $this->drug;
    }

    function get_filled_by_id() {
        return $this->pharmacist->id;
    }
    function set_filled_by_id($id) {
        if (is_numeric($id)) { return $this->pharmacist->id = $id; }
    }

    function set_drug_id($drug_id) {
        $this->drug_id = $drug_id;
    }
    function get_drug_id() {
        return $this->drug_id;
    }

    function set_active($active) {
        $this->active = $active;
    }
    function get_active() {
        return $this->active;
    }
    
    function get_prescription_display() {
        $pconfig = $GLOBALS['oer_config']['prescriptions'];
        
        switch ($pconfig['format']) {
            case "FL":
                return $this->get_prescription_florida_display();
                break;
            default:
                break;
        }

        $sql = "SELECT * FROM users JOIN facility AS f ON f.name = users.facility where users.id ='" . mysql_real_escape_string($this->provider->id) . "'";
        $db = get_db();
        $results = $db->Execute($sql);
        if (!$results->EOF) {
            $string = $results->fields['name'] . "\n"
                    . $results->fields['street'] . "\n"
                    . $results->fields['city'] . ", " . $results->fields['state'] . " " . $results->fields['postal_code'] . "\n"
                    . $results->fields['phone'] . "\n\n";
        }
        
        $string .= ""
                ."Prescription For:" . "\t" .$this->patient->get_name_display() . "\n"
                ."DOB:"."\t".$this->patient->get_dob()."\n"
                ."Start Date: " . "\t\t" . $this->start_date. "\n"
                ."Provider: " . "\t\t" . $this->provider->get_name_display(). "\n"
                ."Provider DEA No.: " . "\t\t" . $this->provider->federal_drug_id. "\n"
                ."Drug: " . "\t\t\t" . $this->drug. "\n"
//                ."Dosage: " . "\t\t" . $this->dosage . " in ". $this->form_array[$this->form]. " form " . $this->interval_array[$this->interval]. "\n"
                ."Dosage: " . "\t\t" . $this->dosage . " in ". $this->form. " form " . $this->interval_array[$this->interval]. "\n"
                ."Qty: " . "\t\t\t" . $this->quantity. "\n"
//                ."Medication Unit: " . "\t" . $this->size  . " ". $this->unit_array[$this->unit] . "\n"
                ."Medication Unit: " . "\t" . $this->size  . " ". $this->unit . "\n"
                ."Substitute: " . "\t\t" . $this->substitute_array[$this->substitute]. "\n";
        if ($this->refills > 0) {
            $string .= "Refills: " . "\t\t" . $this->refills. ", of quantity: " . $this->per_refill ."\n";
        }
        $string .= "\n"."Notes: \n" . $this->note . "\n";
        return $string;
    }
    
    function get_prescription_florida_display() {
    
        $db = get_db();
        $ntt = new NumberToText($this->quantity);
        $ntt2 = new NumberToText($this->per_refill);
        $ntt3 = new NumberToText($this->refills);
        
        $string = "";
        
        $gnd = $this->provider->get_name_display();
        
        while(strlen($gnd)<31) { $gnd .= " "; }
        
        $string .= $gnd . $this->provider->federal_drug_id . "\n"; 
        
        $sql = "SELECT * FROM users JOIN facility AS f ON f.name = users.facility where users.id ='" . mysql_real_escape_string($this->provider->id) . "'";
        $results = $db->Execute($sql);
        
        if (!$results->EOF) {
            $rfn = $results->fields['name'];
        
            while(strlen($rfn)<31) { $rfn .= " "; }
        
            $string .= $rfn . $this->provider->get_provider_number_default() . "\n"
                    . $results->fields['street'] . "\n"
                    . $results->fields['city'] . ", " . $results->fields['state'] . " " . $results->fields['postal_code'] . "\n"
                    . $results->fields['phone'] . "\n";
        }
        
        $string .= "\n";
        $string .= strtoupper($this->patient->lname) . ", " . ucfirst($this->patient->fname) . " " . $this->patient->mname . "\n";
        $string .= "DOB " .  $this->patient->date_of_birth . "\n";
        $string .= "\n";
        $string .= date("F j, Y", strtotime($this->start_date)) . "\n";
        $string .= "\n";
//        $string .= strtoupper($this->drug) . " " . $this->size  . " ". $this->unit_array[$this->unit] . "\n";
        $string .= strtoupper($this->drug) . " " . $this->size  . " ". $this->unit . "\n";
        if (strlen($this->note) > 0) {
            $string .= "Notes: \n" . $this->note . "\n";	
        }
        if (!empty($this->dosage)) {
            $string .= $this->dosage;
            if (!empty($this->form)){ 
                $string .= " " . $this->form_array[$this->form];
            } 
            if (!empty($this->interval)) {
                $string .= " " . $this->interval_array[$this->interval];
            }
            if (!empty($this->route)) {
			    $string .= " " . $this->route . "\n";
            }
        }
        if (!empty($this->quantity)) {
            $string .= "Disp: " . $this->quantity . " (" . trim(strtoupper($ntt->convert())) . ")" . "\n";
        }
        $string .= "\n";
        $string .= "Refills: " . $this->refills . " (" . trim(strtoupper($ntt3->convert())) ."), Per Refill Disp: " . $this->per_refill . " (" . trim(strtoupper($ntt2->convert())) . ")" ."\n";
        $string .= $this->substitute_array[$this->substitute]. "\n";
        $string .= "\n";
        
        return $string;
    }
	function prescriptions_factory($patient_id,$order_by = "active DESC, date_modified DESC, date_added DESC")
    {
        $prescriptions = array();
        require_once (dirname(__FILE__) . "/../translation.inc.php");
        $p = new Prescription();
        
		if($order_by != '')
		{
		 $qry_order = " Order by ".mysql_real_escape_string($order_by);
		}
      $sql = "SELECT id,date_format(date_added,'%D %M, %Y') as dateadd,drug,drug_id,sig,dosage,route,form FROM  " . $p->_table . " WHERE patient_id = " .
                mysql_real_escape_string($patient_id) ."$qry_order";                
	

        $results = sqlStatement($sql);
		$num_rows = sqlNumRows($results);

         if($num_rows >0)  
		{
			while ($row = mysql_fetch_array($results) ) 
			{
				$prescriptions[] = new Prescription($row['id']);
			}	
		}
		/*else
		{
			$prescriptions ="No record(s) found";
		}*/
        return $prescriptions;
    }
   
/*=====================Eprescription history from digital Rx would be called and shown in list prescription==========*/
   //Displaying the records in front end
   //Getting the Medication History Through Webservices
	function eprescribe_factory($patient_id,$order_by = "erx_active DESC, date_modified DESC, date_added DESC")
	{
	  $prescriptions = array();
    
            $query = "select ev.vendor_erx_id,ev.vendor_erx_password,epv.vendor_erx_practice_id from erx_vendor ev left join
                 erx_practice_vendor epv on ev.vendor_id = epv.vendor_id where epv.id ='1'";
               
               
                    $res = sqlStatement($query);
                   
                    while($row = mysql_fetch_array($res))
                    {
                        $vendorcredential['vendorid']        = $row['vendor_erx_id'];
                        $vendorcredential['vendorpassword']  = $row['vendor_erx_password'];
                        $vendorcredential['practice_id']  = $row['vendor_erx_practice_id'];
                       
                    }
                     
                    $vendor_id = $vendorcredential['vendorid'] ;
                    $vendor_password = $vendorcredential['vendorpassword'] ;
                    $vendor_practiceid =$vendorcredential['practice_id'] ;
                                                               
                    $physician_user_id = $_SESSION['authUserID'];
  
                    $phy_cred_query = "select * from erx_physician where user_id = '".$physician_user_id."'";
                    $phy_cred_res = sqlStatement($phy_cred_query);


                      
                    while($phy_cred_row = mysql_fetch_array($phy_cred_res))
                    {
                        $phy_cred_arr['physician_username']      = $phy_cred_row['physician_username'];
                        $phy_cred_arr['physician_password']        = $phy_cred_row['physician_password'];   
						

                    }
					
					
                     $phyuname   = $phy_cred_arr['physician_username'];  //Physician Username
                     $phypwd      = $phy_cred_arr['physician_password'];   //Physician Password
                    /*****************************************************************************************/
                 
					/***************************Data variable created by practiceid,venodrid,vendorpwd********/
					 
                     /******************************CONTACT H2H at drxcustomersupport@h2hsolutions.com *****************/
 
					//$data = $GLOBALS['TOKEN_URL']."?function=getToken&vendorId=".$vendor_id."&vendorPwd=".$vendor_password."&practiceId=".$vendor_practiceid."";
					$cURL = new cURL();
					$ch = $cURL->get($data);
					
					$code = $ch['code'];
					$token = substr($ch['cr'],strpos($ch['cr'],'=')+1,strlen($ch['cr'])-1);

					/*****************************************************************************************/
					/*******************************WSDL file TO access API***********************************/
					$wsdl =$GLOBALS['WSDL_URL'];
					/*****************************************************************************************/

                    /*********************Creating object by nusoap class*************************************/
                    $client=new nusoap_client($wsdl,'wsdl');
                    $err = $client->getError();
                    if ($err) {
                        // Display the error
                        echo '<p><b>Constructor error: ' . $err . '</b></p>';
                        exit;
                        // At this point, you know the call that follows will fail
                    }
                    /*****************************************************************************************/

                    
                    /********************Parameters being transfered  in WSDL API ****************************/
										
					      $query_patient_count = "Select * from prescriptions where patient_id='".$_SESSION['pid']."' ";
						  $query_patient_res   = sqlStatement($query_patient_count);                						  
     					  $query_patient_row = sqlNumRows($query_patient_res);				
						  
                          //If records fetched are more than 0
			  if($query_patient_row > 0)
				  {
					
					$patientretrieve_data_query = "select pd.id,pd.lname,pd.mname,pd.fname,pd.city,pd.street,pd.address2,pd.postal_code,pd.suffix,pd.state,pd.country_code,
DATE_FORMAT(DOB,'%m/%d/%Y') as DOB,DATE_FORMAT(max(pr.date_added) - INTERVAL 1 DAY,'%m') as stdate_m,
DATE_FORMAT(max(pr.date_added) - INTERVAL 1 DAY,'%d') as stdate_d,DATE_FORMAT(max(pr.date_added)- INTERVAL 1 DAY,'%Y') as stdate_Y,
DATE_FORMAT(now(),'%d') as endate_d,DATE_FORMAT(now(),'%m') as endate_m,DATE_FORMAT(now(),'%Y') as endate_Y,
if(sex = 'Male','M','F') as sex,phone_home from patient_data pd right join
 prescriptions pr on pd.pid = pr.patient_id where pd.pid =".$_SESSION['pid']." and pr.erx_active = '1' group by pr.patient_id";
                  }
			 if($query_patient_row == 0)
				  {
					  $patientretrieve_data_query = "select id,lname,mname,fname,city,street,address2,postal_code,suffix,state,country_code,DATE_FORMAT(DOB,'%m/%d/%Y') as DOB,DATE_FORMAT(date,'%m') as stdate_m,DATE_FORMAT(date,'%d') as stdate_d,DATE_FORMAT(date,'%Y') as stdate_Y,DATE_FORMAT(now(),'%d') as endate_d,DATE_FORMAT(now(),'%m') as endate_m,DATE_FORMAT(now(),'%Y') as endate_Y,if(sex = 'Male','M','F') as sex,phone_home from patient_data where pid =".$_SESSION['pid']."";
				  }
					
					$patientretrieve_data_result = sqlStatement($patientretrieve_data_query);
					$patientretrieve_data_fetch = mysql_fetch_array($patientretrieve_data_result);

					//Vendor Credentials

					 
                    $vendor_param1=array('vendorId' => $vendor_id,
                    'vendorUniqueIdentifierExt' => "1",
                    'vendorPassword' => $vendor_password,
                    'vendorDescription' => "1",
                    'practiceId' => $vendor_practiceid,
                    'practiceUniqueIdentifierExt' => "1",
                    'practiceDescription' => "Practice Desc",
                    'drxProviderId' =>  $phyuname,
                    'drxProviderPwd' =>  $phypwd
                    );

					//DigitalRx Status

                    $vendor_param2=array('code' => "1",
                    'digitalRxCode'    => 200,
                    'digitalRxCodeDesc' => "",
                    'digitalRxMessage' => "",
                    'pbmCode' => "",
                    'pbmCodeDesc' => "",
                    'pbmMessage' => "",
                    'pbmDetailsCode' => "",
                    'pbmDetailsCodeDesc' => "");

                    $vendor_param3= "More Information";
                    //MIDADTTT002  x0XD53qvbByTMyQyU30zdkp0pI0=


                    $param2=array("patientUniqueIdentifier" => $_SESSION['pid']);

					//Start Date

                                    $param2_st['year']=$patientretrieve_data_fetch['stdate_Y'];
				                	$param2_st['month']=$patientretrieve_data_fetch['stdate_m'];
                    				$param2_st['day']=$patientretrieve_data_fetch['stdate_d'];

					//End Date

                        			$param2_en['year']=$patientretrieve_data_fetch['endate_Y'];
                        			$param2_en['month']=$patientretrieve_data_fetch['endate_m'];
									$param2_en['day']=$patientretrieve_data_fetch['endate_d'];
									
								if($param2_en['day'] == $param2_st['day'] && $param2_en['month'] == $param2_st['month'] && $param2_en['year'] == $param2_st['year'])
								{
								     $param2_st['day'] = $param2_st['day'] -1;
								    	
								}




					/***************************************Getting UserID Password****************************/
					//Get Medication History

					//$result_medical_history=$client->call('getDigitalRxMedicationHistory',array('SenderInformation' => $vendor_param1,'DigitalRxStatus' => $vendor_param2,'PatientInformation' => $param2,'greaterThanEqualto' => $param2_st,'lessThanEqualto' => $param2_en,'detail' => 'true'));

					/******************************************************************************************/
	
	 
					$result_medicalhistory = $result_medical_history;

					$mainarray = $result_medicalhistory['return']['item'];
					
			
				
					if($mainarray['activeFlag'] == 'false')
					{
					$mainarray = array();
					}
					if($mainarray['activeFlag'] == 'true')
					{
					$mainarray = $mainarray;
					}
				    //Pulling the Records For Prescription of particular patient in case the records are coming from webservices
					if(!empty($mainarray))
					{		
						 					  
                          //If records fetched are more than 0
						  if($query_patient_row > 0)
							  {
									

											  for($x = 0;$x<sizeof($mainarray);$x++)
												{				  

													 $drug_erx_array['drugId'][$x]  = $mainarray[$x]['drugId'] ;
											
													
													if($mainarray[$x]['activeFlag'] == 'true')
													 {	
													   $drug_erx_array['activeFlag'][$x]  = '1';
													}
													else
													{
													   $drug_erx_array['activeFlag'][$x]  = '0';
													}
					
													
													$drug_erx_array['createdDate'][$x]  = $mainarray[$x]['createdDate'] ;

													$drug_erx_array['sig'][$x]  = strtoupper($mainarray[$x]['sig']);
													if($drug_erx_array['sig'][$x] == '')
													 {	
													   $drug_erx_array['sig'][$x] = 'none';
													}
													else
													{
													   $drug_erx_array['sig'][$x] = $drug_erx_array['sig'][$x];
													}
													$drug_erx_array['drugType'][$x]  = $mainarray[$x]['drugType'];
													$drug_erx_array['drugName'][$x]  = $mainarray[$x]['drugName'] ;
													$drug_erx_array['strength'][$x]  = $mainarray[$x]['strength'];
													$drug_erx_array['strengthUnit'][$x]  = $mainarray[$x]['strengthUnit'] ;
													$drug_erx_array['route'][$x]  = $mainarray[$x]['route'];
													$drug_erx_array['dosageForm'][$x]  = $mainarray[$x]['dosageForm'];
													$drug_erx_array['form'][$x]= ucfirst(ereg_replace("[^A-Za-z]", "",$mainarray[$x]['sig']));							
													$drug_erx_array['quantity'][$x]  = $mainarray[$x]['quantity'] ;
													$drug_erx_array['instructions'][$x]  = $mainarray[$x]['instructions'];
											  
													$date_c[$x] = date_create($drug_erx_array['createdDate'][$x]);  
																			  
								  $query_drugid_date = "Select * from prescriptions where patient_id='".$_SESSION['pid']."' and drug_id ='".$drug_erx_array['drugId'][$x]."' and  date(date_added)='".date_format($date_c[$x],'Y-m-d')."' and drug !=''";

													
						                              $res_drugid_date     = sqlStatement($query_drugid_date);         
                                                      $count_drugid_date = sqlNumRows($res_drugid_date);
                                                         
														   
                                                      if($count_drugid_date > 0)  //If records are present in Database
											           {
						  
															$sql_erx_arr[$x] ="UPDATE prescriptions set patient_id='".$_SESSION['pid']."',date_added='".$drug_erx_array['createdDate'][$x]."',date_modified='".$drug_erx_array['createdDate'][$x]."',provider_id='".$_SESSION['authUserID']."',start_date='".$drug_erx_array['createdDate'][$x]."',drug='".$drug_erx_array['drugName'][$x]."',drug_id='".$drug_erx_array['drugId'][$x]."',form='".$drug_erx_array['form'][$x]."',dosage='".$drug_erx_array['dosage'][$x]."',quantity='".$drug_erx_array['quantity'][$x]."',size='".$drug_erx_array['strength'][$x]."',unit='".$drug_erx_array['strengthUnit'][$x]."',sig='".$drug_erx_array['sig'][$x]."',route='".$drug_erx_array['route'][$x]."',note='1',refills='1',active = '1',erx_active='".$drug_erx_array['activeFlag'][$x]."' where patient_id='".$_SESSION['pid']."' and  provider_id='".$_SESSION['authUserID']."' and date_added='".$drug_erx_array['createdDate'][$x]."' and drug_id='".$drug_erx_array['drugId'][$x]."'";

															
															   sqlStatement($sql_erx_arr[$x]);
													   }
													   else if($count_drugid_date == 0)  //If records are not present in Database
											          {
														  if($drug_erx_array['drugName'][$x]!='')
														  {

																$sql_erx_arr[$x] ="insert into  prescriptions(patient_id,date_added,date_modified,provider_id,start_date,drug,drug_id,form,sig,dosage,quantity,size,unit,route,note,refills,active,erx_active) values('".$_SESSION['pid']."','".$drug_erx_array['createdDate'][$x]."','".$drug_erx_array['createdDate'][$x]."','".$_SESSION['authUserID']."','".$drug_erx_array['createdDate'][$x]."','". $drug_erx_array['drugName'][$x]."','".$drug_erx_array['drugId'][$x]."','".$drug_erx_array['form'][$x]."','".$drug_erx_array['sig'][$x]."','".$drug_erx_array['dosage'][$x]."','".$drug_erx_array['quantity'][$x]."','".$drug_erx_array['strength'][$x]  ."','".$drug_erx_array['strengthUnit'][$x]."','".$drug_erx_array['route'][$x]."','1','1','1','".$drug_erx_array['activeFlag'][$x]."')" ;


																sqlStatement($sql_erx_arr[$x]);
														  }
													  }

										   }	
									
															  
								  }
								  else   
									{
									
										for($x = 0;$x<sizeof($mainarray);$x++)
										{		
											if(sizeof($mainarray) == '22')
											{
											  $mainarray = array($mainarray);
											}
											else
											{
											 $mainarray = $mainarray;
											}
											
															 $drug_erx_array['drugId'][$x]  = $mainarray[$x]['drugId'] ;
															if($mainarray[$x]['activeFlag'] == 'true')
															 {	
															   $drug_erx_array['activeFlag'][$x]  = '1';
															}
															else
															{
															   $drug_erx_array['activeFlag'][$x]  = '0';
															}
							
															
															$drug_erx_array['createdDate'][$x]  = $mainarray[$x]['createdDate'] ;
															$drug_erx_array['sig'][$x]  = $mainarray[$x]['sig'] ;
															$drug_erx_array['drugType'][$x]  = $mainarray[$x]['drugType'];
															$drug_erx_array['drugName'][$x]  = $mainarray[$x]['drugName'] ;
															$drug_erx_array['strength'][$x]  = $mainarray[$x]['strength'];
															$drug_erx_array['strengthUnit'][$x]  = $mainarray[$x]['strengthUnit'] ;
															$drug_erx_array['route'][$x]  = $mainarray[$x]['route'];
															$drug_erx_array['dosageForm'][$x]  = ucfirst($mainarray[$x]['dosageForm']);
															$drug_erx_array['form'][$x]= ereg_replace("[^A-Za-z]", "",$mainarray[$x]['sig']);							
															$drug_erx_array['quantity'][$x]  = $mainarray[$x]['quantity'] ;
															$drug_erx_array['instructions'][$x]  = $mainarray[$x]['instructions'];



                                                             if($drug_erx_array['drugName'][$x]!='')
											              {
												          	  //If records are not present in Database
																$sql_erx_arr[$x] ="insert into  prescriptions(patient_id,date_added,date_modified,provider_id,start_date,drug,drug_id,form,dosage,quantity,sig,size,unit,route,note,refills,active,erx_active) values('".$_SESSION['pid']."','".$drug_erx_array['createdDate'][$x]."','".$drug_erx_array['createdDate'][$x]."','".$_SESSION['authUserID']."','".$drug_erx_array['createdDate'][$x]."','". $drug_erx_array['drugName'][$x]."','".$drug_erx_array['drugId'][$x]."','".$drug_erx_array['form'][$x]."','".$drug_erx_array['dosage'][$x]."','".$drug_erx_array['quantity'][$x]."','".$drug_erx_array['sig'][$x]."','".$drug_erx_array['strength'][$x]  ."','".$drug_erx_array['strengthUnit'][$x]."','".$drug_erx_array['route'][$x]."','1','1','1','".$drug_erx_array['activeFlag'][$x]."')" ;
							                                

														     sqlStatement($sql_erx_arr[$x]);
														  }
								        		}		   
		
									}	
                     }						  
					
		
					 $p = new Prescription();
					$sql = "SELECT id FROM  " . $p->_table . " WHERE patient_id = " .
					mysql_real_escape_string($patient_id) ." ORDER BY " . mysql_real_escape_string($order_by);
					$results = sqlQ($sql);
					while ($row = mysql_fetch_array($results) ) 
					{
					$prescriptions[] = new Prescription($row['id']);
					}
					return $prescriptions;
				

                   
                   
	}
    
    function get_dispensation_count() {
        if (empty($this->id)) return 0;
        $refills_row = sqlQuery("SELECT count(*) AS count FROM drug_sales " .
                    "WHERE prescription_id = '" . $this->id . "' AND quantity > 0");
        return $refills_row['count'];
    }

}// end of Prescription
?>
