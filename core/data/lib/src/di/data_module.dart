import 'package:data/data.dart';
import 'package:data/src/repository/attachment_repository.dart';
import 'package:data/src/repository/user_repository.dart';
import 'package:data/src/repository/visitor_repository.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DataModule {
  @lazySingleton
  UserRepository userRepositoryProvider(
      DatabasePort databasePort, NetworkPort networkPort) {
    return UserRepositoryImpl(databasePort, networkPort);
  }

  @lazySingleton
  AttachmentRepository attachmentRepositoryProvider(
      AttachmentPort attachmentPort) {
    return AttachmentRepositoryImpl(attachmentPort);
  }

  @lazySingleton
  VisitorRepository visitorRepositoryProvider(NetworkPort networkPort) {
    return VisitorRepositoryImpl(networkPort: networkPort);
  }
}
