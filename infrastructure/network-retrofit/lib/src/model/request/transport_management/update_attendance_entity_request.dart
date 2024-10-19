import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_attendance_entity_request.g.dart';

@JsonSerializable()
class UpdateAttendanceRequestEntity
    implements
        BaseLayerDataTransformer<UpdateAttendanceRequestEntity,
            UpdateAttendanceRequest> {
  @JsonKey(name: "attendanceUpdates")
  List<AttendanceUpdateEntity>? attendanceUpdates;

  UpdateAttendanceRequestEntity({this.attendanceUpdates});

  factory UpdateAttendanceRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$UpdateAttendanceRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateAttendanceRequestEntityToJson(this);

  @override
  UpdateAttendanceRequestEntity restore(UpdateAttendanceRequest data) {
    return UpdateAttendanceRequestEntity();
  }

  @override
  UpdateAttendanceRequest transform() {
    return UpdateAttendanceRequest(
        attendanceUpdates:
            attendanceUpdates?.map((e) => e.transform()).toList());
  }
}

@JsonSerializable()
class AttendanceUpdateEntity
    implements
        BaseLayerDataTransformer<AttendanceUpdateEntity, AttendanceUpdate> {
  @JsonKey(name: "student_id")
  List<int>? studentId;
  @JsonKey(name: "attendance_date")
  List<String>? attendanceDate;
  @JsonKey(name: "attendance_type")
  int? attendanceType;
  @JsonKey(name: "attendance_remark")
  String? attendanceRemark;

  AttendanceUpdateEntity({
    this.studentId,
    this.attendanceDate,
    this.attendanceType,
    this.attendanceRemark,
  });

  factory AttendanceUpdateEntity.fromJson(Map<String, dynamic> json) =>
      _$AttendanceUpdateEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceUpdateEntityToJson(this);

  @override
  AttendanceUpdateEntity restore(AttendanceUpdate data) {
    return AttendanceUpdateEntity();
  }

  @override
  AttendanceUpdate transform() {
    return AttendanceUpdate(
        attendanceDate: attendanceDate,
        attendanceRemark: attendanceRemark,
        attendanceType: attendanceType,
        studentId: studentId);
  }
}
