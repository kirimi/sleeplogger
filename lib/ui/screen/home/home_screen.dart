import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:sleeplogger/ui/res/consts.dart';
import 'package:sleeplogger/ui/screen/home/home_wm.dart';
import 'package:sleeplogger/ui/screen/home/widget/custom_bottom_nav_bar.dart';

/// Домашняя страница
class HomeScreen extends CoreMwwmWidget {
  const HomeScreen(WidgetModelBuilder wmBuilder)
      : super(widgetModelBuilder: wmBuilder);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends WidgetState<HomeWm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        index: 0,
      ),
      body: Center(
        child: Hero(
          tag: Consts.heroPlay,
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black54,
            ),
            child: GestureDetector(
              onTap: wm.start,
              child: Icon(
                Icons.play_arrow_rounded,
                size: 120,
                color: Colors.white30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
