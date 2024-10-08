class CheckListResponse {
  int? status;

  CheckListResponseData? data;

  String? message;

  CheckListResponse({this.status, this.data, this.message});
}

class CheckListResponseData {
  List<Checklist>? results;

  int? total;

  String? page;

  String? limit;

  CheckListResponseData({this.results, this.total, this.page, this.limit});
}

class Checklist {
  String? id;

  String? slug;

  String? checkList;

  String? description;

  String? icon;

  String? img;

  int? parentId;

  bool? isActive;

  String? status;

  String? createdAt;

  String? updatedAt;

  bool? isVerified;

  Checklist(
      {this.id,
      this.slug,
      this.checkList,
      this.description,
      this.icon,
      this.img,
      this.parentId,
      this.isActive,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.isVerified = false});
}
