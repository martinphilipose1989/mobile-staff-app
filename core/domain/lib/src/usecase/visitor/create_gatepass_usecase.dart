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
    if (Validator.isEmpty(requestModel.visitorTypeId.toString())) {
      return Left(AppError(
          type: ErrorType.uiVistorType,
          throwable: Exception(),
          error: ErrorInfo(message: 'Please select type of visitor')));
    } else if (Validator.isEmpty(requestModel.purposeOfVisitId.toString())) {
      return Left(AppError(
          type: ErrorType.uiPurposeOfVisit,
          throwable: Exception(),
          error: ErrorInfo(message: 'Please select purpose of visit')));
    } else if (Validator.isEmpty(requestModel.profileImage ?? '')) {
      return Left(AppError(
          type: ErrorType.uiPorfileImage,
          throwable: Exception(),
          error: ErrorInfo(message: 'Please click image of visitor')));
    }
    return Right(true);
  }
}
