// To parse this JSON data, do
//
//     final CreateGatePassRequestEntity = CreateGatePassResponseEntityFromJson(jsonString);

import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'create_gatepass_entity.g.dart';

CreateGatePassRequestEntity createGatePassRequestEntityFromJson(String str) =>
    CreateGatePassRequestEntity.fromJson(json.decode(str));

String createGatePassRequestEntityToJson(CreateGatePassRequestEntity data) =>
    json.encode(data.toJson());

@JsonSerializable()
class CreateGatePassRequestEntity
    implements
        BaseLayerDataTransformer<CreateGatePassRequestEntity,
            CreateGatePassModel> {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "mobile")
  String? mobile;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "visitor_type_id")
  int? visitorTypeId;
  @JsonKey(name: "company_name")
  String? companyName;
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
  @JsonKey(name: "profile_image")
  String? profileImage;

  CreateGatePassRequestEntity({
    this.name,
    this.mobile,
    this.email,
    this.visitorTypeId,
    this.companyName,
    this.pointOfContact,
    this.otherPointOfContact,
    this.purposeOfVisitId,
    this.comingFrom,
    this.guestCount,
    this.profileImage,
  });

  factory CreateGatePassRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateGatePassRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGatePassRequestEntityToJson(this);

  @override
  CreateGatePassRequestEntity restore(CreateGatePassModel data) {
    return CreateGatePassRequestEntity(
        comingFrom: data.comingFrom,
        companyName: data.companyName,
        email: data.email,
        guestCount: data.guestCount,
        mobile: data.mobile,
        name: data.name,
        otherPointOfContact: data.otherPointOfContact,
        pointOfContact: data.pointOfContact,
        profileImage: data.profileImage,
        purposeOfVisitId: data.purposeOfVisitId,
        visitorTypeId: data.visitorTypeId);
  }

  @override
  CreateGatePassModel transform() {
    return CreateGatePassModel(
        name: name,
        email: email,
        comingFrom: comingFrom,
        companyName: companyName,
        guestCount: guestCount,
        mobile: mobile,
        otherPointOfContact: otherPointOfContact,
        pointOfContact: pointOfContact,
        profileImage: profileImage,
        purposeOfVisitId: purposeOfVisitId,
        visitorTypeId: visitorTypeId);
  }
}
