import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_reportincident_entity_response.g.dart';

@JsonSerializable()
class CreateIncidentReportResponseEntity
    implements
        BaseLayerDataTransformer<CreateIncidentReportResponseEntity,
            CreateIncidentReportResponse> {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "data")
  CreateIncidentReportResponseDataEntity? data;
  @JsonKey(name: "message")
  String? message;

  CreateIncidentReportResponseEntity({this.status, this.data, this.message});

  factory CreateIncidentReportResponseEntity.fromJson(
          Map<String, dynamic> json) =>
      _$CreateIncidentReportResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateIncidentReportResponseEntityToJson(this);

  @override
  CreateIncidentReportResponseEntity restore(
      CreateIncidentReportResponse data) {
    return CreateIncidentReportResponseEntity(
        data: CreateIncidentReportResponseDataEntity(
            busDidiId: data.data?.busDidiId,
            busDiverId: data.data?.busDiverId,
            busId: data.data?.busId,
            comment: data.data?.comment,
            createdAt: data.data?.createdAt,
            id: data.data?.id,
            incidentType: data.data?.incidentType,
            studentId: data.data?.studentId,
            teacherId: data.data?.teacherId,
            updatedAt: data.data?.updatedAt),
        message: message,
        status: status);
  }

  @override
  CreateIncidentReportResponse transform() {
    return CreateIncidentReportResponse(
        data: data?.transform(), message: message, status: status);
  }
}

@JsonSerializable()
class CreateIncidentReportResponseDataEntity
    implements
        BaseLayerDataTransformer<CreateIncidentReportResponseDataEntity,
            CreateIncidentReportResponseData> {
  @JsonKey(name: "student_id")
  int? studentId;
  @JsonKey(name: "bus_id")
  int? busId;
  @JsonKey(name: "bus_diver_id")
  int? busDiverId;
  @JsonKey(name: "bus_didi_id")
  int? busDidiId;
  @JsonKey(name: "teacher_id")
  int? teacherId;
  @JsonKey(name: "incident_type")
  int? incidentType;
  @JsonKey(name: "comment")
  String? comment;
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "createdAt")
  String? createdAt;
  @JsonKey(name: "updatedAt")
  String? updatedAt;

  CreateIncidentReportResponseDataEntity({
    this.studentId,
    this.busId,
    this.busDiverId,
    this.busDidiId,
    this.teacherId,
    this.incidentType,
    this.comment,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory CreateIncidentReportResponseDataEntity.fromJson(
          Map<String, dynamic> json) =>
      _$CreateIncidentReportResponseDataEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateIncidentReportResponseDataEntityToJson(this);

  @override
  CreateIncidentReportResponseDataEntity restore(
      CreateIncidentReportResponseData data) {
    return CreateIncidentReportResponseDataEntity(
        busDidiId: data.busDidiId,
        busDiverId: data.busDiverId,
        busId: data.busId,
        comment: data.comment,
        createdAt: data.createdAt,
        id: data.id,
        incidentType: data.incidentType,
        studentId: data.studentId,
        teacherId: data.teacherId,
        updatedAt: data.updatedAt);
  }

  @override
  CreateIncidentReportResponseData transform() {
    return CreateIncidentReportResponseData(
        busDidiId: busDidiId,
        busDiverId: busDiverId,
        busId: busId,
        comment: comment,
        createdAt: createdAt,
        id: id,
        incidentType: incidentType,
        studentId: studentId,
        teacherId: teacherId,
        updatedAt: updatedAt);
  }
}
