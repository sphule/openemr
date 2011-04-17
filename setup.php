<?php
/**
 * OpenEMR setup.php
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * @package     OpenEMR
 */

    // Define ABSPATH as this files directory
    define( 'ABSPATH', dirname(__FILE__) );

    $COMMAND_LINE = php_sapi_name() == 'cli';
    require_once( ABSPATH . '/library/classes/Installer.class.php' );

    // turn off PHP compatibility warnings
    ini_set('session.bug_compat_warn','off');

    if ( isset($_POST['state']) ) {
        $state = $_POST['state'];
    } else {
        $state = 0;
    }

    // Make this true for IPPF.
    $ippf_specific = false;

    // If this script was invoked with no site ID, then ask for one.
    if ( !$COMMAND_LINE && empty($_REQUEST['site']) ) {
?>
<html>
    <head>
        <title>OpenEMR Setup Tool</title>
        <link rel="stylesheet" href="interface/themes/style_blue.css" />
    </head>
    <body>
        <p><b>Optional Site ID Selection</b></p>
        <p>Most OpenEMR installations support only one site. If that is true for you then ignore the rest of this text and just click Continue.</p>
        <p>Otherwise please enter a unique Site ID here.</p>
        <p>A Site ID is a short identifier with no spaces or special characters other than periods or dashes. It is case-sensitive and we suggest sticking to lower case letters for ease of use.</p>
        <p>If each site will have its own host/domain name, then use that name as the Site ID (e.g. www.example.com).</p>
        <p>The site ID is used to identify which site you will log in to. If it is a hostname then it is taken from the hostname in the URL. Otherwise you must append "?site=<i>siteid</i>" to the URL used for logging in.</p>
        <p>It is OK for one of the sites to have "default" as its ID. This is the ID that will be used if it cannot otherwise be determined.</p>
        <form action="#"  method="post">
            <input type="hidden" name="state" value="0" />
            Site ID: <input type="text" name="site" value="default" />&nbsp;
            <input type="submit" value="Continue" /><br />
        </form>
        <br />
    </body>
</html>
<?php
        exit();
    }

    // Support "?site=siteid" in the URL, otherwise assume "default".
    $site_id = 'default';
    if ( !$COMMAND_LINE && !empty($_REQUEST['site']) )
        $site_id = trim($_REQUEST['site']);

    // Die if site ID is empty or has invalid characters.
    if (empty($site_id) || preg_match('/[^A-Za-z0-9\\-.]/', $site_id))
        die('Site ID "'.$site_id.'" contains invalid characters.');

    // If having problems with file and directory permission
    // checking, then can be manually disabled here.
    $checkPermissions = True;

    $installer = new Installer( $_REQUEST );
    global $OE_SITE_DIR; // The Installer sets this

    $docsDirectory = $OE_SITE_DIR.'/documents';
    $billingDirectory = $OE_SITE_DIR.'/edi';
    $billingDirectory2 = $OE_SITE_DIR.'/era';

    $billingLogDirectory = ABSPATH.'/library/freeb';
    $lettersDirectory = $OE_SITE_DIR.'/letter_templates';
    $gaclWritableDirectory = ABSPATH.'/gacl/admin/templates_c';
    $requiredDirectory1 = ABSPATH.'/interface/main/calendar/modules/PostCalendar/pntemplates/compiled';
    $requiredDirectory2 = ABSPATH.'/interface/main/calendar/modules/PostCalendar/pntemplates/cache';

    // These are files and dir checked before install for correct permissions.
    if (is_dir($OE_SITE_DIR)) {
        $writableFileList = array($installer->conffile);
        $writableDirList = array($docsDirectory, $billingDirectory, $billingDirectory2, $lettersDirectory, $gaclWritableDirectory, $requiredDirectory1, $requiredDirectory2);
    } else {
        $writableFileList = array();
        $writableDirList = array($OE_SITES_BASE, $gaclWritableDirectory, $requiredDirectory1, $requiredDirectory2);
    }

    // Include the sqlconf file if it exists yet.
    $config = 0;
    if ( file_exists($OE_SITE_DIR) ) {
        include_once($installer->conffile);
    } elseif ($state > 3) {
        // State 3 should have created the site directory if it is missing.
        die('Internal error, site directory is missing.');
    }

