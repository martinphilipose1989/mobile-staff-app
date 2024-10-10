import 'dart:io';

import 'package:domain/domain.dart';

abstract class TransportRepository {
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

  Future<Either<NetworkError, FetchStopLogsModel>> fetchStopLogs(
      {required int routeId, required int stopId});

  Future<Either<NetworkError, CheckListResponse>> getAllCheckList(
      {required int userId, required int routeId, required int busId});

  Future<Either<NetworkError, GetChecklistConfirmationModel>>
      getChecklistConfirmation(
          {required int routeId, required int userId, required int userType});

  Future<Either<NetworkError, CreateRouteLogsModel>> createRouteLogs(
      {required int routeId,
      int? driverId,
      int? didId,
      int? teacherId,
      required String routeStatus,
      required int userType,
      required String startDate,
      required String endDate});

  Future<Either<NetworkError, CreateBearerResponse>> createBearer(
      {required CreateBearerRequest request});

  Future<Either<NetworkError, MapStudenttoBearerResponse>> mapBearerToGuardians(
      {required MapStudenttoBearerRequest request});

  Future<Either<NetworkError, UploadFileResponseModel>> uploadProfileImage(
      {required File file, String module = "TRANSPORT"});
  Future<Either<NetworkError, CreateStopLogsModel>> createStopLogs(
      {required int routeId,
      required int stopId,
      required String stopStatus,
      required String time});
}
