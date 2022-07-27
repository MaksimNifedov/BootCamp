<?php

$cat_id = intval($_GET['cat_id']); // intval - переводит строку в число.
if ($cat_id) { // Если перевод получился
    // проверяем сколько АКТИВНЫХ товаров в данной категории
    $findSection = mysqli_query($connect, "SELECT  COUNT(section_product.section_id_section) FROM section 
    INNER JOIN section_product ON section_product.section_id_section=section.id_section 
    INNER JOIN product on section_product.product_id_product=product.id_product
WHERE product.product_activity=1 AND section.id_section='$cat_id';");
    $findSection = mysqli_fetch_all($findSection);
    if ($findSection[0][0] == 0) {
        // Если в категории нет активных товаров, то отправляем ответ 404 и показываем стр. 404.
        header('HTTP/1.1 404 Not Found');
        header('Status: 404 Not Found');
        require 'Error.html';
        exit;
    }
} else {
    // Если перевод строки в число не получился, то тоже ответ 404
   header('HTTP/1.1 404 Not Found');
    header('Status: 404 Not Found');
    require 'Error.html';
    exit;
}
// запрос для получения названия и описания категории
$section = mysqli_query($connect, "SELECT section.name, section.description FROM section WHERE section.id_section='$cat_id'");
$section = mysqli_fetch_all($section);
$kol = 12;  //количество записей для вывода

// Проверка для пагинации
if (isset($_GET['page'])) { // Если у Get есть данный параметр
    $page = abs(intval($_GET['page'])); // Переводим в положительное число
    if (!$page) { // Если перевод не произошел, то 404
        header('HTTP/1.1 404 Not Found');
        header('Status: 404 Not Found');
        require 'Error.html';
        exit;
    }
} else $page = 1; // Если в ссылке нет Get с таким параметром присвоить 1
// Считаем с какой записи начинать выборку на данной странице
$art = ($page * $kol) - $kol;

$total = $findSection[0][0]; // всего записей
$str_pag = ceil($total / $kol); // сколько будет страниц, с округлением в большую сторону
if ($page > $str_pag) { // Если пользователь ввёл число больше, чем есть у категории, то 404.
    header('HTTP/1.1 404 Not Found');
    header('Status: 404 Not Found');
    require 'Error.html';
    exit;
}
?>


<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title> Категория <?= $section[0][0] ?> </title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="sidenav">
        <!-- Ссылка ведущая к списку категорий   -->
    <a href="products.php">На главную</a>
    <?php
    // Запрос для получения названия категории и сколько в ней активных товаров
    $catigories = mysqli_query($connect, "SELECT section.id_section, section.name, COUNT(section_product.section_id_section) FROM section
                                                INNER JOIN section_product ON section_product.section_id_section=section.id_section 
                                                INNER JOIN product on section_product.product_id_product=product.id_product WHERE product.product_activity=1 GROUP BY section.id_section ORDER BY COUNT(section_product.section_id_section) DESC;");
    $catigories = mysqli_fetch_all($catigories); // Полученный результат преобразуем в массив
    foreach ($catigories as $catigory) { //  Используем цикл, для прохода по полученным записям
        ?>
        <!-- В ссылке на категорию указываем её ID-->
        <a  class="cate"  href="products.php?cat_id=<?= $catigory[0] ?>"><?= $catigory[1] ?> <span class="count"> <?= $catigory[2] ?></span> </a>
        <?php
    }
    ?>
</div>

<div class="main">
    <div class="category">
        <div class="category__title">
            <!-- Название данной категории     -->
            <?= $section[0][0] ?>
        </div>
        <div class="category__description">
            <!--     Описание данной категории        -->
            <?= $section[0][1] ?>
        </div>
    </div>

    <div class="cards">
        <?php
        // Запрос для вывода активных товаров категории, по 12 штук на страницу.
        $products = mysqli_query($connect, "SELECT product.id_product, product.name,images.link_image, images.alt from product
                                                  INNER JOIN section_product on section_product.product_id_product=product.id_product 
                                                  INNER JOIN section on section.id_section=section_product.section_id_section 
                                                  INNER JOIN images on product.id_main_image=images.id_image 
                                                  where section.id_section='$cat_id' AND product_activity=1 LIMIT $art,$kol;");
        $products = mysqli_fetch_all($products);

        foreach ($products as $product) {
            // Узнаем главную категорию товара по его ID.
            $main_section = mysqli_query($connect, "SELECT section.name FROM section INNER JOIN product ON section.id_section=product.id_main_section where product.id_product='$product[0]'; ");
            $main_section = mysqli_fetch_all($main_section);
            ?>
            <!--       Выводим карточки с товарами         -->
            <a href="product.php?id=<?= $product[0] ?>">
                <div class="card">
                    <div class="card__body">
                        <img src="<?= $product[2] ?>" alt="<?= $product[3] ?>" class="img__card">
                    </div>
                    <div class="card__subtitle"> <?= $product[1] ?><br> Главная категория: <?= $main_section[0][0] ?>
                    </div>
                </div>
            </a>
            <?php
        }
        ?>
    </div>

    <div class="page__navi">
        <?php

        for ($i = 1; $i <= $str_pag; $i++) {
            if($page==$i){ // Для выделения номера стр на которой находимся
            ?>
            <!-- Вывод пагинации           -->
            <a href="products.php?cat_id=<?= $cat_id ?>&page=<?= $i ?>" style="color: #0b76ef"> стр. <?= $i ?></a>
            <?php
            }
            else{
            ?>
        <a href="products.php?cat_id=<?= $cat_id ?>&page=<?= $i ?>"> стр. <?= $i ?></a>

                <?php
        }
        }
        ?>
    </div>
</div>


</body>
</html>