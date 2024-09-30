import 'package:dio/dio.dart';
import 'package:network_retrofit/src/model/response/transport_management/trip_response_entity.dart';

import 'package:retrofit/retrofit.dart';

part 'transport_service.g.dart';

@RestApi()
abstract class TransportService {
  factory TransportService(Dio dio, {String? transportUrl}) {
    return _TransportService(dio, baseUrl: transportUrl);
  }

  @GET("mobile-app/my-duty")
  Future<TripResponseEntity> getMyDutyList(
      @Query("page") int page, @Query("limit") int limit);
}
