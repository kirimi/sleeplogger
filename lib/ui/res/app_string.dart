class AppString {
  static const String appTitle = 'Эксперимент';
  static const String slideToStop = 'Проведите чтобы закончить';
  static const String registeredTaps = 'Зарегистрировано касаний:';

  static const String regNameHint = 'Введите ваше имя';
  static const String regNameHelper = 'Имя';
  static const String regEmailHint = 'Введите адрес вашей электронной почты';
  static const String regEmailHelper = 'Email';
  static const String regAgeHint = 'Введите ваш возраст';
  static const String regAgeHelper = 'Возраст';
  static const String regGenderHelper = 'Пол';
  static const String regSkip = 'Пропустить';
  static const String regSubmit = 'Продолжить';

  static const String instrSubmit = 'Продолжить';

  static const String navBarInstruction = 'Инструкции';
  static const String navBarProfile = 'Профиль';

  static String homeUnsentLogs(int count) {
    return 'У Вас есть $count неотправленных отчета.';
  }

  static const String homeCheckInternet =
      'Проверьте интернет-соединение\nи нажмите на кнопку "отправить"';
  static const String homeSendBtn = 'Отправить';

  static const String instructionsMarkdown = '''
1. Цель данного эксперимента – исследовать процесс засыпания под влиянием различных звуковых стимулов. Опыт рекомендуется проводить либо примерно в 16 часов, либо примерно в 23 часа.
2. Наденьте (вставьте) стереонаушники.
3. Займите положение, в котором Вы могли бы уснуть.
4. Нажмите кнопку воспроизведения – стартует воспроизведение звукового стимула. У Вас есть 1 минута, чтобы отрегулировать комфортную громкость звука и найти оптимальное положение для руки и смартфона (экраном верх). Палец руки положите на экран.
5. Через 1 минуту начнется подача контрольных сигналов. Программа подает их через случайный интервал в диапазоне 7-13 сек. После начала каждого сигнала Вам необходимо поднять палец с экрана и снова опустить на него. 
6. Через какое-то время Вы начнете засыпать и пропускать контрольные сигналы вследствие снижения внимания. Старайтесь не препятствовать этому естественному процессу, но и не пропускайте нажатия намеренно.
7. Через 60 минут воспроизведение звука прекратится. Если Вы хотите завершить опыт раньше – проведите пальцем по слайдеру вверху экрана.
8. По завершении опыта статистика контрольных сигналов и ответных нажатий будет записана в лог-файл и передана на сервер для последующего анализа. Помимо статистики нажатий будут переданы: id Вашего устройства, дата и время опыта, а также Ваше имя, возраст и емейл для обратной связи, если Вы сочли нужным указать их.
''';
}
