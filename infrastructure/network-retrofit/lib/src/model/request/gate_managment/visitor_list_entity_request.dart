import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visitor_list_entity_request.g.dart';

@JsonSerializable()
class GetVisitorListRequestEntity
    implements
        BaseLayerDataTransformer<GetVisitorListRequestEntity,
            GetVisitorListRequestModel> {
  @JsonKey(name: "pageNumber")
  int? pageNumber;

  @JsonKey(name: "pageSize")
  int? pageSize;

  @JsonKey(name: "filters")
  List<FilterEntity>? filters;

  GetVisitorListRequestEntity({this.pageNumber, this.pageSize, this.filters});

  factory GetVisitorListRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetVisitorListRequestEntityFromJson(json);

  Map<String, dynamic> toJson() {
    // Filter out any empty filters
    final List<FilterEntity>? validFilters =
        filters?.where((filter) => filter.isValid()).toList();
    // Exclude the 'filters' field if it's empty
    final Map<String, dynamic> json = _$GetVisitorListRequestEntityToJson(this);
    if (validFilters == null || validFilters.isEmpty) {
      json.remove('filters');
    } else {
      json['filters'] = validFilters.map((e) => e.toJson()).toList();
    }
    return json;
  }

  @override
  GetVisitorListRequestEntity restore(GetVisitorListRequestModel data) {
    return GetVisitorListRequestEntity();
  }

  @override
  GetVisitorListRequestModel transform() {
    return GetVisitorListRequestModel(
        filters: filters?.map((filter) => filter.transform()).toList(),
        pageNumber: pageNumber,
        pageSize: pageSize);
  }
}

@JsonSerializable()
class FilterEntity
    implements BaseLayerDataTransformer<FilterEntity, FilterRequestModel> {
  @JsonKey(name: "column")
  String? column;

  @JsonKey(name: "operation")
  String? operation;

  @JsonKey(name: "search")
  dynamic search;

  FilterEntity({this.column, this.operation, this.search});

  factory FilterEntity.fromJson(Map<String, dynamic> json) =>
      _$FilterEntityFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = _$FilterEntityToJson(this);
    // Remove empty fields
    if (column == null) json.remove('column');
    if (operation == null) json.remove('operation');
    if (search == null) json.remove('search');
    return json;
  }

  // Method to check if the filter is valid (none of the fields are null)
  bool isValid() {
    return column != null && operation != null && search != null;
  }

  @override
  FilterEntity restore(FilterRequestModel data) {
    return FilterEntity(
        column: data.column, operation: data.operation, search: data.search);
  }

  @override
  FilterRequestModel transform() {
    return FilterRequestModel(
        column: column, operation: operation, search: search);
  }
}
