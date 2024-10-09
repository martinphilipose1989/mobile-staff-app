import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class GetGuardianlistUsecase extends BaseUseCase<NetworkError,
    GetGuardianlistUsecaseParams, GetGuardianListResponse> {
  final TransportRepository transportRepository;

  GetGuardianlistUsecase({required this.transportRepository});

  @override
  Future<Either<NetworkError, GetGuardianListResponse>> execute(
      {required GetGuardianlistUsecaseParams params}) {
    return transportRepository.getGuardianList(studentId: params.studentId);
  }
}

class GetGuardianlistUsecaseParams extends Params {
  final int studentId;

  GetGuardianlistUsecaseParams({required this.studentId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
