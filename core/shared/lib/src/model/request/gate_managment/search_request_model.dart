class SearchRequest {
  final int pageNumber;

  final int pageSize;

  final String search;

  final CreatedBy? createdBy;

  SearchRequest(
      {required this.pageNumber,
      required this.pageSize,
      required this.search,
      this.createdBy});
}

class CreatedBy {
  final int userId;

  final String userName;

  final String email;

  CreatedBy(
      {required this.userId, required this.userName, required this.email});
}
