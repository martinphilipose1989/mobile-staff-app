import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class GetBearerListUsecase extends BaseUseCase<NetworkError,
    GetBearerListUsecaseParams, GetBearerListResponse> {
  final TransportRepository transportRepository;

  GetBearerListUsecase({required this.transportRepository});

  @override
  Future<Either<NetworkError, GetBearerListResponse>> execute(
      {required GetBearerListUsecaseParams params}) {
    return transportRepository.getBearerList(studentId: params.studentId);
  }
}

class GetBearerListUsecaseParams extends Params {
  final int studentId;

  GetBearerListUsecaseParams({required this.studentId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
