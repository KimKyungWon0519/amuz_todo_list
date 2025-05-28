import 'package:amuz_todo_list/src/presentation/pages/details_todo_page/details_todo_page.dart';
import 'package:amuz_todo_list/src/presentation/pages/todo_list_page/todo_list_page.dart';
import 'package:go_router/go_router.dart';

final class AppRoutes {
  const AppRoutes._();

  static final GoRoute main = GoRoute(
    path: '/',
    builder: (context, state) => TodoListPage(),
  );

  static final GoRoute detailsTodo = GoRoute(
    path: '/details_todo',
    builder: (context, state) => DetailsTodoPage(),
  );

  static final List<RouteBase> routes = [main, detailsTodo];
}
