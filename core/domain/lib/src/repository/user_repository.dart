import 'package:dartz/dartz.dart';
import 'package:shared/shared.dart';

abstract class UserRepository {
  Future<Either<NetworkError, LoginResponse>> loginWithEmail(
      {required String email, required String password});

  Future<Either<DatabaseError, User>> saveUser(User user);
}
