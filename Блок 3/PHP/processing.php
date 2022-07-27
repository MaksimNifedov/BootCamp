<?php
define('HOST', 'localhost');
define('USER', 'root');
define('PASSWORD', '');
define('DATABASE', 'feedback_form');
//setlocale(LC_ALL, 'russian');
$connect = mysqli_connect(HOST, USER, PASSWORD, DATABASE);
if (!$connect) {
    die('Error connect to database!');
}
$sql = "INSERT INTO `feedback_form`  VALUES (?, ?, ?, ?, ?, ?, ?)";
$stmt = mysqli_prepare($connect, $sql);
$n = Null;
function check_length($value , $min, $max) {
    $result = (mb_strlen($value) < $min || mb_strlen($value) > $max);
    return !$result;
}
function clean($value) {
    $value = trim($value);
    $value = stripslashes($value);
    $value = strip_tags($value);
    $value = htmlspecialchars($value);
    return $value;
}
$name = clean($_POST['name']);
$email = clean($_POST['email']);
$topic = clean($_POST['topic']);
$question = clean($_POST['question']);
$sex = $_POST['sex'];
$birthday = $_POST['birthday'];
if(!preg_match("/^[А-ЯЁ]{1}[а-яё]*[а-яё]{1}$/u",$name)){
    $name = '';
}

if(!empty($name) && !empty($email) && !empty($topic) && !empty($question)) {
    $email_validate = filter_var($email, FILTER_VALIDATE_EMAIL);

    if(check_length($name, 2, 45) && check_length($topic, 2, 45) && check_length($question, 2, 300) && $email_validate) {
        mysqli_stmt_bind_param($stmt, "sssssss",$n, $name, $email, $sex, $birthday, $topic, $question);
        mysqli_stmt_execute($stmt);
        mysqli_stmt_close($stmt);

        $redicet = $_SERVER['HTTP_REFERER'];
        @header ("Location: $redicet");

    }
}