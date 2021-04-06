import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sleeplogger/ui/res/app_string.dart';

/// BottomNavigationBar - нижнее меню
///
/// нужно передать index - текущий активный элемент меню
class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.index,
    this.onTapItem,
  })  : assert(index != null),
        super(key: key);

  final int index;
  final ValueChanged<int> onTapItem;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white38,
      unselectedItemColor: Colors.white38,
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
      onTap: (int index) => onTapItem?.call(index),
    );
  }
}
