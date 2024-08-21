import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class PopulateVisitorDataUsecase extends BaseUseCase<NetworkError,
    PopulateVisitorDataUsecaseParams, VisitorPopulateResponseModel> {
  final VisitorRepository _visitorRepository;

  PopulateVisitorDataUsecase({required VisitorRepository visitorRepository})
      : _visitorRepository = visitorRepository;

  @override
  Future<Either<NetworkError, VisitorPopulateResponseModel>> execute(
      {required PopulateVisitorDataUsecaseParams params}) {
    return _visitorRepository.populateVisitorData(
        visitorMobileNumber: params.mobileNumber);
  }
}

class PopulateVisitorDataUsecaseParams extends Params {
  final String mobileNumber;

  PopulateVisitorDataUsecaseParams({required this.mobileNumber});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
