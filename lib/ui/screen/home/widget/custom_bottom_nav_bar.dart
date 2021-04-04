import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sleeplogger/ui/res/app_string.dart';
import 'package:sleeplogger/ui/screen/instructions/instructions_route.dart';
import 'package:sleeplogger/ui/screen/registration/registration_route.dart';

/// BottomNavigationBar - нижнее меню
///
/// нужно передать index - текущий активный элемент меню
class CustomBottomNavBar extends StatelessWidget {
  final int index;

  const CustomBottomNavBar({
    Key key,
    @required this.index,
  })  : assert(index != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white38,
      unselectedItemColor: Colors.white38,
      // selectedFontSize: 0,
      // unselectedFontSize: 0,
      currentIndex: index,
      items: const [
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.info),
          label: AppString.navBarInstruction,
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.user),
          label: AppString.navBarProfile,
        ),
      ],
      onTap: (idx) {
        String route;
        switch (idx) {
          case 0:
            route = InstructionsRoute.routeName;
            break;
          case 1:
            route = RegistrationRoute.routeName;
            break;
        }
        if (route != null) {
          Navigator.of(context).pushNamed(route);
        }
      },
    );
  }
}
