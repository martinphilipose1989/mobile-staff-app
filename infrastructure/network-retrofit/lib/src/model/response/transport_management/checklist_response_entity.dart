import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'checklist_response_entity.g.dart';

@JsonSerializable()
class CheckListResponseEntity
    implements
        BaseLayerDataTransformer<CheckListResponseEntity, CheckListResponse> {
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

  @override
  CheckListResponseEntity restore(CheckListResponse data) {
    return CheckListResponseEntity(
        data: CheckListResponseDataEntity(
            limit: data.data?.limit,
            page: data.data?.page,
            results:
                data.data?.results?.map((e) => ChecklistEntity()).toList()),
        message: data.message,
        status: data.status);
  }

  @override
  CheckListResponse transform() {
    return CheckListResponse(
        status: status, message: message, data: data?.transform());
  }
}

@JsonSerializable()
class CheckListResponseDataEntity
    implements
        BaseLayerDataTransformer<CheckListResponseDataEntity,
            CheckListResponseData> {
  @JsonKey(name: "results")
  List<ChecklistEntity>? results;
  @JsonKey(name: "total")
  int? total;
  @JsonKey(name: "page")
  String? page;
  @JsonKey(name: "limit")
  String? limit;

  CheckListResponseDataEntity(
      {this.results, this.total, this.page, this.limit});

  factory CheckListResponseDataEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckListResponseDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckListResponseDataEntityToJson(this);

  @override
  CheckListResponseDataEntity restore(CheckListResponseData data) {
    return CheckListResponseDataEntity(
        limit: data.limit,
        page: data.page,
        results: data.results
            ?.map(
              (result) => ChecklistEntity(
                  checkList: result.checkList,
                  createdAt: result.createdAt,
                  description: result.description,
                  icon: result.icon,
                  id: result.id,
                  img: result.img,
                  isActive: result.isActive,
                  parentId: result.parentId,
                  slug: result.slug,
                  status: result.status,
                  updatedAt: result.updatedAt),
            )
            .toList());
  }

  @override
  CheckListResponseData transform() {
    return CheckListResponseData(
        limit: limit,
        page: page,
        results: results?.map((e) => e.transform()).toList());
  }
}

@JsonSerializable()
class ChecklistEntity
    implements BaseLayerDataTransformer<ChecklistEntity, Checklist> {
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
  String? createdAt;
  @JsonKey(name: "updatedAt")
  String? updatedAt;

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

  @override
  ChecklistEntity restore(Checklist data) {
    return ChecklistEntity(
        checkList: data.checkList,
        createdAt: data.createdAt,
        description: data.description,
        icon: data.icon,
        id: data.id,
        img: data.img,
        isActive: data.isActive,
        parentId: data.parentId,
        slug: data.slug,
        status: data.status,
        updatedAt: data.updatedAt);
  }

  @override
  Checklist transform() {
    return Checklist(
        checkList: checkList,
        createdAt: createdAt,
        description: description,
        icon: icon,
        id: id,
        img: img,
        isActive: isActive,
        parentId: parentId,
        slug: slug,
        status: status,
        updatedAt: updatedAt);
  }
}
