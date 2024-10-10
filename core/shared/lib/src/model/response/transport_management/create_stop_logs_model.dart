class CreateStopLogsModel {
  int? status;
  CreateStopLogsData? data;
  String? message;

  CreateStopLogsModel({
    this.status,
    this.data,
    this.message,
  });
}

class CreateStopLogsData {
  int? routeId;
  int? stopId;
  String? stopStatus;
  String? time;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  CreateStopLogsData({
    this.routeId,
    this.stopId,
    this.stopStatus,
    this.time,
    this.id,
    this.createdAt,
    this.updatedAt,
  });
}
