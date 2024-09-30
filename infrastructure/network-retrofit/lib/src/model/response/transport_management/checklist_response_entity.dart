import 'package:json_annotation/json_annotation.dart';

part 'checklist_response_entity.g.dart';

@JsonSerializable()
class CheckListResponseEntity {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "data")
  CheckListResponseDataEntity? data;
  @JsonKey(name: "message")
  String? message;

  CheckListResponseEntity({this.status, this.data, this.message});

  factory CheckListResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckListResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckListResponseEntityToJson(this);
}

@JsonSerializable()
class CheckListResponseDataEntity {
  @JsonKey(name: "results")
  List<ChecklistEntity>? results;
  @JsonKey(name: "total")
  int? total;
  @JsonKey(name: "page")
  String? page;
  @JsonKey(name: "limit")
  String? limit;

  CheckListResponseDataEntity({
    this.results,
    this.total,
    this.page,
    this.limit,
  });

  factory CheckListResponseDataEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckListResponseDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckListResponseDataEntityToJson(this);
}

@JsonSerializable()
class ChecklistEntity {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "slug")
  String? slug;
  @JsonKey(name: "check_list")
  String? checkList;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "icon")
  String? icon;
  @JsonKey(name: "img")
  String? img;
  @JsonKey(name: "parent_id")
  int? parentId;
  @JsonKey(name: "isActive")
  bool? isActive;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;

  ChecklistEntity({
    this.id,
    this.slug,
    this.checkList,
    this.description,
    this.icon,
    this.img,
    this.parentId,
    this.isActive,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ChecklistEntity.fromJson(Map<String, dynamic> json) =>
      _$ChecklistEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ChecklistEntityToJson(this);
}
