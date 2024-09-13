import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:services/services.dart';

class TokenInterceptor extends InterceptorsWrapper {
  final SecureStorageService sharedPreferencesService =
      GetIt.I<SecureStorageService>();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final isCoReasonRequest = options.uri.path.contains("/api/co-reasons");
    if (!isCoReasonRequest) {
      final token = await sharedPreferencesService
          .getFromDisk(sharedPreferencesService.accessTokenKey);
      options.headers.putIfAbsent(ServerConstants.authorization, () => token);
    }
    return handler.next(options);
  }
}
