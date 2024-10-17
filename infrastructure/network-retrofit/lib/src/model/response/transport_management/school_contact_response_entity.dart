import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'school_contact_response_entity.g.dart';

@JsonSerializable()
class GetSchoolContactResponseEntity
    implements
        BaseLayerDataTransformer<GetSchoolContactResponseEntity,
            GetSchoolContactResponse> {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "data")
  List<dynamic>? data;
  @JsonKey(name: "message")
  String? message;

  GetSchoolContactResponseEntity({this.status, this.data, this.message});

  factory GetSchoolContactResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetSchoolContactResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetSchoolContactResponseEntityToJson(this);

  @override
  GetSchoolContactResponseEntity restore(GetSchoolContactResponse data) {
    return GetSchoolContactResponseEntity(
        data: data.data, message: message, status: status);
  }

  @override
  GetSchoolContactResponse transform() {
    return GetSchoolContactResponse();
  }
}
