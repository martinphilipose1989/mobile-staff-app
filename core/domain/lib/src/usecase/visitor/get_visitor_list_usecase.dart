import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class GetVisitorListUsecase extends BaseUseCase<BaseError,
    GetVisitorListUsecaseParams, VisitorListResponseModel> {
  final VisitorRepository _visitorRepository;

  GetVisitorListUsecase({required VisitorRepository visitorRepository})
      : _visitorRepository = visitorRepository;

  @override
  Future<Either<NetworkError, VisitorListResponseModel>> execute(
      {required GetVisitorListUsecaseParams params}) {
    return _visitorRepository.getVisitorList(
        pageNumber: params.pageNumber,
        pageSize: params.pageSize == null ? 10 : params.pageSize!);
  }
}

class GetVisitorListUsecaseParams extends Params {
  final int pageNumber;
  final int? pageSize;

  GetVisitorListUsecaseParams({required this.pageNumber, this.pageSize});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
