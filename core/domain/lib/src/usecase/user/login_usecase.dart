// import 'package:dartz/dartz.dart';
// import 'package:get_it/get_it.dart';
// import 'package:shared/shared.dart';


// import '../../repository/user_repository.dart';
// import '../base/base_usecase.dart';
// import '../base/params.dart';

// class LoginUseCase
//     extends BaseUseCase<BaseError, LoginUseCaseParams, LoginResponse> {
//   final UserRepository _userRepository;
 

//   LoginUseCase(this._userRepository);

//   @override
//   Future<Either<BaseError, LoginResponse>> execute(
//       {required LoginUseCaseParams params}) async {
//     final repoResult = await _userRepository.loginWithEmail(
//         email: params.emailOrPhone, password: params.password);

//     return repoResult.fold((error) {
//       return Left(error);
//     }, (data) async {
//       sharedPreferencesService.saveToDisk(
//           CommonVariables.tokenKey, data.data?.accessToken);

//       final result = await _userRepository.userPermissionDetails(
//           UserPermissionRequest(
//               userEmail: params.emailOrPhone,
//               applicationId: CommonVariables.gateApplicationId,
//               service: CommonVariables.gateService));
//       result.fold((error) {}, (data) {
//         sharedPreferencesService.saveToDisk(
//             CommonVariables.userInfoKey, data.data?.userInfo?.name);
//       });
//       return Right(data);
//     });
//   }
// }

// class LoginUseCaseParams extends Params {
//   final String emailOrPhone;
//   final String password;

//   LoginUseCaseParams({required this.emailOrPhone, required this.password});

//   @override
//   Either<AppError, bool> verify() {
//     if (Validator.isEmpty(emailOrPhone)) {
//       return Left(
//         AppError(
//           type: ErrorType.uiEmptyEmail,
//           throwable: Exception(),
//           error: ErrorInfo(message: 'Email cannot be mepty'),
//         ),
//       );
//     } else if (!Validator.validateEmail(emailOrPhone)) {
//       return Left(
//         AppError(
//           type: ErrorType.uiInvalidEmail,
//           throwable: Exception(),
//           error: ErrorInfo(message: 'Invalid email'),
//         ),
//       );
//     } else if (Validator.isEmpty(password)) {
//       return Left(
//         AppError(
//           type: ErrorType.uiEmptyPassword,
//           throwable: Exception(),
//           error: ErrorInfo(message: 'Password cannot be empty'),
//         ),
//       );
//     } else {
//       return Right(true);
//     }
//   }
// }
