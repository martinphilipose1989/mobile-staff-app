import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class PatchParentGatepassUsecase extends BaseUseCase<NetworkError,
    PatchParentGatepassUsecaseParams, ParentGatepassResponseModel> {
  final VisitorRepository _visitorRepository;

  PatchParentGatepassUsecase({required VisitorRepository visitorRepository})
      : _visitorRepository = visitorRepository;

  @override
  Future<Either<NetworkError, ParentGatepassResponseModel>> execute(
      {required PatchParentGatepassUsecaseParams params}) {
    return _visitorRepository.patchParentGatePass(
        gatepassID: params.gatePassId, requestBody: params.requestBody);
  }
}

class PatchParentGatepassUsecaseParams extends Params {
  final String gatePassId;
  final ParentGatePassRequestModel requestBody;

  PatchParentGatepassUsecaseParams(
      {super.reloading, required this.gatePassId, required this.requestBody});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
