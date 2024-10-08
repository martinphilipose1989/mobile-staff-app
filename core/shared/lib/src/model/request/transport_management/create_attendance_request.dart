class CreateAttendance {
  int? academicYearId;
  int? schoolId;
  int? boardId;
  int? brandId;
  int? gradeId;
  int? shiftId;
  int? divisionId;
  String? attendanceDate;
  List<AttendanceDetail>? attendanceDetails;

  CreateAttendance(
      {this.academicYearId,
      this.schoolId,
      this.boardId,
      this.brandId,
      this.gradeId,
      this.shiftId,
      this.divisionId,
      this.attendanceDate,
      this.attendanceDetails});
}

class AttendanceDetail {
  int? attendanceType;
  int? subjectId;
  int? timetableId;
  int? globalStudentId;
  String? attendanceRemark;

  AttendanceDetail({
    this.attendanceType,
    this.subjectId,
    this.timetableId,
    this.globalStudentId,
    this.attendanceRemark,
  });
}
