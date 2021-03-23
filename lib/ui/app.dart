import 'package:flutter/material.dart';
import 'package:sleeplogger/ui/res/app_string.dart';
import 'package:sleeplogger/ui/screen/home/home_route.dart';
import 'package:sleeplogger/ui/screen/play/play_route.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppString.appTitle,
      theme: ThemeData.dark().copyWith(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: HomeRoute.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case HomeRoute.routeName:
            return HomeRoute();
          case PlayRoute.routeName:
            return PlayRoute();
          default:
            return null;
        }
      },
    );
  }
}
