<?php

$api_dev_key           = 'a169da63957ce82b2c7e4d32e93c220f';
$api_paste_code        = file_get_contents('php://stdin');
$api_paste_private     = '1';
$api_paste_expire_date = '10M';
$api_user_key          = ''; // if an invalid api_user_key or no key is used, the paste will be create as a guest
$api_paste_code        = urlencode($api_paste_code);

$ch  = curl_init('http://pastebin.com/api/api_post.php');
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, 'api_option=paste&api_user_key='.$api_user_key.'&api_paste_private='.$api_paste_private.'&api_paste_expire_date='.$api_paste_expire_date.'&api_dev_key='.$api_dev_key.'&api_paste_code='.$api_paste_code.'');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_VERBOSE, 0);
curl_setopt($ch, CURLOPT_NOBODY, 0);

$response = curl_exec($ch);

echo $response, "\n";
