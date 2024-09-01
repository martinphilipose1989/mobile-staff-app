import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:network_retrofit/src/model/response/gate_managment/visitor_data_entity.dart';

part 'parent_gatepass_response_entity.g.dart';

@JsonSerializable()
class ParentGatepassResponseEntity
    implements
        BaseLayerDataTransformer<ParentGatepassResponseEntity,
            ParentGatepassResponseModel> {
  @JsonKey(name: "status")
  int? status;

  @JsonKey(name: "data")
  ParentGatepassResponseDataEntity? data;

  ParentGatepassResponseEntity({this.status, this.data});

  factory ParentGatepassResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ParentGatepassResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ParentGatepassResponseEntityToJson(this);

  @override
  ParentGatepassResponseEntity restore(ParentGatepassResponseModel data) {
    return ParentGatepassResponseEntity();
  }

  @override
  ParentGatepassResponseModel transform() {
    return ParentGatepassResponseModel(data: data?.transform(), status: status);
  }
}

@JsonSerializable()
class ParentGatepassResponseDataEntity
    implements
        BaseLayerDataTransformer<ParentGatepassResponseDataEntity,
            ParentGatepassResponseDataModel> {
  @JsonKey(name: "signedIn")
  bool? signedIn;

  @JsonKey(name: "signedOut")
  bool? signedOut;

  @JsonKey(name: "gatepassDetails")
  VisitorDataEntity? visitorData;

  ParentGatepassResponseDataEntity(
      {this.visitorData, this.signedIn, this.signedOut});

  factory ParentGatepassResponseDataEntity.fromJson(
          Map<String, dynamic> json) =>
      _$ParentGatepassResponseDataEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ParentGatepassResponseDataEntityToJson(this);

  @override
  ParentGatepassResponseDataEntity restore(
      ParentGatepassResponseDataModel data) {
    return ParentGatepassResponseDataEntity(
        signedIn: data.signedIn,
        signedOut: data.signedOut,
        visitorData: VisitorDataEntity());
  }

  @override
  ParentGatepassResponseDataModel transform() {
    return ParentGatepassResponseDataModel(
        signedIn: signedIn,
        signedOut: signedOut,
        visitorDataModel: visitorData?.transform());
  }
}
