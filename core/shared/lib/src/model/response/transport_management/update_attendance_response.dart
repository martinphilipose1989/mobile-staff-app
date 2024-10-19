class UpdateAttendanceResponse {
  int? status;

  List<List<UpdateAttendance>>? data;

  String? message;

  bool? success;

  UpdateAttendanceResponse(
      {this.status, this.data, this.message, this.success});
}

class UpdateAttendance {
  int? id;

  int? attendanceId;

  int? attendanceType;

  dynamic subjectId;

  dynamic timetableId;

  int? globalStudentId;

  String? attendanceRemark;

  String? createdAt;

  String? updatedAt;

  UpdateAttendance(
      {this.id,
      this.attendanceId,
      this.attendanceType,
      this.subjectId,
      this.timetableId,
      this.globalStudentId,
      this.attendanceRemark,
      this.createdAt,
      this.updatedAt});
}
