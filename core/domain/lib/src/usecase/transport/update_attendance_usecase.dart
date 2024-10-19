import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class UpdateAttendanceUsecase extends BaseUseCase<NetworkError,
    UpdateAttendanceUsecaseParams, UpdateAttendanceResponse> {
  final TransportRepository transportRepository;

  UpdateAttendanceUsecase({required this.transportRepository});

  @override
  Future<Either<NetworkError, UpdateAttendanceResponse>> execute(
      {required UpdateAttendanceUsecaseParams params}) {
    return transportRepository.updateAttendance(body: params.request);
  }
}

class UpdateAttendanceUsecaseParams extends Params {
  final UpdateAttendanceRequest request;

  UpdateAttendanceUsecaseParams({required this.request});
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
