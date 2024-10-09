class CreateBearerResponse {
  final int? id;
  final CreateBearerAttributes? attributes;

  CreateBearerResponse({this.id, this.attributes});
}

class CreateBearerAttributes {
  final String? firstName;

  final String? lastName;

  final String? profileImage;

  CreateBearerAttributes({this.firstName, this.lastName, this.profileImage});
}
