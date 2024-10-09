import 'package:data/data.dart';
import 'package:domain/domain.dart';

class TransportRepositoryImpl implements TransportRepository {
  final NetworkPort networkPort;

  TransportRepositoryImpl({required this.networkPort});

  @override
  Future<Either<NetworkError, TripResponse>> getMyDutyList(
      {required int pageNo, required int dayId}) {
    return networkPort.getMyDutyList(page: pageNo, dayId: dayId);
  }

  @override
  Future<Either<NetworkError, CreateIncidentReportResponse>> createIncident(
      {required CreateIncidentReportRequest requestBody}) {
    return networkPort.createIncidentReport(requestBody: requestBody);
  }

  @override
  Future<Either<NetworkError, BusStopResponseModel>> getBusStopsList(
      {required String routeId, required int dayId}) {
    return networkPort.getBusStopsList(routeId: routeId, dayId: dayId);
  }

  @override
  Future<Either<NetworkError, FetchStopLogsModel>> fetchStopLogs(
      {required int routeId, required int stopId}) {
    return networkPort.fetchStopLogs(routeId: routeId, stopId: stopId);
  }

  @override
  Future<Either<NetworkError, CheckListResponse>> getAllCheckList(
      {required int userId, required int routeId, required int busId}) {
    return networkPort.getAllCheckList(
        routeId: routeId, userId: userId, busId: busId);
  }

  @override
  Future<Either<NetworkError, GetChecklistConfirmationModel>>
      getChecklistConfirmation(
          {required int routeId, required int userId, required int userType}) {
    return networkPort.getChecklistConfirmation(
        routeId: routeId, userId: userId, userType: userType);
  }

  @override
  Future<Either<NetworkError, CreateRouteLogsModel>> createRouteLogs(
      {required int routeId,
      int? driverId,
      int? didId,
      int? teacherId,
      required String routeStatus,
      required int userType,
      required String startDate,
      required String endDate}) {
    return networkPort.createRouteLogs(
        routeId: routeId,
        driverId: driverId,
        didId: didId,
        userType: userType,
        teacherId: teacherId,
        routeStatus: routeStatus,
        startDate: startDate,
        endDate: endDate);
  }
}
