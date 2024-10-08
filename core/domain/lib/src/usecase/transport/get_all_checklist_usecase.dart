import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class GetAllChecklistUsecase extends BaseUseCase<NetworkError,
    GetAllChecklistParams, CheckListResponse> {
  final TransportRepository transportRepository;

  GetAllChecklistUsecase({required this.transportRepository});
  @override
  Future<Either<NetworkError, CheckListResponse>> execute(
      {required GetAllChecklistParams params}) {
    return transportRepository.getAllCheckList(
        pageNo: params.pageNo, dayId: params.dayId);
  }
}

class GetAllChecklistParams extends Params {
  final int pageNo;
  final int dayId;

  GetAllChecklistParams({required this.pageNo, required this.dayId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
