import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class GetAllChecklistUsecase extends BaseUseCase<NetworkError,
    GetAllChecklistParams, CheckListResponse> {
  final TransportRepository transportRepository;

  GetAllChecklistUsecase({required this.transportRepository});
  @override
  Future<Either<NetworkError, CheckListResponse>> execute(
      {required GetAllChecklistParams params}) {
    return transportRepository.getAllCheckList(pageNo: params.pageNo);
  }
}

class GetAllChecklistParams extends Params {
  final int pageNo;

  GetAllChecklistParams({required this.pageNo});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
