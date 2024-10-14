import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:network_retrofit/src/model/request/gate_managment/create_gatepass_entity.dart';
import 'package:network_retrofit/src/model/request/gate_managment/parent_gatepass_entity.dart';
import 'package:network_retrofit/src/model/request/gate_managment/visitor_list_entity_request.dart';
import 'package:network_retrofit/src/model/request/login/login_request_entity.dart';
import 'package:network_retrofit/src/model/request/transport_management/create_attendane_entity_request.dart';
import 'package:network_retrofit/src/model/request/transport_management/create_bearer_entity_request.dart';
import 'package:network_retrofit/src/model/request/transport_management/create_reportincident_entity_request.dart';
import 'package:network_retrofit/src/model/request/transport_management/create_route_logs_request.dart';
import 'package:network_retrofit/src/model/request/transport_management/create_route_logs_request_entity.dart';
import 'package:network_retrofit/src/model/request/transport_management/get_check_list_entity_request.dart';
import 'package:network_retrofit/src/model/request/transport_management/get_checklist_confirmation_request.dart';
import 'package:network_retrofit/src/model/request/transport_management/map_student_bearer_entity_request.dart';
import 'package:network_retrofit/src/model/request/user_permission/user_permission_request_entity.dart';
import 'package:network_retrofit/src/model/response/gate_managment/create_gatepass_entity_response.dart';
import 'package:network_retrofit/src/model/response/gate_managment/upload_file_response_entity.dart';
import 'package:network_retrofit/src/model/response/gate_managment/visitor_search_request_entity.dart';
import 'package:network_retrofit/src/services/academics_service.dart';
import 'package:network_retrofit/src/services/mdm_service.dart';
import 'package:network_retrofit/src/services/transport_service.dart';

import 'package:network_retrofit/src/util/safe_api_call.dart';
import 'package:retrofit/retrofit.dart';

import 'services/retrofit_service.dart';

class NetworkAdapter implements NetworkPort {
  final RetrofitService apiService;
  final TransportService transportService;
  final AcademicsService academicsService;
  final MdmService mdmService;
  CancelToken? _cancelToken;

  NetworkAdapter(
    this.apiService,
    this.transportService,
    this.academicsService,
    this.mdmService,
  );

  @override
  Future<Either<NetworkError, VisitorDetailsResponseModel>> getVisitorDetails(
      {required String gatepassId}) async {
    final response =
        await safeApiCall(apiService.getVisitorDetails(gatepassId));
    return response.fold((error) {
      return Left(error);
    }, (data) {
      return Right(data.data.transform());
    });
  }

  @override
  Future<Either<NetworkError, VisitorDetailsResponseModel>> petchVisitorDetails(
      {required String gatepassId,
      required Map<String, dynamic> outgoingTime}) async {
    final response = await safeApiCall(apiService.patchVisitorDetails(
      gatepassId,
      outgoingTime,
    ));
    return response.fold((error) {
      return Left(error);
    }, (data) {
      return Right(data.data.transform());
    });
  }

