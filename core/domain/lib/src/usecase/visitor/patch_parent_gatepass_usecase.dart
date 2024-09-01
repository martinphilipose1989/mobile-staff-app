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
        gatepassID: params.gatePassId);
  }
}

class PatchParentGatepassUsecaseParams extends Params {
  final String gatePassId;

  PatchParentGatepassUsecaseParams({super.reloading, required this.gatePassId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
