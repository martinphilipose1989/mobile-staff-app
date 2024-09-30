import 'package:data/data.dart';
import 'package:domain/domain.dart';

class TransportRepositoryImpl implements TransportRepository {
  final NetworkPort networkPort;

  TransportRepositoryImpl({required this.networkPort});

  @override
  Future<Either<NetworkError, TripResponse>> getMyDutyList(
      {required int pageNo}) {
    return networkPort.getMyDutyList(page: pageNo);
  }

  @override
  Future<Either<NetworkError, CheckListResponse>> getAllCheckList(
      {required int pageNo}) {
    return networkPort.getAllCheckList(page: pageNo);
  }

  @override
  Future<Either<NetworkError, CreateIncidentReportResponse>> createIncident(
      {required CreateIncidentReportRequest requestBody}) {
    return networkPort.createIncidentReport(requestBody: requestBody);
  }
}
