<?php

require "config.php"; // Подключаем файл для соединения с БД
if (isset($_GET['cat_id'])) {
    // Если в ссылке страницы задана Get категории, то подключаем вспомогательный файл, если нет, то остаёмся на страницы с категориями
    include "category.php"; // Вспомогательный файл, чтобы не нагружать данный.
} else {
    ?>
    <!doctype html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Главная страница магазина</title>
        <link rel="stylesheet" href="style.css">
    </head>
    <body>

    <!--Боковое меню с категориями и товарами в них отсортированных от большего к меньшему-->
    <div class="sidenav">
        <a href="products.php">Категории</a>
        <?php
        // Запрос для получения названия категории и сколько в ней активных товаров
        $catigories = mysqli_query($connect, "SELECT section.id_section, section.name, COUNT(section_product.section_id_section) FROM section
                                                INNER JOIN section_product ON section_product.section_id_section=section.id_section 
                                                INNER JOIN product on section_product.product_id_product=product.id_product WHERE product.product_activity=1 GROUP BY section.id_section ORDER BY COUNT(section_product.section_id_section) DESC;");
        $catigories = mysqli_fetch_all($catigories);// Полученный результат преобразуем в массив
        foreach ($catigories as $catigory) { //  Используем цикл, для прохода по полученным записям
            ?>
                <!-- В ссылке на категорию указываем её ID-->
            <a class="cate" href="products.php?cat_id=<?= $catigory[0] ?>"><?= $catigory[1] ?> <span class="count">  <?= $catigory[2] ?> </span></a>
            <?php
        }
        ?>
    </div>

    <div class="main">
        <h1>
            Летняя распродажа продится до 03.08.2022
        </h1>
        <img src="https://postinger.halyavshiki.com/upload/60a8ad61dac61.jpg" alt="" class="ttt">

    </div>

    </body>
    </html>
    <?php
}
?>