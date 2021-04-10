import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:provider/provider.dart';
import 'package:relation/relation.dart';
import 'package:sleeplogger/ui/res/app_string.dart';
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

class _HomeScreenState extends WidgetState<HomeWm> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<RouteObserver>().subscribe(this, ModalRoute.of(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(
        index: 0,
        onTapItem: (int index) => wm.bottomNavTap(index),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Hero(
                tag: Consts.heroPlay,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black54,
                  ),
                  child: GestureDetector(
                    onTap: wm.start,
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      size: 120,
                      color: Colors.white30,
                    ),
                  ),
                ),
              ),
            ),
          ),
          StreamedStateBuilder<int>(
            streamedState: wm.unsentFilesCount,
            builder: (context, count) {
              if (count != 0) {
                return Column(
                  children: [
                    Text(
                      AppString.homeUnsentLogs(count),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      AppString.homeCheckInternet,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: wm.sendLogs,
                      child: const Text(AppString.homeSendBtn),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    context.read<RouteObserver>().unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() => wm.enterPage();

  @override
  void didPush() => wm.enterPage();
}
