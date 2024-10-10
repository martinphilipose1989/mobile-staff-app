class CreateAttendanceResponse {
  int? status;

  CreateAttendanceResponsData? data;

  String? message;

  bool? success;

  CreateAttendanceResponse(
      {this.status, this.data, this.message, this.success});
}

class CreateAttendanceResponsData {
  dynamic academicYearId;

  int? schoolId;

  int? boardId;

  int? gradeId;

  int? brandId;

  dynamic divisionId;

  int? shiftId;

  String? attendanceDate;

  int? id;

  String? createdAt;

  String? updatedAt;

  List<Attendance>? attendance;

  CreateAttendanceResponsData({
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
}

class Attendance {
  int? attendanceId;

  dynamic attendanceType;

  dynamic subjectId;

  dynamic timetableId;

  int? globalStudentId;

  String? attendanceRemark;

  int? id;

  String? createdAt;

  String? updatedAt;

  Attendance({
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
}
