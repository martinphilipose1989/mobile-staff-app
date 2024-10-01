class BusStopResponseEntity {
  int? status;

  BusStopDataEntity? data;

  String? message;

  BusStopResponseEntity({this.status, this.data, this.message});
}

class BusStopDataEntity {
  List<BusStopResultEntity>? results;

  int? total;

  String? page;

  String? limit;

  BusStopDataEntity({
    this.results,
    this.total,
    this.page,
    this.limit,
  });
}

class BusStopResultEntity {
  int? id;

  String? stopName;

  String? stopMapName;

  String? lat;

  String? long;

  int? relatedStopId;

  String? startDate;

  String? endDate;

  int? orderBy;

  int? distanceKm;

  String? zoneName;

  int? schoolId;

  int? academicYrsId;

  bool? isDraft;

  String? createdAt;

  String? updatedAt;

  dynamic routeStopMapping;

  BusStopResultEntity({
    this.id,
    this.stopName,
    this.stopMapName,
    this.lat,
    this.long,
    this.relatedStopId,
    this.startDate,
    this.endDate,
    this.orderBy,
    this.distanceKm,
    this.zoneName,
    this.schoolId,
    this.academicYrsId,
    this.isDraft,
    this.createdAt,
    this.updatedAt,
    this.routeStopMapping,
  });
}
