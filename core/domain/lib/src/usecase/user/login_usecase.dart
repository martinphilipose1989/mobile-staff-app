import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/shared.dart';
import 'package:themes/themes.dart';

import '../../repository/user_repository.dart';
import '../base/base_usecase.dart';
import '../base/params.dart';

class LoginUseCase
    extends BaseUseCase<BaseError, LoginUseCaseParams, LoginResponse> {
  final UserRepository _userRepository;
  final SharedPreferencesService sharedPreferencesService =
      GetIt.I<SharedPreferencesService>();

  LoginUseCase(this._userRepository);

  @override
  Future<Either<BaseError, LoginResponse>> execute(
      {required LoginUseCaseParams params}) async {
    final repoResult = await _userRepository.loginWithEmail(
        email: params.emailOrPhone, password: params.password);

    return repoResult.fold((error) {
      return Left(error);
    }, (data) {
      sharedPreferencesService.saveToDisk("token", data.data?.accessToken);
      return Right(data);
    });
    // return Future.value(
    //   (await _userRepository.loginWithEmail(
    //           email: params.emailOrPhone, password: params.password))
    //       .fold((l) => Left(l), (result) async {
    //     //TODO: Implement shared prefernce
    //     return _userRepository.saveUser(User());
    //   }),
    // );
  }
}

class LoginUseCaseParams extends Params {
  final String emailOrPhone;
  final String password;

  LoginUseCaseParams({required this.emailOrPhone, required this.password});

  @override
  Either<AppError, bool> verify() {
    if (Validator.isEmpty(emailOrPhone)) {
      return Left(
        AppError(
          type: ErrorType.uiEmptyEmail,
          throwable: Exception(),
          error: ErrorInfo(message: 'Email cannot be mepty'),
        ),
      );
    } else if (!Validator.validateEmail(emailOrPhone)) {
      return Left(
        AppError(
          type: ErrorType.uiInvalidEmail,
          throwable: Exception(),
          error: ErrorInfo(message: 'Invalid email'),
        ),
      );
    } else if (Validator.isEmpty(password)) {
      return Left(
        AppError(
          type: ErrorType.uiEmptyPassword,
          throwable: Exception(),
          error: ErrorInfo(message: 'Password cannot be empty'),
        ),
      );
    } else {
      return Right(true);
    }
  }
}
