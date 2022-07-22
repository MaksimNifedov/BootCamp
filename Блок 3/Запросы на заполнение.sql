-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Июл 22 2022 г., 12:49
-- Версия сервера: 8.0.24
-- Версия PHP: 8.0.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `shop`
--

-- --------------------------------------------------------

--
-- Структура таблицы `images`
--

CREATE TABLE `images` (
  `ID_Image` int NOT NULL,
  `ALT` varchar(150) NOT NULL,
  `Link_Image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Дамп данных таблицы `images`
--

INSERT INTO `images` (`ID_Image`, `ALT`, `Link_Image`) VALUES
(1, 'Белые спортивные брюки. Вид спереди.', 'https://a.lmcdn.ru/product/R/T/RTLABJ347301_16872462_1_v1_2x.jpg'),
(2, 'Белые спортивные брюки. На мужчине с синим свитшотом. ', 'https://a.lmcdn.ru/product/R/T/RTLABJ347301_16872463_2_v1_2x.jpg'),
(3, 'Белые спортивные брюки. Вид сзади.', 'https://a.lmcdn.ru/product/R/T/RTLABJ347301_16872464_3_v1_2x.jpg'),
(4, 'Massimo Dutti черные брюки вид спереди.', 'https://a.lmcdn.ru/product/R/T/RTLABP728701_17659419_1_v1_2x.jpg'),
(5, 'Massimo Dutti чёрные брюки вид во весь рост.', 'https://a.lmcdn.ru/product/R/T/RTLABP728701_17659420_2_v1_2x.jpg'),
(6, 'Брюки в клетку от Остин. Вид во весь рост.', 'https://a.lmcdn.ru/product/M/P/MP002XM08M7B_17637206_2_v1_2x.jpg'),
(7, 'Брюки в клетку от Остин. Вид спереди.', 'https://a.lmcdn.ru/product/M/P/MP002XM08M7B_17637205_1_v1_2x.jpg'),
(8, 'Летняя распродажа на этот товар! Успей купить.', 'https://cdn.telegram-site.com/images/1/3/8/7/3/7/5/8/2/0/963a69b4164442817ccd2f615cf0dc23.jpg'),
(9, 'Голубые джинсы от Остин. Вид спереди.', 'https://a.lmcdn.ru/product/M/P/MP002XM1I73N_16426879_1_v1_2x.jpg'),
(10, 'Голубые джинсы от Остин. Вид во весь рост на мужчине-модели.', 'https://a.lmcdn.ru/product/M/P/MP002XM1I73N_16426880_2_v1_2x.jpg'),
(11, 'Синие джинсы Tom Tailor. Вид спереди.', 'https://a.lmcdn.ru/product/M/P/MP002XM1I9BB_16487190_1_v1_2x.jpg'),
(12, 'Синие джинсы Tom Tailor. Модель во весь рост.', 'https://a.lmcdn.ru/product/M/P/MP002XM1I9BB_16487191_2_v1_2x.jpg'),
(13, 'Джинсы Колинс. Вид спереди.', 'https://a.lmcdn.ru/product/M/P/MP002XM08LL1_17615192_1_v1_2x.jpg'),
(14, 'Джинсы Колинс. Вид во весь рост.', 'https://a.lmcdn.ru/product/M/P/MP002XM08LL1_17615193_2_v1_2x.jpg'),
(15, 'Джинсы DeFacto. Вид спереди.', 'https://a.lmcdn.ru/product/M/P/MP002XM1HUWE_15801854_1_v1_2x.jpg'),
(16, 'Джинсы DeFacto. Вид во весь рост.', 'https://a.lmcdn.ru/product/M/P/MP002XM1HUWE_15801855_2_v1_2x.jpg'),
(17, 'Джинсы Levi\'s. Вид спереди. ', 'https://a.lmcdn.ru/product/R/T/RTLAAJ770301_14358327_1_v1_2x.jpg'),
(18, 'Джинсы Levi\'s. Модель-мужчина сидит на стуле.', 'https://a.lmcdn.ru/product/R/T/RTLAAJ770301_14358328_2_v1_2x.jpg'),
(19, 'Джинсы Mango Man. Вид спереди.', 'https://a.lmcdn.ru/product/R/T/RTLABB029201_16165189_1_v1.jpg'),
(20, 'Джинсы Mango Man. Вид сзади.', 'https://a.lmcdn.ru/product/R/T/RTLABB029201_16165191_3_v1.jpg'),
(21, 'Джинсы Gloria Jeans. Вид спереди.', 'https://a.lmcdn.ru/product/M/P/MP002XM08DB2_17170950_1_v1_2x.jpg'),
(22, 'Джинсы Gloria Jeans. Вид во весь рост.', 'https://a.lmcdn.ru/product/M/P/MP002XM08DB2_17170951_2_v1_2x.jpg'),
(23, 'Джинсы Mossmore. Вид спереди. ', 'https://a.lmcdn.ru/product/M/P/MP002XM1RI43_15493361_1_v1_2x.jpg'),
(24, 'Джинсы Mossmore. Вид сзади. ', 'https://a.lmcdn.ru/product/M/P/MP002XM1RI43_15493363_3_v1_2x.jpg'),
(25, 'Джинсы Classic fit. Вид спереди.', 'https://a.lmcdn.ru/product/M/P/MP002XM1I8YM_17091836_1_v1_2x.jpg'),
(26, 'Джинсы Classic fit. Вид во весь рост.', 'https://a.lmcdn.ru/product/M/P/MP002XM1I8YM_17091837_2_v1_2x.jpg'),
(27, 'Velikoross джинсы. Вид спереди. \r\n', 'https://a.lmcdn.ru/product/M/P/MP002XM08IW2_17513526_1_v1_2x.jpg'),
(28, 'Velikoross джинсы. Вид во весь рост. \r\n', 'https://a.lmcdn.ru/product/M/P/MP002XM08IW2_17513527_2_v1_2x.jpg'),
(29, 'Джинсы Trendyol. Вид спереди.', 'https://a.lmcdn.ru/product/R/T/RTLABF360601_16507772_1_v2_2x.jpg'),
(30, 'Джинсы Trendyol. Вид сзади.', 'https://a.lmcdn.ru/product/R/T/RTLABF360601_16507774_3_v2_2x.jpg'),
(31, 'Джинсы Befree. Вид спереди.', 'https://a.lmcdn.ru/product/M/P/MP002XM08JFI_17493117_1_v1_2x.jpg'),
(32, 'Джинсы Befree. Вид сзади.', 'https://a.lmcdn.ru/product/M/P/MP002XM08JFI_17493119_3_v1_2x.jpg'),
(33, 'Кроссовки Reebok Classics. Вид сбоку.', 'https://a.lmcdn.ru/product/R/T/RTLABK224501_17026327_3_v1.jpg'),
(34, 'Кроссовки Reebok Classics. Вид сверху.', 'https://a.lmcdn.ru/product/R/T/RTLABK224501_17026326_2_v1.jpg');

-- --------------------------------------------------------

--
-- Структура таблицы `product`
--

CREATE TABLE `product` (
  `ID_Product` int NOT NULL,
  `Name` varchar(60) NOT NULL,
  `ID_Main_Section` int NOT NULL,
  `ID_Main_Image` int NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Price_Without_Sale` decimal(10,2) NOT NULL,
  `Price_With_Promocode` decimal(10,2) NOT NULL,
  `Description` varchar(350) NOT NULL,
  `Product_activity` tinyint(1) NOT NULL
) ;

