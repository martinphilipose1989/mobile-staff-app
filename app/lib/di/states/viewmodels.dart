import 'package:app/errors/flutter_toast_error_presenter.dart';
import 'package:app/feature/gate_management/gate_keeper_dashboard/dashboard_page_viewmodel.dart';
import 'package:app/feature/gate_management/create_edit_gate_pass/create_edit_gate_pass_viewmodel.dart';
import 'package:app/feature/gate_management/gate_pass_qr_scanner/gate_pass_qr_scanner_viewmodel.dart';
import 'package:app/feature/gate_management/visitor_details/visitor_details_viewmodel.dart';
import 'package:app/feature/gate_management/visitor_list/visitor_list_page_viewmodel.dart';
import 'package:app/feature/login/login_viewmodel.dart';
import 'package:app/feature/splash/splash_page_model.dart';
import 'package:app/feature/transport_management/bus_checklist/bus_checklist_page_viewmodel.dart';
import 'package:app/feature/transport_management/bus_route_details/bus_route_details_page_viewmodel.dart';
import 'package:app/feature/transport_management/bus_route_list/bus_route_list_page_viewmodel.dart';
import 'package:app/feature/transport_management/incident_report/incident_report_page_viewmodel.dart';
import 'package:app/feature/transport_management/my_duty/my_duty_page_viewmodel.dart';
import 'package:app/feature/transport_management/school_contacts/school_contacts_page_viewmodel.dart';
import 'package:app/feature/transport_management/transport_managment_dashboard/transport_dashboard_page_viewmodel.dart';
import 'package:app/utils/commonTime/common_time_model.dart';
import 'package:app/utils/common_calendar/common_calendar_model.dart';
import 'package:app/utils/common_widgets/common_chip_list/common_chip_list_view_model.dart';
import 'package:app/utils/common_widgets/common_stepper/common_stepper_model.dart';
import 'package:domain/domain.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dependencies.dart';

final splashViewModelProvider =
    ChangeNotifierProvider.autoDispose<SplashViewModel>(
  (ref) => SplashViewModel(
    getIt.get<String>(instanceName: "BaseUrl"),
    getIt.get<FlutterExceptionHandlerBinder>(),
    getIt.get<AuthUsecase>(),
    getIt.get<FlutterToastErrorPresenter>(),
  ),
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
      logoutUsecase: getIt.get<LogoutUsecase>(),
      getTypeOfVisitorListUsecase: getIt.get<GetTypeOfVisitorListUsecase>(),
      getVisitorListUsecase: getIt.get<GetVisitorListUsecase>(),
      exceptionHandlerBinder: getIt.get<FlutterExceptionHandlerBinder>()),
);

final dashboardPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<DashboardPageViewModel>((ref) =>
        DashboardPageViewModel(
            exceptionHandlerBinder:
                getIt.get<FlutterExceptionHandlerBinder>()));

final createEditGatePassViewModelProvider = ChangeNotifierProvider.autoDispose<
        CreateEditGatePassViewModel>(
    (ref) => CreateEditGatePassViewModel(
        patchParentGatepassUsecase: getIt.get<PatchParentGatepassUsecase>(),
        populateVisitorDataUsecase: getIt.get<PopulateVisitorDataUsecase>(),
        flutterToastErrorPresenter: getIt.get<FlutterToastErrorPresenter>(),
        uploadVisitorProfileUsecase: getIt.get<UploadVisitorProfileUsecase>(),
        getTypeOfVisitorListUsecase: getIt.get<GetTypeOfVisitorListUsecase>(),
        getPurposeOfVisitListUsecase: getIt.get<GetPurposeOfVisitListUsecase>(),
        createGatepassUsecase: getIt.get<CreateGatepassUsecase>(),
        chooseFileUseCase: getIt.get<ChooseFileUseCase>(),
        exceptionHandlerBinder: getIt.get<FlutterExceptionHandlerBinder>()));

final visitorDetailsViewModelProvider =
    ChangeNotifierProvider.autoDispose<VisitorDetailsViewModel>((ref) =>
        VisitorDetailsViewModel(
            getVisitorDetailsUsecase: getIt.get<GetVisitorDetailsUsecase>(),
            exceptionHandlerBinder:
                getIt.get<FlutterExceptionHandlerBinder>()));

final gatePassQrScannerViewModelProvider =
    ChangeNotifierProvider.autoDispose<GatePassQrScannerViewModel>((ref) =>
        GatePassQrScannerViewModel(
          patchParentGatepassUsecase: getIt.get<PatchParentGatepassUsecase>(),
          getGatePassDetailsUsecase: getIt.get<GetVisitorDetailsUsecase>(),
          getVisitorDetailsUsecase: getIt.get<PatchVisitorDetailsUsecase>(),
          exceptionHandlerBinder: getIt.get<FlutterExceptionHandlerBinder>(),
          flutterToastErrorPresenter: getIt.get<FlutterToastErrorPresenter>(),
        ));

final transportDashboardPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<TransportDashboardPageViewModel>((ref) =>
        TransportDashboardPageViewModel(
            exceptionHandlerBinder:
                getIt.get<FlutterExceptionHandlerBinder>()));

final loginPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<LoginPageViewModel>((ref) =>
        LoginPageViewModel(
            flutterToastErrorPresenter: getIt.get<FlutterToastErrorPresenter>(),
            exceptionHandlerBinder:
                getIt.get<FlutterExceptionHandlerBinder>()));

final incidentReportPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<IncidentReportPageViewModel>((ref) =>
        IncidentReportPageViewModel(
            flutterToastErrorPresenter: getIt.get<FlutterToastErrorPresenter>(),
            exceptionHandlerBinder:
                getIt.get<FlutterExceptionHandlerBinder>()));

final schoolContactsPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<SchoolContactsPageViewModel>((ref) =>
        SchoolContactsPageViewModel(
            flutterToastErrorPresenter: getIt.get<FlutterToastErrorPresenter>(),
            exceptionHandlerBinder:
                getIt.get<FlutterExceptionHandlerBinder>()));

final busChecklistPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<BusChecklistPageViewModel>((ref) =>
        BusChecklistPageViewModel(
            flutterToastErrorPresenter: getIt.get<FlutterToastErrorPresenter>(),
            exceptionHandlerBinder:
                getIt.get<FlutterExceptionHandlerBinder>()));

final busRouteDetailsPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<BusRouteDetailsPageViewModel>(
  (ref) => BusRouteDetailsPageViewModel(
    flutterToastErrorPresenter: getIt.get<FlutterToastErrorPresenter>(),
    exceptionHandlerBinder: getIt.get<FlutterExceptionHandlerBinder>(),
  ),
);

final busRouteListPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<BusRouteListPageViewModel>(
  (ref) => BusRouteListPageViewModel(
    flutterToastErrorPresenter: getIt.get<FlutterToastErrorPresenter>(),
    exceptionHandlerBinder: getIt.get<FlutterExceptionHandlerBinder>(),
  ),
);

final myDutyPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<MyDutyPageViewModel>(
  (ref) => MyDutyPageViewModel(
      getMydutyListUsecase: getIt.get<GetMydutyListUsecase>(),
      flutterToastErrorPresenter: getIt.get<FlutterToastErrorPresenter>(),
      exceptionHandlerBinder: getIt.get<FlutterExceptionHandlerBinder>()),
);
