class GetVisitorListRequestModel {
  int? pageNumber;
  int? pageSize;
  String? search;
  List<FilterRequestModel>? filters;

  GetVisitorListRequestModel(
      {this.pageNumber, this.pageSize, this.filters, this.search});
}

class FilterRequestModel {
  String? column;
  String? operation;
  dynamic search;

  FilterRequestModel({this.column, this.operation, this.search});
}
