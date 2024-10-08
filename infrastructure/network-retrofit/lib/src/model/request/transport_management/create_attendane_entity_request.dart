import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_attendane_entity_request.g.dart';

@JsonSerializable()
class CreateAttendanceEntity
    implements
        BaseLayerDataTransformer<CreateAttendanceEntity, CreateAttendance> {
  @JsonKey(name: "academic_year_id")
  int? academicYearId;
  @JsonKey(name: "school_id")
  int? schoolId;
  @JsonKey(name: "board_id")
  int? boardId;
  @JsonKey(name: "brand_id")
  int? brandId;
  @JsonKey(name: "grade_id")
  int? gradeId;
  @JsonKey(name: "shift_id")
  int? shiftId;
  @JsonKey(name: "division_id")
  int? divisionId;
  @JsonKey(name: "attendance_date")
  String? attendanceDate;
  @JsonKey(name: "attendance_details")
  List<AttendanceDetailEntity>? attendanceDetails;

  CreateAttendanceEntity({
    this.academicYearId,
    this.schoolId,
    this.boardId,
    this.brandId,
    this.gradeId,
    this.shiftId,
    this.divisionId,
    this.attendanceDate,
    this.attendanceDetails,
  });

  factory CreateAttendanceEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateAttendanceEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAttendanceEntityToJson(this);

  @override
  CreateAttendanceEntity restore(CreateAttendance data) {
    return CreateAttendanceEntity();
  }

  @override
  CreateAttendance transform() {
    return CreateAttendance(
        academicYearId: academicYearId,
        attendanceDate: attendanceDate,
        attendanceDetails:
            attendanceDetails?.map((e) => e.transform()).toList(),
        boardId: boardId,
        brandId: brandId,
        divisionId: divisionId,
        gradeId: gradeId,
        schoolId: schoolId,
        shiftId: shiftId);
  }
}

@JsonSerializable()
class AttendanceDetailEntity
    implements
        BaseLayerDataTransformer<AttendanceDetailEntity, AttendanceDetail> {
  @JsonKey(name: "attendance_type")
  int? attendanceType;
  @JsonKey(name: "subject_id")
  int? subjectId;
  @JsonKey(name: "timetable_id")
  int? timetableId;
  @JsonKey(name: "global_student_id")
  int? globalStudentId;
  @JsonKey(name: "attendance_remark")
  String? attendanceRemark;

  AttendanceDetailEntity(
      {this.attendanceType,
      this.subjectId,
      this.timetableId,
      this.globalStudentId,
      this.attendanceRemark});

  factory AttendanceDetailEntity.fromJson(Map<String, dynamic> json) =>
      _$AttendanceDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceDetailEntityToJson(this);

  @override
  AttendanceDetailEntity restore(AttendanceDetail data) {
    return AttendanceDetailEntity();
  }

  @override
  AttendanceDetail transform() {
    return AttendanceDetail(
        attendanceRemark: attendanceRemark,
        attendanceType: attendanceType,
        globalStudentId: globalStudentId,
        subjectId: subjectId,
        timetableId: timetableId);
  }
}
