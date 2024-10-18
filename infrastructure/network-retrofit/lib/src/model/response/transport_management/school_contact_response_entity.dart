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
  List<SchoolResponseEntity>? data;
  @JsonKey(name: "message")
  String? message;

  GetSchoolContactResponseEntity({this.status, this.data, this.message});

  factory GetSchoolContactResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetSchoolContactResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetSchoolContactResponseEntityToJson(this);

  @override
  GetSchoolContactResponseEntity restore(GetSchoolContactResponse data) {
    return GetSchoolContactResponseEntity();
  }

  @override
  GetSchoolContactResponse transform() {
    return GetSchoolContactResponse(
        message: message,
        status: status,
        data: data?.map((e) => e.transform()).toList());
  }
}

@JsonSerializable()
class SchoolResponseEntity
    implements BaseLayerDataTransformer<SchoolResponseEntity, SchoolResponse> {
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "full_name")
  String? fullName;
  @JsonKey(name: "first_name")
  String? firstName;
  @JsonKey(name: "middle_name")
  String? middleName;
  @JsonKey(name: "last_name")
  String? lastName;
  @JsonKey(name: "mobile")
  String? mobile;

  SchoolResponseEntity({
    this.userId,
    this.fullName,
    this.firstName,
    this.middleName,
    this.lastName,
    this.mobile,
  });

  factory SchoolResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$SchoolResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolResponseEntityToJson(this);

  @override
  SchoolResponseEntity restore(SchoolResponse data) {
    return SchoolResponseEntity();
  }

  @override
  SchoolResponse transform() {
    return SchoolResponse(
        firstName: firstName,
        lastName: lastName,
        fullName: fullName,
        middleName: middleName,
        mobile: mobile,
        userId: userId);
  }
}
