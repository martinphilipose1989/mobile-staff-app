import 'package:json_annotation/json_annotation.dart';

part 'bus_route_response_entity.g.dart';

@JsonSerializable()
class BusStopResponseEntity {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "data")
  BusStopDataEntity? data;
  @JsonKey(name: "message")
  String? message;

  BusStopResponseEntity({this.status, this.data, this.message});

  factory BusStopResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$BusStopResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BusStopResponseEntityToJson(this);
}

@JsonSerializable()
class BusStopDataEntity {
  @JsonKey(name: "results")
  List<BusStopResultEntity>? results;
  @JsonKey(name: "total")
  int? total;
  @JsonKey(name: "page")
  String? page;
  @JsonKey(name: "limit")
  String? limit;

  BusStopDataEntity({
    this.results,
    this.total,
    this.page,
    this.limit,
  });

  factory BusStopDataEntity.fromJson(Map<String, dynamic> json) =>
      _$BusStopDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BusStopDataEntityToJson(this);
}

@JsonSerializable()
class BusStopResultEntity {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "stop_name")
  String? stopName;
  @JsonKey(name: "stop_map_name")
  String? stopMapName;
  @JsonKey(name: "lat")
  String? lat;
  @JsonKey(name: "long")
  String? long;
  @JsonKey(name: "related_stop_id")
  int? relatedStopId;
  @JsonKey(name: "start_date")
  String? startDate;
  @JsonKey(name: "end_date")
  String? endDate;
  @JsonKey(name: "order_by")
  int? orderBy;
  @JsonKey(name: "distance_km")
  int? distanceKm;
  @JsonKey(name: "zone_name")
  String? zoneName;
  @JsonKey(name: "school_id")
  int? schoolId;
  @JsonKey(name: "academic_yrs_id")
  int? academicYrsId;
  @JsonKey(name: "isDraft")
  bool? isDraft;
  @JsonKey(name: "createdAt")
  String? createdAt;
  @JsonKey(name: "updatedAt")
  String? updatedAt;
  @JsonKey(name: "routeStopMapping")
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

  factory BusStopResultEntity.fromJson(Map<String, dynamic> json) =>
      _$BusStopResultEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BusStopResultEntityToJson(this);
}
