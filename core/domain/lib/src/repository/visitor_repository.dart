import 'package:domain/domain.dart';

abstract class VisitorRepository {
  Future<Either<NetworkError, VisitorListResponseModel>> getVisitorList(
      {required int pageNumber, int pageSize = 10});

  Future<Either<NetworkError, VisitorDetailsResponseModel>> getVisitorDetails(
      {required String gatepassId});

  Future<Either<NetworkError, VisitorDetailsResponseModel>> patchVisitorDetails(
      {required String gatepassId, required Map<String, dynamic> outgoingTime});
}
