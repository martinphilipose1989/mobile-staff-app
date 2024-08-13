import 'package:data/data.dart';
import 'package:domain/domain.dart';

class VisitorRepositoryImpl extends VisitorRepository {
  final NetworkPort networkPort;

  VisitorRepositoryImpl({required this.networkPort});
  @override
  Future<Either<NetworkError, VisitorListResponseModel>> getVisitorList(
      {required int pageNumber, int pageSize = 10}) {
    return networkPort.getVisitorList(
        pageNumber: pageNumber, pageSize: pageSize);
  }

  @override
  Future<Either<NetworkError, VisitorDetailsResponseModel>> getVisitorDetails({
    required String gatepassId,
  }) {
    return networkPort.getVisitorDetails(
      gatepassId: gatepassId,
    );
  }
}
