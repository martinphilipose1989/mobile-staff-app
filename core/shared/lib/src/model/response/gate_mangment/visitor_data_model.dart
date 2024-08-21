// ignore_for_file: public_member_api_docs, sort_constructors_first

class VisitorDataModel {
  String? id;

  String? pointOfContact;

  String? issuedDate;

  String? incomingTime;

  String? outgoingTime;

  String? visitStatus;

  String? visitorId;

  String? visitorName;

  String? visitorMobile;

  String? visitorEmail;

  String? visitorProfileImage;

  String? purposeOfVisit;

//visitor details related fields
  String? purposeOfVisitId;

  String? comingFrom;

  String? qrCode;

  String? visitorProfileImageImageUrl;

  String? visitorProfileImageFilePath;

  String? visitorType;

  int? guestCount;

  VisitorDataModel(
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
      this.purposeOfVisit,
      this.purposeOfVisitId,
      this.comingFrom,
      this.qrCode,
      this.visitorProfileImageImageUrl,
      this.visitorProfileImageFilePath,
      this.visitorType = "Parent",
      this.guestCount});
}
