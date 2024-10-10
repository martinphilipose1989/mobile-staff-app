import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_attendance_response_entity.g.dart';

@JsonSerializable()
class CreateAttendanceResponseEntity
    implements
        BaseLayerDataTransformer<CreateAttendanceResponseEntity,
            CreateAttendanceResponse> {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "data")
  CreateAttendanceResponsDataEntity? data;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "success")
  bool? success;

  CreateAttendanceResponseEntity(
      {this.status, this.data, this.message, this.success});

  factory CreateAttendanceResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateAttendanceResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAttendanceResponseEntityToJson(this);

  @override
  CreateAttendanceResponseEntity restore(CreateAttendanceResponse data) {
    return CreateAttendanceResponseEntity();
  }

  @override
  CreateAttendanceResponse transform() {
    return CreateAttendanceResponse(
        data: data?.transform(),
        message: message,
        status: status,
        success: success);
  }
}

@JsonSerializable()
class CreateAttendanceResponsDataEntity
    implements
        BaseLayerDataTransformer<CreateAttendanceResponsDataEntity,
            CreateAttendanceResponsData> {
  @JsonKey(name: "academic_year_id")
  dynamic academicYearId;
  @JsonKey(name: "school_id")
  int? schoolId;
  @JsonKey(name: "board_id")
  int? boardId;
  @JsonKey(name: "grade_id")
  int? gradeId;
  @JsonKey(name: "brand_id")
  int? brandId;
  @JsonKey(name: "division_id")
  dynamic divisionId;
  @JsonKey(name: "shift_id")
  int? shiftId;
  @JsonKey(name: "attendance_date")
  String? attendanceDate;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "attendance")
  List<AttendanceEntity>? attendance;

  CreateAttendanceResponsDataEntity({
    this.academicYearId,
    this.schoolId,
    this.boardId,
    this.gradeId,
    this.brandId,
    this.divisionId,
    this.shiftId,
    this.attendanceDate,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.attendance,
  });

  factory CreateAttendanceResponsDataEntity.fromJson(
          Map<String, dynamic> json) =>
      _$CreateAttendanceResponsDataEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateAttendanceResponsDataEntityToJson(this);

  @override
  CreateAttendanceResponsDataEntity restore(CreateAttendanceResponsData data) {
    return CreateAttendanceResponsDataEntity();
  }

  @override
  CreateAttendanceResponsData transform() {
    return CreateAttendanceResponsData(
        attendance: attendance?.map((e) => e.transform()).toList(),
        attendanceDate: attendanceDate,
        boardId: boardId,
        schoolId: schoolId,
        brandId: brandId);
  }
}

@JsonSerializable()
class AttendanceEntity
    implements BaseLayerDataTransformer<AttendanceEntity, Attendance> {
  @JsonKey(name: "attendance_id")
  int? attendanceId;
  @JsonKey(name: "attendance_type")
  dynamic attendanceType;
  @JsonKey(name: "subject_id")
  dynamic subjectId;
  @JsonKey(name: "timetable_id")
  dynamic timetableId;
  @JsonKey(name: "global_student_id")
  int? globalStudentId;
  @JsonKey(name: "attendance_remark")
  String? attendanceRemark;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  AttendanceEntity({
    this.attendanceId,
    this.attendanceType,
    this.subjectId,
    this.timetableId,
    this.globalStudentId,
    this.attendanceRemark,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory AttendanceEntity.fromJson(Map<String, dynamic> json) =>
      _$AttendanceEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceEntityToJson(this);

  @override
  AttendanceEntity restore(Attendance data) {
    return AttendanceEntity();
  }

  @override
  Attendance transform() {
    return Attendance(
        attendanceId: attendanceId,
        attendanceRemark: attendanceRemark,
        globalStudentId: globalStudentId);
  }
}
