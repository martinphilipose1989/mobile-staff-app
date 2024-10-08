import 'package:domain/domain.dart';
import 'package:domain/src/usecase/transport/create_incident_report_usecase.dart';
import 'package:domain/src/usecase/transport/get_all_checklist_usecase.dart';

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

  CreateAttendanceUsecase createAttendanceUsecase(
      TransportRepository transportRepository) {
    return CreateAttendanceUsecase(transportRepository: transportRepository);
  }
}
