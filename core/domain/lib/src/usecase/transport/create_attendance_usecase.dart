import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class CreateAttendanceUsecase extends BaseUseCase<NetworkError,
    CreateAttendanceUsecaseParams, CreateAttendance> {
  final TransportRepository transportRepository;

  CreateAttendanceUsecase({required this.transportRepository});

  @override
  Future<Either<NetworkError, CreateAttendance>> execute(
      {required CreateAttendanceUsecaseParams params}) {
    return transportRepository.createAttendance(
        createAttendance: params.createAttendance);
  }
}

class CreateAttendanceUsecaseParams extends Params {
  final CreateAttendance createAttendance;

  CreateAttendanceUsecaseParams({required this.createAttendance});
  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
