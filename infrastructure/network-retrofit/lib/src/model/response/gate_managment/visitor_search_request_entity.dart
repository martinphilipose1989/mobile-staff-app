import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visitor_search_request_entity.g.dart';

@JsonSerializable()
class SearchRequestEntity
    implements BaseLayerDataTransformer<SearchRequestEntity, SearchRequest> {
  @JsonKey(name: 'pageNumber')
  final int pageNumber;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  @JsonKey(name: 'search')
  final String search;

  @JsonKey(name: 'created_by')
  final CreatedByEntity? createdByEntity;

  SearchRequestEntity(
      {required this.pageNumber,
      required this.pageSize,
      required this.search,
      this.createdByEntity});

  factory SearchRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$SearchRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SearchRequestEntityToJson(this);

  @override
  SearchRequestEntity restore(SearchRequest data) {
    return SearchRequestEntity(
        pageNumber: data.pageNumber,
        pageSize: data.pageSize,
        search: data.search,
        createdByEntity: CreatedByEntity(
            userId: data.createdBy?.userId ?? 0,
            userName: data.createdBy?.userName ?? "",
            email: data.createdBy?.email ?? ""));
  }

  @override
  SearchRequest transform() {
    return SearchRequest(
        pageNumber: pageNumber,
        pageSize: pageSize,
        search: search,
        createdBy: createdByEntity?.transform());
  }
}

@JsonSerializable()
class CreatedByEntity
    implements BaseLayerDataTransformer<CreatedByEntity, CreatedBy> {
  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'user_name')
  final String userName;

  final String email;

  CreatedByEntity(
      {required this.userId, required this.userName, required this.email});

  factory CreatedByEntity.fromJson(Map<String, dynamic> json) =>
      _$CreatedByEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedByEntityToJson(this);

  @override
  CreatedByEntity restore(CreatedBy data) {
    return CreatedByEntity(userId: userId, userName: userName, email: email);
  }

  @override
  CreatedBy transform() {
    return CreatedBy(userId: userId, userName: userName, email: email);
  }
}
