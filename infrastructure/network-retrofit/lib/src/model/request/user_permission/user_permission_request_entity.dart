import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_permission_request_entity.g.dart';

@JsonSerializable()
class UserPermissionEntityRequest
    implements
        BaseLayerDataTransformer<UserPermissionEntityRequest,
            UserPermissionRequest> {
  @JsonKey(name: "user_email")
  String? userEmail;
  @JsonKey(name: "application_id")
  int? applicationId;
  @JsonKey(name: "service")
  String? service;

  UserPermissionEntityRequest({
    this.userEmail,
    this.applicationId,
    this.service,
  });

  factory UserPermissionEntityRequest.fromJson(Map<String, dynamic> json) =>
      _$UserPermissionEntityRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserPermissionEntityRequestToJson(this);

  @override
  UserPermissionEntityRequest restore(UserPermissionRequest data) {
    return UserPermissionEntityRequest(
        applicationId: data.applicationId,
        service: data.service,
        userEmail: data.userEmail);
  }

  @override
  UserPermissionRequest transform() {
    return UserPermissionRequest(
        applicationId: applicationId, service: service, userEmail: userEmail);
  }
}
