import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_confirmation_checklist_entity.g.dart';

@JsonSerializable()
class GetChecklistConfirmationEntity extends BaseLayerDataTransformer<
    GetChecklistConfirmationEntity, GetChecklistConfirmationModel> {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "data")
  DataEntity? data;
  @JsonKey(name: "message")
  String? message;

  GetChecklistConfirmationEntity({
    this.status,
    this.data,
    this.message,
  });

  factory GetChecklistConfirmationEntity.fromJson(Map<String, dynamic> json) =>
      _$GetChecklistConfirmationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetChecklistConfirmationEntityToJson(this);

  @override
  GetChecklistConfirmationModel transform() {
    // TODO: implement transform
    return GetChecklistConfirmationModel(
        data: data?.transform(), message: message, status: status);
  }
}

@JsonSerializable()
class DataEntity
    extends BaseLayerDataTransformer<DataEntity, GetChecklistConfirmationData> {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "id")
  String? id;
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
  int? userType;
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

  DataEntity({
    this.id,
    this.routeId,
    this.driverId,
    this.didId,
    this.teacherId,
    this.routeStatus,
    this.startDate,
    this.endDate,
    this.userType,
    this.driverConfirmed,
    this.teacherConfirmed,
    this.didConfirmed,
    this.createdAt,
    this.updatedAt,
    this.message,
  });

  factory DataEntity.fromJson(Map<String, dynamic> json) =>
      _$DataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DataEntityToJson(this);

  @override
  GetChecklistConfirmationData transform() {
    // TODO: implement transform
    return GetChecklistConfirmationData(
        message: message,
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
        userType: userType.toString());
  }
}
