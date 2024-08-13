import 'package:domain/domain.dart';
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
}
