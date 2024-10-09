class CreateBearerRequest {
  CreateBearerData? data;

  CreateBearerRequest({this.data});
}

class CreateBearerData {
  String? firstName;

  String? lastName;

  String? profileImage;

  CreateBearerData({this.firstName, this.lastName, this.profileImage});
}
