# AURA
  Если вы смотрели курсы авитологов, то там всегда советуют для уникализации фотографий использовать XnView. Это замечательная программа, вопросов нет, но есть одно но: ее нельзя автоматизировать
  Сдвигать паттерн рандомизации вручную для каждой пачки, держа random.org второй вкладкой это не очень то удобно. С той мыслью я и приступил к написанию уникализатора изображений AURA.

  <b>Как это работает?</b>
Для работы AURA требуется паттерн уникализации. Он выглядит как png изображение размером 1024х1024, заполненное черными точками в случайных местах. Затем Aura наносит этот паттерн на изображения с рандомным сдвигом. Этого достаточно, чтобы Авито не считало фотографии одинаковыми.

  <b>Как это установить?</b>
Просто скачайте скомпилированный .exe файл из вкладки Releases и затем откройте
    ИЛИ
Скачайте [AutoHotKey](https://autohotkey.com)
Скачайте AURA.ahk из данного репозитория
Скачайте [GDI+](https://www.autohotkey.com/boards/viewtopic.php?t=6517) (Gdip_All.ahk) и положите его в папку с AURA
Откройте AURA.ahk

TODO:
English readme
Dropdown lists of previous folders
GUI polish
Code unspaghetting
