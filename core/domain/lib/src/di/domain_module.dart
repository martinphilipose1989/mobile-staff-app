import 'package:domain/domain.dart';
import 'package:domain/src/usecase/visitor/get_visitor_list_usecase.dart';
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
}
