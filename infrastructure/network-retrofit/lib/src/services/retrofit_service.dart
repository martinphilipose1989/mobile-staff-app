import 'dart:io';

import 'package:dio/dio.dart';
import 'package:network_retrofit/src/model/request/gate_managment/parent_gatepass_entity.dart';
import 'package:network_retrofit/src/model/request/gate_managment/visitor_list_entity_request.dart';
import 'package:network_retrofit/src/model/request/login/login_request_entity.dart';
import 'package:network_retrofit/src/model/request/user_permission/user_permission_request_entity.dart';
import 'package:network_retrofit/src/model/response/gate_managment/parent_gatepass_response_entity.dart';
import 'package:network_retrofit/src/model/response/gate_managment/visitor_details_response_entity.dart';
import 'package:network_retrofit/src/model/request/gate_managment/create_gatepass_entity.dart';
import 'package:network_retrofit/src/model/response/gate_managment/create_gatepass_entity_response.dart';

import 'package:network_retrofit/src/model/response/gate_managment/upload_file_response_entity.dart';

import 'package:network_retrofit/src/model/response/gate_managment/visitor_list_response_entity.dart';
import 'package:network_retrofit/src/model/response/gate_managment/visitor_populate_response_entity.dart';
import 'package:network_retrofit/src/model/response/gate_managment/mdm_coreason_entity.dart';
import 'package:network_retrofit/src/model/response/login/login_response_entity.dart';
import 'package:network_retrofit/src/model/response/user_permission/user_permission_entity_response.dart';
import 'package:network_retrofit/src/util/network_properties.dart';

import 'package:retrofit/retrofit.dart';

part 'retrofit_service.g.dart';

@RestApi()
abstract class RetrofitService {
  factory RetrofitService(Dio dio, {String? baseUrl}) {
    return _RetrofitService(dio, baseUrl: dio.options.baseUrl);
  }

  @POST(NetworkProperties.getVisitorList)
  Future<HttpResponse<VisitorListResponseEntity>> getVisitorList(
      @Body() GetVisitorListRequestEntity requestBody);

  @GET(NetworkProperties.getVisitorDetails)
  Future<HttpResponse<VisitorDetailsResponseEntity>> getVisitorDetails(
    @Path("gatepassId") String getpassID,
  );

  @PATCH(NetworkProperties.signOutVisitor)
  Future<HttpResponse<VisitorDetailsResponseEntity>> patchVisitorDetails(
    @Path("gatepassId") String getpassID,
    @Body() Map<String, dynamic> outgoingTime,
  );
  @POST(NetworkProperties.createVistorGatepass)
  Future<HttpResponse<CreateGatePassResponseEntity>> createVisitorGatePass(
      @Body() CreateGatePassRequestEntity requestBody);

  @GET(NetworkProperties.mdmModule)
  Future<HttpResponse<MdmCoReasonEntity>> getPurposeOfVisitList(
      @Query('filters[parent_id]') int id, @Query("fields[0]") String name);

  @GET(NetworkProperties.mdmModule)
  Future<HttpResponse<MdmCoReasonEntity>> getVisitorTypeList(
      @Query('filters[parent_id]') int id, @Query("fields[0]") String name);

  @POST(NetworkProperties.uploadProfileImage)
  @MultiPart()
  Future<HttpResponse<UploadFileResponseEntity>> uploadProfileImage(
    @Part(name: "file") File file,
  );

  @GET(NetworkProperties.populateVisitorData)
  Future<HttpResponse<VisitorPopulateResponseEntity>> populateVisitorData(
      @Path("mobile") visitorMobileNumber);

  @GET(NetworkProperties.globalSearchVisitor)
  Future<HttpResponse<VisitorListResponseEntity>> searchVisitorList(
      @Query('pageNumber') int pageNumber,
      @Query('pageSize') int pageSize,
      @Query('search') String searchQuery,
      CancelToken? cancelToken);

  @PATCH(NetworkProperties.getVisitorDetails)
  Future<HttpResponse<ParentGatepassResponseEntity>> patchParentGatePass(
      @Path("gatepassId") String gatepassID,
      @Body() ParentGatePassRequestEntity requestBody);

  @POST(NetworkProperties.gateLogin)
  Future<HttpResponse<LoginResponseEntity>> gateLogin(
      @Body() LoginRequestEntity requestBody);

  @POST(NetworkProperties.getUserRoleBasePermission)
  Future<HttpResponse<UserPermissionEntityResponse>> getUserRoleBasedDetails(
      @Body() UserPermissionEntityRequest requestBody);
}
