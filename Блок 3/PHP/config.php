<?php

// Устанавливаем константы для подключения к БД
define('HOST', 'localhost');
define('USER', 'root');
define('PASSWORD', '');
define('DATABASE', 'shop');

// Производим подключение к БД
$connect = mysqli_connect(HOST, USER, PASSWORD, DATABASE);
if (!$connect) { // При ошибки подключения выводим сообщения и прекращаем работу.
    die('Error connect to database!');
}
?>