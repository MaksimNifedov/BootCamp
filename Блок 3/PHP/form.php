<!DOCTYPE html>
<html lang="ru">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Форма обратной связи</title>
    <!--    Подключаем файл со стилями-->
    <link rel="stylesheet" href="forma__style.css">
</head>
<?php
//Устанавливаем константы для соединения с БД
define('HOST', 'localhost');
define('USER', 'root');
define('PASSWORD', '');
define('DATABASE', 'feedback_form');

// Флаг прошли ли проверку поля
$flag = false;

// Флаг прошла ли вставка в таблицу БД
$insering = false;


// Массив флагов, чтобы узнать какое поле не подходит требования
$default = $output = array(
    'name' => true,
    'email' => true,
    'birthday' => true,
    'sex' => true,
    'topic' => true,
    'question' => true,
    'check' => false,
);

// Функция для того, чтобы узнать подходит ли строка под заданую длину
function check_length($value, $min, $max)
{
    $result = (mb_strlen($value) < $min || mb_strlen($value) > $max);
    return !$result;
}

// Функция для очистики строк от всякой гадости
function clean($value)
{
    $value = trim($value); // Обрезаем пробелы по краям
    $value = stripslashes($value); // для удаления экранированных символов
    $value = strip_tags($value);//для удаления HTML и PHP тегов
    $value = htmlspecialchars($value); // преобразует специальные символы в HTML-сущности ('&' преобразуется в '&amp;' и т.д.)
    return $value;
}


