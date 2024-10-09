import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class GetAllChecklistUsecase extends BaseUseCase<NetworkError,
    GetAllChecklistParams, CheckListResponse> {
  final TransportRepository transportRepository;

  GetAllChecklistUsecase({required this.transportRepository});
  @override
  Future<Either<NetworkError, CheckListResponse>> execute(
      {required GetAllChecklistParams params}) {
    return transportRepository.getAllCheckList(
        userId: params.userId, routeId: params.routeId, busId: params.busId);
  }
}

class GetAllChecklistParams extends Params {
  final int userId;
  final int routeId;
  final int busId;

  GetAllChecklistParams(
      {required this.userId, required this.routeId, required this.busId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
