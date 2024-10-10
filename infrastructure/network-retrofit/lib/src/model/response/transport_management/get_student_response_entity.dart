import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_student_response_entity.g.dart';

@JsonSerializable()
class GetStudentListEntity
    implements BaseLayerDataTransformer<GetStudentListEntity, GetStudentList> {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "data")
  List<StudentEntity>? data;
  @JsonKey(name: "message")
  String? message;

  GetStudentListEntity({this.status, this.data, this.message});

  factory GetStudentListEntity.fromJson(Map<String, dynamic> json) =>
      _$GetStudentListEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetStudentListEntityToJson(this);

  @override
  GetStudentListEntity restore(GetStudentList data) {
    return GetStudentListEntity();
  }

  @override
  GetStudentList transform() {
    return GetStudentList(
      status: status,
      message: message,
      data: data?.map((e) => e.transform()).toList(),
    );
  }
}

@JsonSerializable()
class StudentEntity
    implements BaseLayerDataTransformer<StudentEntity, Student> {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "student_id")
  int? studentId;
  @JsonKey(name: "stop_id")
  int? stopId;
  @JsonKey(name: "route_id")
  int? routeId;
  @JsonKey(name: "start_date")
  String? startDate;
  @JsonKey(name: "end_date")
  String? endDate;
  @JsonKey(name: "fees_id")
  String? feesId;
  @JsonKey(name: "fees_status")
  String? feesStatus;
  @JsonKey(name: "createdAt")
  String? createdAt;
  @JsonKey(name: "updatedAt")
  String? updatedAt;
  @JsonKey(name: "student_details")
  StudentDetailsEntity? studentDetails;
  @JsonKey(name: "intimation_details")
  List<IntimationDetailsEntity>? intimationDetails;
  @JsonKey(name: "attendance_details")
  List<AttendanceLogDetailsResponseEntity>? attendanceDetail;

  StudentEntity(
      {this.id,
      this.studentId,
      this.stopId,
      this.routeId,
      this.startDate,
      this.endDate,
      this.feesId,
      this.feesStatus,
      this.createdAt,
      this.updatedAt,
      this.studentDetails,
      this.intimationDetails,
      this.attendanceDetail});

  factory StudentEntity.fromJson(Map<String, dynamic> json) =>
      _$StudentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$StudentEntityToJson(this);

  @override
  StudentEntity restore(Student data) {
    return StudentEntity();
  }

  @override
  Student transform() {
    return Student(
        id: id,
        feesId: feesId,
        feesStatus: feesStatus,
        createdAt: createdAt,
        endDate: endDate,
        routeId: routeId,
        stopId: stopId,
        startDate: startDate,
        studentDetails: studentDetails?.transform(),
        intimationList: intimationDetails?.map((e) => e.transform()).toList(),
        studentId: studentId,
        updatedAt: updatedAt,
        attendanceList: attendanceDetail?.map((e) => e.transform()).toList());
  }
}

@JsonSerializable()
class StudentDetailsEntity
    implements BaseLayerDataTransformer<StudentDetailsEntity, StudentDetails> {
  @JsonKey(name: "first_name")
  String? firstName;
  @JsonKey(name: "middle_name")
  String? middleName;
  @JsonKey(name: "last_name")
  String? lastName;
  @JsonKey(name: "profile_image")
  String? profileImage;
  @JsonKey(name: "crt_enr_on")
  String? crtEnrOn;
  @JsonKey(name: "crt_school_id")
  int? crtSchoolId;
  @JsonKey(name: "crt_board_id")
  int? crtBoardId;
  @JsonKey(name: "crt_brand_id")
  int? crtBrandId;
  @JsonKey(name: "crt_grade_id")
  int? crtGradeId;
  @JsonKey(name: "crt_shift_id")
  int? crtShiftId;

  StudentDetailsEntity(
      {this.firstName,
      this.middleName,
      this.lastName,
      this.profileImage,
      this.crtEnrOn,
      this.crtBoardId,
      this.crtBrandId,
      this.crtGradeId,
      this.crtSchoolId,
      this.crtShiftId});

  factory StudentDetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$StudentDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$StudentDetailsEntityToJson(this);

  @override
  StudentDetailsEntity restore(StudentDetails data) {
    return StudentDetailsEntity();
  }

  @override
  StudentDetails transform() {
    return StudentDetails(
        crtEnrOn: crtEnrOn,
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        profileImage: profileImage,
        crtBoardId: crtBoardId,
        crtBrandId: crtBrandId,
        crtGradeId: crtGradeId,
        crtSchoolId: crtSchoolId,
        crtShiftId: crtShiftId);
  }
}

