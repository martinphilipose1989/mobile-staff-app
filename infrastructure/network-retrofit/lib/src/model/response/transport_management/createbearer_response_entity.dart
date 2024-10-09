import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'createbearer_response_entity.g.dart';

@JsonSerializable()
class CreateBearerResponseEntity
    implements
        BaseLayerDataTransformer<CreateBearerResponseEntity,
            CreateBearerResponse> {
  final int? id;
  final CreateBearerAttributesEntity? attributes;

  CreateBearerResponseEntity({this.id, this.attributes});

  factory CreateBearerResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateBearerResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBearerResponseEntityToJson(this);

  @override
  CreateBearerResponseEntity restore(CreateBearerResponse data) {
    return CreateBearerResponseEntity();
  }

  @override
  CreateBearerResponse transform() {
    return CreateBearerResponse(attributes: attributes?.transform(), id: id);
  }
}

@JsonSerializable()
class CreateBearerAttributesEntity
    implements
        BaseLayerDataTransformer<CreateBearerAttributesEntity,
            CreateBearerAttributes> {
  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'last_name')
  final String? lastName;

  @JsonKey(name: 'profile_image')
  final String? profileImage;

  CreateBearerAttributesEntity(
      {this.firstName, this.lastName, this.profileImage});

  factory CreateBearerAttributesEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateBearerAttributesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateBearerAttributesEntityToJson(this);

  @override
  CreateBearerAttributesEntity restore(CreateBearerAttributes data) {
    return CreateBearerAttributesEntity();
  }

  @override
  CreateBearerAttributes transform() {
    return CreateBearerAttributes(
        firstName: firstName, lastName: lastName, profileImage: profileImage);
  }
}
