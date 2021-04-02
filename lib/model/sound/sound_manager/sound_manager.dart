import 'dart:async';
import 'dart:math';

import 'package:just_audio/just_audio.dart';
import 'package:sleeplogger/domain/sound.dart';
import 'package:sleeplogger/model/log/log_repository/log_repository_base.dart';
import 'package:sleeplogger/model/sound/sound_manager/sounds.dart';

/// Управление воспроизведением
class SoundManager {
  SoundManager(this.logRepository);

  final LogRepository logRepository;

  final _mainPlayer = AudioPlayer();
  final _signalPlayer = AudioPlayer();

  Timer _signalTimer;

  Random _rnd;

  /// Запускает воспроизведение звука [sound]
  /// Сигнальный звук переодически воспроизводится в окне
  /// с [signalWindowFrom] по [signalWindowTo]
  Future<void> play(
    Sound sound, {
    Duration signalWindowFrom = const Duration(seconds: 7),
    Duration signalWindowTo = const Duration(seconds: 13),
  }) async {
    // Инициализируем рандомайзер
    _rnd = Random(DateTime.now().millisecondsSinceEpoch);

    _signalPlayer.setAsset(signal.asset);
    await _signalPlayer.setVolume(0.5);

    _mainPlayer.setAsset(sound.asset);
    _mainPlayer.setLoopMode(LoopMode.all);
    _mainPlayer.play();

    _signalTimer = Timer(
      const Duration(seconds: 60),
      () => _playSignal(
        signalWindowFrom: signalWindowFrom,
        signalWindowTo: signalWindowTo,
      ),
    );

    logRepository.add('Play sample ${sound.name} (${sound.asset})');
  }

  /// Проигрывает сигнальный звук
  /// и планирует следующее воспроизведение в окне
  /// с [signalWindowFrom] по [signalWindowTo]
  Future<void> _playSignal({
    Duration signalWindowFrom,
    Duration signalWindowTo,
  }) async {
    Duration getRandomDuration() {
      final minMillis = signalWindowFrom.inMilliseconds;
      final maxMillis = signalWindowTo.inMilliseconds;
      final randomMillis = minMillis + _rnd.nextInt(maxMillis - minMillis);
      return Duration(milliseconds: randomMillis);
    }

    await _signalPlayer.seek(Duration.zero);
    _signalPlayer.play();

    logRepository.add('Play signal');

    _signalTimer?.cancel();
    _signalTimer = Timer(
      getRandomDuration(),
      () => _playSignal(
        signalWindowFrom: signalWindowFrom,
        signalWindowTo: signalWindowTo,
      ),
    );
  }

  /// Останавливает все звуки
  void stop() {
    _signalTimer?.cancel();
    _signalPlayer.stop();

    _mainPlayer.stop();

    logRepository.add('Stop');
  }

  /// Уничтожает плееры
  void dispose() {
    _signalTimer?.cancel();
    _mainPlayer.dispose();
    _signalPlayer.dispose();
  }
}
