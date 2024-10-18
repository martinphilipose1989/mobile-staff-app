import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class CreateRouteLogsUsecase extends BaseUseCase<NetworkError,
    CreateRouteLogsParams, CreateRouteLogsModel> {
  final TransportRepository transportRepository;

  CreateRouteLogsUsecase({required this.transportRepository});

  @override
  Future<Either<NetworkError, CreateRouteLogsModel>> execute(
      {required CreateRouteLogsParams params}) {
    return transportRepository.createRouteLogs(
        routeId: params.routeId,
        driverId: params.driverId,
        didId: params.didId,
        userType: params.userType,
        teacherId: params.teacherId,
        routeStatus: params.routeStatus,
        startDate: params.startDate,
        endDate: params.endDate);
  }
}

/*
 * student_id:[],
attendance_type:3,4
 */

class CreateRouteLogsParams extends Params {
  final int? driverId;
  final int? didId;
  final int routeId;
  final int? teacherId;
  final String routeStatus;
  final String startDate;
  final String endDate;
  final int userType;

  CreateRouteLogsParams(
      {required this.routeId,
      this.driverId,
      this.didId,
      this.teacherId,
      required this.routeStatus,
      required this.startDate,
      required this.endDate,
      required this.userType});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
