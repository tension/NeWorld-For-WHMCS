{php}

// 下方输入您的授权许可
$NeWorld_license = "whmcs-8537c953b1f8cd895adc1fb944f55a63";
// 上方输入您的授权许可

function NeWorld_Prefix_Check_License($NeWorld_license, $localkey='') {

    // -----------------------------------
    //  -- Configuration Values --
    // -----------------------------------

    // Enter the url to your WHMCS installation here
    $whmcsurl = 'https://www.neworld.org/';
    // Must match what is specified in the MD5 Hash Verification field
    // of the licensing product that will be used with this check.
    $licensing_secret_key = 'teNsi0n';
    // The number of days to wait between performing remote license checks
    $localkeydays = 7;
    // The number of days to allow failover for after local key expiry
    $allowcheckfaildays = 5;

    // -----------------------------------
    //  -- Do not edit below this line --
    // -----------------------------------

    $check_token = time() . md5(mt_rand(1000000000, 9999999999) . $NeWorld_license);
    $checkdate = date("Ymd");
    $domain = $_SERVER['SERVER_NAME'];
    $usersip = isset($_SERVER['SERVER_ADDR']) ? $_SERVER['SERVER_ADDR'] : $_SERVER['LOCAL_ADDR'];
    $dirpath = dirname(__FILE__);
    $verifyfilepath = 'modules/servers/licensing/verify.php';
    $localkeyvalid = false;
    if ($localkey) {
        $localkey = str_replace("\n", '', $localkey); # Remove the line breaks
        $localdata = substr($localkey, 0, strlen($localkey) - 32); # Extract License Data
        $md5hash = substr($localkey, strlen($localkey) - 32); # Extract MD5 Hash
        if ($md5hash == md5($localdata . $licensing_secret_key)) {
            $localdata = strrev($localdata); # Reverse the string
            $md5hash = substr($localdata, 0, 32); # Extract MD5 Hash
            $localdata = substr($localdata, 32); # Extract License Data
            $localdata = base64_decode($localdata);
            $localkeyresults = unserialize($localdata);
            $originalcheckdate = $localkeyresults['checkdate'];
            if ($md5hash == md5($originalcheckdate . $licensing_secret_key)) {
                $localexpiry = date("Ymd", mktime(0, 0, 0, date("m"), date("d") - $localkeydays, date("Y")));
                if ($originalcheckdate > $localexpiry) {
                    $localkeyvalid = true;
                    $results = $localkeyresults;
                    $validdomains = explode(',', $results['validdomain']);
                    if (!in_array($_SERVER['SERVER_NAME'], $validdomains)) {
                        $localkeyvalid = false;
                        $localkeyresults['status'] = "Invalid";
                        $results = array();
                    }
                    $validips = explode(',', $results['validip']);
                    if (!in_array($usersip, $validips)) {
                        $localkeyvalid = false;
                        $localkeyresults['status'] = "Invalid";
                        $results = array();
                    }
                    $validdirs = explode(',', $results['validdirectory']);
                    if (!in_array($dirpath, $validdirs)) {
                        $localkeyvalid = false;
                        $localkeyresults['status'] = "Invalid";
                        $results = array();
                    }
                }
            }
        }
    }
    if (!$localkeyvalid) {
        $responseCode = 0;
        $postfields = array(
            'licensekey' => $NeWorld_license,
            'domain' => $domain,
            'ip' => $usersip,
            'dir' => $dirpath,
        );
        if ($check_token) $postfields['check_token'] = $check_token;
        $query_string = '';
        foreach ($postfields AS $k=>$v) {
            $query_string .= $k.'='.urlencode($v).'&';
        }
        if (function_exists('curl_exec')) {
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $whmcsurl . $verifyfilepath);
            curl_setopt($ch, CURLOPT_POST, 1);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $query_string);
            curl_setopt($ch, CURLOPT_TIMEOUT, 30);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            $data = curl_exec($ch);
            $responseCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
            curl_close($ch);
        } else {
            $responseCodePattern = '/^HTTP\/\d+\.\d+\s+(\d+)/';
            $fp = @fsockopen($whmcsurl, 80, $errno, $errstr, 5);
            if ($fp) {
                $newlinefeed = "\r\n";
                $header = "POST ".$whmcsurl . $verifyfilepath . " HTTP/1.0" . $newlinefeed;
                $header .= "Host: ".$whmcsurl . $newlinefeed;
                $header .= "Content-type: application/x-www-form-urlencoded" . $newlinefeed;
                $header .= "Content-length: ".@strlen($query_string) . $newlinefeed;
                $header .= "Connection: close" . $newlinefeed . $newlinefeed;
                $header .= $query_string;
                $data = $line = '';
                @stream_set_timeout($fp, 20);
                @fputs($fp, $header);
                $status = @socket_get_status($fp);
                while (!@feof($fp)&&$status) {
                    $line = @fgets($fp, 1024);
                    $patternMatches = array();
                    if (!$responseCode
                        && preg_match($responseCodePattern, trim($line), $patternMatches)
                    ) {
                        $responseCode = (empty($patternMatches[1])) ? 0 : $patternMatches[1];
                    }
                    $data .= $line;
                    $status = @socket_get_status($fp);
                }
                @fclose ($fp);
            }
        }
        if ($responseCode != 200) {
            $localexpiry = date("Ymd", mktime(0, 0, 0, date("m"), date("d") - ($localkeydays + $allowcheckfaildays), date("Y")));
            if ($originalcheckdate > $localexpiry) {
                $results = $localkeyresults;
            } else {
                $results = array();
                $results['status'] = "Invalid";
                $results['description'] = "Remote Check Failed";
                return $results;
            }
        } else {
            preg_match_all('/<(.*?)>([^<]+)<\/\\1>/i', $data, $matches);
            $results = array();
            foreach ($matches[1] AS $k=>$v) {
                $results[$v] = $matches[2][$k];
            }
        }
        if (!is_array($results)) {
            die("Invalid License Server Response");
        }
        if ($results['md5hash']) {
            if ($results['md5hash'] != md5($licensing_secret_key . $check_token)) {
                $results['status'] = "Invalid";
                $results['description'] = "MD5 Checksum Verification Failed";
                return $results;
            }
        }
        if ($results['status'] == "Active") {
            $results['checkdate'] = $checkdate;
            $data_encoded = serialize($results);
            $data_encoded = base64_encode($data_encoded);
            $data_encoded = md5($checkdate . $licensing_secret_key) . $data_encoded;
            $data_encoded = strrev($data_encoded);
            $data_encoded = $data_encoded . md5($data_encoded . $licensing_secret_key);
            $data_encoded = wordwrap($data_encoded, 80, "\n", true);
            $results['localkey'] = $data_encoded;
        }
        $results['remotecheck'] = true;
    }
    unset($postfields,$data,$matches,$whmcsurl,$licensing_secret_key,$checkdate,$usersip,$localkeydays,$allowcheckfaildays,$md5hash);
    return $results;
}

// Validate the license key information
$results = NeWorld_Prefix_Check_License($NeWorld_license, $localkey);

function msg($val,$val2='') {
	echo '<style>body { background-color: #356AB3 !important;background-image: linear-gradient(#356ab3 0,#5d8ed0 100%); }</style><div class="logincontainer login"><a class="navbar-brand" href="https://www.neworld.org">NeWorld</a><div class="login-content"><div class="alert alert-warning text-center">';
	echo $val;
	echo '</div><div class="foot text-center"><a href="https://www.neworld.org"><strong>支持国产软件发展，购买正版许可</strong></a></div></div></div>';
}

// Interpret response
switch ($results['status']) {
    case "Active":
        // get new local key and save it somewhere
        $localkeydata = $results['localkey'];
        break;
    case "Invalid":
        die(msg("您的 NeWorld For WHMCS 许可无效<br/>如果更换域名请登录用户中心释放许可"));
        break;
    case "Expired":
        die(msg("您的 NeWorld For WHMCS 许可过期<br/>请登录用户中心进行续费"));
        break;
    case "Suspended":
        die(msg("您的 NeWorld For WHMCS 许可被停用<br/>请登录用户中心寻求支持"));
        break;
    default:
        die(msg("无效的响应"));
        break;
}
{/php}