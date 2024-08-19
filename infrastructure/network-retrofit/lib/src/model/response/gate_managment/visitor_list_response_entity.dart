import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:network_retrofit/src/model/response/gate_managment/visitor_data_entity.dart';

part 'visitor_list_response_entity.g.dart';

// Function to parse JSON string to VisitorListResponseEntity
VisitorListResponseEntity visitorListResponseEntityFromJson(String str) =>
    VisitorListResponseEntity.fromJson(json.decode(str));

// Function to convert VisitorListResponseEntity to JSON string
String visitorListResponseEntityToJson(VisitorListResponseEntity data) =>
    json.encode(data.toJson());

@JsonSerializable()
class VisitorListResponseEntity
    implements
        BaseLayerDataTransformer<VisitorListResponseEntity,
            VisitorListResponseModel> {
  @JsonKey(name: "status")
  int? status;

  @JsonKey(name: "data")
  VisitorListDataEntity? visitorListData;

  @JsonKey(name: "message")
  String? message;

  VisitorListResponseEntity({this.status, this.visitorListData, this.message});

  factory VisitorListResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$VisitorListResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VisitorListResponseEntityToJson(this);

  @override
  VisitorListResponseEntity restore(VisitorListResponseModel data) {
    return VisitorListResponseEntity(
        message: data.message,
        status: data.status,
        visitorListData: VisitorListDataEntity(
            isNextPage: data.visitorListDataModel?.isNextPage));
  }

  @override
  VisitorListResponseModel transform() {
    return VisitorListResponseModel(
        message: message,
        status: status,
        visitorListDataModel: visitorListData?.transform());
  }
}

@JsonSerializable()
class VisitorListDataEntity
    implements
        BaseLayerDataTransformer<VisitorListDataEntity, VisitorListDataModel> {
  @JsonKey(name: "totalCount")
  int? totalCount;

  @JsonKey(name: "isNextPage")
  bool? isNextPage;

  @JsonKey(name: "data")
  List<VisitorDataEntity>? visitors;

  VisitorListDataEntity({this.totalCount, this.isNextPage, this.visitors});

  factory VisitorListDataEntity.fromJson(Map<String, dynamic> json) =>
      _$VisitorListDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VisitorListDataEntityToJson(this);

  @override
  VisitorListDataEntity restore(VisitorListDataModel data) {
    return VisitorListDataEntity(
        isNextPage: data.isNextPage,
        totalCount: data.totalCount,
        visitors: visitors);
  }

  @override
  VisitorListDataModel transform() {
    return VisitorListDataModel(
        isNextPage: isNextPage,
        totalCount: totalCount,
        visitors: visitors?.map((visitor) => visitor.transform()).toList());
  }
}
