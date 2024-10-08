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
  Future<Either<NetworkError, CheckListResponse>> getAllCheckList(
      {required int pageNo, required int dayId}) {
    return networkPort.getAllCheckList(page: pageNo, dayId: dayId);
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
}
