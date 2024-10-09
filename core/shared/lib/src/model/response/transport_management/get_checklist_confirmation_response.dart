class GetChecklistConfirmationModel {
  int? status;
  GetChecklistConfirmationData? data;
  String? message;

  GetChecklistConfirmationModel({
    this.status,
    this.data,
    this.message,
  });
}

class GetChecklistConfirmationData {
  String? id;
  int? routeId;
  int? driverId;
  int? didId;
  int? teacherId;
  String? routeStatus;
  DateTime? startDate;
  DateTime? endDate;
  String? userType;
  bool? driverConfirmed;
  bool? teacherConfirmed;
  bool? didConfirmed;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? message;

  GetChecklistConfirmationData({
    this.id,
    this.routeId,
    this.driverId,
    this.didId,
    this.teacherId,
    this.routeStatus,
    this.startDate,
    this.endDate,
    this.userType,
    this.driverConfirmed,
    this.teacherConfirmed,
    this.didConfirmed,
    this.createdAt,
    this.updatedAt,
    this.message,
  });
}
