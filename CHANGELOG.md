### 1.0.3
- фикс возможных щелчков при воспроизведении сигнала

### 1.0.2
- отправка логов на странице с кнопкой play
- сообщение об неотправленных отчетах и кнопка отправить

### 1.0.1
- прикрепляем к email файл с отчетом 

### 1.0.0
- формат лог-файла

### 0.0.10
- в тексте инструкции 45мин->60мин
- bufix: черный экран при нажатии аппаратной back
- во время сессии скрывать системные элементы управления
- формат log файла. Разделитель табуляция, без "+" и "s"

### 0.0.9
- bugfix. Первый лог не отправлялся сразу после сессии 

### 0.0.8
- таймер сессии 60 минут
- логи отправляются на email и в cloud storage
- при отсутствии интернета логи сохраняются в локальном хранилище
- при запуске приложения или после окончания тренировки делается попытка отправить ранее сохраненные логи.

### 0.0.7
- таймер сессии 45 минут

### 0.0.6
- В логах пишется время относительно начала сессии.
- пишется только первый тап после сигнального звука
- Экран регистрации
- Экран с инструкцией
- добавлены age и gender
- добавил на экран запуска кнопки которые показывают инструкцию и редактирование профиля
- простенькая иконка для приложения

### 0.0.5
- первый сигнальный звук после 1 минуты
- wakelock для рабочего экрана. Чтобы экран не гас до конца сессии  
- сохранение лога в firebase cloud storage
- firebase analytics для аналитики использования приложения
- firebase crashlytics для контроля ошибок в приложении
