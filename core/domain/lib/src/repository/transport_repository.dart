import 'package:domain/domain.dart';

abstract class TransportRepository {
  Future<Either<NetworkError, TripResponse>> getMyDutyList(
      {required int pageNo});

  Future<Either<NetworkError, CheckListResponse>> getAllCheckList(
      {required int pageNo});

  Future<Either<NetworkError, CreateIncidentReportResponse>> createIncident(
      {required CreateIncidentReportRequest requestBody});
}
