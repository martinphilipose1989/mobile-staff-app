import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class GetVisitorListUsecase extends BaseUseCase<BaseError,
    GetVisitorListUsecaseParams, VisitorListResponseModel> {
  final VisitorRepository _visitorRepository;

  GetVisitorListUsecase({required VisitorRepository visitorRepository})
      : _visitorRepository = visitorRepository;

  @override
  Future<Either<NetworkError, VisitorListResponseModel>> execute(
      {required GetVisitorListUsecaseParams params}) {
    return _visitorRepository.getVisitorList(requestBody: params.requestBody);
  }
}

class GetVisitorListUsecaseParams extends Params {
  final GetVisitorListRequestModel requestBody;

  GetVisitorListUsecaseParams({required this.requestBody});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
