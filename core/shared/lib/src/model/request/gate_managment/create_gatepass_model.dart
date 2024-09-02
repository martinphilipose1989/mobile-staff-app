class CreateGatePassModel {
  String? name;

  String? mobile;

  String? email;

  int? visitorTypeId;

  String? companyName;

  String? pointOfContact;

  String? otherPointOfContact;

  int? purposeOfVisitId;

  String? comingFrom;

  int? guestCount;

  String? profileImage;

  String? vehicleNumber;

  CreateGatePassModel(
      {this.name,
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
      this.vehicleNumber});
}
