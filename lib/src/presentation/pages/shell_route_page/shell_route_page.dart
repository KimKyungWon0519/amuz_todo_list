import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class ShellRoutePage extends HookWidget {
  final GoRouterState state;
  final StatefulNavigationShell navigationShell;

  const ShellRoutePage({
    super.key,
    required this.state,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (value) {
          navigationShell.goBranch(value);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: '목록'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}
