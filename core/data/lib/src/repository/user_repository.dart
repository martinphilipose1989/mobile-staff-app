import 'package:domain/domain.dart';

import '../out/database_port.dart';
import '../out/network_port.dart';

class UserRepositoryImpl extends UserRepository {
  final DatabasePort databaseProvider;
  final NetworkPort networkPort;

  UserRepositoryImpl(this.databaseProvider, this.networkPort);

  @override
  Future<Either<NetworkError, LoginResponse>> loginWithEmail(
      {required String email, required String password}) {
    return networkPort.login(
        loginRequest: LoginRequest(username: email, password: password));
  }

  @override
  Future<Either<DatabaseError, User>> saveUser(User user) {
    throw UnimplementedError();
  }

  @override
  Future<Either<NetworkError, UserPermissionResponse>> userPermissionDetails(
      UserPermissionRequest request) {
    return networkPort.userPermissionDetails(request: request);
  }
}
