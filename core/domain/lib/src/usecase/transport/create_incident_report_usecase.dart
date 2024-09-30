import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class CreateIncidentReportUsecase extends BaseUseCase<NetworkError,
    CreateIncidentReportParams, CreateIncidentReportResponse> {
  final TransportRepository transportRepository;

  CreateIncidentReportUsecase({required this.transportRepository});
  @override
  Future<Either<NetworkError, CreateIncidentReportResponse>> execute(
      {required CreateIncidentReportParams params}) {
    return transportRepository.createIncident(requestBody: params.request);
  }
}

class CreateIncidentReportParams extends Params {
  final CreateIncidentReportRequest request;

  CreateIncidentReportParams({required this.request});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
