import 'package:dio/dio.dart';

import 'package:network_retrofit/src/model/request/transport_management/create_reportincident_entity_request.dart';
import 'package:network_retrofit/src/model/response/transport_management/checklist_response_entity.dart';
import 'package:network_retrofit/src/model/response/transport_management/create_reportincident_entity_response.dart';
import 'package:network_retrofit/src/model/response/transport_management/get_student_profile_entity_response.dart';
import 'package:network_retrofit/src/model/response/transport_management/get_student_response_entity.dart';
import 'package:network_retrofit/src/model/response/transport_management/guardians_detail_response_entity.dart';
import 'package:network_retrofit/src/model/response/transport_management/trip_response_entity.dart';
import 'package:retrofit/retrofit.dart';

part 'transport_service.g.dart';

const String _getMyDutyList = "transport-service/mobile-app/my-duty";
const String _getCheckList = "transport-service/mobile-app/check-list";
const String _createIncidentReport = "transport-service/mobile-app/check-list";
const String _getStudentListByRoute =
    "transport-service/mobile-app/student-list";
const String _getStudentProfile =
    "transport-service/mobile-app/student-profile/{studentId}";

const String _getGuardianList =
    "transport-service/mobile-app/guardians-list/{studentId}";

@RestApi()
abstract class TransportService {
  factory TransportService(Dio dio, {String? transportUrl}) {
    return _TransportService(dio, baseUrl: transportUrl);
  }

  @GET(_getMyDutyList)
  Future<HttpResponse<TripResponseEntity>> getMyDutyList(
      @Query("page") int page, @Query("limit") int limit);

  @GET(_getCheckList)
  Future<HttpResponse<CheckListResponseEntity>> getAllCheckList(
      @Query("page") int page, @Query("limit") int limit);

  @POST(_createIncidentReport)
  Future<HttpResponse<CreateIncidentReportResponseEntity>> createIncidentReport(
      @Body() CreateIncidentReportRequestEntity body);

  @GET(_getStudentListByRoute)
  Future<HttpResponse<GetStudentListEntity>> getStudentRouteList(
      @Query("route_id") int routeId, @Query("stop_id") int stopId);

  @GET(_getStudentProfile)
  Future<HttpResponse<GetStudentProfileResponseEntity>> getStudentProfile(
      @Path("studentId") int studentid);

  @GET(_getGuardianList)
  Future<HttpResponse<GetGuardianListResponseEntity>> getGuardianList(
      @Path("studentId") int studentid);
}
