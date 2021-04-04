import 'package:flutter/material.dart';

/// Лог для страницы play
class LoggerWidget extends StatelessWidget {
  final List<String> items;

  const LoggerWidget({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: ListView(
        children: items.reversed
            .map(
              (item) => Text(item,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.black54)),
            )
            .toList(),
      ),
    );
  }
}
