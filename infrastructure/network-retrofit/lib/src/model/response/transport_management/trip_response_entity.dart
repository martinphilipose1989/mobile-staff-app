import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'trip_response_entity.g.dart';

@JsonSerializable()
class TripResponseEntity
    implements BaseLayerDataTransformer<TripResponseEntity, TripResponse> {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "data")
  TripDataEntity? data;
  @JsonKey(name: "message")
  String? message;

  TripResponseEntity({this.status, this.data, this.message});

  factory TripResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$TripResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TripResponseEntityToJson(this);

  @override
  TripResponseEntity restore(TripResponse data) {
    return TripResponseEntity(
        data: TripDataEntity(
            limit: data.data?.limit,
            page: data.data?.page,
            total: data.data?.total,
            tripResult:
                data.data?.tripResult?.map((e) => TripResultEntity()).toList()),
        message: data.message,
        status: data.status);
  }

  @override
  TripResponse transform() {
    return TripResponse();
  }
}

@JsonSerializable()
class TripDataEntity
    implements BaseLayerDataTransformer<TripDataEntity, TripData> {
  @JsonKey(name: "results")
  List<TripResultEntity>? tripResult;
  @JsonKey(name: "total")
  int? total;
  @JsonKey(name: "page")
  String? page;
  @JsonKey(name: "limit")
  String? limit;

  TripDataEntity({this.tripResult, this.total, this.page, this.limit});

  factory TripDataEntity.fromJson(Map<String, dynamic> json) =>
      _$TripDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TripDataEntityToJson(this);

  @override
  TripDataEntity restore(TripData data) {
    return TripDataEntity(
      limit: data.limit,
      page: data.page,
      total: data.total,
      // tripResult: data.tripResult.ma
    );
  }

  @override
  TripData transform() {
    return TripData(
        limit: limit,
        page: page,
        total: total,
        tripResult: tripResult?.map((trip) => trip.transform()).toList());
  }
}

@JsonSerializable()
class TripResultEntity
    implements BaseLayerDataTransformer<TripResultEntity, TripResult> {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "shift_id")
  int? shiftId;
  @JsonKey(name: "working_saturday_id")
  int? workingSaturdayId;
  @JsonKey(name: "route_name")
  String? routeName;
  @JsonKey(name: "bus_type")
  String? busType;
  @JsonKey(name: "bus_capacity")
  int? busCapacity;
  @JsonKey(name: "route_type")
  String? routeType;
  @JsonKey(name: "is_permanent_route")
  bool? isPermanentRoute;
  @JsonKey(name: "start_date")
  String? startDate;
  @JsonKey(name: "end_date")
  String? endDate;
  @JsonKey(name: "school_code")
  String? schoolCode;
  @JsonKey(name: "school_id")
  int? schoolId;
  @JsonKey(name: "route_code")
  String? routeCode;
  @JsonKey(name: "academic_yrs_id")
  int? academicYrsId;
  @JsonKey(name: "isDraft")
  bool? isDraft;
  @JsonKey(name: "createdAt")
  String? createdAt;
  @JsonKey(name: "updatedAt")
  String? updatedAt;
  @JsonKey(name: "routeWorkingDays")
  dynamic routeWorkingDays;
  @JsonKey(name: "routeBusUserMapping")
  List<RouteBusUserMappingEntity>? routeBusUserMappingEntity;
  @JsonKey(name: "routeStopMapping")
  List<RouteStopMappingEntity>? routeStopMapping;

  TripResultEntity({
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
    this.routeBusUserMappingEntity,
    this.routeStopMapping,
  });

  factory TripResultEntity.fromJson(Map<String, dynamic> json) =>
      _$TripResultEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TripResultEntityToJson(this);

  @override
  TripResultEntity restore(TripResult data) {
    return TripResultEntity(
        academicYrsId: data.academicYrsId,
        busCapacity: data.busCapacity,
        busType: data.busType,
        createdAt: data.createdAt,
        endDate: data.endDate,
        id: data.id,
        isDraft: data.isDraft,
        isPermanentRoute: data.isPermanentRoute,
        routeCode: data.routeCode,
        routeName: data.routeName,
        routeType: data.routeType,
        schoolCode: data.schoolCode,
        routeWorkingDays: data.routeWorkingDays,
        schoolId: data.schoolId,
        shiftId: data.shiftId,
        startDate: data.startDate,
        updatedAt: data.updatedAt,
        workingSaturdayId: data.workingSaturdayId,
        routeStopMapping: data.routeStopMapping
            ?.map(
              (e) => RouteStopMappingEntity(
                approxTime: e.approxTime,
                createdAt: e.createdAt,
                id: e.id,
                orderNo: e.orderNo,
                stop: StopEntity(),
                //  updatedAt:
              ),
            )
            .toList());
  }

  @override
  TripResult transform() {
    return TripResult(
        academicYrsId: academicYrsId,
        busCapacity: busCapacity,
        busType: busType,
        createdAt: createdAt,
        endDate: endDate,
        id: id,
        isDraft: isDraft,
        isPermanentRoute: isPermanentRoute,
        routeBusUserMapping:
            routeBusUserMappingEntity?.map((e) => e.transform()).toList(),
        routeStopMapping: routeStopMapping?.map((e) => e.transform()).toList(),
        routeCode: routeCode,
        routeName: routeName,
        routeType: routeType,
        routeWorkingDays: routeWorkingDays,
        schoolCode: schoolCode,
        schoolId: schoolId,
        shiftId: shiftId,
        startDate: startDate,
        updatedAt: updatedAt,
        workingSaturdayId: workingSaturdayId);
  }
}

