import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'visitor_details_response_entity.g.dart';

VisitorDetailsResponseEntity visitorDetailsResponseEntityFromJson(String str) =>
    VisitorDetailsResponseEntity.fromJson(json.decode(str));

String visitorDetailsResponseEntityToJson(VisitorDetailsResponseEntity data) =>
    json.encode(data.toJson());

@JsonSerializable()
class VisitorDetailsResponseEntity
    implements
        BaseLayerDataTransformer<VisitorDetailsResponseEntity,
            VisitorDetailsResponseModel> {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "data")
  VisitorDetailsDataEntity? data;
  @JsonKey(name: "message")
  String? message;

  VisitorDetailsResponseEntity({
    this.status,
    this.data,
    this.message,
  });

  factory VisitorDetailsResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$VisitorDetailsResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VisitorDetailsResponseEntityToJson(this);

  @override
  VisitorDetailsResponseEntity restore(VisitorDetailsResponseModel data) {
    return VisitorDetailsResponseEntity(
      message: data.message,
      status: data.status,
      data: VisitorDetailsDataEntity(
        id: data.data?.id ?? '',
        pointOfContact: data.data?.pointOfContact ?? '',
        purposeOfVisitId: '',
        comingFrom: '',
        issuedDate: DateTime.now(),
        incomingTime: data.data?.incomingTime ?? '',
        outgoingTime: data.data?.outgoingTime,
        qrCode: '',
        visitStatus: data.data?.visitStatus ?? '',
        visitorId: data.data?.visitorId ?? ' ',
        visitorName: data.data?.visitorName ?? '',
        visitorMobile: '',
        visitorEmail: data.data?.visitorEmail ?? '',
        visitorProfileImageFilePath: data.data?.visitorProfileImage ?? '',
        purposeOfVisit: data.data?.purposeOfVisit ?? '',
        visitorProfileImageImageUrl: '',
      ),
    );
  }

  @override
  VisitorDetailsResponseModel transform() {
    return VisitorDetailsResponseModel(
        status: status,
        message: message,
        data: VisitorDataModel(
          id: data?.id ?? '',
          incomingTime: data?.incomingTime ?? '',
          issuedDate: data?.issuedDate.toString() ?? '',
          pointOfContact: data?.pointOfContact ?? '',
          outgoingTime: data?.outgoingTime ?? '',
          visitStatus: data?.visitStatus ?? '',
          visitorId: data?.visitorId ?? '',
          visitorName: data?.visitorName ?? '',
          visitorMobile: data?.visitorMobile ?? '',
          visitorEmail: data?.visitorEmail ?? '',
          purposeOfVisit: data?.purposeOfVisit ?? '',
        ));
  }
}

@JsonSerializable()
class VisitorDetailsDataEntity {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "point_of_contact")
  String pointOfContact;
  @JsonKey(name: "purpose_of_visit_id")
  String purposeOfVisitId;
  @JsonKey(name: "coming_from")
  String comingFrom;
  @JsonKey(name: "issued_date")
  DateTime issuedDate;
  @JsonKey(name: "incoming_time")
  String incomingTime;
  @JsonKey(name: "outgoing_time")
  dynamic outgoingTime;
  @JsonKey(name: "qr_code")
  String qrCode;
  @JsonKey(name: "visit_status")
  String visitStatus;
  @JsonKey(name: "visitor_id")
  String visitorId;
  @JsonKey(name: "visitor_name")
  String visitorName;
  @JsonKey(name: "visitor_mobile")
  String visitorMobile;
  @JsonKey(name: "visitor_email")
  String visitorEmail;
  @JsonKey(name: "visitor_profile_image_file_path")
  String visitorProfileImageFilePath;
  @JsonKey(name: "purpose_of_visit")
  String purposeOfVisit;
  @JsonKey(name: "visitor_profile_image_image_url")
  String visitorProfileImageImageUrl;

  VisitorDetailsDataEntity({
    required this.id,
    required this.pointOfContact,
    required this.purposeOfVisitId,
    required this.comingFrom,
    required this.issuedDate,
    required this.incomingTime,
    required this.outgoingTime,
    required this.qrCode,
    required this.visitStatus,
    required this.visitorId,
    required this.visitorName,
    required this.visitorMobile,
    required this.visitorEmail,
    required this.visitorProfileImageFilePath,
    required this.purposeOfVisit,
    required this.visitorProfileImageImageUrl,
  });

  factory VisitorDetailsDataEntity.fromJson(Map<String, dynamic> json) =>
      _$VisitorDetailsDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VisitorDetailsDataEntityToJson(this);
}
