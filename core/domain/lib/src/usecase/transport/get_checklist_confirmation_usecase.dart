import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class GetChecklistConfirmationUsecase extends BaseUseCase<NetworkError,
    GetChecklistConfirmationParams, GetChecklistConfirmationModel> {
  final TransportRepository transportRepository;

  GetChecklistConfirmationUsecase({required this.transportRepository});

  @override
  Future<Either<NetworkError, GetChecklistConfirmationModel>> execute(
      {required GetChecklistConfirmationParams params}) {
    return transportRepository.getChecklistConfirmation(
        routeId: params.routeId,
        userId: params.userId,
        userType: params.userType);
  }
}

class GetChecklistConfirmationParams extends Params {
  final int userId;
  final int userType;
  final int routeId;

  GetChecklistConfirmationParams(
      {required this.routeId, required this.userId, required this.userType});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
