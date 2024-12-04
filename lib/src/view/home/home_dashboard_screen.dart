import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/extensions/extensions.dart';
import '../../common/router/app_router.gr.dart';

@RoutePage()
class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: const [
        HomeRoute(),
        BankCardsRoute(),
        TransactionHistoryRoute(),
        SettingsRoute(),
      ],
      physics: const NeverScrollableScrollPhysics(),
      builder: (context, child, tabController) {
        return Scaffold(
          body: child,
          bottomNavigationBar: _BottomNavigationBar(
            onChanged: (index) => tabController.animateTo(index),
          ),
        );
      },
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  final void Function(int) onChanged;

  const _BottomNavigationBar({
    required this.onChanged,
  });

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });

        widget.onChanged(index);
      },
      showSelectedLabels: false,
      selectedItemColor: context.colorScheme.primary,
      unselectedItemColor: context.colorScheme.onSurface,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_rounded),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.creditcard),
          activeIcon: Icon(CupertinoIcons.creditcard_fill),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.doc_text),
          activeIcon: Icon(CupertinoIcons.doc_text_fill),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          activeIcon: Icon(Icons.settings),
          label: '',
        ),
      ],
    );
  }
}
