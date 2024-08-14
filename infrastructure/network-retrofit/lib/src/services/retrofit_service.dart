import 'package:dio/dio.dart';
import 'package:network_retrofit/src/model/response/gate_managment/visitor_details_response_entity.dart';
import 'package:network_retrofit/src/model/request/gate_managment/create_gatepass_entity.dart';
import 'package:network_retrofit/src/model/response/gate_managment/create_gatepass_entity_response.dart';
import 'package:network_retrofit/src/model/response/gate_managment/purpose_of_visit_entity.dart';

import 'package:network_retrofit/src/model/response/gate_managment/visitor_list_response_entity.dart';
import 'package:network_retrofit/src/model/response/gate_managment/visitor_type_entity.dart';
import 'package:network_retrofit/src/util/network_properties.dart';

import 'package:retrofit/retrofit.dart';

part 'retrofit_service.g.dart';

@RestApi()
abstract class RetrofitService {
  factory RetrofitService(Dio dio, {String? baseUrl}) {
    return _RetrofitService(dio, baseUrl: dio.options.baseUrl);
  }

  @GET(NetworkProperties.getVisitorList)
  Future<HttpResponse<VisitorListResponseEntity>> getVisitorList(
      @Query('pageNumber') int pageNumber, @Query('pageSize') int pageSize);

  @GET(NetworkProperties.getVisitorDetails)
  Future<HttpResponse<VisitorDetailsResponseEntity>> getVisitorDetails(
    @Path("gatepassId") String getpassID,
  );

  @PATCH(NetworkProperties.getVisitorDetails)
  Future<HttpResponse<VisitorDetailsResponseEntity>> patchVisitorDetails(
    @Path("gatepassId") String getpassID,
    @Body() Map<String, dynamic> outgoingTime,
  );
  @POST(NetworkProperties.createVistorGatepass)
  Future<HttpResponse<CreateGatePassResponseEntity>> createVisitorGatePass(
      @Body() CreateGatePassRequestEntity requestBody);

  @GET(NetworkProperties.getPurposeOfVisitList)
  Future<HttpResponse<PurposeOfVisitEntity>> getPurposeOfVisitList();

  @GET(NetworkProperties.getVisitorTypeList)
  Future<HttpResponse<TypeOfVisitorEntity>> getVisitorTypeList();
}