@JsonSerializable()
class IntimationDetailsEntity
    implements
        BaseLayerDataTransformer<IntimationDetailsEntity, IntimationDetails> {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "global_user_id")
  int? globalUserId;
  @JsonKey(name: "global_student_id")
  int? globalStudentId;
  @JsonKey(name: "from_date")
  String? fromDate;
  @JsonKey(name: "to_date")
  String? toDate;
  @JsonKey(name: "intimation_status")
  int? intimationStatus;
  @JsonKey(name: "initimation_type")
  int? initimationType;
  @JsonKey(name: "intimation_note")
  String? intimationNote;

  IntimationDetailsEntity({
    this.id,
    this.globalUserId,
    this.globalStudentId,
    this.fromDate,
    this.toDate,
    this.intimationStatus,
    this.initimationType,
    this.intimationNote,
  });

  factory IntimationDetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$IntimationDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$IntimationDetailsEntityToJson(this);

  @override
  IntimationDetailsEntity restore(IntimationDetails data) {
    return IntimationDetailsEntity();
  }

  @override
  IntimationDetails transform() {
    return IntimationDetails(
        fromDate: fromDate,
        globalStudentId: globalStudentId,
        globalUserId: globalUserId,
        id: id,
        initimationType: initimationType,
        intimationNote: intimationNote,
        intimationStatus: intimationStatus,
        toDate: toDate);
  }
}

@JsonSerializable()
class AttendanceLogDetailsResponseEntity
    implements
        BaseLayerDataTransformer<AttendanceLogDetailsResponseEntity,
            AttendanceLogDetailsResponse> {
  @JsonKey(name: "id")
  int? id;
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
  @JsonKey(name: "start_time")
  dynamic startTime;
  @JsonKey(name: "end_time")
  dynamic endTime;
  @JsonKey(name: "subject_name")
  dynamic subjectName;
  @JsonKey(name: "first_name")
  String? firstName;
  @JsonKey(name: "middle_name")
  dynamic middleName;
  @JsonKey(name: "last_name")
  String? lastName;
  @JsonKey(name: "enr_on")
  String? enrOn;

  AttendanceLogDetailsResponseEntity({
    this.id,
    this.attendanceId,
    this.attendanceType,
    this.subjectId,
    this.timetableId,
    this.globalStudentId,
    this.attendanceRemark,
    this.startTime,
    this.endTime,
    this.subjectName,
    this.firstName,
    this.middleName,
    this.lastName,
    this.enrOn,
  });

  factory AttendanceLogDetailsResponseEntity.fromJson(
          Map<String, dynamic> json) =>
      _$AttendanceLogDetailsResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AttendanceLogDetailsResponseEntityToJson(this);

  @override
  AttendanceLogDetailsResponseEntity restore(
      AttendanceLogDetailsResponse data) {
    return AttendanceLogDetailsResponseEntity();
  }

  @override
  AttendanceLogDetailsResponse transform() {
    return AttendanceLogDetailsResponse(
        attendanceId: attendanceId,
        attendanceRemark: attendanceRemark,
        attendanceType: attendanceType,
        endTime: endTime,
        enrOn: enrOn,
        firstName: firstName,
        lastName: lastName,
        globalStudentId: globalStudentId,
        id: id,
        middleName: middleName,
        startTime: startTime,
        subjectId: subjectId,
        subjectName: subjectName,
        timetableId: timetableId);
  }
}
