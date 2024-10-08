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

  Future<Either<NetworkError, UploadFileResponseModel>> uploadProfileImage(
      {required File file});

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

  Future<Either<NetworkError, TripResponse>> getMyDutyList(
      {int page = 1, int limit = 10});

  Future<Either<NetworkError, CheckListResponse>> getAllCheckList(
      {int page = 1, int limit = 10});

  Future<Either<NetworkError, CreateIncidentReportResponse>>
      createIncidentReport({required CreateIncidentReportRequest requestBody});

  Future<Either<NetworkError, GetStudentList>> getStudentListByRoute(
      {required int routeId, required int stopId});

  Future<Either<NetworkError, CreateAttendance>> createAttendance(
      {required CreateAttendance createAttendance});
}
