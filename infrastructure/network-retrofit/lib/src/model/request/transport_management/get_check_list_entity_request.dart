import 'package:json_annotation/json_annotation.dart';

part 'get_check_list_entity_request.g.dart';

@JsonSerializable()
class GetCheckListEntityRequest {
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "route_id")
  int? routeId;
  @JsonKey(name: "bus_id")
  int? busId;

  GetCheckListEntityRequest({
    this.userId,
    this.routeId,
    this.busId,
  });

  factory GetCheckListEntityRequest.fromJson(Map<String, dynamic> json) =>
      _$GetCheckListEntityRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetCheckListEntityRequestToJson(this);
}
