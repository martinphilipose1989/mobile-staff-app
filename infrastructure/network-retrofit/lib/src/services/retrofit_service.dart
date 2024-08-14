import 'package:dio/dio.dart';
import 'package:network_retrofit/src/model/response/gate_managment/visitor_details_response_entity.dart';
import 'package:network_retrofit/src/model/response/gate_managment/visitor_list_response_entity.dart';
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
}
