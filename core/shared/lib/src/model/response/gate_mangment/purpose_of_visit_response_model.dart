class PurposeOfVisitModel {
  int? status;
  List<PurposeOfVisitDataModel>? data;
  String? message;

  PurposeOfVisitModel({
    this.status,
    this.data,
    this.message,
  });
}

class PurposeOfVisitDataModel {
  String? id;
  String? name;

  PurposeOfVisitDataModel({
    this.id,
    this.name,
  });
}
