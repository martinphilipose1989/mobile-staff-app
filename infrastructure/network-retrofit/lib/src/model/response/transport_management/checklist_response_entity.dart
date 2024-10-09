import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'checklist_response_entity.g.dart';

@JsonSerializable()
class CheckListEntity
    extends BaseLayerDataTransformer<CheckListEntity, CheckListResponse> {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "data")
  List<CheckListDatumEntity>? data;
  @JsonKey(name: "message")
  String? message;

  CheckListEntity({
    this.status,
    this.data,
    this.message,
  });

  factory CheckListEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckListEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckListEntityToJson(this);

  @override
  CheckListResponse transform() {
    // TODO: implement transform
    return CheckListResponse(
        status: status,
        data: data
            ?.map(
              (e) => e.transform(),
            )
            .toList(),
        message: message);
  }
}

@JsonSerializable()
class CheckListDatumEntity
    extends BaseLayerDataTransformer<CheckListDatumEntity, CheckListDatum> {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "user_type")
  String? userType;
  @JsonKey(name: "start_date")
  DateTime? startDate;
  @JsonKey(name: "end_date")
  DateTime? endDate;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "user_details")
  UserDetailsEntity? userDetails;

  CheckListDatumEntity({
    this.id,
    this.userType,
    this.startDate,
    this.endDate,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.userDetails,
  });

  factory CheckListDatumEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckListDatumEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckListDatumEntityToJson(this);

  @override
  CheckListDatum transform() {
    // TODO: implement transform
    return CheckListDatum(
        createdAt: createdAt,
        endDate: endDate,
        id: id,
        startDate: startDate,
        updatedAt: updatedAt,
        userDetails: userDetails?.transform(),
        userId: userId,
        userType: userType);
  }
}

@JsonSerializable()
class UserDetailsEntity
    extends BaseLayerDataTransformer<UserDetailsEntity, UserDetails> {
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

  UserDetailsEntity(
      {this.userId,
      this.fullName,
      this.firstName,
      this.middleName,
      this.lastName,
      this.mobile});

  factory UserDetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailsEntityToJson(this);

  @override
  UserDetails transform() {
    // TODO: implement transform
    return UserDetails(
        firstName: firstName,
        fullName: fullName,
        lastName: lastName,
        middleName: middleName,
        userId: userId,
        mobile: mobile);
  }
}
