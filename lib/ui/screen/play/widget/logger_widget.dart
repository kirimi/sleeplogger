import 'package:flutter/material.dart';

class LoggerWidget extends StatelessWidget {
  final List<String> items;

  const LoggerWidget({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: items.reversed.map((e) => Text(e)).toList(),
      ),
    );
  }
}
