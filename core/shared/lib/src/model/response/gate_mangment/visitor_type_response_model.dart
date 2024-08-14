class TypeOfVisitorResponseModel {
  int? status;
  List<TypeOfVisitorDataModel>? data;
  String? message;

  TypeOfVisitorResponseModel({this.status, this.data, this.message});
}

class TypeOfVisitorDataModel {
  String? id;
  String? name;

  TypeOfVisitorDataModel({this.id, this.name});
}
