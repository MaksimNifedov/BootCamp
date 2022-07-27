<?php
require "config.php";
$id = intval($_GET['id']); // intval - переводит строку в число.
if ($id) { // Если это число
    // запрос для проверки, если ли активный товар с данным ID, данные будут использоваться и дальше, поэтому так много полей
    $products = mysqli_query($connect, "SELECT product.name, product.price,product.price_without_sale,product.price_with_promocode,product.description, images.alt, images.link_image FROM product 
                                            INNER JOIN images on images.id_image=product.id_main_image where product.id_product = '$id' and product_activity=1;");
    $products = mysqli_fetch_all($products);// преобразуем в массив
    if (!$products) { // Если ноль записей, то на 404
        header('HTTP/1.1 404 Not Found');
        header('Status: 404 Not Found');
        require 'Error.html';
        exit;
    }
} else {
    //Если не получилось преобразовать в число, то 404
    header('HTTP/1.1 404 Not Found');
    header('Status: 404 Not Found');
    require 'Error.html';
    exit;
}
// Узнаем категории в которых есть данный товар, выводим ID категорий для того, чтобы сделать кликабельными ссылки на странице рядом с описанием
// А главную категорию для того, чтобы вернутся на нее по заданию по кнопку Назад
$sections = mysqli_query($connect, "SELECT section.id_section, section.name, product.id_main_section FROM section INNER JOIN section_product ON section_product.section_id_section=section.id_section INNER JOIN product ON product.id_product=section_product.product_id_product where product.id_product='$id';");
$sections = mysqli_fetch_all($sections);
?>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title><?= $products[0][0] ?></title>
    <link rel="stylesheet" href="styleproduct.css">
</head>
<body>
<!--Боковое меню с категориями и товарами в них отсортированных от большего к меньшему-->
<div class="sidenav">
    <a href="products.php">Категории</a>
    <?php
    $catigories = mysqli_query($connect, "SELECT section.id_section, section.name, COUNT(section_product.section_id_section) FROM section
                                                INNER JOIN section_product ON section_product.section_id_section=section.id_section 
                                                INNER JOIN product on section_product.product_id_product=product.id_product WHERE product.product_activity=1 GROUP BY section.id_section  ORDER BY COUNT(section_product.section_id_section) DESC;;");
    $catigories = mysqli_fetch_all($catigories);
    foreach ($catigories as $catigory) {
        ?>

        <a  class="cate " href="products.php?cat_id=<?= $catigory[0] ?>"><?= $catigory[1] ?> <span class="count"> <?= $catigory[2] ?> </span></a>
        <?php
    }
    ?>
</div>

<div class="main">
    <?php
    if (isset($_SERVER['HTTP_REFERER'])) { // Если у вкладки есть история, то просто уходим назад
        $urlback = htmlspecialchars($_SERVER['HTTP_REFERER']);
        echo "<a href='$urlback' class='history-back'>Вернуться назад</a>";
    } else { // Если у вкладки нет истории, то возвращаемся на главную категорию товара
        $urlback = htmlspecialchars("products.php?cat_id=" . $sections[0][2]);
        echo "<a href='$urlback' class='history-back'>Вернуться к главной категории</a>";
    }
    ?>
    <div class="shop">

        <section class="photos">
            <div class="photo__shirt">
                <?php
                // Получаем дополнительные картинки товара по его ID
                $images = mysqli_query($connect, "SELECT images.link_image,images.alt FROM images 
                                                                INNER JOIN product_image on product_image.id_image=images.id_image
                                                                INNER JOIN product ON product.id_product=product_image.id_prodict where product.id_product='$id';");
                $images = mysqli_fetch_all($images);

                foreach ($images as $image) {
                    ?>

                    <div class="photo__img">
                        <a href="<?= $image[0] ?>"><img src="<?= $image[0] ?>" alt="<?= $image[1] ?>"></a>
                    </div>
                    <?php
                }
                ?>

            </div>
            <!-- Главное фото с зумом -->
            <div class="main__photo">
                <div class="zoom-img">
                    <div class="zoom-img-block">
                        <a href="<?= $products[0][6] ?>" class="zoom-img-item">
                            <div class="zoom-img-cursor"></div>
                            <img src="<?= $products[0][6] ?>" alt="<?= $products[0][5] ?>" class="rrr">
                        </a>
                    </div>
                    <div class="zoom-img-overlay"></div>
                </div>

            </div>
        </section>
        <section class="information">
            <div class="information">
                <div class="information__title">
                    <?= $products[0][0] ?>
                </div>
                <div class="information__categories">
                    <div class="information__category">
                        <?php
                        foreach ($sections as $section) {
                            ?>
                                    <!--   Категории товара с ссылками на них                             -->
                            <a href="products.php?cat_id=<?= $section[0] ?>" class="category"><?= $section[1] ?></a>
                            <?php
                        }
                        ?>
                    </div>

                </div>

                <div class="information__prices">
                    <del><?= $products[0][2] ?> ₽</del>
                    <div class="price"><?= $products[0][1] ?> ₽</div>
                    <div class="price__promocode"><?= $products[0][3] ?> ₽</div>
                    <div class="promo">– с промокодом</div>
                </div>
                <div class="delivery">
                    <div class="delivery__item">
                        <img src="./img/galka.png" alt="">
                        <div class="item__text">
                            В наличии в магазине
                            <a href="" class="shop__name">Lamoda</a>
                        </div>
                    </div>
                    <div class="delivery__item">
                        <img src="./img/car.png" alt="">
                        <div class="item__text">
                            Бесплатная доставка
                        </div>
                    </div>
                </div>
                <div class="quantity__inner">
                    <button class="bt__minus">-</button>
                    <input type="text" class="quantity" value="1" data-max-count="50">
                    <button class="bt__plus">+</button>
                </div>
                <div class="group__buttons">
                    <button class="btn__primary">КУПИТЬ</button>
                    <button class="btn__outline">В ИЗБРАННОЕ</button>
                </div>
            </div>
            <div class="description">
                <?= $products[0][4] ?>
            </div>
            <div class="social__network">
                <div class="network__text">ПОДЕЛИТЬСЯ:</div>
                <div class="network__img">
                    <a href="">
                        <img src="img/vk.png" alt="">
                    </a>
                    <a href="">
                        <img src="img/gogle.png" alt="">
                    </a>
                    <a href="">
                        <img src="img/facebook.png" alt="">
                    </a>
                    <a href="">
                        <img src="img/tw.png" alt="">
                    </a>
                    <div class="repost">
                        123
                    </div>
                </div>
            </div>
        </section>
    </div>


</div>

</body>

<script crossorigin="anonymous" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js "></script>
<script src="./js/scripts.min.js"></script>

</html>
