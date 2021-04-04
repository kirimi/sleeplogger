/// https://github.com/surfstudio/SurfGear/blob/dev/template/lib/domain/time.dart

/// Обёртка над Duration для вычисления кол-ва дней, часов, минут и т.д.
class TimeDuration {
  TimeDuration(this._innerDuration);

  TimeDuration.fromSeconds(int seconds) : this(Duration(seconds: seconds));

  Duration _innerDuration;

  ///период в минутах
  int get inMinutes => _innerDuration.inMinutes;

  ///период в секундах
  int get inSeconds => _innerDuration.inSeconds;

  ///кол-во дней
  int get days => _innerDuration.inDays;

  ///кол-во часов
  int get hours => _innerDuration.inHours - (_innerDuration.inDays * 24);

  ///кол-во минут
  int get minutes => _innerDuration.inMinutes - (_innerDuration.inHours * 60);

  ///кол-во секунд
  int get seconds => _innerDuration.inSeconds - (_innerDuration.inMinutes * 60);

  ///увеличение периода на 1 минуту
  void incrementMinute() {
    var newMinutes = _innerDuration.inMinutes;
    _innerDuration = Duration(minutes: ++newMinutes);
  }

  ///уменьшение периода на 1 минуту
  void decrementMinute() {
    var newMinutes = _innerDuration.inMinutes;
    _innerDuration = Duration(minutes: --newMinutes);
  }
}
