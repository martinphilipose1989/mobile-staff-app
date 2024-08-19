import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visitor_type_entity.g.dart';

@JsonSerializable()
class TypeOfVisitorEntity
    implements
        BaseLayerDataTransformer<TypeOfVisitorEntity,
            TypeOfVisitorResponseModel> {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "data")
  List<TypeOfVisitorDataEntity>? data;
  @JsonKey(name: "message")
  String? message;

  TypeOfVisitorEntity({this.status, this.data, this.message});

  factory TypeOfVisitorEntity.fromJson(Map<String, dynamic> json) =>
      _$TypeOfVisitorEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TypeOfVisitorEntityToJson(this);

  @override
  TypeOfVisitorEntity restore(TypeOfVisitorResponseModel data) {
    return TypeOfVisitorEntity(
        status: data.status,
        message: data.message,
        data: data.data
            ?.map((e) => TypeOfVisitorDataEntity(id: e.id, name: e.name))
            .toList());
  }

  @override
  TypeOfVisitorResponseModel transform() {
    return TypeOfVisitorResponseModel(
        status: status,
        message: message,
        data: data?.map((e) => e.transform()).toList());
  }
}

@JsonSerializable()
class TypeOfVisitorDataEntity
    implements
        BaseLayerDataTransformer<TypeOfVisitorDataEntity,
            TypeOfVisitorDataModel> {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "name")
  String? name;

  TypeOfVisitorDataEntity({this.id, this.name});

  factory TypeOfVisitorDataEntity.fromJson(Map<String, dynamic> json) =>
      _$TypeOfVisitorDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TypeOfVisitorDataEntityToJson(this);

  @override
  TypeOfVisitorDataEntity restore(TypeOfVisitorDataModel data) {
    return TypeOfVisitorDataEntity(id: data.id, name: data.name);
  }

  @override
  TypeOfVisitorDataModel transform() {
    return TypeOfVisitorDataModel(id: id, name: name);
  }
}
