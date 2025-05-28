import 'package:amuz_todo_list/src/core/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

final class AppPages {
  const AppPages._();

  static final String _initialLocation = AppRoutes.detailsTodo.path;

  static final GoRouter routeConfig = GoRouter(
    routes: AppRoutes.routes,
    initialLocation: _initialLocation,
  );
}
