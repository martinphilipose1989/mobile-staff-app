import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_reportincident_entity_request.g.dart';

@JsonSerializable()
class CreateIncidentReportRequestEntity
    implements
        BaseLayerDataTransformer<CreateIncidentReportRequestEntity,
            CreateIncidentReportRequest> {
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

  CreateIncidentReportRequestEntity(
      {this.studentId,
      this.busId,
      this.busDiverId,
      this.busDidiId,
      this.teacherId,
      this.incidentType,
      this.comment});

  factory CreateIncidentReportRequestEntity.fromJson(
          Map<String, dynamic> json) =>
      _$CreateIncidentReportRequestEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateIncidentReportRequestEntityToJson(this);

  @override
  CreateIncidentReportRequestEntity restore(CreateIncidentReportRequest data) {
    return CreateIncidentReportRequestEntity(
        busDidiId: data.busDidiId,
        busDiverId: data.busDiverId,
        busId: data.busId,
        comment: data.comment,
        incidentType: data.incidentType,
        studentId: data.studentId,
        teacherId: data.teacherId);
  }

  @override
  CreateIncidentReportRequest transform() {
    return CreateIncidentReportRequest(
        busDidiId: busDidiId,
        busDiverId: busDiverId,
        busId: busId,
        comment: comment,
        incidentType: incidentType,
        studentId: studentId,
        teacherId: teacherId);
  }
}
