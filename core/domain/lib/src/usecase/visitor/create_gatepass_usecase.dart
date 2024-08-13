import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class CreateGatepassUsecase extends BaseUseCase<NetworkError,
    CreateGatepassUsecaseParams, CreateGatepassResponseModel> {
  final VisitorRepository _visitorRepository;

  CreateGatepassUsecase({required VisitorRepository visitorRepository})
      : _visitorRepository = visitorRepository;

  @override
  Future<Either<NetworkError, CreateGatepassResponseModel>> execute(
      {required CreateGatepassUsecaseParams params}) {
    return _visitorRepository.createVisitorGatePass(
        request: params.requestModel);
  }
}

class CreateGatepassUsecaseParams extends Params {
  final CreateGatePassModel requestModel;

  CreateGatepassUsecaseParams({required this.requestModel});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
