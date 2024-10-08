import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class GetStudentlistByRouteUsecase extends BaseUseCase<NetworkError,
    GetStudentlistByRouteUsecaseParams, GetStudentList> {
  final TransportRepository transportRepository;

  GetStudentlistByRouteUsecase({required this.transportRepository});

  @override
  Future<Either<NetworkError, GetStudentList>> execute(
      {required GetStudentlistByRouteUsecaseParams params}) {
    return transportRepository.getStudentListByRoute(
        routeId: params.routeId, stopId: params.stopId);
  }
}

class GetStudentlistByRouteUsecaseParams extends Params {
  final int routeId;

  final int stopId;

  GetStudentlistByRouteUsecaseParams(
      {super.reloading, required this.routeId, required this.stopId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
