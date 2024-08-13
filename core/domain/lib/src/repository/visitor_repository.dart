import 'package:domain/domain.dart';

abstract class VisitorRepository {
  Future<Either<NetworkError, VisitorListResponseModel>> getVisitorList(
      {required int pageNumber, int pageSize = 10});
}
