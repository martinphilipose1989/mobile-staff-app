import 'package:dartz/dartz.dart';
import 'package:shared/shared.dart';

abstract class UserRepository {
  Future<Either<NetworkError, LoginResponse>> loginWithEmail(
      {required String email, required String password});

  Future<Either<DatabaseError, User>> saveUser(User user);

  Future<Either<NetworkError, UserPermissionResponse>> userPermissionDetails(
      UserPermissionRequest request);

  Future<Either<BaseError, AuthResponse>> login();

  Future<Either<BaseError, bool>> storeAccessToken(AuthResponse authResponse);
}
