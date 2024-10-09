import 'package:dio/dio.dart';

import 'package:network_retrofit/src/model/request/transport_management/create_reportincident_entity_request.dart';
import 'package:network_retrofit/src/model/request/transport_management/create_route_logs_request.dart';
import 'package:network_retrofit/src/model/request/transport_management/get_check_list_entity_request.dart';
import 'package:network_retrofit/src/model/request/transport_management/get_checklist_confirmation_request.dart';
import 'package:network_retrofit/src/model/response/transport_management/bus_route_response_entity.dart';
import 'package:network_retrofit/src/model/response/transport_management/checklist_response_entity.dart';
import 'package:network_retrofit/src/model/response/transport_management/create_reportincident_entity_response.dart';
import 'package:network_retrofit/src/model/response/transport_management/create_route_logs_entity.dart';
import 'package:network_retrofit/src/model/response/transport_management/fetch_stops_logs_entity.dart';
import 'package:network_retrofit/src/model/response/transport_management/get_confirmation_checklist_entity.dart';
import 'package:network_retrofit/src/model/response/transport_management/trip_response_entity.dart';

import 'package:retrofit/retrofit.dart';

part 'transport_service.g.dart';

const String _getMyDutyList = "transport-service/mobile-app/my-duty";
const String _getCheckList = "transport-service/mobile-app/check-list";
const String _createIncidentReport = "transport-service/mobile-app/check-list";
const String _getBusStopsList = 'transport-service/mobile-app/bus-stops';
const String _fetchStopsLogs = "transport-service/mobile-app/fetch-stop-logs";
const String _getChecklistConformation =
    "transport-service/mobile-app/confirm-checklist";
const String _createRouteLogs =
    'transport-service/mobile-app/create/route-logs';

@RestApi()
abstract class TransportService {
  factory TransportService(Dio dio, {String? transportUrl}) {
    return _TransportService(dio, baseUrl: transportUrl);
  }

  // @GET(_getCheckList)
  // Future<HttpResponse<CheckListResponseEntity>> getAllCheckList(
  //     @Query("page") int page,
  //     @Query("limit") int limit,
  //     @Query("day_id") int dayId);

  @POST(_createIncidentReport)
  Future<HttpResponse<CreateIncidentReportResponseEntity>> createIncidentReport(
      @Body() CreateIncidentReportRequestEntity body);

  @GET(_getMyDutyList)
  Future<HttpResponse<TripResponseEntity>> getMyDutyList(
      @Query("page") int page,
      @Query("limit") int limit,
      @Query("day_id") int dayId);

  @GET(_getBusStopsList)
  Future<HttpResponse<BusStopResponseEntity>> getBusStopsList(
      {@Query("route_id") required String routeId,
      @Query("day_id") required int dayId});

  @GET(_fetchStopsLogs)
  Future<HttpResponse<FetchStopLogsEntity>> fetchStopLogs(
      {@Query("route_id") required int routeId,
      @Query("stop_id") required int stopId});

  @POST(_getCheckList)
  Future<HttpResponse<CheckListEntity>> getAllCheckList(
      @Body() GetCheckListEntityRequest getCheckListEntityRequest);

  @POST(_getChecklistConformation)
  Future<HttpResponse<GetChecklistConfirmationEntity>> getChecklistConfirmation(
      @Body() GetChecklistConfirmationRequest getCheckListEntityRequest);

  @POST(_createRouteLogs)
  Future<HttpResponse<CreateRouteLogsEntity>> createRouteLogs(
      @Body() CreateRouteLogsRequest createRouteLogsRequest);
}
