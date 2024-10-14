import 'package:domain/domain.dart';

import 'package:domain/src/usecase/transport/create_incident_report_usecase.dart';
import 'package:domain/src/usecase/transport/get_bearer_list_usecase.dart';

import 'package:domain/src/usecase/user/user_permission_details_usecase.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DomainModule {
  @lazySingleton
  ChooseFileUseCase attachmentUseCaseProvider(
      AttachmentRepository attachmentRepository) {
    return ChooseFileUseCase(attachmentRepository: attachmentRepository);
  }

  @lazySingleton
  GetVisitorListUsecase visitorListUsecaseProvider(
      VisitorRepository visitorRepository) {
    return GetVisitorListUsecase(visitorRepository: visitorRepository);
  }

  @lazySingleton
  GetVisitorDetailsUsecase visitorDetailsUsecaseProvider(
      VisitorRepository visitorRepository) {
    return GetVisitorDetailsUsecase(visitorRepository: visitorRepository);
  }

  @lazySingleton
  PatchVisitorDetailsUsecase gatePassQrScannerViewModelProvider(
      VisitorRepository visitorRepository) {
    return PatchVisitorDetailsUsecase(visitorRepository: visitorRepository);
  }

  @lazySingleton
  CreateGatepassUsecase createGatePassUsecaseProvider(
      VisitorRepository visitorRepository) {
    return CreateGatepassUsecase(visitorRepository: visitorRepository);
  }

  @lazySingleton
  GetPurposeOfVisitListUsecase createGetPurposeOfVisitListUsecaseProvider(
      VisitorRepository visitorRepository) {
    return GetPurposeOfVisitListUsecase(visitorRepository: visitorRepository);
  }

  @lazySingleton
  GetTypeOfVisitorListUsecase createGetTypeOfVisitorListUsecaseeProvider(
      VisitorRepository visitorRepository) {
    return GetTypeOfVisitorListUsecase(visitorRepository: visitorRepository);
  }

  @lazySingleton
  UploadVisitorProfileUsecase uploadVisitorProfileUsecase(
      VisitorRepository visitorRepository) {
    return UploadVisitorProfileUsecase(visitorRepository: visitorRepository);
  }

  @lazySingleton
  PopulateVisitorDataUsecase populateVisitorDataUsecase(
      VisitorRepository visitorRepository) {
    return PopulateVisitorDataUsecase(visitorRepository: visitorRepository);
  }

  @lazySingleton
  SearchVisitorUsecase searchVisitorUsecase(
      VisitorRepository visitorRepository) {
    return SearchVisitorUsecase(visitorRepository: visitorRepository);
  }

  @lazySingleton
  PatchParentGatepassUsecase patchParentGatepassUsecase(
      VisitorRepository visitorRepository) {
    return PatchParentGatepassUsecase(visitorRepository: visitorRepository);
  }

  @lazySingleton
  UserPermissionDetailsUsecase userPermissionDetailsUsecase(
      UserRepository userRepository) {
    return UserPermissionDetailsUsecase(userRepository: userRepository);
  }

  @lazySingleton
  AuthUsecase authUsecase(UserRepository userRepository) {
    return AuthUsecase(userRepository: userRepository);
  }

  @lazySingleton
  LogoutUsecase logoutUsecase(UserRepository userRepository) {
    return LogoutUsecase(userRepository: userRepository);
  }

  @lazySingleton
  GetMydutyListUsecase getMydutyListUsecase(
      TransportRepository transportRepository) {
    return GetMydutyListUsecase(transportRepository: transportRepository);
  }

  @lazySingleton
  GetAllChecklistUsecase getAllChecklistUsecase(
      TransportRepository transportRepository) {
    return GetAllChecklistUsecase(transportRepository: transportRepository);
  }

  @lazySingleton
  CreateIncidentReportUsecase createIncidentReportUsecase(
      TransportRepository transportRepository) {
    return CreateIncidentReportUsecase(
        transportRepository: transportRepository);
  }

  @lazySingleton
  GetStudentlistByRouteUsecase getStudentlistByRouteUsecase(
      TransportRepository transportRepository) {
    return GetStudentlistByRouteUsecase(
        transportRepository: transportRepository);
  }

  @lazySingleton
  CreateAttendanceUsecase createAttendanceUsecase(
      TransportRepository transportRepository) {
    return CreateAttendanceUsecase(transportRepository: transportRepository);
  }

  @lazySingleton
  GetStudentProfileUsecase getStudentProfileUsecase(
      TransportRepository transportRepository) {
    return GetStudentProfileUsecase(transportRepository: transportRepository);
  }

  @lazySingleton
  GetGuardianlistUsecase getGuardianlistUsecase(
      TransportRepository transportRepository) {
    return GetGuardianlistUsecase(transportRepository: transportRepository);
  }

  @lazySingleton
  GetAllBusStopsUsecase getBusStopsList(
      TransportRepository transportRepository) {
    return GetAllBusStopsUsecase(transportRepository: transportRepository);
  }

  @lazySingleton
  FetchStopLogsUsecase fetchStopLogs(TransportRepository transportRepository) {
    return FetchStopLogsUsecase(transportRepository: transportRepository);
  }

  @lazySingleton
  GetChecklistConfirmationUsecase getChecklistConfirmation(
      TransportRepository transportRepository) {
    return GetChecklistConfirmationUsecase(
        transportRepository: transportRepository);
  }

  @lazySingleton
  CreateRouteLogsUsecase createRouteLogs(
      TransportRepository transportRepository) {
    return CreateRouteLogsUsecase(transportRepository: transportRepository);
  }

  @lazySingleton
  UploadBearerProfileUsecase uploadBearerProfileUsecase(
      TransportRepository transportRepository) {
    return UploadBearerProfileUsecase(transportRepository: transportRepository);
  }

  @lazySingleton
  CreateBearerUsecase createBearerUsecase(
      TransportRepository transportRepository) {
    return CreateBearerUsecase(transportRepository: transportRepository);
  }

  @lazySingleton
  CreateStopsLogsUsecase createStopLogs(
      TransportRepository transportRepository) {
    return CreateStopsLogsUsecase(transportRepository: transportRepository);
  }

  @lazySingleton
  GetBearerListUsecase getBearerList(TransportRepository transportRepository) {
    return GetBearerListUsecase(transportRepository: transportRepository);
  }
}
