import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:sleeplogger/ui/res/app_string.dart';
import 'package:sleeplogger/ui/res/consts.dart';
import 'package:sleeplogger/ui/screen/play/play_wm.dart';
import 'package:slide_to_act/slide_to_act.dart';

/// Домашняя страница
class PlayScreen extends CoreMwwmWidget {
  const PlayScreen(WidgetModelBuilder wmBuilder)
      : super(widgetModelBuilder: wmBuilder);

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends WidgetState<PlayWm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Hero(
              tag: Consts.heroPlay,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SlideAction(
                  height: 50,
                  text: AppString.slideToStop,
                  innerColor: Colors.white30,
                  outerColor: Colors.black54,
                  elevation: 0,
                  sliderButtonIconPadding: 6,
                  onSubmit: wm.stop,
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: StreamedStateBuilder<int>(
                        streamedState: wm.registeredTaps,
                        builder: (context, taps) {
                          return Text(
                            '${AppString.registeredTaps} $taps',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.black54),
                          );
                        },
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTapDown: (_) => wm.tap(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
