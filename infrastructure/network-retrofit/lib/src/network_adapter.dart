import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:data/data.dart';
import 'package:network_retrofit/src/model/request/gate_managment/create_gatepass_entity.dart';
import 'package:network_retrofit/src/model/request/gate_managment/visitor_list_entity_request.dart';
import 'package:network_retrofit/src/model/response/gate_managment/create_gatepass_entity_response.dart';

import 'package:network_retrofit/src/util/safe_api_call.dart';
import 'package:retrofit/retrofit.dart';

import 'services/retrofit_service.dart';

class NetworkAdapter implements NetworkPort {
  final RetrofitService apiService;

  NetworkAdapter(this.apiService);

  @override
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

  @override
  Future<Either<NetworkError, VisitorListResponseModel>> getVisitorList(
      {required GetVisitorListRequestModel request}) async {
    final response = await safeApiCall(
      apiService.getVisitorList(
        GetVisitorListRequestEntity(
          pageNumber: request.pageNumber,
          pageSize: request.pageSize,
          filters: request.filters
              ?.map(
                (filter) => FilterEntity(
                  column: filter.column,
                  operation: filter.operation,
                  search: filter.search,
                ),
              )
              .toList(),
        ),
      ),
    );
    return response.fold(
        (error) => Left(error), (data) => Right(data.data.transform()));
  }
}
