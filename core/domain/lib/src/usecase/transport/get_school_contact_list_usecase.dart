import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class GetSchoolContactListUsecase extends BaseUseCase<NetworkError,
    GetSchoolContactListUsecaseParams, GetSchoolContactResponse> {
  final TransportRepository transportRepository;

  GetSchoolContactListUsecase({required this.transportRepository});

  @override
  Future<Either<NetworkError, GetSchoolContactResponse>> execute(
      {required GetSchoolContactListUsecaseParams params}) {
    return transportRepository.getSchoolContactList(schoolId: params.schoolId);
  }
}

class GetSchoolContactListUsecaseParams extends Params {
  final int schoolId;

  GetSchoolContactListUsecaseParams({required this.schoolId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
