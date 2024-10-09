import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:network_retrofit/src/model/response/transport_management/route_stop_mapping_entity.dart';
import 'package:network_retrofit/src/model/response/transport_management/stop_entity.dart';

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
    return TripResponse(
        data: data?.transform(), message: message, status: status);
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
