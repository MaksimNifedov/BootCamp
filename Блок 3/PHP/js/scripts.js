// Custom Scripts
// Custom scripts
let globalX = 0;
let globalY = 0;

// Отслеживание позиций курора мыши
$(document).on('mousemove', function (e) {
   globalX = e.pageX;
   globalY = e.pageY;
});


$('.zoom-img-item').on('mousemove', function () {
   let zoom = 4; //Во сколько раз увеличивает зум
   let img = $(this).attr('href'); // Получение ссылки-изображения 
   let imgBlock = $(this).find('img');//находим изображение в классе zoom-img-item
   let imgWidth = imgBlock.width();// ширина изображения
   let imgHeight = imgBlock.height();//высота изображения
   let overlay = $('.zoom-img-overlay');
   let cursor = $('.zoom-img-cursor');
   cursor.css('width', overlay.width() / zoom + 'px'); // Уставливаем ширину курсора-зума пропорцианально зуму
   cursor.css('height', overlay.height() / zoom + 'px');// Уставливаем высоту курсора-зума пропорцианально зуму

   let cursorWidth = cursor.outerWidth();//Получаем ширину курсора-зума без рамки
   let cursorHeight = cursor.outerHeight();
   let posX = globalX - $(this).offset().left - cursorWidth / 2; //Вычисляем позиции курсора на картинке, именно центр курсора-зума
   let posY = globalY - $(this).offset().top - cursorHeight / 2;


   // Чтобы курсор не мог зайти за границы изображения
   if (posX < 0) {
      posX = 0;
   }

   if (posX > (imgWidth - cursorWidth)) {
      posX = imgWidth - cursorWidth;
   }
   if (posY < 0) {
      posY = 0;
   }
   if (posY > (imgHeight - cursorHeight)) {
      posY = imgHeight - cursorHeight;
   }

   cursor.css('left', posX + 'px');
   cursor.css('top', posY + 'px');
   cursor.show();
   posX *= zoom;
   posY *= zoom;
   overlay.css('background-image', `url(${img})`);//задаем изображение для зума
   overlay.css('background-size', (imgWidth * zoom) + 'px');// увеличиваем 

   overlay.css('background-position', `-${posX}px -${posY}px`);//Позиционируем чтобы зум показывал, то на чём сейчас стоит курсор-зум
   overlay.show();
});

$('.zoom-img-item').on('mouseleave', function () {
   $('.zoom-img-cursor').hide();//если курсор мыши покинул изображение скрываем элементы зума
   $('.zoom-img-overlay').hide();
});


$('.quantity__inner .bt__minus').click(function () {
   let $input = $(this).parent().find('.quantity');
   let count = parseInt($input.val()) - 1;
   count = count < 1 ? 1 : count;
   $input.val(count);
});
// Прибавляем кол-во по клику
$('.quantity__inner .bt__plus').click(function () {
   let $input = $(this).parent().find('.quantity');
   let count = parseInt($input.val()) + 1;
   count = count > parseInt($input.data('max-count')) ? parseInt($input.data('max-count')) : count;
   $input.val(parseInt(count));
});
// Убираем все лишнее и невозможное при изменении поля
$('.quantity__inner .quantity').bind("change keyup input click", function () {
   if (this.value.match(/[^0-9]/g)) {
      this.value = this.value.replace(/[^0-9]/g, '');
   }
   if (this.value == "") {
      this.value = 1;
   }
   if (this.value > parseInt($(this).data('max-count'))) {
      this.value = parseInt($(this).data('max-count'));
   }
});

$('.btn__primary').click(function () { //При нажатии на кнопку купить
   let $input = $('.quantity__inner ').parent().find('.quantity');
   let text = '';
   let count = parseInt($input.val());//считываем число товаров
   if (count == 1) {
      text = "В корзину добавлен " + count + " товар!";
   }
   if (count >= 5) {
      text = "В корзину добавлено " + count + " товаров!";
   }
   if (count > 1 && count < 5) {
      text = "В корзину добавлено " + count + " товара!";
   }
   swal("Успешно!", text, "success");//Вызов окна с количеством товаров добавленных в корзину 
});
