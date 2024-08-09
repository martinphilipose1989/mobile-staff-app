import 'package:app/feature/dashboard/dashboard_page.dart';
import 'package:app/feature/gate_managment/visitor_list/visitor_list_page.dart';
import 'package:flutter/cupertino.dart';
import '../feature/splash/splash_page.dart';
import 'route_paths.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.splash:
        return CupertinoPageRoute(
            builder: (context) => const SplashPage(),
            settings: const RouteSettings(name: RoutePaths.splash));
      case RoutePaths.dashboard:
        return CupertinoPageRoute(
            builder: (context) => const DashboardPage(),
            settings: const RouteSettings(name: RoutePaths.dashboard));
      case RoutePaths.visitorListPage:
        return CupertinoPageRoute(
            builder: (context) => const VisitorListPage(),
            settings: const RouteSettings(name: RoutePaths.visitorListPage));

      default:
        // Replace by Empty Page
        return CupertinoPageRoute(
          builder: (context) => Container(),
        );
    }
  }
}
