import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parent_gatepass_entity.g.dart';

@JsonSerializable()
class ParentGatePassRequestEntity
    implements
        BaseLayerDataTransformer<ParentGatePassRequestEntity,
            ParentGatePassRequestModel> {
  @JsonKey(name: "company_name")
  String? companyName;
  @JsonKey(name: "visitor_type_id")
  int? visitorTypeId;
  @JsonKey(name: "point_of_contact")
  String? pointOfContact;
  @JsonKey(name: "other_point_of_contact")
  String? otherPointOfContact;
  @JsonKey(name: "purpose_of_visit_id")
  int? purposeOfVisitId;
  @JsonKey(name: "coming_from")
  String? comingFrom;
  @JsonKey(name: "guest_count")
  String? guestCount;

  ParentGatePassRequestEntity(
      {this.companyName,
      this.visitorTypeId,
      this.pointOfContact,
      this.otherPointOfContact,
      this.purposeOfVisitId,
      this.comingFrom,
      this.guestCount});

  factory ParentGatePassRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$ParentGatePassRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ParentGatePassRequestEntityToJson(this);

  @override
  ParentGatePassRequestEntity restore(ParentGatePassRequestModel data) {
    return ParentGatePassRequestEntity();
  }

  @override
  ParentGatePassRequestModel transform() {
    return ParentGatePassRequestModel(
        visitorTypeId: visitorTypeId,
        comingFrom: comingFrom,
        companyName: companyName,
        guestCount: guestCount,
        otherPointOfContact: otherPointOfContact,
        pointOfContact: pointOfContact,
        purposeOfVisitId: purposeOfVisitId);
  }
}
