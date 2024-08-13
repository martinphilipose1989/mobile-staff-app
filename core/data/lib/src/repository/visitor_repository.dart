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

  @override
  Future<Either<NetworkError, VisitorDetailsResponseModel>>
      patchVisitorDetails({
    required String gatepassId,
    required Map<String, dynamic> outgoingTime,
  }) {
    return networkPort.petchVisitorDetails(
      gatepassId: gatepassId,
      outgoingTime: outgoingTime,
    );
  }

  @override
  Future<Either<NetworkError, CreateGatepassResponseModel>>
      createVisitorGatePass({required CreateGatePassModel request}) {
    return networkPort.createVisitorGatePass(request: request);
  }
}
