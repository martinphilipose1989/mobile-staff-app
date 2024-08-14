import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class GetTypeOfVisitorListUsecase extends BaseUseCase<NetworkError,
    GetTypeOfVisitorListUsecaseParams, TypeOfVisitorResponseModel> {
  final VisitorRepository _visitorRepository;

  GetTypeOfVisitorListUsecase({required VisitorRepository visitorRepository})
      : _visitorRepository = visitorRepository;

  @override
  Future<Either<NetworkError, TypeOfVisitorResponseModel>> execute(
      {required GetTypeOfVisitorListUsecaseParams params}) {
    return _visitorRepository.getTypeOfVistorList();
  }
}

class GetTypeOfVisitorListUsecaseParams extends Params {
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
