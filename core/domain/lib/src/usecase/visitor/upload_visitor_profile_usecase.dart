import 'dart:io';

import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class UploadVisitorProfileUsecase extends BaseUseCase<NetworkError,
    UploadVisitorProfileUsecaseParams, UploadFileResponseModel> {
  final VisitorRepository _visitorRepository;

  UploadVisitorProfileUsecase({required VisitorRepository visitorRepository})
      : _visitorRepository = visitorRepository;

  @override
  Future<Either<NetworkError, UploadFileResponseModel>> execute(
      {required UploadVisitorProfileUsecaseParams params}) {
    return _visitorRepository.uploadProfileImage(file: params.file);
  }
}

class UploadVisitorProfileUsecaseParams extends Params {
  final File file;

  UploadVisitorProfileUsecaseParams({super.reloading, required this.file});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
