import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visitor_populate_response_entity.g.dart';

@JsonSerializable()
class VisitorPopulateResponseEntity
    implements
        BaseLayerDataTransformer<VisitorPopulateResponseEntity,
            VisitorPopulateResponseModel> {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "data")
  VisitorPopulateDataEntity? data;
  @JsonKey(name: "message")
  String? message;

  VisitorPopulateResponseEntity({
    this.status,
    this.data,
    this.message,
  });

  factory VisitorPopulateResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$VisitorPopulateResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VisitorPopulateResponseEntityToJson(this);

  @override
  VisitorPopulateResponseEntity restore(VisitorPopulateResponseModel data) {
    return VisitorPopulateResponseEntity();
  }

  @override
  VisitorPopulateResponseModel transform() {
    return VisitorPopulateResponseModel(
        data: data?.transform(), message: message, status: status);
  }
}

@JsonSerializable()
class VisitorPopulateDataEntity
    implements
        BaseLayerDataTransformer<VisitorPopulateDataEntity,
            VisitorPopulateDataModel> {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "visitor_id")
  String? visitorId;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "mobile")
  String? mobile;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "global_id")
  String? globalId;
  @JsonKey(name: "profile_image")
  String? profileImage;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "__v")
  int? v;
  @JsonKey(name: "profile_image_url")
  String? profileImageUrl;

  VisitorPopulateDataEntity(
      {this.id,
      this.visitorId,
      this.name,
      this.mobile,
      this.email,
      this.globalId,
      this.profileImage,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.profileImageUrl});

  factory VisitorPopulateDataEntity.fromJson(Map<String, dynamic> json) =>
      _$VisitorPopulateDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VisitorPopulateDataEntityToJson(this);

  @override
  VisitorPopulateDataEntity restore(VisitorPopulateDataModel data) {
    return VisitorPopulateDataEntity();
  }

  @override
  VisitorPopulateDataModel transform() {
    return VisitorPopulateDataModel(
        id: id,
        email: email,
        mobile: mobile,
        createdAt: createdAt,
        updatedAt: updatedAt,
        globalId: globalId,
        name: name,
        profileImage: profileImage,
        profileImageUrl: profileImageUrl,
        v: v,
        visitorId: visitorId);
  }
}
