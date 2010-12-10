<?php
class CheckPrescribe {

	function checkCount()
	{
	               //$dbase_practice	= $row_practice->practice_database_name;
					//$login_practice	= $row_practice->practice_database_username;
					//$pass_practice	= $row_practice->practice_database_user_password;

                    $user_Id = $_SESSION['authUserID'];

					$fetch_uname = "select physician_username,erx_physician_id from erx_physician where user_id = '".$user_Id."' and active_status=1";
					$uname_res = SqlStatement($fetch_uname);
					
					//$uname_fetch_row = mysql_fetch_row($uname_res);
					$countPracticeID=mysql_num_rows($uname_res);

					if($countPracticeID!= '')
					{
						// mysql_query("delete from erx_physician where user_id = '".$user_Id."'");
						//$sql_practice="select erx_physician_id from erx_physician where user_id = ".$user_Id." and active_status=1";					
						//$result_practice=mysql_query($sql_practice);
						//$countPracticeID=mysql_num_rows($result_practice);
						return  $countPracticeID;
					}
					else {
						return 0;
					}        
	}	

}
?>
