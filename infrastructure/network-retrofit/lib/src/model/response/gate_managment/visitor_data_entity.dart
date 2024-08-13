import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visitor_data_entity.g.dart';

@JsonSerializable()
class VisitorDataEntity
    implements BaseLayerDataTransformer<VisitorDataEntity, VisitorDataModel> {
  @JsonKey(name: "_id")
  String? id;

  @JsonKey(name: "point_of_contact")
  String? pointOfContact;

  @JsonKey(name: "issued_date")
  String? issuedDate;

  @JsonKey(name: "incoming_time")
  String? incomingTime;

  @JsonKey(name: "outgoing_time")
  String? outgoingTime;

  @JsonKey(name: "visit_status")
  String? visitStatus;

  @JsonKey(name: "visitor_id")
  String? visitorId;

  @JsonKey(name: "visitor_name")
  String? visitorName;

  @JsonKey(name: "visitor_mobile")
  String? visitorMobile;

  @JsonKey(name: "visitor_email")
  String? visitorEmail;

  @JsonKey(name: "visitor_profile_image")
  String? visitorProfileImage;

  @JsonKey(name: "purpose_of_visit")
  String? purposeOfVisit;

  VisitorDataEntity(
      {this.id,
      this.pointOfContact,
      this.issuedDate,
      this.incomingTime,
      this.outgoingTime,
      this.visitStatus,
      this.visitorId,
      this.visitorName,
      this.visitorMobile,
      this.visitorEmail,
      this.visitorProfileImage,
      this.purposeOfVisit});

  factory VisitorDataEntity.fromJson(Map<String, dynamic> json) =>
      _$VisitorDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VisitorDataEntityToJson(this);

  @override
  VisitorDataEntity restore(VisitorDataModel data) {
    return VisitorDataEntity(id: data.id, incomingTime: data.incomingTime);
  }

  @override
  VisitorDataModel transform() {
    return VisitorDataModel(
        id: id,
        incomingTime: incomingTime,
        issuedDate: issuedDate,
        outgoingTime: outgoingTime,
        pointOfContact: pointOfContact,
        purposeOfVisit: purposeOfVisit,
        visitStatus: visitStatus,
        visitorEmail: visitorEmail,
        visitorId: visitorId,
        visitorMobile: visitorMobile,
        visitorName: visitorName,
        visitorProfileImage: visitorProfileImage);
  }
}
