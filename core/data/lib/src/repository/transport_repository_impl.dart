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

  @override
  Future<Either<NetworkError, GetStudentList>> getStudentListByRoute(
      {required int routeId, required int stopId}) {
    return networkPort.getStudentListByRoute(routeId: routeId, stopId: stopId);
  }

  @override
  Future<Either<NetworkError, CreateAttendance>> createAttendance(
      {required CreateAttendance createAttendance}) {
    return networkPort.createAttendance(createAttendance: createAttendance);
  }

  @override
  Future<Either<NetworkError, GetStudentProfileResponse>> getStudentProfile(
      {required int studentId}) {
    return networkPort.getStudentProfile(studentId: studentId);
  }

  @override
  Future<Either<NetworkError, GetGuardianListResponse>> getGuardianList(
      {required int studentId}) {
    return networkPort.getGuardianList(studentId: studentId);
  }
}
