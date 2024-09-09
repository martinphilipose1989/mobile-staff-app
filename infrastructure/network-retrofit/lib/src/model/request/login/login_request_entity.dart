import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_request_entity.g.dart';

@JsonSerializable()
class LoginRequestEntity
    implements BaseLayerDataTransformer<LoginRequestEntity, LoginRequest> {
  @JsonKey(name: "username")
  String? username;
  @JsonKey(name: "password")
  String? password;

  LoginRequestEntity({this.username, this.password});

  factory LoginRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestEntityToJson(this);

  @override
  LoginRequestEntity restore(LoginRequest data) {
    return LoginRequestEntity(password: data.password, username: data.username);
  }

  @override
  LoginRequest transform() {
    return LoginRequest(password: password, username: username);
  }
}
