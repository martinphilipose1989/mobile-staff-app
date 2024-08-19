import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class GetVisitorDetailsUsecase extends BaseUseCase<BaseError,
    GetVisitorDetailsUsecaseParams, VisitorDetailsResponseModel> {
  final VisitorRepository _visitorRepository;

  GetVisitorDetailsUsecase({required VisitorRepository visitorRepository})
      : _visitorRepository = visitorRepository;

  @override
  Future<Either<NetworkError, VisitorDetailsResponseModel>> execute(
      {required GetVisitorDetailsUsecaseParams params}) {
    return _visitorRepository.getVisitorDetails(
        gatepassId: params.gatepassId,
        );
  }
}

class GetVisitorDetailsUsecaseParams extends Params {
  final String gatepassId;
  

  GetVisitorDetailsUsecaseParams({required this.gatepassId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
