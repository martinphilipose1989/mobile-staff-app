import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class GetMydutyListUsecase
    extends BaseUseCase<NetworkError, GetMydutyListParams, TripResponse> {
  final TransportRepository transportRepository;

  GetMydutyListUsecase({required this.transportRepository});

  @override
  Future<Either<NetworkError, TripResponse>> execute(
      {required GetMydutyListParams params}) {
    return transportRepository.getMyDutyList(pageNo: params.pageNo);
  }
}

class GetMydutyListParams extends Params {
  final int pageNo;

  GetMydutyListParams({required this.pageNo});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
