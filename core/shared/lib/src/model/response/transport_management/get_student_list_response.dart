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
  StudentDetails? studentDetails;

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
      this.studentDetails});
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
