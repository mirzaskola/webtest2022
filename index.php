<?php 
require 'vendor/autoload.php';
Flight::route('/', function(){
	echo "Allah";
});
Flight::start();
?>