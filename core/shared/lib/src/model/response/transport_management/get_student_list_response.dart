class GetStudentList {
  int? status;
  List<Student>? data;
  String? message;

  GetStudentList({this.status, this.data, this.message});
}

class Student {
  String? id;
  int? studentId;
  int? stopId;
  int? routeId;
  String? startDate;
  String? endDate;
  String? feesId;
  String? feesStatus;
  String? createdAt;
  String? updatedAt;
  bool isOpen;
  StudentDetails? studentDetails;
  List<IntimationDetails>? intimationList;
  List<AttendanceLogDetailsResponse>? attendanceList;

  Student(
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
      this.intimationList,
      this.attendanceList,
      this.isOpen = true});
}

class StudentDetails {
  String? firstName;
  String? middleName;
  String? lastName;
  String? profileImage;
  String? crtEnrOn;
  int? crtSchoolId;
  int? crtBoardId;
  int? crtBrandId;
  int? crtGradeId;
  int? crtShiftId;

  StudentDetails(
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
}

class IntimationDetails {
  int? id;
  int? globalUserId;
  int? globalStudentId;
  String? fromDate;
  String? toDate;
  int? intimationStatus;
  int? initimationType;
  String? intimationNote;

  IntimationDetails(
      {this.id,
      this.globalUserId,
      this.globalStudentId,
      this.fromDate,
      this.toDate,
      this.intimationStatus,
      this.initimationType,
      this.intimationNote});
}

class AttendanceLogDetailsResponse {
  int? id;
  int? attendanceId;
  dynamic attendanceType;
  dynamic subjectId;
  dynamic timetableId;
  int? globalStudentId;
  String? attendanceRemark;
  dynamic startTime;
  dynamic endTime;
  dynamic subjectName;
  String? firstName;
  dynamic middleName;
  String? lastName;
  String? enrOn;

  AttendanceLogDetailsResponse({
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
}
