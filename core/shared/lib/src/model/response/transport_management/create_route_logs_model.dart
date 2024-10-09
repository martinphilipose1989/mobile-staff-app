class CreateRouteLogsModel {
  int? status;
  CreateRouteLogsData? data;
  String? message;

  CreateRouteLogsModel({
    this.status,
    this.data,
    this.message,
  });
}

class CreateRouteLogsData {
  int? routeId;
  int? driverId;
  int? didId;
  int? teacherId;
  String? routeStatus;
  DateTime? startDate;
  DateTime? endDate;
  dynamic userType;
  String? id;
  bool? driverConfirmed;
  bool? teacherConfirmed;
  bool? didConfirmed;
  DateTime? createdAt;
  DateTime? updatedAt;

  CreateRouteLogsData({
    this.routeId,
    this.driverId,
    this.didId,
    this.teacherId,
    this.routeStatus,
    this.startDate,
    this.endDate,
    this.userType,
    this.id,
    this.driverConfirmed,
    this.teacherConfirmed,
    this.didConfirmed,
    this.createdAt,
    this.updatedAt,
  });
}
