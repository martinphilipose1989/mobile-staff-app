import 'package:json_annotation/json_annotation.dart';

part 'get_checklist_confirmation_request.g.dart';

@JsonSerializable()
class GetChecklistConfirmationRequest {
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "user_type")
  int? userType;
  @JsonKey(name: "route_id")
  int? routeId;

  GetChecklistConfirmationRequest({
    this.userId,
    this.userType,
    this.routeId,
  });

  factory GetChecklistConfirmationRequest.fromJson(Map<String, dynamic> json) =>
      _$GetChecklistConfirmationRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetChecklistConfirmationRequestToJson(this);
}
