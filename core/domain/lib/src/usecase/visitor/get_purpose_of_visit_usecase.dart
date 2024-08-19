import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class GetPurposeOfVisitListUsecase extends BaseUseCase<NetworkError,
    GetPurposeOfVisitListUsecaseParams, PurposeOfVisitModel> {
  final VisitorRepository _visitorRepository;

  GetPurposeOfVisitListUsecase({required VisitorRepository visitorRepository})
      : _visitorRepository = visitorRepository;

  @override
  Future<Either<NetworkError, PurposeOfVisitModel>> execute(
      {required GetPurposeOfVisitListUsecaseParams params}) {
    return _visitorRepository.getPurposeOfVisitList();
  }
}

class GetPurposeOfVisitListUsecaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
