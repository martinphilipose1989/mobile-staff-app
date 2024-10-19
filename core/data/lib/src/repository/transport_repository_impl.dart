import 'dart:io';

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
  Future<Either<NetworkError, GetStudentList>> getStudentListByRoute(
      {required int routeId, int? stopId}) {
    return networkPort.getStudentListByRoute(routeId: routeId, stopId: stopId);
  }

  @override
  Future<Either<NetworkError, CreateAttendanceResponse>> createAttendance(
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
      List<int>? studentIdList,
      int? attendanceType,
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
        endDate: endDate,
        attendanceType: attendanceType,
        studentIdList: studentIdList);
  }

  @override
  Future<Either<NetworkError, CreateBearerResponse>> createBearer(
      {required CreateBearerRequest request}) {
    return networkPort.createBearer(request: request);
  }

  @override
  Future<Either<NetworkError, MapStudenttoBearerResponse>> mapBearerToGuardians(
      {required MapStudenttoBearerRequest request}) {
    return networkPort.mapBearerToGuardians(request: request);
  }

  @override
  Future<Either<NetworkError, UploadFileResponseModel>> uploadProfileImage(
      {required File file, String module = "TRANSPORT"}) {
    return networkPort.uploadProfileImage(file: file, module: module);
  }

  @override
  Future<Either<NetworkError, CreateStopLogsModel>> createStopLogs(
      {required int routeId,
      required int stopId,
      required String stopStatus,
      required String time}) {
    return networkPort.createStopLogs(
        routeId: routeId, stopId: stopId, stopStatus: stopStatus, time: time);
  }

  @override
  Future<Either<NetworkError, GetBearerListResponse>> getBearerList(
      {required int studentId}) {
    return networkPort.getBearerList(studentId: studentId);
  }

  @override
  Future<Either<NetworkError, GetSchoolContactResponse>> getSchoolContactList(
      {required int schoolId}) {
    return networkPort.getSchoolContactList(schoolId: schoolId);
  }

  @override
  Future<Either<NetworkError, UpdateAttendanceResponse>> updateAttendance(
      {required UpdateAttendanceRequest body}) {
    return networkPort.updateAttendance(body: body);
  }
}
