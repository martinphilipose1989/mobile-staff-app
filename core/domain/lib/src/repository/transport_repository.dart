import 'package:domain/domain.dart';

abstract class TransportRepository {
  Future<Either<NetworkError, CheckListResponse>> getAllCheckList(
      {required int pageNo, required int dayId});

  Future<Either<NetworkError, CreateIncidentReportResponse>> createIncident(
      {required CreateIncidentReportRequest requestBody});

  Future<Either<NetworkError, TripResponse>> getMyDutyList(
      {required int pageNo, required int dayId});

  Future<Either<NetworkError, BusStopResponseModel>> getBusStopsList(
      {required String routeId, required int dayId});
}
