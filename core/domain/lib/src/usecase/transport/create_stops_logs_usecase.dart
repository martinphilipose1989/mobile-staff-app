import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class CreateStopsLogsUsecase extends BaseUseCase<NetworkError,
    CreateStopsLogsParams, CreateStopLogsModel> {
  final TransportRepository transportRepository;

  CreateStopsLogsUsecase({required this.transportRepository});

  @override
  Future<Either<NetworkError, CreateStopLogsModel>> execute(
      {required CreateStopsLogsParams params}) {
    return transportRepository.createStopLogs(
      routeId: params.routeId,
      stopId: params.stopId,
      stopStatus: params.stopStatus,
      time: params.time,
    );
  }
}

class CreateStopsLogsParams extends Params {
  final int routeId;
  final int stopId;
  final String stopStatus;
  final String time;

  CreateStopsLogsParams({
    required this.routeId,
    required this.stopId,
    required this.stopStatus,
    required this.time,
  });

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
