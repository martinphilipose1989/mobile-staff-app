import 'package:dartz/dartz.dart';
import 'package:shared/shared.dart';

abstract class UserRepository {
  Future<Either<NetworkError, LoginResponse>> loginWithEmail(
      {required String email, required String password});

  Future<Either<DatabaseError, User>> saveUser(User user);

  Future<Either<NetworkError, UserPermissionResponse>> userPermissionDetails(
      UserPermissionRequest request);

  Future<Either<LocalError, AuthResponse>> login();

  Future<Either<LocalError, bool>> storeAccessToken(AuthResponse authResponse);

  Future<Either<LocalError, LogoutResponse>> logOut();

  Future<Either<LocalError, bool>> clearSession();
}
