import 'package:data/data.dart';
import 'package:database_floor/src/app_database.dart';

class AppPersistenceAdapter implements DatabasePort {
  final AppDatabase appDatabase;

  AppPersistenceAdapter(this.appDatabase);

  @override
  void fetchPosts() {}

  @override
  void reload() {}

  @override
  void saveUser() {}
}
