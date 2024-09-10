import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:themes/themes.dart';

class UserPermissionDetailsUsecase extends BaseUseCase<BaseError,
    UserPermissionDetailsUsecaseParams, UserPermissionResponse> {
  final UserRepository _userRepository;
  final SharedPreferencesService sharedPreferencesService =
      GetIt.I<SharedPreferencesService>();

  UserPermissionDetailsUsecase({required UserRepository userRepository})
      : _userRepository = userRepository;
  @override
  Future<Either<BaseError, UserPermissionResponse>> execute(
      {required UserPermissionDetailsUsecaseParams params}) async {
    final result = await _userRepository.userPermissionDetails(params.request);
    return result.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response);
    });
  }
}

class UserPermissionDetailsUsecaseParams extends Params {
  final UserPermissionRequest request;

  UserPermissionDetailsUsecaseParams({required this.request});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
