import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class SearchVisitorUsecase extends BaseUseCase<NetworkError,
    SearchUseCaseParams, VisitorListResponseModel> {
  final VisitorRepository _visitorRepository;

  SearchVisitorUsecase({required VisitorRepository visitorRepository})
      : _visitorRepository = visitorRepository;

  @override
  Future<Either<NetworkError, VisitorListResponseModel>> execute(
      {required SearchUseCaseParams params}) {
    return _visitorRepository.searchVisitorList(
      request: SearchRequest(
        pageNumber: params.pageNumber,
        pageSize: params.pageSize,
        search: params.searchQuery,
      ),
    );
  }
}

class SearchUseCaseParams extends Params {
  final int pageNumber;
  final int pageSize;
  final String searchQuery;

  SearchUseCaseParams(
      {super.reloading,
      required this.pageNumber,
      required this.pageSize,
      required this.searchQuery});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
