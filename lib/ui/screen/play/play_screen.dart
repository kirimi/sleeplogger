import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:relation/relation.dart';
import 'package:sleeplogger/ui/res/app_string.dart';
import 'package:sleeplogger/ui/res/consts.dart';
import 'package:sleeplogger/ui/screen/play/play_wm.dart';
import 'package:sleeplogger/ui/screen/play/widget/logger_widget.dart';
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
    return WillPopScope(
      onWillPop: () {
        wm.stop();
        return Future.value(false);
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Hero(
                tag: Consts.heroPlay,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SlideAction(
                    text: AppString.slideToStop,
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.white38),
                    innerColor: Colors.white30,
                    outerColor: Colors.black54,
                    elevation: 0,
                    onSubmit: wm.stop,
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: StreamedStateBuilder<String>(
                              streamedState: wm.timer,
                              builder: (context, timer) {
                                return Center(
                                  child: Text(
                                    timer,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1
                                        .copyWith(
                                          color: Colors.black54,
                                          fontSize: 100,
                                        ),
                                  ),
                                );
                              }),
                        ),
                        Expanded(
                          flex: 3,
                          child: StreamedStateBuilder<List<String>>(
                            streamedState: wm.log,
                            builder: (context, logs) {
                              return LoggerWidget(items: logs);
                            },
                          ),
                        ),
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
                      ],
                    ),
                    RawGestureDetector(
                      behavior: HitTestBehavior.opaque,
                      gestures: {
                        MultiTapGestureRecognizer:
                            GestureRecognizerFactoryWithHandlers<
                                MultiTapGestureRecognizer>(
                          () => MultiTapGestureRecognizer(),
                          (instance) {
                            instance.onTap = (_) => wm.tap();
                            instance.onTapUp = (_, __) => wm.tap();
                            instance.onTapDown = (_, __) => wm.tap();
                          },
                        )
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
