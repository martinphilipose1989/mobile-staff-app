import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class PatchVisitorDetailsUsecase extends BaseUseCase<BaseError,
    PatchVisitorDetailsUsecaseParams, VisitorDetailsResponseModel> {
  final VisitorRepository _visitorRepository;

  PatchVisitorDetailsUsecase({required VisitorRepository visitorRepository})
      : _visitorRepository = visitorRepository;

  @override
  Future<Either<NetworkError, VisitorDetailsResponseModel>> execute(
      {required PatchVisitorDetailsUsecaseParams params}) {
    return _visitorRepository.patchVisitorDetails(
      gatepassId: params.gatepassId,
      outgoingTime: params.outgoingTime,
    );
  }
}

class PatchVisitorDetailsUsecaseParams extends Params {
  final String gatepassId;
  final Map<String, dynamic> outgoingTime;

  PatchVisitorDetailsUsecaseParams({
    required this.gatepassId,
    required this.outgoingTime,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
