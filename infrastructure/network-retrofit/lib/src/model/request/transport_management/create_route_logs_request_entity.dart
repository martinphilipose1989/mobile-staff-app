import 'package:json_annotation/json_annotation.dart';

part 'create_route_logs_request_entity.g.dart';

@JsonSerializable()
class CreateStopLogsRequest {
  @JsonKey(name: "route_id")
  int? routeId;
  @JsonKey(name: "stop_id")
  int? stopId;
  @JsonKey(name: "stop_status")
  String? stopStatus;
  @JsonKey(name: "time")
  String? time;

  CreateStopLogsRequest({
    this.routeId,
    this.stopId,
    this.stopStatus,
    this.time,
  });

  factory CreateStopLogsRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateStopLogsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateStopLogsRequestToJson(this);
}
