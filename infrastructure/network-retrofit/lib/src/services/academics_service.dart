import 'package:dio/dio.dart';
import 'package:network_retrofit/src/model/request/transport_management/create_attendane_entity_request.dart';

import 'package:retrofit/retrofit.dart';

part 'academics_service.g.dart';

const String _createAttendance = "academics/attendance/create";

@RestApi()
abstract class AcademicsService {
  factory AcademicsService(Dio dio, {String? academicsUrl}) {
    return _AcademicsService(dio, baseUrl: academicsUrl);
  }

  @POST(_createAttendance)
  Future<HttpResponse<CreateAttendanceEntity>> createAttendance(
      @Body() CreateAttendanceEntity body);
}