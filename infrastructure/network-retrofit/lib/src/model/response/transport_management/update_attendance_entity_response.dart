import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_attendance_entity_response.g.dart';

@JsonSerializable()
class UpdateAttendanceResponseEntity
    implements
        BaseLayerDataTransformer<UpdateAttendanceResponseEntity,
            UpdateAttendanceResponse> {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "data")
  List<List<UpdateAttendanceEntity>>? data;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "success")
  bool? success;

  UpdateAttendanceResponseEntity(
      {this.status, this.data, this.message, this.success});

  factory UpdateAttendanceResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$UpdateAttendanceResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateAttendanceResponseEntityToJson(this);

  @override
  UpdateAttendanceResponseEntity restore(UpdateAttendanceResponse data) {
    return UpdateAttendanceResponseEntity();
  }

  @override
  UpdateAttendanceResponse transform() {
    return UpdateAttendanceResponse(
        data: data?.map((e) => e.map((e) => e.transform()).toList()).toList());
  }
}

@JsonSerializable()
class UpdateAttendanceEntity
    implements
        BaseLayerDataTransformer<UpdateAttendanceEntity, UpdateAttendance> {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "attendance_id")
  int? attendanceId;
  @JsonKey(name: "attendance_type")
  int? attendanceType;
  @JsonKey(name: "subject_id")
  dynamic subjectId;
  @JsonKey(name: "timetable_id")
  dynamic timetableId;
  @JsonKey(name: "global_student_id")
  int? globalStudentId;
  @JsonKey(name: "attendance_remark")
  String? attendanceRemark;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  UpdateAttendanceEntity(
      {this.id,
      this.attendanceId,
      this.attendanceType,
      this.subjectId,
      this.timetableId,
      this.globalStudentId,
      this.attendanceRemark,
      this.createdAt,
      this.updatedAt});

  factory UpdateAttendanceEntity.fromJson(Map<String, dynamic> json) =>
      _$UpdateAttendanceEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateAttendanceEntityToJson(this);

  @override
  UpdateAttendanceEntity restore(UpdateAttendance data) {
    return UpdateAttendanceEntity();
  }

  @override
  UpdateAttendance transform() {
    return UpdateAttendance(
        attendanceId: attendanceId,
        attendanceType: attendanceType,
        attendanceRemark: attendanceRemark,
        createdAt: createdAt,
        globalStudentId: globalStudentId,
        id: id,
        subjectId: subjectId,
        timetableId: timetableId,
        updatedAt: updatedAt);
  }
}
