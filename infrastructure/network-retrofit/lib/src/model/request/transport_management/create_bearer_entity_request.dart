import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_bearer_entity_request.g.dart';

@JsonSerializable()
class CreateBearerRequestEntity
    implements
        BaseLayerDataTransformer<CreateBearerRequestEntity,
            CreateBearerRequest> {
  @JsonKey(name: "data")
  CreateBearerDataEntity? data;

  CreateBearerRequestEntity({this.data});

  factory CreateBearerRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateBearerRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBearerRequestEntityToJson(this);

  @override
  CreateBearerRequestEntity restore(CreateBearerRequest data) {
    return CreateBearerRequestEntity();
  }

  @override
  CreateBearerRequest transform() {
    return CreateBearerRequest(data: data?.transform());
  }
}

@JsonSerializable()
class CreateBearerDataEntity
    implements
        BaseLayerDataTransformer<CreateBearerDataEntity, CreateBearerData> {
  @JsonKey(name: "first_name")
  String? firstName;
  @JsonKey(name: "last_name")
  String? lastName;
  @JsonKey(name: "profile_image")
  String? profileImage;

  CreateBearerDataEntity({this.firstName, this.lastName, this.profileImage});

  factory CreateBearerDataEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateBearerDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBearerDataEntityToJson(this);

  @override
  CreateBearerDataEntity restore(CreateBearerData data) {
    return CreateBearerDataEntity();
  }

  @override
  CreateBearerData transform() {
    return CreateBearerData(
        firstName: firstName, lastName: lastName, profileImage: profileImage);
  }
}