--
-- Дамп данных таблицы `product`
--

INSERT INTO `product` (`ID_Product`, `Name`, `ID_Main_Section`, `ID_Main_Image`, `Price`, `Price_Without_Sale`, `Price_With_Promocode`, `Description`, `Product_activity`) VALUES
(1, 'Брюки спортивные M FV PT Adidas', 1, 1, '3290.00', '5999.00', '3000.00', 'В составе 100% хлопок. Мультисезонные. Вид стиля: спортивный. Цвет: Белый.', 1),
(3, 'Massimo Dutti  чёрные брюки', 2, 4, '5990.00', '9520.00', '5145.00', 'Состав: Полиэстер - 54%, Шерсть - 44%, Эластан - 2%. Посадка: Slim fit. Карманы: 4. Вид застёжки: молния.', 1),
(4, 'Брюки от O\'Stin', 1, 6, '2999.00', '5000.00', '2450.00', 'Состав: Полиэстер - 69%, Вискоза - 31%. Цвет: Синий. Узор: клетка. Страна производства: Китай.', 1),
(5, 'Голубые джинсы от O\'Stin', 2, 10, '2599.00', '5299.00', '2100.00', 'Состав: Хлопок 100%. Цвет: Голубой. Страна производства: Бангладеш.', 1),
(6, 'Синие джинсы Tom Tailor', 2, 11, '3599.00', '6599.00', '3250.00', 'Джинсы Tom Tailor. Состав:Хлопок - 70%, Полиэстер - 28%, Эластан - 2%. Карманы:4. Гарантийный период:30 дней.', 1),
(7, 'Джинсы Colin\'s', 2, 13, '4490.00', '5999.00', '4000.00', 'Цвет: чёрный. Состав: Хлопок - 99%, Эластан - 1%. Страна: Бангладеж. ', 1),
(8, 'Джинсы DeFacto', 2, 16, '1729.00', '3000.00', '1550.00', 'Состав:Хлопок - 82%, Эластан - 2%, Полиэстер - 16%. Сезон: Демисезон. Страна: Турция.', 1),
(9, 'Джинсы Levi\'s', 2, 18, '7740.00', '12900.00', '7000.00', 'Товар как минимум на 50% состоит из органического хлопка. Отдавая предпочтение товарам с натуральным и органическим составом, вы проявляете заботу о себе и бережете планету.', 1),
(10, 'Джинсы JUDE', 2, 20, '4999.00', '5500.00', '4585.00', 'Состав: Хлопок - 98%, Эластан - 2%. Карманы: 5. Страна: Пакистан.', 1),
(11, 'Джинсы Gloria Jeans', 2, 21, '1799.00', '2199.00', '1500.00', 'Состав: Хлопок - 94%, Полиэстер - 4%, Спандекс - 2%. Страна: Россия.', 1),
(12, 'Джинсы Mossmore', 2, 23, '3490.00', '6590.00', '3000.00', 'Состав:Хлопок - 98%, Эластан - 2%. Страна: Китай.', 1),
(13, 'Джинсы Classic fit', 2, 25, '2890.00', '5990.00', '2500.00', 'Состав: Хлопок - 98%, Эластан - 2%. Страна: Китай.', 1),
(14, 'Velikoross джинсы', 2, 27, '7799.00', '12990.00', '7315.00', 'Состав: Хлопок - 100%. Страна: Россия.', 1),
(15, 'Джинсы Trendyol', 2, 29, '2470.00', '4990.00', '2250.00', 'Состав:Хлопок - 98%, Эластан - 2%. Страна: Турция.', 1),
(16, 'Джинсы Befree', 2, 31, '3999.00', '4800.00', '3500.00', 'Состав:Хлопок - 85%, Полиэстер - 13%, Вискоза - 2%. Страна: Китай.', 1),
(17, 'Кроссовки Reebok Classics', 4, 33, '10999.00', '12999.00', '10000.00', 'Кроссовки выполнены из натуральной кожи и композиционной кожи. Детали: верх из натуральной кожи, амортизация без утяжеления, стандартная шнуровка, текстильная подкладка.', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `product_image`
--

CREATE TABLE `product_image` (
  `ID_Prodict` int NOT NULL,
  `ID_Image` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Дамп данных таблицы `product_image`
--

INSERT INTO `product_image` (`ID_Prodict`, `ID_Image`) VALUES
(1, 2),
(1, 3),
(1, 8),
(3, 5),
(3, 8),
(4, 7),
(5, 9),
(6, 12),
(7, 14),
(8, 15),
(9, 17),
(10, 19),
(11, 22),
(12, 24),
(13, 26),
(14, 28),
(15, 30),
(16, 32),
(17, 34);

-- --------------------------------------------------------

--
-- Структура таблицы `section`
--

CREATE TABLE `section` (
  `ID_Section` int NOT NULL,
  `Name` varchar(80) NOT NULL,
  `Description` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Дамп данных таблицы `section`
--

INSERT INTO `section` (`ID_Section`, `Name`, `Description`) VALUES
(1, 'Брюки', 'Все виды брюк от спортивных до элегантных.'),
(2, 'Джинсы', 'Джинсы от обычных голубых до разноцветных рваных'),
(3, 'Мужская одежда', 'Одежда от верха до низа.'),
(4, 'Кроссовки', 'Кроссовки на все сезоны.'),
(5, 'Обувь', 'От кроссовок до пары элегантных туфель. ');

-- --------------------------------------------------------

--
-- Структура таблицы `section_product`
--

CREATE TABLE `section_product` (
  `Product_ID_Product` int NOT NULL,
  `Section_ID_Section` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Дамп данных таблицы `section_product`
--

INSERT INTO `section_product` (`Product_ID_Product`, `Section_ID_Section`) VALUES
(1, 2),
(1, 3),
(3, 1),
(3, 3),
(4, 2),
(4, 3),
(5, 3),
(6, 3),
(7, 3),
(8, 3),
(9, 3),
(10, 3),
(11, 3),
(12, 3),
(13, 1),
(13, 3),
(14, 3),
(15, 3),
(16, 3),
(17, 5);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`ID_Image`),
  ADD UNIQUE KEY `Link_Image` (`Link_Image`);

--
-- Индексы таблицы `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`ID_Product`),
  ADD KEY `Prodict_Main_Section` (`ID_Main_Section`),
  ADD KEY `Product_Main_Image` (`ID_Main_Image`);

--
-- Индексы таблицы `product_image`
--
ALTER TABLE `product_image`
  ADD PRIMARY KEY (`ID_Prodict`,`ID_Image`),
  ADD KEY `ID_Product_for_Image` (`ID_Prodict`),
  ADD KEY `Image_Product` (`ID_Image`);

--
-- Индексы таблицы `section`
--
ALTER TABLE `section`
  ADD PRIMARY KEY (`ID_Section`);

--
-- Индексы таблицы `section_product`
--
ALTER TABLE `section_product`
  ADD PRIMARY KEY (`Product_ID_Product`,`Section_ID_Section`),
  ADD KEY `Section_Product_ID_Product` (`Product_ID_Product`),
  ADD KEY `Section_Product_ID_Section` (`Section_ID_Section`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `images`
--
ALTER TABLE `images`
  MODIFY `ID_Image` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT для таблицы `product`
--
ALTER TABLE `product`
  MODIFY `ID_Product` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `section`
--
ALTER TABLE `section`
  MODIFY `ID_Section` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `product_image`
--
ALTER TABLE `product_image`
  ADD CONSTRAINT `ID_Image` FOREIGN KEY (`ID_Image`) REFERENCES `images` (`ID_Image`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ID_Product` FOREIGN KEY (`ID_Prodict`) REFERENCES `product` (`ID_Product`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `section_product`
--
ALTER TABLE `section_product`
  ADD CONSTRAINT `Product_ID_Product` FOREIGN KEY (`Product_ID_Product`) REFERENCES `product` (`ID_Product`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Section_ID_Section` FOREIGN KEY (`Section_ID_Section`) REFERENCES `section` (`ID_Section`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
