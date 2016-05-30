<?php
 
use WHMCS\Database\Capsule;
 
define("CLIENTAREA", true);
//define("FORCESSL", true); // Uncomment to force the page to use https://
 
require("init.php");
 
$ca = new WHMCS_ClientArea();
 
$ca->setPageTitle(Lang::trans('features'));
 
$ca->addToBreadCrumb('index.php', Lang::trans('globalsystemname'));
$ca->addToBreadCrumb('features.php', Lang::trans('features'));
 
$ca->initPage();
 
//$ca->requireLogin(); // Uncomment this line to require a login to access this page
 
# To assign variables to the template system use the following syntax.
# These can then be referenced using {$variablename} in the template.

$ca->assign('variablename', $value);
 
# Check login status
if ($ca->isLoggedIn()) {
 
  # User is logged in - put any code you like here

  # Here's an example to get the currently logged in clients first name

  $clientName = Capsule::table('tblclients')
      ->where('id', '=', $ca->getUserID())->pluck('firstname');
 
  $ca->assign('clientname', $clientName);
 
} else {
 
  # User is not logged in

}
 
# Define the template filename to be used without the .tpl extension

$ca->setTemplate('features');
 
$ca->output();