if ($_SERVER['REQUEST_METHOD'] === 'POST') {  // Если форму отправили

    $input = array_intersect_key($_POST, $default); //Вычислить пересечение массивов, сравнивая ключи

    // Очищаем данные от ненужных символов
    $input['name'] = clean($input['name']);
    $input['email'] = clean($input['email']);
    $input['topic'] = clean($input['topic']);
    $input['question'] = clean($input['question']);



    // Если тема содержит символы не входящие в регулярное выражение или недопустимая длина, то зануляем флаг
    if (!(preg_match("/^[а-яА-ЯёЁa-zA-Z0-9\-.,!?:()\s]+$/u", $input['topic']) && check_length($input['topic'], 2, 45) ) ){
        $output['topic'] = false;
    }

    // Если вопрос содержит сиволы не входящие в регулярное выражение или имеет недопустимую длину, то тоже зануляем флаг
    if (!(preg_match("/^[а-яА-ЯёЁa-zA-Z0-9\-@():.,!?;\s]+$/u", $input['question']) && check_length($input['question'], 10, 300))) {
        $output['question'] = false;
    }

    // Если почта содержит сиволы не входящие в регулярное выражение или длина не подходит, то зануляем флаг
    if (!(preg_match ('/^[a-z0-9._]+[@]+[a-z0-9]+[.]+[a-z]{2,4}$/i', $input['email']) && check_length($input['email'], 2, 60) )) {
        $output['email'] = false;
    }
    // В имени должна быть первая буква заглавной, а другие строчные и только русские или недопустимая длина, то зануляем флаг
    if (!(preg_match("/^[А-ЯЁ]{1}[а-яё]*[а-яё]{1}$/u", $input['name']) && check_length($input['name'], 2, 45))) {
        $output['name'] = false;
    }

    // Проверяем нажат ли чекбокс
    if (isset($_POST['check']) && $input['check'] == 'on') {
        $output['check'] = true;
    }
    // Если параметры прошли валидацию
    if ($output['name'] && $output['email'] && $output['topic'] && $output['question'] && $output['check']) {
        $flag = true; // Переводим флаг
        // Подключаемся к БД
        $connect = mysqli_connect(HOST, USER, PASSWORD, DATABASE);
        if (!$connect) { // Если ошибка при соединении , то выводим ошибку и останавливаемся
            die('Error connect to database!');
        }
        // Подготовленный запрос для вставки в таблицу
        $sql = "INSERT INTO `feedback_form`  VALUES (?, ?, ?, ?, ?, ?, ?)";
        // Разбираем запрос
        $stmt = mysqli_prepare($connect, $sql);
        $n = Null; // переменная доя автоинкримета в таблице
        // Задаём параметры для запроса, указывая тип параметров
        mysqli_stmt_bind_param($stmt, "sssssss", $n, $input['name'], $input['email'], $input['sex'], $input['birthday'], $input['topic'], $input['question']);
        // Выполняем запрос с переданными параметрами и закрываем
        mysqli_stmt_execute($stmt);
        mysqli_stmt_close($stmt);
        // Флаг успешной вставки
        $insering = true;

        // Устанавливаем куки
        setcookie("name", $input['name']);
        setcookie("email", $input['email']);
        setcookie("sex", $input['sex']);
        setcookie("birthday", $input['birthday']);
    }
}
?>
<body class="main__body">
<main>
    <section class="forma">
        <div class="forma__container">
            <div class="forma__title">
                Форма обратной связи
            </div>
            <form action="" method="post">
                <!--     Устанавливаем id, если есть ошибка в поле Имя, чтобы рядом вывести блок с подсказкой ::after  -->
                <div class="input__component" <?php if (!$output['name']) echo 'id="name"' ?>>
                    <div class="title">Имя:</div>
                    <input type="text" name="name" class="main<?php if (!$output['name']) {
                        // Если поле имеет не допустимые символы меняем класс, чтобы сделать поле красным.
                        echo '-red';
                    } ?>" required value="<?php if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        // Устанавливаем значение поля, если форма была отправлена
                        if (!$flag) { // Если не все поля прошли проверку, то оставляем, то что было заполнено
                            echo $input['name'];
                        } else { // Если все поля прошли проверку и запись вставилась используем куки, чтобы вывести что было введено
                            if (isset($_COOKIE["name"])) {
                                echo $_COOKIE["name"];
                            }
                        }
                    } elseif (isset($_COOKIE["name"])) { // Если форма еще ни разу не отправилась показать куки
                        echo $_COOKIE["name"];
                    } ?>">
                </div>

                <!--      Смотри на поле Имя          -->
                <div class="input__component" <?php if (!$output['email']) echo 'id="email"' ?> >
                    <div class="title">E-mail:</div>
                    <input type="text" name="email" class="main<?php if (!$output['email']) {
                        echo '-red';
                    } ?>" required value="<?php if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        if (!$flag) {
                            echo $input['email'];
                        } else {
                            if (isset($_COOKIE["email"])) {
                                echo $_COOKIE["email"];
                            }
                        }
                    } elseif (isset($_COOKIE["email"])) {
                        echo $_COOKIE["email"];
                    } ?>">
                </div>

                <!--      Смотри на поле Имя, но тут нет подсветки и подсказок, т.к. они уже все вшиты в html, нельзя ничего ввести кроме даты  -->
                <div class="input__component">
                    <div class="title">День рождения:</div>
                    <input type="date" name="birthday" class="main" required min="1900-01-01" max="2017-01-01"
                           value="<?php if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                               if (!$flag) {
                                   echo $input['birthday'];
                               } else {
                                   if (isset($_COOKIE["birthday"])) {
                                       echo $_COOKIE["birthday"];
                                   }
                               }
                           } elseif (isset($_COOKIE["birthday"])) {
                               echo $_COOKIE["birthday"];
                           } ?>">
                </div>
                <div class="input__radio">
                    <div class="title">Пол:</div>
                    <div class="radio__group">


                        <label><input type="radio" name="sex" class="radio" value="Мужской" <?php
                            // Если форма была отправлена
                            if ($_SERVER['REQUEST_METHOD'] === 'POST') {

                                if (!$flag) {// Если есть некорректные поля, то ставим что было выбрано
                                    if ($input['sex'] == 'Мужской') {
                                        echo 'checked';
                                    }
                                } elseif (isset($_COOKIE['sex']) && $_COOKIE['sex'] == 'Мужской') {
                                    // Если поля все корректны, то берем из куки
                                    echo 'checked';
                                }
                            }
                            // Если форма не отправлялась, то проверяем есть ли куки
                            elseif (isset($_COOKIE['sex'])) {
                                if ($_COOKIE['sex'] == 'Мужской') {
                                    echo 'checked';
                                }
                            } else { //если куки нет, то ставим выбор по умолчанию
                                echo 'checked';
                            }

                            ?>>
                            <div class="new__radio"></div>
                            Мужской</label>

                            <!--    Смотри мужской пол -->
                        <label><input type="radio" name="sex" class="radio" value="Женский" <?php
                            if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                                if (!$flag) {
                                    if ($input['sex'] == 'Женский') {
                                        echo 'checked';
                                    }
                                } elseif ( isset($_COOKIE['sex']) && $_COOKIE['sex'] == 'Женский') {
                                    echo 'checked';
                                }
                            } elseif (isset($_COOKIE['sex'])) {
                                if ($_COOKIE['sex'] == 'Женский') {
                                    echo 'checked';
                                }
                            }


                            ?>>
                            <div class="new__radio"></div>
                            Женский</label>
                    </div>

                </div>

                <!--      Смотри на поле Имя , только тут уже нет куки         -->
                <div class="input__component" <?php if (!$output['topic']) echo 'id="topic"' ?> >
                    <div class="title">Тема обращения:</div>
                    <input type="text" name="topic" class="main<?php if (!$output['topic']) {
                        echo '-red';
                    } ?>" required value="<?php if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                        if (!$flag) {
                            echo $input['topic'];
                        }
                    } ?>">
                </div>

                <!--      Смотри на поле Имя , только тут уже нет куки         -->
                <div class="input__component" <?php if (!$output['question']) echo 'id="question"' ?>>
                    <div class="title">Cуть вопроса:</div>
                    <textarea name="question" cols="45" rows="7" class="main<?php if (!$output['question']) {
                        echo '-red';
                    } ?>" required> <?php if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                            if (!$flag) {
                                echo $input['question'];
                            }
                        } ?></textarea>
                </div>

                    <!--   Ставим id , для того, чтобы использовать элемент ::after  для подсказки           -->
                <div class="input__component" <?php if ($_SERVER['REQUEST_METHOD'] === 'POST') {
                    if (!$output['check']) echo 'id="check"';
                } ?>>
                    <label> <input name="check" type="checkbox" class="checkbox">
                        <div class="new__checkbox"></div>
                        С контрактом ознакомлен</label>
                </div>

                <div class="input__component">
                    <input type="submit" class="submit">
                </div>
            </form>
        </div>
    </section>

</main>


</body>


<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js "></script>
<?php
// Если вставка произошла успешно, то выводим диалоговое окно через js-фреймворк.
if ($insering) {
    echo '<script >
swal("Успешно!","Ваш вопрос отправлен", "success");//Вызов окна с количеством товаров добавленных в корзину
</script>';
}
?>

</html>