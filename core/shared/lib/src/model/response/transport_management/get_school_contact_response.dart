class GetSchoolContactResponse {
  int? status;

  List<SchoolResponse>? data;

  String? message;

  GetSchoolContactResponse({this.status, this.data, this.message});
}

class SchoolResponse {
  int? userId;

  String? fullName;

  String? firstName;

  String? middleName;

  String? lastName;

  String? mobile;

  SchoolResponse(
      {this.userId,
      this.fullName,
      this.firstName,
      this.middleName,
      this.lastName,
      this.mobile});
}