  @override
  Future<Either<NetworkError, CreateGatepassResponseModel>>
      createVisitorGatePass({required CreateGatePassModel request}) async {
    final response =
        await safeApiCall<HttpResponse<CreateGatePassResponseEntity>>(
            apiService.createVisitorGatePass(CreateGatePassRequestEntity(
                name: request.name,
                companyName: request.companyName,
                comingFrom: request.comingFrom,
                email: request.email,
                guestCount: request.guestCount,
                mobile: request.mobile,
                otherPointOfContact: request.otherPointOfContact,
                pointOfContact: request.pointOfContact,
                profileImage: request.profileImage,
                purposeOfVisitId: request.purposeOfVisitId,
                visitorTypeId: request.visitorTypeId)));
    return response.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response.data.transform());
    });
  }

  @override
  Future<Either<NetworkError, MdmCoReasonResponseModel>>
      getPurposeOfVisitList() async {
    final response =
        await safeApiCall(apiService.getPurposeOfVisitList(19, "name"));
    return response.fold((error) {
      return Left(error);
    }, (data) {
      return Right(data.data.transform());
    });
  }

  @override
  Future<Either<NetworkError, MdmCoReasonResponseModel>>
      getTypeOfVistorList() async {
    final response =
        await safeApiCall(apiService.getVisitorTypeList(15, "name"));
    return response.fold((error) {
      return Left(error);
    }, (data) {
      return Right(data.data.transform());
    });
  }

  @override
  Future<Either<NetworkError, UploadFileResponseModel>> uploadProfileImage(
      {required File file, String module = "GATE"}) async {
    Either<NetworkError, HttpResponse<UploadFileResponseEntity>>? response;
    if (module == "TRANSPORT") {
      response = await safeApiCall(transportService.uploadProfileImage(file));
    } else {
      response = await safeApiCall(apiService.uploadProfileImage(file));
    }
    return response.fold(
        (error) => Left(error), (data) => Right(data.data.transform()));
  }

  @override
  Future<Either<NetworkError, VisitorPopulateResponseModel>>
      populateVisitorData({required visitorMobileNumber}) async {
    final response =
        await safeApiCall(apiService.populateVisitorData(visitorMobileNumber));
    return response.fold(
        (error) => Left(error), (data) => Right(data.data.transform()));
  }

  @override
  Future<Either<NetworkError, VisitorListResponseModel>> getVisitorList(
      {required GetVisitorListRequestModel request}) async {
    if (request.search != null || (request.search?.isNotEmpty ?? false)) {
      // Log to track cancellation
      log("New search request: ${request.search}");

      // Cancel the previous request, if any
      _cancelToken?.cancel("Previous request cancelled");

      // Create a new CancelToken for the new request
      _cancelToken = CancelToken();
    }

    // Create a new CancelToken for the new request
    final response = await safeApiCall(
      apiService.getVisitorList(
          GetVisitorListRequestEntity(
            pageNumber: request.pageNumber,
            pageSize: request.pageSize,
            search: request.search,
            filters: request.filters
                ?.map(
                  (filter) => FilterEntity(
                      column: filter.column,
                      operation: filter.operation,
                      search: filter.search),
                )
                .toList(),
          ),
          _cancelToken),
    );
    return response.fold(
        (error) => Left(error), (data) => Right(data.data.transform()));
  }

  @override
  Future<Either<NetworkError, VisitorListResponseModel>> searchVisitorList(
      {required SearchRequest requestBody}) async {
    _cancelToken?.cancel();

    // Create a new CancelToken for the new request
    _cancelToken = CancelToken();

    final response = await safeApiCall(apiService.searchVisitorList(
        SearchRequestEntity(
            pageNumber: requestBody.pageNumber,
            pageSize: requestBody.pageSize,
            search: requestBody.search),
        _cancelToken));

    return response.fold(
        (error) => Left(error), (data) => Right(data.data.transform()));
  }

  @override
  Future<Either<NetworkError, ParentGatepassResponseModel>> patchParentGatePass(
      {required String gatepassID,
      required ParentGatePassRequestModel requestModel}) async {
    final response = await safeApiCall(
      apiService.patchParentGatePass(
          gatepassID,
          ParentGatePassRequestEntity(
              comingFrom: requestModel.comingFrom,
              companyName: requestModel.companyName,
              guestCount: requestModel.guestCount,
              otherPointOfContact: requestModel.otherPointOfContact,
              pointOfContact: requestModel.pointOfContact,
              purposeOfVisitId: requestModel.purposeOfVisitId,
              visitorTypeId: requestModel.visitorTypeId)),
    );
    return response.fold(
        (error) => Left(error), (data) => Right(data.data.transform()));
  }

  @override
  Future<Either<NetworkError, LoginResponse>> login(
      {required LoginRequest loginRequest}) async {
    final response = await safeApiCall(
      apiService.gateLogin(
        LoginRequestEntity(
            username: loginRequest.username, password: loginRequest.password),
      ),
    );
    return response.fold(
        (error) => Left(error), (data) => Right(data.data.transform()));
  }

  @override
  Future<Either<NetworkError, UserPermissionResponse>> userPermissionDetails(
      {required UserPermissionRequest request}) async {
    final response = await safeApiCall(
      apiService.getUserRoleBasedDetails(UserPermissionEntityRequest(
          applicationId: request.applicationId,
          service: request.service,
          userEmail: request.userEmail)),
    );
    return response.fold(
        (error) => Left(error), (data) => Right(data.data.transform()));
  }

  @override
  Future<Either<NetworkError, CreateIncidentReportResponse>>
      createIncidentReport(
          {required CreateIncidentReportRequest requestBody}) async {
    final request = CreateIncidentReportRequestEntity(
        teacherId: requestBody.teacherId,
        busDidiId: requestBody.busDidiId,
        busDiverId: requestBody.busDiverId,
        busId: requestBody.busId,
        comment: requestBody.comment,
        incidentType: requestBody.incidentType,
        studentId: requestBody.studentId);
    final response =
        await safeApiCall(transportService.createIncidentReport(request));
    return response.fold(
        (error) => Left(error), (data) => Right(data.data.transform()));
  }

  @override
  Future<Either<NetworkError, GetStudentList>> getStudentListByRoute(
      {required int routeId, required int stopId}) async {
    final response = await safeApiCall(
        transportService.getStudentRouteList(routeId, stopId));

    return response.fold(
        (error) => Left(error),
        (data) => Right(
              data.data.transform(),
            ));
  }

  @override
  Future<Either<NetworkError, CreateAttendanceResponse>> createAttendance(
      {required CreateAttendance createAttendance}) async {
    final response = await safeApiCall(
      academicsService.createAttendance(
        CreateAttendanceEntity(
          academicYearId: createAttendance.academicYearId,
          attendanceDate: createAttendance.attendanceDate,
          boardId: createAttendance.boardId,
          brandId: createAttendance.brandId,
          divisionId: createAttendance.divisionId,
          gradeId: createAttendance.gradeId,
          schoolId: createAttendance.schoolId,
          shiftId: createAttendance.shiftId,
          attendanceDetails: createAttendance.attendanceDetails
              ?.map(
                (e) => AttendanceDetailEntity(
                    attendanceRemark: e.attendanceRemark,
                    attendanceType: e.attendanceType,
                    globalStudentId: e.globalStudentId,
                    subjectId: e.subjectId,
                    timetableId: e.timetableId),
              )
              .toList(),
        ),
      ),
    );

    return response.fold(
        (error) => Left(error),
        (data) => Right(
              data.data.transform(),
            ));
  }

  @override
  Future<Either<NetworkError, GetStudentProfileResponse>> getStudentProfile(
      {required int studentId}) async {
    final response =
        await safeApiCall(transportService.getStudentProfile(studentId));

    return response.fold(
        (error) => Left(error), (data) => Right(data.data.transform()));
  }

  @override
  Future<Either<NetworkError, TripResponse>> getMyDutyList(
      {required int page, required int dayId}) async {
    final response = await safeApiCall(
      transportService.getMyDutyList(page, 10, dayId),
    );

    return response.fold(
        (error) => Left(error), (data) => Right(data.data.transform()));
  }

  @override
  Future<Either<NetworkError, GetGuardianListResponse>> getGuardianList(
      {required int studentId}) async {
    final response =
        await safeApiCall(transportService.getGuardianList(studentId));

    return response.fold(
      (error) => Left(error),
      (data) => Right(
        data.data.transform(),
      ),
    );
  }

  @override
  Future<Either<NetworkError, BusStopResponseModel>> getBusStopsList(
      {required String routeId, required int dayId}) async {
    final response = await safeApiCall(
      transportService.getBusStopsList(routeId: routeId, dayId: dayId),
    );

    return response.fold(
        (error) => Left(error), (data) => Right(data.data.transform()));
  }

  @override
  Future<Either<NetworkError, FetchStopLogsModel>> fetchStopLogs(
      {required int routeId, required int stopId}) async {
    final response = await safeApiCall(
      transportService.fetchStopLogs(routeId: routeId, stopId: stopId),
    );

    return response.fold(
        (error) => Left(error), (data) => Right(data.data.transform()));
  }

  @override
  Future<Either<NetworkError, CheckListResponse>> getAllCheckList(
      {required int routeId, required int userId, required int busId}) async {
    final GetCheckListEntityRequest getCheckListEntityRequest =
        GetCheckListEntityRequest(
            busId: busId, routeId: routeId, userId: userId);
    final response = await safeApiCall(
      transportService.getAllCheckList(getCheckListEntityRequest),
    );

    return response.fold(
        (error) => Left(error), (data) => Right(data.data.transform()));
  }

  @override
  Future<Either<NetworkError, GetChecklistConfirmationModel>>
      getChecklistConfirmation(
          {required int routeId,
          required int userId,
          required int userType}) async {
    final GetChecklistConfirmationRequest getCheckListEntityRequest =
        GetChecklistConfirmationRequest(
            userType: userType, routeId: routeId, userId: userId);
    final response = await safeApiCall(
      transportService.getChecklistConfirmation(getCheckListEntityRequest),
    );

    return response.fold(
        (error) => Left(error), (data) => Right(data.data.transform()));
  }

  @override
  Future<Either<NetworkError, CreateRouteLogsModel>> createRouteLogs(
      {required int routeId,
      int? driverId,
      int? didId,
      int? teacherId,
      required int userType,
      required String routeStatus,
      required String startDate,
      required String endDate}) async {
    final CreateRouteLogsRequest createRouteLogsRequest =
        CreateRouteLogsRequest(
            didId: didId,
            driverId: driverId,
            endDate: endDate,
            routeId: routeId,
            userType: userType,
            routeStatus: routeStatus,
            startDate: startDate,
            teacherId: teacherId);
    final response = await safeApiCall(
      transportService.createRouteLogs(createRouteLogsRequest),
    );

    return response.fold(
        (error) => Left(error), (data) => Right(data.data.transform()));
  }

  @override
  Future<Either<NetworkError, CreateBearerResponse>> createBearer(
      {required CreateBearerRequest request}) async {
    final response = await safeApiCall(
      mdmService.createBearer(
        CreateBearerRequestEntity(
          data: CreateBearerRequesDataEntity(
              firstName: request.data?.firstName,
              lastName: request.data?.lastName,
              profileImage: request.data?.profileImage),
        ),
      ),
    );

    return response.fold(
        (error) => Left(error), (data) => Right(data.data.transform()));
  }

  @override
  Future<Either<NetworkError, MapStudenttoBearerResponse>> mapBearerToGuardians(
      {required MapStudenttoBearerRequest request}) async {
    final response = await safeApiCall(mdmService.mapBearerToGuardians(
      MapStudenttoBearerRequestEntity(
        data: MapStudenttoBearerRequestDataEntity(
          guardianId: request.data?.guardianId,
          guardianRelationshipId: request.data?.guardianRelationshipId,
          studentId: request.data?.studentId,
        ),
      ),
    ));
    return response.fold(
        (error) => Left(error), (data) => Right(data.data.transform()));
  }

  @override
  Future<Either<NetworkError, CreateStopLogsModel>> createStopLogs(
      {required int routeId,
      required int stopId,
      required String stopStatus,
      required String time}) async {
    CreateStopLogsRequest createStopLogsRequest = CreateStopLogsRequest(
        routeId: routeId, stopId: stopId, stopStatus: stopStatus, time: time);
    final response = await safeApiCall(
      transportService.createStopLogs(createStopLogsRequest),
    );

    return response.fold(
        (error) => Left(error), (data) => Right(data.data.transform()));
  }

  @override
  Future<Either<NetworkError, GetBearerListResponse>> getBearerList(
      {required int studentId}) async {
    final response =
        await safeApiCall(transportService.getBearerList(studentId));

    return response.fold(
        (error) => Left(error), (data) => Right(data.data.transform()));
  }
}
