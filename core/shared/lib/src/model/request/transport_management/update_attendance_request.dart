class UpdateAttendanceRequest {
  List<AttendanceUpdate>? attendanceUpdates;

  UpdateAttendanceRequest({this.attendanceUpdates});
}

class AttendanceUpdate {
  List<int>? studentId;

  List<String>? attendanceDate;

  int? attendanceType;

  String? attendanceRemark;

  AttendanceUpdate(
      {this.studentId,
      this.attendanceDate,
      this.attendanceType,
      this.attendanceRemark});
}