?>
<html>
    <head>
        <title>OpenEMR Setup Tool</title>
        <link rel="stylesheet" href="interface/themes/style_sky_blue.css" />
        <style type="text/css">
            .noclone { }
        </style>
        <script type="text/javascript" src="library/js/jquery.js" />
        <script type="text/javascript" language="javascript">
            // onclick handler for "clone database" checkbox
            function cloneClicked() {
                var cb = document.forms[0].clone_database;
                $('.noclone').css('display', cb.checked ? 'none' : 'block');
            }
        </script>
    </head>
    <body>
        <span class="title">OpenEMR Setup</span>
        <br /><br />
        <span class="text">
<?php
    if ( strtolower(ini_get('register_globals')) != 'off' && (bool) ini_get('register_globals') ) {
        echo 'It appears that you have register_globals enabled in your php.ini configuration file. This causes unacceptable security risks. You must turn it off before continuing with installation.';
        exit();
    }
    if ($state == 7) {
?>
        <p>Congratulations! OpenEMR is now installed.</p>
        <ul>
            <li>Access controls (php-GACL) are installed for fine-grained security, and can be administered in OpenEMR's admin->acl menu.</li>
            <li>Reviewing <?php echo $OE_SITE_DIR; ?>/config.php is a good idea. This file contains some settings that you may want to change.</li>
            <li>There's much information and many extra tools bundled within the OpenEMR installation directory. Please refer to openemr/Documentation. Many forms and other useful scripts can be found at openemr/contrib.</li>
            <li>To ensure a consistent look and feel through out the application using <a href="http://www.mozilla.org/products/firefox/">Firefox</a> is recommended.</li>
            <li>The OpenEMR project home page and wiki can be found at <a href="http://www.oemr.org/" target="_blank">http://www.oemr.org</a></li>
            <li>The OpenEMR forums can be found at <a href="http://sourceforge.net/projects/openemr/" target="_blank">http://sourceforge.net/projects/openemr</a></li>
            <li>We pursue grants to help fund the future development of OpenEMR. To apply for these grants, we need to estimate how many times this program is installed and how many practices are evaluating or using this software.  It would be awesome if you would email us at <a href="mailto:drbowen@openmedsoftware.org">drbowen@openmedsoftware.org</a> if you have installed this software. The more details about your plans with this software, the better, but even just sending us an email stating you just installed it is very helpful.</li>
        </ul>
        <p>We recommend you print these instructions for future reference.</p>
<?php
        if ( empty($installer->clone_database) ) {
            echo '<p><b>The initial OpenEMR user is "'.$installer->iuser.'" and the password is "'.$installer->iuserpass.'"</b></p>';
            echo '<p>If you edited the PHP or Apache configuration files during this installation process, then we recommend you restart your Apache server before following below OpenEMR link.</p>';
        }
        echo '<p><a href="./?site='.$site_id.'">Click here to start using OpenEMR.</a></p>';
        exit();
    }

    if ( isset($_POST['inst']) )
        $inst = $_POST['inst'];

    if ( ($config == 1) && ($state < 4) ) {
        echo 'OpenEMR has already been installed. If you wish to force re-installation, then edit '.$installer->conffile.' (change the "config" variable to 0), and re-run this script.<br />';
    } else {
        switch ($state) {
            case 1:
?>
                <b>Step <?php echo $state; ?></b>
                <br /><br />
                <p>Now I need to know whether you want me to create the database on my own or if you have already created the database for me to use. For me to create the database, you will need to supply the MySQL root password.</p>
				<br />
                <span class="title">NOTE: clicking on "Continue" may delete or cause damage to data on your system. Before you continue please backup your data.</span>
                <br /><br />
                <form action="#" method="post">
                    <input type="hidden" name="state" value="2" />
                    <input type="hidden" name="site" value="<?php echo $site_id; ?>" />
                    <label for="inst1"><input type="radio" id="inst1" name="inst" value="1" checked>Have setup create the database</label><br />
                    <label for="inst2"><input type="radio" id="inst2" name="inst" value="2">I have already created the database</label><br />
                    <br />
                    <input type="submit" value="Continue"><br />
                </form>
                <br />
<?php
                break;
            case 2:
?>
                <b>Step <?php echo $state; ?></b>
                <br /><br />
                <p>Now you need to supply the MySQL server information and path information. Detailed instructions on each item can be found in the <a href="INSTALL" target="_blank"><span style="text-decoration:underline;">"INSTALL"</span></a> manual file.</p>
                <br /><br />
                <form action="#"  method="post">
                    <input type="hidden" name="state" value="3" />
                    <input type="hidden" name="site" value="<?php echo $site_id; ?>" />
                    <input type="hidden" name="inst" value="<?php echo $inst; ?>" />
                    <table>
                        <tr valign="top"><td colspan="2"><font color="red">MYSQL SERVER:</font></td></tr>
                        <tr valign="top">
                            <td><span class="text">Server Host: </span></td>
                            <td><input type="text" value="localhost" name="server" size="30" /></td>
                            <td><span class="text">(If you run MySQL and Apache/PHP on the same computer, then leave this as 'localhost'. If they are on separate computers, then enter the IP address of the computer running MySQL.)</span><br /></td>
                        </tr>
                        <tr valign="top">
                            <td><span class="text">Server Port: </span></td>
                            <td><input type="text" value="3306" name="port" size="30" /></td>
                            <td><span class="text">(This is the MySQL port. The default port for MySQL is 3306.)</span><br /></td>
                        </tr>
                        <tr valign="top">
                            <td><span class="text">Database Name: </span></td>
                            <td><input type="text" value="openemr" name="dbname" size="30" /></td>
                            <td><span class="text">(This is the name of the OpenEMR database in MySQL - 'openemr' is the recommended)</span><br /></td>
                        </tr>
                        <tr valign="top">
                            <td><span class="text">Login Name: </span></td>
                            <td><input type="text" value="openemr" name="login" size="30" /></td>
                            <td><span class="text">(This is the name of the OpenEMR login name in MySQL - 'openemr' is the recommended)</span><br /></td>
                        </tr>
                        <tr valign="top">
                            <td><span class="text">Password: </span></td>
                            <td><input type="password" value="" name="pass" size="30" /></td>
                            <td><span class="text">(This is the Login Password for when PHP accesses MySQL - it should be at least 8 characters long and composed of both numbers and letters)</span><br /></td>
                        </tr>
<?php if ($inst != 2) { ?>
                        <tr valign="top">
                            <td><span class="text">Name for Root Account: </span></td>
                            <td><input type="text" value="root" name="root" size="30" /></td>
                            <td><span class="text">(This is name for MySQL root account. For localhost, it is usually ok to leave it 'root'.)</span><br /></td>
                        </tr>
                        <tr valign="top">
                            <td><span class="text">Root Pass: </span></td>
                            <td><input type="password" value="" name="rootpass" size="30" /></td>
                            <td><span class="text">(This is your MySQL root password. For localhost, it is usually ok to leave it blank.)</span><br /></td>
                        </tr>
                        <tr valign="top">
                            <td><span class="text">User Hostname: </span></td>
                            <td><input type="text" value="localhost" name="loginhost" size="30" /></td>
                            <td><span class="text">(If you run Apache/PHP and MySQL on the same computer, then leave this as 'localhost'. If they are on separate computers, then enter the IP address of the computer running Apache/PHP.)</span><br /></td>
                        </tr>
                        <tr valign="top">
                            <td><span class="text">UTF-8 Collation: </span></td>
                            <td colspan="2">
                                <select name="collate">
                                    <option value="utf8_bin" >Bin</option>
                                    <option value="utf8_czech_ci" >Czech</option>
                                    <option value="utf8_danish_ci" >Danish</option>
                                    <option value="utf8_esperanto_ci" >Esperanto</option>
                                    <option value="utf8_estonian_ci" >Estonian</option>
                                    <option value="utf8_general_ci" selected>General</option>
                                    <option value="utf8_hungarian_ci" >Hungarian</option>
                                    <option value="utf8_icelandic_ci" >Icelandic</option>
                                    <option value="utf8_latvian_ci" >Latvian</option>
                                    <option value="utf8_lithuanian_ci" >Lithuanian</option>
                                    <option value="utf8_persian_ci" >Persian</option>
                                    <option value="utf8_polish_ci" >Polish</option>
                                    <option value="utf8_roman_ci" >Roman</option>
                                    <option value="utf8_romanian_ci" >Romanian</option>
                                    <option value="utf8_slovak_ci" >Slovak</option>
                                    <option value="utf8_slovenian_ci" >Slovenian</option>
                                    <option value="utf8_spanish2_ci" >Spanish2 (Traditional)</option>
                                    <option value="utf8_spanish_ci" >Spanish (Modern)</option>
                                    <option value="utf8_swedish_ci" >Swedish</option>
                                    <option value="utf8_turkish_ci" >Turkish</option>
                                    <option value="utf8_unicode_ci" >Unicode (German, French, Russian, Armenian, Greek)</option>
                                    <option value="" >None (Do not force UTF-8)</option>
                                </select>
                            </td>
                        </tr>
                        <tr valign="top">
                            <td>&nbsp;</td>
                            <td colspan="2"><span class="text">(This is the collation setting for mysql. Leave as "General" if you are not sure. If the language you are planning to use in OpenEMR is in the menu, then you can select it. Otherwise, just select "General".)</span><br /></td>
                        </tr>
<?php }
                    echo '<tr valign="top"><td>&nbsp;</td></tr>';

					/**
					 * Include a "source" site ID drop-list and a checkbox to
					 * indicate if cloning its database. When checked, do not
					 * display initial user and group stuff below.
					 */

					$dh = opendir($OE_SITES_BASE);
					if (!$dh) die('Cannot read directory "'.$OE_SITES_BASE.'".');
					$siteslist = array();
					while (false !== ($sfname = readdir($dh))) {
						if (substr($sfname, 0, 1) == '.') continue;
						if ($sfname == 'CVS'            ) continue;
						if ($sfname == $site_id         ) continue;
						$sitedir = $OE_SITES_BASE.'/$sfname';
						if (!is_dir($sitedir)               ) continue;
						if (!is_file($sitedir.'/sqlconf.php')) continue;
						$siteslist[$sfname] = $sfname;
					}
					closedir($dh);

					// If this is not the first site...
					if (!empty($siteslist)) {
						ksort($siteslist);
?>
						<tr valign="top">
							<td class="text">Source Site: </td>
							<td class="text">
								<select name="source_site_id">
<?php
								foreach ($siteslist as $sfname) {
									echo '<option value="'.$sfname.'"';
									if ($sfname == 'default') echo ' selected';
									echo '>'.$sfname.'</option>';
								}
?>
								</select>
							</td>
							<td class="text">(The site directory that will be a model for the new site.)</td>
						</tr>
						<tr valign="top">
							<td class="text">Clone Source Database: </td>
							<td class="text"><input type="checkbox" name="clone_database" onclick="cloneClicked()" /></td>
							<td class="text">(Clone the source site's database instead of creating a fresh one.)</td>
						</tr>
<?php           	} ?>
						<tr valign="top" class="noclone"><td colspan="2"><font color="red">OPENEMR USER:</font></td></tr>
						<tr valign="top" class="noclone">
							<td><span class="text">Initial User:</span></td>
							<td><input size="30" type="text" name='iuser' value="admin" /></td>
							<td><span class="text">(This is the login name of user that will be created for you. Limit this to one word.)</span></td>
						</tr>
						<tr valign="top" class="noclone">
							<td><span class="text">Initial User Password:</span></td>
							<td><input size="30" type="password" name='iuserpass' value="" /></td>
							<td><span class="text">(This is the password for the initial user account above.)</span></td>
						</tr>
						<tr valign="top" class="noclone">
							<td><span class="text">Initial User's Name:</span></td>
							<td><input size="30" type="text" name='iuname' value="Administrator" /></td>
							<td><span class="text">(This is the real name of the 'initial user'.)</span></td>
						</tr>
						<tr valign="top" class="noclone">
							<td><span class="text">Initial Group:</span></td>
							<td><input size="30" type="text" name='igroup' value="Default" /></td>
							<td><span class="text">(This is the group that will be created for your users. This should be the name of your practice.)</span></td>
						</tr>
						<tr valign="top"><td>&nbsp;</td></tr>
					</table>
					<br />
					<input type="submit" value="Continue" /><br />
				</form><br />
<?php
                break;
            case 3:

                // Form Validation (applicable if not cloning from another database)
                if ( empty($installer->clone_database) ) {
                    if ( ! $installer->login_is_valid() ) {
                        echo 'ERROR. Please pick a proper "Login Name".<br />';
                        echo 'Click Back in browser to re-enter.<br />';
                        break;
                    }
                    if ( ! $installer->iuser_is_valid() ) {
                        echo 'ERROR. The "Initial User" field can only contain one word and no spaces.<br />';
                        echo 'Click Back in browser to re-enter.<br />';
                        break;
                    }
                    if ( ! $installer->user_password_is_valid() ) {
                        echo 'ERROR. Please pick a proper "Initial User Password".<br />';
                        echo 'Click Back in browser to re-enter.<br />';
                        break;
                    }
                }
                if ( ! $installer->password_is_valid() ) {
                    echo 'ERROR. Please pick a proper "Password".<br />';
                    echo 'Click Back in browser to re-enter.<br />';
                    break;
                }

                echo '<b>Step '.$state.'</b><br /><br />';
                echo 'Configuring OpenEMR...<br /><br />';

                // Skip below if database shell has already been created.
                if ($inst != 2) {
                    echo 'Connecting to MySQL Server...';
                    flush();
                    if ( ! $installer->root_database_connection() ) {
                        echo 'ERROR.  Check your login credentials.';
                        echo $installer->error_message;
                        break;
                    } else {
                        echo 'OK.<br />';
                        flush();
                    }
                }

                // Only pertinent if cloning another installation database
                if ( ! empty($installer->clone_database) ) {
                    echo 'Dumping source database...';
                    flush();
                    if ( ! $installer->create_dumpfiles() ) {
                        echo $installer->error_message;
                        break;
                    } else {
                        echo ' OK.<br />';
                        flush();
                    }
                }

                // Only pertinent if mirroring another installation directory
                if ( ! empty($installer->source_site_id) ) {
                    echo 'Creating site directory...';
                    if ( ! $installer->create_site_directory() ) {
                        echo $installer->error_message;
                        break;
                    } else {
                        echo 'OK.<br />';
                        flush();
                    }
                }

                // Skip below if database shell has already been created.
                if ($inst != 2) {
                    echo 'Creating database...';
                    flush();
                    if ( ! $installer->create_database() ) {
                        echo 'ERROR. Check your login credentials.';
                        echo $installer->error_message;
                        break;
                    } else {
                        echo 'OK.<br />';
                        flush();
                    }
                    echo 'Creating user with permissions for database...';
                    flush();
                    if ( ! $installer->grant_privileges() ) {
                        echo 'ERROR when granting privileges to the specified user.';
                        echo $installer->error_message;
                        break;
                    } else {
                        echo 'OK.<br />';
                        flush();
                    }
                    echo 'Reconnecting as new user...';
                    flush();
                    $installer->disconnect();
                } else {
                    echo 'Connecting to MySQL Server...';
                }
                if ( ! $installer->user_database_connection() ) {
                    echo 'ERROR. Check your login credentials.';
                    echo $installer->error_message;
                    break;
                } else {
                    echo 'OK.<br />';
                    flush();
                }

                // Load the database files
                $dump_results = $installer->load_dumpfiles();
                if ( ! $dump_results ) {
                    echo $installer->error_message;
                    break;
                } else {
                    echo $dump_results;
                    flush();
                }

                echo 'Writing SQL configuration...';
                flush();
                if ( ! $installer->write_configuration_file() ) {
                    echo $installer->error_message;
                    break;
                } else {
                    echo 'OK.<br />';
                    flush();
                }

                // Only pertinent if not cloning another installation database
                if (empty($installer->clone_database) ) {
                    echo 'Setting version indicators...';
                    flush();
                    if ( ! $installer->add_version_info() ) {
                        echo 'ERROR.';
                        echo $installer->error_message;;
                        break;
                    } else {
                        echo 'OK<br />';
                        flush();
                    }
                    echo 'Writing global configuration defaults...';
                    flush();
                    if ( ! $installer->insert_globals() ) {
                        echo 'ERROR.';
                        echo $installer->error_message;;
                        break;
                    } else {
                        echo 'OK<br />';
                        flush();
                    }
                    echo 'Adding Initial User...';
                    flush();
                    if ( ! $installer->add_initial_user() ) {
                        echo $installer->error_message;
                        break;
                    }
                    echo 'OK<br />';
                    flush();
                }
                if ( ! empty($installer->clone_database) ) {
                    // Database was cloned, skip ACL setup.
                    echo 'Click "continue" for further instructions.';
                    $next_state = 7;
                } else {
                    echo '<br />Next step will install and configure access controls (php-GACL).<br />';
                    $next_state = 4;
                }
?>
                <form action="#"  method="post">
                    <input type="hidden" name="state" value="<?php echo $next_state; ?>">
                    <input type="hidden" name="site" value="<?php echo $site_id; ?>">
                    <input type="hidden" name="iuser" value="<?php echo $installer->iuser; ?>">
                    <input type="hidden" name="iuserpass" value="<?php echo $installer->iuserpass; ?>">
                    <input type="hidden" name="iuname" value="<?php echo $installer->iuname; ?>">
                    <input type="hidden" name="clone_database" value="<?php if ( isset($installer->clone_database) ) echo $installer->clone_database; ?>">
                    <br />
                    <input type="submit" value="Continue" />
                    <br />
                </form>
                <br />
<?php
                break;
            case 4:
                echo '<b>Step '.$state.'</b><br /><br />';
                echo 'Installing and Configuring Access Controls (php-GACL)...<br /><br />';

                if ( ! $installer->install_gacl() ) {
                    echo $installer->error_message;
                    break;
                } else {
                    // display the status information for gacl setup
                    echo $installer->debug_message;
                }
?>
                Gave the "<?php echo $installer->iuser; ?>" user (password is "<?php echo $installer->iuserpass; ?>") administrator access.
                <br /><br />Done installing and configuring access controls (php-GACL).
                <br />Next step will configure PHP.<br />
                <form action="#" method="post">
                    <input type="hidden" name="state" value="5">
                    <input type="hidden" name="site" value="<?php echo $site_id; ?>">
                    <input type="hidden" name="iuser" value="<?php echo $installer->iuser; ?>">
                    <input type="hidden" name="iuserpass" value="<?php echo $installer->iuserpass; ?>">
                    <br />
                    <input type="submit" value="Continue" />
                    <br />
                </form>
                <br />
<?php
                break;
            case 5:
                echo '<b>Step '.$state.'</b><br /><br />Configuration of PHP...<br /><br />';
                echo 'We recommend making the following changes to your PHP installation, which can normally be done by editing the php.ini configuration file:<ul>';
                $gotFileFlag = 0;
                if ( version_compare(PHP_VERSION, '5.2.4', '>=') ) {
                    $phpINIfile = php_ini_loaded_file();
                    if ($phpINIfile) {
                        echo '<li><font color="green">Your php.ini file can be found at '.$phpINIfile.'</font></li>';
                        $gotFileFlag = 1;
                    }
                }
                echo '<li>To ensure proper functioning of OpenEMR you must make sure that settings in php.ini file include  "short_open_tag = On", "display_errors = Off", "register_globals = Off", "magic_quotes_gpc = On", "max_execution_time" set to at least 60, "max_input_time" set to at least 90, "post_max_size" set to at least 30M, and "memory_limit" set to at least "128M".</li>';
                echo '<li>In order to take full advantage of the patient documents capability you must make sure that settings in php.ini file include "file_uploads = On", that "upload_max_filesize" is appropriate for your use and that "upload_tmp_dir" is set to a correct value that will work on your system.</li>';
                if (!$gotFileFlag) {
                    echo '<li>If you are having difficulty finding your php.ini file, then refer to the <a href="INSTALL" target="_blank"><span style="text-decoration:underline;">"INSTALL"</span></a> manual for suggestions.</li>';
                }
                echo '</ul>';
?>
                <br />We recommend you print these instructions for future reference.
                <br /><br />Next step will configure Apache web server.<br />
                <form action="#" method="post">
                    <input type="hidden" name="state" value="6">
                    <input type="hidden" name="site" value="<?php echo $site_id; ?>">
                    <input type="hidden" name="iuser" value="<?php echo $installer->iuser; ?>">
                    <input type="hidden" name="iuserpass" value="<?php echo $installer->iuserpass; ?>">
                    <br />
                    <input type="submit" value="Continue" />
                    <br />
                </form>
                <br />
<?php
                break;
            case 6:
?>
                <b>Step <?php echo $state; ?></b>
                <br /><br />Configuration of Apache web server...<br /><br />
                The "<?php echo realpath($docsDirectory); ?>", "<?php echo realpath($billingDirectory); ?>" and "<?php echo realpath($billingDirectory2); ?>" directories contain patient information, and it is important to secure these directories. This can be done by placing pertinent .htaccess files in these directories or by pasting the below to end of your apache configuration file:
                <br />&nbsp;&nbsp;&lt;Directory <?php echo realpath($docsDirectory); ?>&gt;<br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;order deny,allow<br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Deny from all<br />
                &nbsp;&nbsp;&lt;/Directory&gt;<br />
                &nbsp;&nbsp;&lt;Directory <?php echo realpath($billingDirectory); ?>&gt;<br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;order deny,allow<br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Deny from all<br />
                &nbsp;&nbsp;&lt;/Directory&gt;<br />
                &nbsp;&nbsp;&lt;Directory <?php echo realpath($billingDirectory2); ?>&gt;<br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;order deny,allow<br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Deny from all<br />
                &nbsp;&nbsp;&lt;/Directory&gt;<br /><br />
                If you are having difficulty finding your apache configuration file, then refer to the <a href="INSTALL" target="_blank"><span style="text-decoration:underline;">"INSTALL"</span></a> manual for suggestions.<br /><br />
                <br />We recommend you print these instructions for future reference.<br /><br />
                Click "continue" for further instructions.<br />
                <form action="#" method="post">
                    <input type="hidden" name="state" value="7">
                    <input type="hidden" name="site" value="<?php echo $site_id; ?>">
                    <input type="hidden" name="iuser" value="<?php echo $installer->iuser; ?>">
                    <input type="hidden" name="iuserpass" value="<?php echo $installer->iuserpass; ?>">
                    <br />
                    <input type="submit" value="Continue" /><br />
                </form>
                <br />
<?php
                break;
            case 0:
            default:
?>
                <p>Welcome to OpenEMR. This utility will step you through the installation and configuration of OpenEMR for your practice.</p>
                <ul>
                    <li>Before proceeding, be sure that you have a properly installed and configured MySQL server available, and a PHP configured webserver.</li>
                    <li>Detailed installation instructions can be found in the <a href="INSTALL" target="_blank"><span style="text-decoration:underline;">"INSTALL"</span></a> manual file.</li>
                    <li>If you are upgrading from a previous version, do NOT use this script. Please read the 'Upgrading' section found in the <a href="INSTALL" target="_blank"><span style="text-decoration:underline;">"INSTALL"</span></a> manual file.</li>
                </ul>
<?php
                if ($checkPermissions) {
                    echo '<p>We will now ensure correct file and directory permissions before starting installation:</p>';
                    echo '<font color="green">Ensuring following files are world-writable...</font><br />';
                    $errorWritable = 0;
                    foreach ($writableFileList as $tempFile) {
                        if (is_writable($tempFile)) {
                            echo '"'.realpath($tempFile).'" file is <font color="green"><b>ready</b></font>.<br />';
                        } else {
                            echo '<p><font color="red">UNABLE</font> to open file "'.realpath($tempFile).'" for writing.<br />';
                            echo '(configure file permissions; see below for further instructions)</p>';
                            $errorWritable = 1;
                        }
                    }
                    if ($errorWritable) {
                        echo '<p><font color="red">You can\'t proceed until all above files are ready (world-writable).</font><br />';
                        echo 'In linux, recommend changing file permissions with the "chmod 666 filename" command.<br />';
                        echo 'Fix above file permissions and then click the "Check Again" button to re-check files.<br />';
                        echo '<form method="post"><input type="submit" value="Check Again"></p>';
                        echo '<input type="hidden" name="site" value="'.$site_id.'"></form><br />';
                        break;
                    }
                    echo '<br /><font color="green">Ensuring following directories have proper permissions...</font><br />';
                    $errorWritable = 0;
                    foreach ($writableDirList as $tempDir) {
                        if (is_writable($tempDir)) {
                            echo '"'.realpath($tempDir).'" directory is <font color="green"><b>ready</b></font>.<br />';
                        } else {
                            echo '<p><font color="red">UNABLE</font> to open directory "'.realpath($tempDir).'" for writing by web server.<br />';
                            echo '(configure directory permissions; see below for further instructions)</p>';
                            $errorWritable = 1;
                        }
                    }
                    if ($errorWritable) {
                        echo '<p><font color="red">You can\'t proceed until all directories are ready.</font><br />';
                        echo 'In linux, recommend changing owners of these directories to the web server. For example, in many linux OS\'s the web server user is "apache", "nobody", or "www-data". So if "apache" were the web server user name, could use the command "chown -R apache:apache directory_name" command.<br />';
                        echo 'Fix above directory permissions and then click the "Check Again" button to re-check directories.<br />';
                        echo '<form method="post"><input type="submit" value="Check Again"></p><input type="hidden" name="site" value="'.$site_id.'"></form><br />';
                        break;
                    }
                    echo '<br />All required files and directories have been verified. Click to continue installation.<br />';
                } else {
                    echo '<br />Click to continue installation.<br />';
                }
                echo '<form method="post"><input type="hidden" name="state" value="1"><input type="hidden" name="site" value="'.$site_id.'"><input type="submit" value="Continue"><br /></form><br />';
            }
        }
?>
        </span>
    </body>
</html>
