import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleeplogger/data/settings_repository/settings_repository.dart';
import 'package:sleeplogger/ui/res/app_string.dart';
import 'package:sleeplogger/ui/screen/home/home_route.dart';
import 'package:sleeplogger/ui/screen/instructions/instructions_route.dart';
import 'package:sleeplogger/ui/screen/play/play_route.dart';
import 'package:sleeplogger/ui/screen/registration/registration_route.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isFirstRun = context.read<SettingsRepository>().isFirstRun;
    return MaterialApp(
      title: AppString.appTitle,
      theme: ThemeData.dark().copyWith(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.white30,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute:
          isFirstRun ? RegistrationRoute.routeName : HomeRoute.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case HomeRoute.routeName:
            return HomeRoute();
          case PlayRoute.routeName:
            return PlayRoute();
          case RegistrationRoute.routeName:
            return RegistrationRoute();
          case InstructionsRoute.routeName:
            return InstructionsRoute();
          default:
            return null;
        }
      },
    );
  }
}
