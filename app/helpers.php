<?php
require_once __DIR__.'/../config/config.php';
function e(?string $s): string { return htmlspecialchars($s??'',ENT_QUOTES,'UTF-8'); }
function url(string $p=''): string { return rtrim(BASE_URL,'/').($p?'/'.ltrim($p,'/'):'/'); }
function redirect(string $p): never { header('Location: '.url($p)); exit; }
function csrf_token(): string { if(empty($_SESSION['_csrf'])) $_SESSION['_csrf']=bin2hex(random_bytes(32)); return $_SESSION['_csrf']; }
function csrf_field(): string { return '<input type="hidden" name="_csrf" value="'.e(csrf_token()).'">'; }
function verify_csrf(): void { if(!is_string($_POST['_csrf']??null)||!hash_equals($_SESSION['_csrf']??'',$_POST['_csrf'])){http_response_code(419);exit('Sesi formulir tidak valid. Muat ulang halaman.');} }
function current_user(): ?array { return $_SESSION['user']??null; }
function require_login(): void { if(!current_user()){flash('error','Silakan masuk terlebih dahulu.');redirect('login.php');} }
function require_role(string ...$roles): void { require_login(); if(!in_array(current_user()['role'],$roles,true)){http_response_code(403);exit('Akses tidak diizinkan.');} }
function flash(string $type,string $message): void { $_SESSION['_flash'][]=['type'=>$type,'message'=>$message]; }
function take_flashes(): array { $f=$_SESSION['_flash']??[];unset($_SESSION['_flash']);return $f; }
function initials(string $s): string { $out='';foreach(array_slice(preg_split('/\s+/',trim($s))?:[],0,2) as $p)$out.=strtoupper(substr($p,0,1));return $out?:'KS'; }
function badge_class(string $s): string { return match($s){'Diterima','Aktif'=>'badge-success','Ditolak','Ditangguhkan'=>'badge-danger','Ditinjau','Diproses','Menunggu'=>'badge-warn',default=>'badge-neutral'}; }
