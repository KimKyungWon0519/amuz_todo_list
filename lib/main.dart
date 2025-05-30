import 'package:amuz_todo_list/src/app_initialize.dart';
import 'package:amuz_todo_list/src/core/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDependency();

  await initializeDateFormatting("ko");

  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: AppPages.routeConfig);
  }
}
