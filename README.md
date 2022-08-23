# AURA
Если вы смотрели курсы авитологов, то там всегда советуют для уникализации фотографий использовать XnView. Это замечательная программа, вопросов нет, но есть одно но: ее нельзя автоматизировать  
Сдвигать паттерн рандомизации вручную для каждой пачки, держа random.org второй вкладкой это не очень то удобно. С этой мыслью я и приступил к написанию уникализатора изображений AURA.

<b>Как это работает?</b>  

Для работы AURA требуется паттерн уникализации. Он выглядит как изображение размером 1024х1024, заполненное черными точками в случайных местах. Затем AURA наносит этот паттерн на изображения с рандомным сдвигом. Этого достаточно, чтобы Авито не считало фотографии одинаковыми.

<b>Как это установить?</b>  

Просто скачайте скомпилированный .exe файл из вкладки Releases и затем откройте  
ИЛИ  
Скачайте [AutoHotKey](https://autohotkey.com)  
Скачайте AURA.ahk из данного репозитория  
Скачайте [GDI+](https://www.autohotkey.com/boards/viewtopic.php?t=6517) (Gdip_All.ahk) и положите его в папку с AURA  
Откройте AURA.ahk  
  
На правах дисклеймера: AURA может показаться вам весьма всратой. Причина этого в том, что изначально я делал ее для личного использования в работе и выложил на гитхаб по причине "чтобы было". Надеюсь в будущем доработать все это дело, чтоб все как у людей. Если что, вкладка Issues всегда открыта.  
  
На правах лицензии: вы можете делать с AURA все что душе угодно: копировать, модифицировать, распространять. Но только до тех пор, пока вы указываете [оригинальный репозиторий](https://github.com/nnmkakouta/AURA) в Readme или где-нибудь еще  

TODO:  
Custom .exe icon  
English readme  
~~Keeping parent folders~~ DONE!   
Dropdown lists of previous folders  
GUI polish  
Code unspaghetting  (like i can ever do that lmao)   
Rewrite that shit in normal language and not AutoHotKey (probably wouldnt happen, but who knows)   
~~Figure out why AURA eats up a crapton of ram and fix it (aka rewrite that shit in normal language)~~ DONE! Even without rewriting lol   
