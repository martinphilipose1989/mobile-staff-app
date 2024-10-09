import 'package:domain/domain.dart';

abstract class TransportRepository {
  Future<Either<NetworkError, TripResponse>> getMyDutyList(
      {required int pageNo});

  Future<Either<NetworkError, CheckListResponse>> getAllCheckList(
      {required int pageNo});

  Future<Either<NetworkError, CreateIncidentReportResponse>> createIncident(
      {required CreateIncidentReportRequest requestBody});

  Future<Either<NetworkError, GetStudentList>> getStudentListByRoute(
      {required int routeId, required int stopId});

  Future<Either<NetworkError, CreateAttendance>> createAttendance(
      {required CreateAttendance createAttendance});

  Future<Either<NetworkError, GetStudentProfileResponse>> getStudentProfile(
      {required int studentId});

  Future<Either<NetworkError, GetGuardianListResponse>> getGuardianList(
      {required int studentId});
}