@JsonSerializable()
class RouteBusUserMappingEntity
    implements
        BaseLayerDataTransformer<RouteBusUserMappingEntity,
            RouteBusUserMapping> {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "user_type")
  String? userType;
  @JsonKey(name: "start_date")
  String? startDate;
  @JsonKey(name: "end_date")
  String? endDate;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "createdAt")
  String? createdAt;
  @JsonKey(name: "updatedAt")
  String? updatedAt;
  @JsonKey(name: "bus")
  BusEntity? bus;

  RouteBusUserMappingEntity(
      {this.id,
      this.userType,
      this.startDate,
      this.endDate,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.bus});

  factory RouteBusUserMappingEntity.fromJson(Map<String, dynamic> json) =>
      _$RouteBusUserMappingEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RouteBusUserMappingEntityToJson(this);

  @override
  RouteBusUserMappingEntity restore(RouteBusUserMapping data) {
    final bus = data.bus;
    return RouteBusUserMappingEntity(
      createdAt: data.createdAt,
      endDate: data.endDate,
      id: data.id,
      startDate: data.startDate,
      userType: data.userType,
      updatedAt: data.updatedAt,
      userId: data.userId,
      bus: BusEntity(
        id: bus?.id,
        busMaxCapacity: bus?.busMaxCapacity,
        busNumber: bus?.busNumber,
        busType: bus?.busType,
        createdAt: bus?.createdAt,
        manualCode: bus?.manualCode,
        updatedAt: bus?.updatedAt,
        wifiIdentification: bus?.wifiIdentification,
        wifiName: bus?.wifiName,
      ),
    );
  }

  @override
  RouteBusUserMapping transform() {
    return RouteBusUserMapping();
  }
}

@JsonSerializable()
class BusEntity implements BaseLayerDataTransformer<BusEntity, Bus> {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "bus_number")
  String? busNumber;
  @JsonKey(name: "wifi_name")
  String? wifiName;
  @JsonKey(name: "wifi_identification")
  String? wifiIdentification;
  @JsonKey(name: "manual_code")
  String? manualCode;
  @JsonKey(name: "bus_type")
  int? busType;
  @JsonKey(name: "bus_max_capacity")
  int? busMaxCapacity;
  @JsonKey(name: "createdAt")
  String? createdAt;
  @JsonKey(name: "updatedAt")
  String? updatedAt;

  BusEntity(
      {this.id,
      this.busNumber,
      this.wifiName,
      this.wifiIdentification,
      this.manualCode,
      this.busType,
      this.busMaxCapacity,
      this.createdAt,
      this.updatedAt});

  factory BusEntity.fromJson(Map<String, dynamic> json) =>
      _$BusEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BusEntityToJson(this);

  @override
  BusEntity restore(Bus data) {
    return BusEntity(
        id: data.id,
        busMaxCapacity: data.busMaxCapacity,
        busNumber: data.busNumber,
        busType: data.busType,
        createdAt: data.createdAt,
        manualCode: data.manualCode,
        updatedAt: data.updatedAt,
        wifiIdentification: data.wifiIdentification,
        wifiName: data.wifiName);
  }

  @override
  Bus transform() {
    return Bus(
        busMaxCapacity: busMaxCapacity,
        busNumber: busNumber,
        busType: busType,
        createdAt: createdAt,
        id: id,
        manualCode: manualCode,
        updatedAt: updatedAt,
        wifiIdentification: wifiIdentification,
        wifiName: wifiName);
  }
}

