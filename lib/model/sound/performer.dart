import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:sleeplogger/model/sound/changes.dart';
import 'package:sleeplogger/model/sound/sound_manager/sound_manager.dart';
import 'package:sleeplogger/model/sound/sound_manager/sounds.dart';

/// Запускает воспроизведение случайного сэмпла
class PlayRandomSamplePerformer
    extends FuturePerformer<void, PlayRandomSample> {
  PlayRandomSamplePerformer({@required this.soundManager})
      : assert(soundManager != null);

  final SoundManager soundManager;

  @override
  Future<void> perform(PlayRandomSample change) async {
    final sound = samples[Random().nextInt(3)];
    soundManager.play(sound);
  }
}

/// Останавливает воспроизведение
class StopAllSoundsPerformer extends FuturePerformer<void, StopAllSounds> {
  StopAllSoundsPerformer({@required this.soundManager})
      : assert(soundManager != null);

  final SoundManager soundManager;

  @override
  Future<void> perform(StopAllSounds change) async {
    soundManager.stop();
  }
}
