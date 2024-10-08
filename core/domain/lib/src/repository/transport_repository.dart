import 'package:domain/domain.dart';

abstract class TransportRepository {
  Future<Either<NetworkError, CheckListResponse>> getAllCheckList(
      {required int pageNo, required int dayId});

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
  Future<Either<NetworkError, TripResponse>> getMyDutyList(
      {required int pageNo, required int dayId});

  Future<Either<NetworkError, BusStopResponseModel>> getBusStopsList(
      {required String routeId, required int dayId});
}
