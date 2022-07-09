
<!DOCTYPE html>
   <html lang="ru">

   <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Запись на курсы программирования </title>
   </head>
   <h1>Спасибо, что заполнили форму записи  </h1>
   <hr>
   <form action="index.html" method="">
      <small>Имя:</small><br>
      <input type="text" value="<?=$_POST['name']?>" readonly><br><br>
      <small>Язык программирования:</small><br>
      <input type="text" value="<?=$_POST['programmingLanguage']?>" readonly>
      <br><br>

      <small>Дополнительная информация:</small><br>
      <textarea  cols="23" rows="4" readonly><?=$_POST['description']?></textarea>
      <br><br>

      <small>Секретное слово:</small><br>
      <input type="text" value="<?=$_POST['secret']?>" readonly><br><br>

      <input id="check"  type="checkbox" checked onClick="return false;"><label for="check">С правилами ознакомился и
         согласен</label> <br><br>

      <input type="submit" value="Понятно">

   </form>
   <hr>
   Made by andron13
   </body>

   </html>
