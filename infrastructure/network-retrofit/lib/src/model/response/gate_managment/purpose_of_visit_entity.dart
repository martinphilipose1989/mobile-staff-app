import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'purpose_of_visit_entity.g.dart';

@JsonSerializable()
class PurposeOfVisitEntity
    implements
        BaseLayerDataTransformer<PurposeOfVisitEntity, PurposeOfVisitModel> {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "data")
  List<PurposeOfVisitDataEntity>? data;
  @JsonKey(name: "message")
  String? message;

  PurposeOfVisitEntity({this.status, this.data, this.message});

  factory PurposeOfVisitEntity.fromJson(Map<String, dynamic> json) =>
      _$PurposeOfVisitEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PurposeOfVisitEntityToJson(this);

  @override
  PurposeOfVisitEntity restore(PurposeOfVisitModel data) {
    return PurposeOfVisitEntity();
  }

  @override
  PurposeOfVisitModel transform() {
    return PurposeOfVisitModel(
        status: status,
        message: message,
        data: data?.map((e) => e.transform()).toList());
  }
}

@JsonSerializable()
class PurposeOfVisitDataEntity
    implements
        BaseLayerDataTransformer<PurposeOfVisitDataEntity,
            PurposeOfVisitDataModel> {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "name")
  String? name;

  PurposeOfVisitDataEntity({this.id, this.name});

  factory PurposeOfVisitDataEntity.fromJson(Map<String, dynamic> json) =>
      _$PurposeOfVisitDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PurposeOfVisitDataEntityToJson(this);

  @override
  PurposeOfVisitDataEntity restore(PurposeOfVisitDataModel data) {
    return PurposeOfVisitDataEntity(id: data.id, name: data.name);
  }

  @override
  PurposeOfVisitDataModel transform() {
    return PurposeOfVisitDataModel(id: id, name: name);
  }
}
