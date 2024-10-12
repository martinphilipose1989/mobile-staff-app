import 'dart:io';

import 'package:domain/domain.dart';

abstract class NetworkPort {
  Future<Either<NetworkError, VisitorListResponseModel>> getVisitorList(
      {required GetVisitorListRequestModel request});
  Future<Either<NetworkError, VisitorDetailsResponseModel>> getVisitorDetails(
      {required String gatepassId});
  Future<Either<NetworkError, VisitorDetailsResponseModel>>
      petchVisitorDetails({
    required String gatepassId,
    required Map<String, dynamic> outgoingTime,
  });

  Future<Either<NetworkError, CreateGatepassResponseModel>>
      createVisitorGatePass({required CreateGatePassModel request});

  Future<Either<NetworkError, MdmCoReasonResponseModel>>
      getPurposeOfVisitList();

  Future<Either<NetworkError, MdmCoReasonResponseModel>> getTypeOfVistorList();

  Future<Either<NetworkError, UploadFileResponseModel>> uploadProfileImage({
    required File file,
    String module = "GATE",
  });

  Future<Either<NetworkError, VisitorPopulateResponseModel>>
      populateVisitorData({required visitorMobileNumber});

  Future<Either<NetworkError, VisitorListResponseModel>> searchVisitorList(
      {required SearchRequest requestBody});

  Future<Either<NetworkError, ParentGatepassResponseModel>> patchParentGatePass(
      {required String gatepassID,
      required ParentGatePassRequestModel requestModel});

  Future<Either<NetworkError, LoginResponse>> login(
      {required LoginRequest loginRequest});

  Future<Either<NetworkError, UserPermissionResponse>> userPermissionDetails(
      {required UserPermissionRequest request});

  Future<Either<NetworkError, CreateIncidentReportResponse>>
      createIncidentReport({required CreateIncidentReportRequest requestBody});

  Future<Either<NetworkError, GetStudentList>> getStudentListByRoute(
      {required int routeId, required int stopId});

  Future<Either<NetworkError, CreateAttendanceResponse>> createAttendance(
      {required CreateAttendance createAttendance});

  Future<Either<NetworkError, GetStudentProfileResponse>> getStudentProfile(
      {required int studentId});

  Future<Either<NetworkError, GetGuardianListResponse>> getGuardianList(
      {required int studentId});
  Future<Either<NetworkError, TripResponse>> getMyDutyList(
      {required int page, required int dayId});

  Future<Either<NetworkError, BusStopResponseModel>> getBusStopsList(
      {required String routeId, required int dayId});

  Future<Either<NetworkError, FetchStopLogsModel>> fetchStopLogs(
      {required int routeId, required int stopId});

  Future<Either<NetworkError, CheckListResponse>> getAllCheckList(
      {required int routeId, required int userId, required int busId});

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
  Future<Either<NetworkError, CreateStopLogsModel>> createStopLogs(
      {required int routeId,
      required int stopId,
      required String stopStatus,
      required String time});

  Future<Either<NetworkError, GetBearerListResponse>> getBearerList(
      {required int studentId});
}
