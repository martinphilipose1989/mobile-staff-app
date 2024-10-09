import 'route_stop_mapping_response.dart';

class TripResponse {
  int? status;

  TripData? data;

  String? message;

  TripResponse({this.status, this.data, this.message});
}

class TripData {
  List<TripResult>? tripResult;

  int? total;

  String? page;

  String? limit;

  TripData({this.tripResult, this.total, this.page, this.limit});
}

class TripResult {
  String? id;

  int? shiftId;

  int? workingSaturdayId;

  String? routeName;

  String? busType;

  int? busCapacity;

  String? routeType;

  bool? isPermanentRoute;

  String? startDate;

  String? endDate;

  String? schoolCode;

  int? schoolId;

  String? routeCode;

  int? academicYrsId;

  bool? isDraft;

  String? createdAt;

  String? updatedAt;

  dynamic routeWorkingDays;

  List<RouteBusUserMapping>? routeBusUserMapping;

  List<RouteStopMapping>? routeStopMapping;

  TripResult({
    this.id,
    this.shiftId,
    this.workingSaturdayId,
    this.routeName,
    this.busType,
    this.busCapacity,
    this.routeType,
    this.isPermanentRoute,
    this.startDate,
    this.endDate,
    this.schoolCode,
    this.schoolId,
    this.routeCode,
    this.academicYrsId,
    this.isDraft,
    this.createdAt,
    this.updatedAt,
    this.routeWorkingDays,
    this.routeBusUserMapping,
    this.routeStopMapping,
  });
}

class RouteBusUserMapping {
  String? id;

  String? userType;

  String? startDate;

  String? endDate;

  int? userId;

  String? createdAt;

  String? updatedAt;

  Bus? bus;

  RouteBusUserMapping(
      {this.id,
      this.userType,
      this.startDate,
      this.endDate,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.bus});
}

class Bus {
  String? id;

  String? busNumber;

  String? wifiName;

  String? wifiIdentification;

  String? manualCode;

  int? busType;

  int? busMaxCapacity;

  String? createdAt;

  String? updatedAt;

  Bus({
    this.id,
    this.busNumber,
    this.wifiName,
    this.wifiIdentification,
    this.manualCode,
    this.busType,
    this.busMaxCapacity,
    this.createdAt,
    this.updatedAt,
  });
}
