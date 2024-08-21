import 'package:domain/domain.dart';
import 'package:domain/src/usecase/visitor/upload_visitor_profile_usecase.dart';
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
}
