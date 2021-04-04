import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mwwm/mwwm.dart';
import 'package:sleeplogger/ui/res/app_string.dart';
import 'package:sleeplogger/ui/res/consts.dart';
import 'package:sleeplogger/ui/screen/instructions/instructions_wm.dart';

class InstructionsScreen extends CoreMwwmWidget {
  const InstructionsScreen(WidgetModelBuilder wmBuilder)
      : super(widgetModelBuilder: wmBuilder);

  @override
  _InstructionsScreenState createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends WidgetState<InstructionsWm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Hero(
            tag: Consts.heroPlay,
            child: Text(
              AppString.appTitle,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Expanded(
            child: Markdown(data: AppString.instructionsMarkdown),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: wm.submit,
              child: Text(AppString.instrSubmit),
            ),
          )
        ],
      ),
    );
  }
}
