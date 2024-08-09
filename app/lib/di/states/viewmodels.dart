import 'package:app/feature/dashboard/dashboard_page_viewmodel.dart';
import 'package:app/feature/gate_managment/visitor_list/visitor_list_page_viewmodel.dart';
import 'package:app/feature/splash/splash_page_model.dart';
import 'package:app/utils/commonTime/common_time_model.dart';
import 'package:app/utils/common_calendar/common_calendar_model.dart';
import 'package:app/utils/common_widgets/common_chip_list/common_chip_list_view_model.dart';
import 'package:app/utils/common_widgets/common_stepper/common_stepper_model.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dependencies.dart';

final splashViewModelProvider =
    ChangeNotifierProvider.autoDispose<SplashViewModel>(
  (ref) => SplashViewModel(getIt.get<String>(instanceName: "BaseUrl"),
      getIt.get<FlutterExceptionHandlerBinder>()),
);

final commonCalendarModelProvider =
    ChangeNotifierProvider.autoDispose<CommonCalendarModel>(
  (ref) => CommonCalendarModel(getIt.get<FlutterExceptionHandlerBinder>()),
);

final commonTimeModelProvider =
    ChangeNotifierProvider.autoDispose<CommonTimeModel>(
  (ref) => CommonTimeModel(getIt.get<FlutterExceptionHandlerBinder>()),
);

// Common widgets providers

final commonStepperProvider =
    ChangeNotifierProvider.autoDispose<CommonStepperModel>(
  (ref) => CommonStepperModel(getIt.get<FlutterExceptionHandlerBinder>()),
);

final commonChipListProvider =
    ChangeNotifierProvider.autoDispose<CommonChipListViewModel>(
  (ref) => CommonChipListViewModel(getIt.get<FlutterExceptionHandlerBinder>()),
);

// GATE MANAGMENT PROVIDERS
final visitorListPageModelProvider =
    ChangeNotifierProvider.autoDispose<VisitorListPageViewModel>(
  (ref) => VisitorListPageViewModel(
      exceptionHandlerBinder: getIt.get<FlutterExceptionHandlerBinder>()),
);

final dashboardPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<DashboardPageViewModel>((ref) =>
        DashboardPageViewModel(
            exceptionHandlerBinder:
                getIt.get<FlutterExceptionHandlerBinder>()));
