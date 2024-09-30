import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:network_retrofit/src/model/request/gate_managment/create_gatepass_entity.dart';
import 'package:network_retrofit/src/model/request/gate_managment/parent_gatepass_entity.dart';
import 'package:network_retrofit/src/model/request/gate_managment/visitor_list_entity_request.dart';
import 'package:network_retrofit/src/model/request/login/login_request_entity.dart';
import 'package:network_retrofit/src/model/request/transport_management/create_reportincident_entity_request.dart';
import 'package:network_retrofit/src/model/request/user_permission/user_permission_request_entity.dart';
import 'package:network_retrofit/src/model/response/gate_managment/create_gatepass_entity_response.dart';
import 'package:network_retrofit/src/model/response/gate_managment/visitor_search_request_entity.dart';
import 'package:network_retrofit/src/services/transport_service.dart';

import 'package:network_retrofit/src/util/safe_api_call.dart';
import 'package:retrofit/retrofit.dart';

import 'services/retrofit_service.dart';

class NetworkAdapter implements NetworkPort {
  final RetrofitService apiService;
  final TransportService transportService;
  CancelToken? _cancelToken;

  NetworkAdapter(this.apiService, this.transportService);

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
      {required File file}) async {
    final response = await safeApiCall(apiService.uploadProfileImage(file));
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

  int counter = 0;
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

      // Log the cancel request count for debugging
      counter++;
      log("Request counter: $counter");
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
  Future<Either<NetworkError, TripResponse>> getMyDutyList(
      {int page = 1, int limit = 10}) async {
    final response = await safeApiCall(
      transportService.getMyDutyList(page, limit),
    );

    return response.fold(
        (error) => Left(error), (data) => Right(data.data.transform()));
  }

  @override
  Future<Either<NetworkError, CheckListResponse>> getAllCheckList(
      {int page = 1, int limit = 10}) async {
    final response = await safeApiCall(
      transportService.getAllCheckList(page, limit),
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
}
