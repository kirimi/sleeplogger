import 'package:sleeplogger/domain/sound.dart';

/// Набор семплов
final List<Sound> samples = [
  Sound(name: 'sound1', asset: 'res/sound/loop_20s_-3db_mono.wav'),
  Sound(name: 'sound2', asset: 'res/sound/loop_20s_binaural.wav'),
  Sound(name: 'sound2', asset: 'res/sound/loop_20s_sham.wav'),
];

/// Сигнальный звук
final Sound signal = Sound(name: 'signal1', asset: 'res/sound/gate.wav');
