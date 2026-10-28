<?php
declare(strict_types=1);
define('APP_NAME','KerjaSetara');
define('BASE_URL','/KerjaSetara/public');
define('DB_HOST','127.0.0.1');
define('DB_NAME','kerjasetara');
define('DB_USER','root');
define('DB_PASS','');
if(session_status()===PHP_SESSION_NONE) session_start();
function db(): PDO {
 static $pdo=null;
 if($pdo instanceof PDO) return $pdo;
 $pdo=new PDO('mysql:host='.DB_HOST.';dbname='.DB_NAME.';charset=utf8mb4',DB_USER,DB_PASS,[
  PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION,
  PDO::ATTR_DEFAULT_FETCH_MODE=>PDO::FETCH_ASSOC,
  PDO::ATTR_EMULATE_PREPARES=>false
 ]);
 return $pdo;
}