@JsonSerializable()
class RouteStopMappingEntity
    implements
        BaseLayerDataTransformer<RouteStopMappingEntity, RouteStopMapping> {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "order_no")
  int? orderNo;
  @JsonKey(name: "approx_time")
  String? approxTime;
  @JsonKey(name: "createdAt")
  String? createdAt;
  @JsonKey(name: "updatedAt")
  String? updatedAt;
  @JsonKey(name: "stop")
  StopEntity? stop;

  RouteStopMappingEntity(
      {this.id,
      this.orderNo,
      this.approxTime,
      this.createdAt,
      this.updatedAt,
      this.stop});

  factory RouteStopMappingEntity.fromJson(Map<String, dynamic> json) =>
      _$RouteStopMappingEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RouteStopMappingEntityToJson(this);

  @override
  RouteStopMappingEntity restore(RouteStopMapping data) {
    final stop = data.stop;
    return RouteStopMappingEntity(
      approxTime: data.approxTime,
      createdAt: data.createdAt,
      id: data.id,
      orderNo: data.orderNo,
      stop: StopEntity(
        academicYrsId: stop?.academicYrsId,
        createdAt: stop?.createdAt,
        distanceKm: stop?.distanceKm,
        endDate: stop?.endDate,
        id: stop?.id,
        isDraft: stop?.isDraft,
        lat: stop?.lat,
        long: stop?.long,
        orderBy: stop?.orderBy,
        relatedStopId: stop?.relatedStopId,
        schoolId: stop?.schoolId,
        startDate: stop?.startDate,
        stopMapName: stop?.stopMapName,
        stopName: stop?.stopName,
        updatedAt: stop?.updatedAt,
        zoneName: stop?.zoneName,
      ),
      updatedAt: data.updatedAt,
    );
  }

  @override
  RouteStopMapping transform() {
    return RouteStopMapping(
        id: id,
        approxTime: approxTime,
        createdAt: createdAt,
        orderNo: orderNo,
        stop: stop?.transform(),
        updatedAt: updatedAt);
  }
}

@JsonSerializable()
class StopEntity implements BaseLayerDataTransformer<StopEntity, Stop> {
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
  dynamic relatedStopId;
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
  dynamic academicYrsId;
  @JsonKey(name: "isDraft")
  bool? isDraft;
  @JsonKey(name: "createdAt")
  String? createdAt;
  @JsonKey(name: "updatedAt")
  String? updatedAt;

  StopEntity({
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
  });

  factory StopEntity.fromJson(Map<String, dynamic> json) =>
      _$StopEntityFromJson(json);

  Map<String, dynamic> toJson() => _$StopEntityToJson(this);

  @override
  StopEntity restore(Stop data) {
    return StopEntity(
        id: data.id,
        distanceKm: data.distanceKm,
        academicYrsId: data.academicYrsId,
        isDraft: data.isDraft,
        createdAt: data.createdAt,
        endDate: data.endDate,
        lat: data.lat,
        long: data.long,
        orderBy: data.orderBy,
        relatedStopId: data.relatedStopId,
        schoolId: data.schoolId,
        startDate: data.startDate,
        stopMapName: data.stopMapName,
        stopName: data.stopName,
        updatedAt: data.updatedAt,
        zoneName: data.zoneName);
  }

  @override
  Stop transform() {
    return Stop(
        academicYrsId: academicYrsId,
        createdAt: createdAt,
        distanceKm: distanceKm,
        endDate: endDate,
        id: id,
        isDraft: isDraft,
        lat: lat,
        long: long,
        orderBy: orderBy,
        relatedStopId: relatedStopId,
        schoolId: schoolId,
        startDate: startDate,
        stopMapName: stopMapName,
        stopName: stopName,
        updatedAt: updatedAt,
        zoneName: zoneName);
  }
}
