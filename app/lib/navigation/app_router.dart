import 'dart:typed_data';

import 'package:app/feature/gate_keeper_dashboard/dashboard_page.dart';
import 'package:app/feature/gate_managment/create_edit_gate_pass/create_edit_gate_pass_page.dart';
import 'package:app/feature/gate_managment/visitor_details/qr_details.dart';
import 'package:app/feature/gate_managment/visitor_details/visitor_details_page.dart';
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
      case RoutePaths.visitorDetailsPage:
        final args = settings.arguments as Map<String, dynamic>;

        return CupertinoPageRoute(
            builder: (context) =>
                VisitorDetailsPage(gatePassId: args['gatePassId']),
            settings: settings);
      case RoutePaths.createEditGatePassPage:
        final arguments = settings.arguments as GatePassArguments;
        return CupertinoPageRoute(
          builder: (context) => CreateEditGatePassPage(arguments: arguments),
          settings: RouteSettings(
            name: RoutePaths.createEditGatePassPage,
            arguments: settings.arguments,
          ),
        );

      case RoutePaths.qrCodeDetailsPage:
        final arguments = settings.arguments as Uint8List;
        return CupertinoPageRoute(
          builder: (context) => QrDetailsPage(qrImageBytes: arguments),
        );

      default:
        // Replace by Empty Page
        return CupertinoPageRoute(
          builder: (context) => Container(),
        );
    }
  }
}
