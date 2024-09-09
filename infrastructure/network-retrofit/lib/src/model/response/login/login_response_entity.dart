import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response_entity.g.dart';

@JsonSerializable()
class LoginResponseEntity
    implements BaseLayerDataTransformer<LoginResponseEntity, LoginResponse> {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "data")
  LoginResponseDataEntity? data;
  @JsonKey(name: "message")
  String? message;

  LoginResponseEntity({this.status, this.data, this.message});

  factory LoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseEntityToJson(this);

  @override
  LoginResponseEntity restore(LoginResponse data) {
    return LoginResponseEntity(
        data: LoginResponseDataEntity(accessToken: data.data?.accessToken),
        message: data.message,
        status: status);
  }

  @override
  LoginResponse transform() {
    return LoginResponse(
        data: data?.transform(), message: message, status: status);
  }
}

@JsonSerializable()
class LoginResponseDataEntity
    implements
        BaseLayerDataTransformer<LoginResponseDataEntity, LoginResponseData> {
  @JsonKey(name: "access_token")
  String? accessToken;

  LoginResponseDataEntity({this.accessToken});

  factory LoginResponseDataEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDataEntityToJson(this);

  @override
  LoginResponseDataEntity restore(LoginResponseData data) {
    return LoginResponseDataEntity(accessToken: data.accessToken);
  }

  @override
  LoginResponseData transform() {
    return LoginResponseData(accessToken: accessToken);
  }
}
