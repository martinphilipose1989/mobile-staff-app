import 'package:json_annotation/json_annotation.dart';

part 'create_route_logs_request.g.dart';

@JsonSerializable()
class CreateRouteLogsRequest {
  @JsonKey(name: "route_id")
  int? routeId;
  @JsonKey(name: "driver_id")
  int? driverId;
  @JsonKey(name: "did_id")
  int? didId;
  @JsonKey(name: "teacher_id")
  int? teacherId;
  @JsonKey(name: "user_type")
  int? userType;
  @JsonKey(name: "route_status")
  String? routeStatus;
  @JsonKey(name: "start_date")
  String? startDate;
  @JsonKey(name: "end_date")
  String? endDate;
  // @JsonKey(name: "student_id")
  // List<int>? studentId;
  // @JsonKey(name: "attendance_type")
  // int? attendanceType;

  CreateRouteLogsRequest({
    this.routeId,
    this.driverId,
    this.didId,
    this.teacherId,
    this.routeStatus,
    this.startDate,
    this.endDate,
    this.userType,
    // this.attendanceType,
    // this.studentId
  });

  factory CreateRouteLogsRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateRouteLogsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRouteLogsRequestToJson(this);
}
