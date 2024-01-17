Приложение АТП Север-Юг
=====================================================================================================================================================================

Это приложение было реализованно для водителя, чтобы он мог быстро и просто отлслеживать свои марщруты, сканировать и проверять билеты только с помощью телефона. Так же в этот проект входит штучки, которые сделали эти люди:

- [Вершини Данил(NDaVS)](https://github.com/NDaVS) - Back-end разработка
- [Запорожский Ярослав(MsYarusa)](https://github.com/NDaVS) - Front-end разработка
- [Стрельцов Илья(IDrumo)](https://github.com/NDaVS) - Android(Kotlin) разработка

Полное описание проекта
=====================================================================================================================================================================

Данный проект был реализован с помощью SwiftUI. Оно имеет окно входа в приложение без регистрации, так как приложение использует водитель, то его регистрирует администратор при устройстве на работу. 

(Картинка)

После того как водитель залогинился, то приложение полностью получает информацию о нем на сегодняшений день, а водитель попадает на первую страницу с его личной информацией, где он может обновить данные, при обновлении данных внтури приложения происходит логин, который нужен для получение новых дынных, в случае если появились новые, и для проверки на изменения логина и пароля(для это мы храним логин и пароль внутри приложения в keychain). 

(Картинка)

Так же водитель может перемещаться по TabView, в котором есть расписание автобусов и QRScanner.

(Картинка)

Распиание автобусов было реализованно через NavigationLink, чтобы мы могли углубиться внутрь выбранного рейса, чтобы начать его или завершить(чтобы завершить, нужно поддтвердить, это было сделано для защиты от случайных нажатий), так же можно листать станции(если их больше 3-х)

(Картинка)

QR-Сканер включает в себя: сам скнер, так же кнопку, после нажатий которой вылазит окно для ручной проверки(если qr-код поврежден или камера не работает). 

(Картинка)

Еще приложение запрашивает доступ к камере и проверяет на ее существование

(Картинка)

Так как билет у нас самоподписанные, поэтому внутри него есть вся информация для проверки и сравнения с данными, которые мы получаем при логине(это нужно для проверки билета)

(Картинка)


Технологии
=====================================================================================================================================================================

- Язык программирования: Swift
- Фреймворк: SwiftUI
- Методы хранения данных: Keychain, UserDefaults, и структуры
- Метод реализации проекта: Все реализован на API запросах к back-end часть нашего проекта

Дополнительные ссылки
====================================================================================================================================================================

- [Документация API](https://tiny-front-f59.notion.site/API-5de5f2b68c8040a4b3428ec7a35a7e09)
- [Репозиторий Back-end](https://github.com/NDaVS/ATP)
- [Репозиторий Front-end](https://github.com/MsYarusa/SeverUg_frontend)
- [Репозиторий Android(Kotlin)](https://github.com/IDrumo/North-South)
- [Сайт](https://ylzaporozhskiy.ru/)
- [Дизайн в Figma](https://www.figma.com/file/Qd1odMcGghZGG4NGTVKVFo/%D0%A5%D0%B5%D1%85%D0%B5?type=design&node-id=11954%3A2&mode=design&t=4y6XE2cm8AyK7qqW-1)
