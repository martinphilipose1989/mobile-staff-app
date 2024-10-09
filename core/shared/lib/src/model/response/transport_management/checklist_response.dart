class CheckListResponse {
  int? status;
  List<CheckListDatum>? data;
  String? message;

  CheckListResponse({
    this.status,
    this.data,
    this.message,
  });
}

class CheckListDatum {
  String? id;
  String? userType;
  DateTime? startDate;
  DateTime? endDate;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserDetails? userDetails;
  bool isVerified;

  CheckListDatum(
      {this.id,
      this.userType,
      this.startDate,
      this.endDate,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.userDetails,
      this.isVerified = false});
}

class UserDetails {
  int? userId;
  String? fullName;
  String? firstName;
  String? middleName;
  String? lastName;
  String? mobile;

  UserDetails(
      {this.userId,
      this.fullName,
      this.firstName,
      this.middleName,
      this.lastName,
      this.mobile});
}
