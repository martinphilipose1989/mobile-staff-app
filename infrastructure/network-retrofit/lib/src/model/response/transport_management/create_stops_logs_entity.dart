import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_stops_logs_entity.g.dart';

@JsonSerializable()
class CreateStopLogsEntity extends BaseLayerDataTransformer<
    CreateStopLogsEntity, CreateStopLogsModel> {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "data")
  CreateStopLogsDataEntity? data;
  @JsonKey(name: "message")
  String? message;

  CreateStopLogsEntity({
    this.status,
    this.data,
    this.message,
  });

  factory CreateStopLogsEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateStopLogsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateStopLogsEntityToJson(this);

  @override
  CreateStopLogsModel transform() {
    // TODO: implement transform
    return CreateStopLogsModel(
        data: data?.transform(), message: message, status: status);
  }
}

@JsonSerializable()
class CreateStopLogsDataEntity
    extends BaseLayerDataTransformer<CreateStopLogsEntity, CreateStopLogsData> {
  @JsonKey(name: "route_id")
  int? routeId;
  @JsonKey(name: "stop_id")
  int? stopId;
  @JsonKey(name: "stop_status")
  String? stopStatus;
  @JsonKey(name: "time")
  String? time;
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;

  CreateStopLogsDataEntity({
    this.routeId,
    this.stopId,
    this.stopStatus,
    this.time,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory CreateStopLogsDataEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateStopLogsDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateStopLogsDataEntityToJson(this);

  @override
  CreateStopLogsData transform() {
    // TODO: implement transform
    return CreateStopLogsData(
        createdAt: createdAt,
        id: id,
        routeId: routeId,
        stopId: stopId,
        stopStatus: stopStatus,
        time: time,
        updatedAt: updatedAt);
  }
}
