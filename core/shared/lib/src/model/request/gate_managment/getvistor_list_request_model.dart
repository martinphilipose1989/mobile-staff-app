class GetVisitorListRequestModel {
  int? pageNumber;
  int? pageSize;
  List<FilterRequestModel>? filters;

  GetVisitorListRequestModel({this.pageNumber, this.pageSize, this.filters});
}

class FilterRequestModel {
  String? column;
  String? operation;
  dynamic search;

  FilterRequestModel({this.column, this.operation, this.search});
}
