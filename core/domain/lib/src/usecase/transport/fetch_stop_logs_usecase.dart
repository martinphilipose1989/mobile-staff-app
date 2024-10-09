import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class FetchStopLogsUsecase
    extends BaseUseCase<NetworkError, FetchStopLogsParams, FetchStopLogsModel> {
  final TransportRepository transportRepository;

  FetchStopLogsUsecase({required this.transportRepository});

  @override
  Future<Either<NetworkError, FetchStopLogsModel>> execute(
      {required FetchStopLogsParams params}) {
    return transportRepository.fetchStopLogs(
        routeId: params.routeId, stopId: params.stopId);
  }
}

class FetchStopLogsParams extends Params {
  final int routeId;
  final int stopId;

  FetchStopLogsParams({required this.routeId, required this.stopId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
