import 'dart:typed_data';

import 'package:app/feature/gate_management/gate_keeper_dashboard/dashboard_page.dart';
import 'package:app/feature/gate_management/create_edit_gate_pass/create_edit_gate_pass_page.dart';
import 'package:app/feature/gate_management/visitor_details/qr_details.dart';
import 'package:app/feature/gate_management/visitor_details/visitor_details_page.dart';
import 'package:app/feature/gate_management/visitor_list/visitor_list_page.dart';
import 'package:app/feature/landing_page.dart';
import 'package:app/feature/login/login_page.dart';
import 'package:app/feature/transport_management/bus_checklist/bus_checklist_page.dart';
import 'package:app/feature/transport_management/bus_route_details/bus_route_details_page.dart';
import 'package:app/feature/transport_management/bus_route_list/bus_route_list_page_page.dart';
import 'package:app/feature/transport_management/incident_report/incident_report_page.dart';
import 'package:app/feature/transport_management/my_duty/my_duty_page.dart';
import 'package:app/feature/transport_management/school_contacts/school_contacts_page.dart';
import 'package:app/feature/transport_management/student_profile/student_profile_page.dart';
import 'package:app/feature/transport_management/transport_managment_dashboard/transport_dashboard_page.dart';
import 'package:app/utils/app_webview.dart';
import 'package:domain/domain.dart';

import 'package:flutter/cupertino.dart';
import '../feature/splash/splash_page.dart';
import 'route_paths.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.splash:
        return CupertinoPageRoute(
          builder: (context) => const SplashPage(),
          settings: const RouteSettings(name: RoutePaths.splash),
        );

      case RoutePaths.dashboard:
        return CupertinoPageRoute(
          builder: (context) => const DashboardPage(),
          settings: const RouteSettings(name: RoutePaths.dashboard),
        );
      case RoutePaths.visitorListPage:
        return CupertinoPageRoute(
          builder: (context) => const VisitorListPage(),
          settings: const RouteSettings(name: RoutePaths.visitorListPage),
        );
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
          settings: RouteSettings(
              name: RoutePaths.qrCodeDetailsPage, arguments: arguments),
          builder: (context) => QrDetailsPage(qrImageBytes: arguments),
        );

      case RoutePaths.login:
        return CupertinoPageRoute(
          settings: const RouteSettings(name: RoutePaths.login),
          builder: (context) => const LoginPage(),
        );

      case RoutePaths.webLogin:
        return CupertinoPageRoute(
          settings: const RouteSettings(name: RoutePaths.webLogin),
          builder: (context) => const MyInAppWebView(),
        );

      // TRANSPORT MODULE
      case RoutePaths.transportDashBoardPage:
        return CupertinoPageRoute(
          settings:
              const RouteSettings(name: RoutePaths.transportDashBoardPage),
          builder: (context) => const TransportDashboardPage(),
        );

      case RoutePaths.incidentReportPage:
        return CupertinoPageRoute(
          settings: const RouteSettings(name: RoutePaths.incidentReportPage),
          builder: (context) => const IncidentReportPage(),
        );

      case RoutePaths.schoolContactPage:
        final int schoolId = settings.arguments as int;
        return CupertinoPageRoute(
          settings: const RouteSettings(name: RoutePaths.schoolContactPage),
          builder: (context) => SchoolContactsPage(schoolId: schoolId),
        );

      case RoutePaths.busCheckListPage:
        final TripResult tripResult = settings.arguments as TripResult;
        return CupertinoPageRoute(
            settings: const RouteSettings(name: RoutePaths.busCheckListPage),
            builder: (context) => BusChecklistPage(tripResult: tripResult));
      case RoutePaths.busRouteDetailsPage:
        BusRouteDetailsPageParams params =
            settings.arguments as BusRouteDetailsPageParams;
        return CupertinoPageRoute(
            settings: const RouteSettings(name: RoutePaths.busRouteDetailsPage),
            builder: (context) =>
                BusRouteDetailsPage(busRouteDetailsPageParams: params));
      case RoutePaths.busRouteListPage:
        return CupertinoPageRoute(
            settings: const RouteSettings(name: RoutePaths.busRouteListPage),
            builder: (context) => BusRouteListPage(
                  dropStarted: settings.arguments == null
                      ? false
                      : settings.arguments as bool,
                ));
      case RoutePaths.myDutyPage:
        return CupertinoPageRoute(
          builder: (context) => const MyDutyPage(),
          settings: const RouteSettings(name: RoutePaths.myDutyPage),
        );
      case RoutePaths.studentProfilePage:
        final studentId = settings.arguments as int;
        return CupertinoPageRoute(
          builder: (context) => StudentProfilePage(studentId: studentId),
          settings: const RouteSettings(name: RoutePaths.studentProfilePage),
        );
      case RoutePaths.landingPage:
        return CupertinoPageRoute(
          builder: (context) => const LandingPage(),
          settings: const RouteSettings(name: RoutePaths.landingPage),
        );
      default:
        // Replace by Empty Page
        return CupertinoPageRoute(builder: (context) => Container());
    }
  }
}
