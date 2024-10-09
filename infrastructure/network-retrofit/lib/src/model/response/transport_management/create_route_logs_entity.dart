import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_route_logs_entity.g.dart';

@JsonSerializable()
class CreateRouteLogsEntity extends BaseLayerDataTransformer<
    CreateRouteLogsEntity, CreateRouteLogsModel> {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "data")
  CreateRouteLogsDataEntity? data;
  @JsonKey(name: "message")
  String? message;

  CreateRouteLogsEntity({
    this.status,
    this.data,
    this.message,
  });

  factory CreateRouteLogsEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateRouteLogsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRouteLogsEntityToJson(this);

  @override
  CreateRouteLogsModel transform() {
    // TODO: implement transform
    return CreateRouteLogsModel(
        data: data?.transform(), message: message, status: status);
  }
}

@JsonSerializable()
class CreateRouteLogsDataEntity extends BaseLayerDataTransformer<
    CreateRouteLogsDataEntity, CreateRouteLogsData> {
  @JsonKey(name: "route_id")
  int? routeId;
  @JsonKey(name: "driver_id")
  int? driverId;
  @JsonKey(name: "did_id")
  int? didId;
  @JsonKey(name: "teacher_id")
  int? teacherId;
  @JsonKey(name: "route_status")
  String? routeStatus;
  @JsonKey(name: "start_date")
  DateTime? startDate;
  @JsonKey(name: "end_date")
  DateTime? endDate;
  @JsonKey(name: "user_type")
  dynamic userType;
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "driverConfirmed")
  bool? driverConfirmed;
  @JsonKey(name: "teacherConfirmed")
  bool? teacherConfirmed;
  @JsonKey(name: "didConfirmed")
  bool? didConfirmed;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;

  CreateRouteLogsDataEntity({
    this.routeId,
    this.driverId,
    this.didId,
    this.teacherId,
    this.routeStatus,
    this.startDate,
    this.endDate,
    this.userType,
    this.id,
    this.driverConfirmed,
    this.teacherConfirmed,
    this.didConfirmed,
    this.createdAt,
    this.updatedAt,
  });

  factory CreateRouteLogsDataEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateRouteLogsDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRouteLogsDataEntityToJson(this);

  @override
  CreateRouteLogsData transform() {
    // TODO: implement transform
    return CreateRouteLogsData(
        createdAt: createdAt,
        didConfirmed: didConfirmed,
        didId: didId,
        driverConfirmed: didConfirmed,
        driverId: driverId,
        endDate: endDate,
        id: id,
        routeId: routeId,
        routeStatus: routeStatus,
        startDate: startDate,
        teacherConfirmed: teacherConfirmed,
        teacherId: teacherId,
        updatedAt: updatedAt,
        userType: userType);
  }
}
