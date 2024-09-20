import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:services/services.dart';

class TokenInterceptor extends InterceptorsWrapper {
  final AppAuthPort appAuthPort;

  final SecureStorageService sharedPreferencesService =
      GetIt.I<SecureStorageService>();

  TokenInterceptor({required this.appAuthPort});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final isCoReasonRequest = options.uri.path.contains("/api/co-reasons");
    if (!isCoReasonRequest) {
      final token = await sharedPreferencesService
          .getFromDisk(sharedPreferencesService.accessTokenKey);
      if (token != null && token.isNotEmpty) {
        options.headers.putIfAbsent(ServerConstants.authorization, () => token);
      }
    }
    return handler.next(options);
  }

  // Function to check if the token is about to expire within a given threshold
  Future<bool> isTokenAboutToExpire({int thresholdInSeconds = 300}) async {
    final expirationTimeString = await sharedPreferencesService
        .getFromDisk(sharedPreferencesService.expirationDateTimeKey);

    if (expirationTimeString != null) {
      final expirationTime = int.parse(expirationTimeString);
      final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      // Check if token will expire within the given threshold
      return (expirationTime - currentTime) <= thresholdInSeconds;
    }

    // If no expiration time is available, consider the token expired
    return true;
  }

  Future<void> ensureValidToken() async {
    try {
      // Check if the token is about to expire within the threshold
      final tokenAboutToExpire = await isTokenAboutToExpire();

      if (tokenAboutToExpire) {
        print('Token is about to expire, refreshing...');

        final authResponse = await appAuthPort.refreshToken();

        if (authResponse.accessToken != null) {
          await Future.wait([
            sharedPreferencesService.saveToDisk(
                sharedPreferencesService.accessTokenKey,
                authResponse.accessToken),
            sharedPreferencesService.saveToDisk(
                sharedPreferencesService.idTokenKey, authResponse.idToken),
            sharedPreferencesService.saveToDisk(
                sharedPreferencesService.refreshTokenKey,
                authResponse.refreshToken),
            sharedPreferencesService.saveToDisk(
              sharedPreferencesService.expirationDateTimeKey,
              authResponse.accessTokenExpirationDateTime?.millisecondsSinceEpoch
                      .toString() ??
                  '',
            ),
          ]);
          print('Token refreshed successfully');
        } else {
          print('Failed to refresh token');
          // Optional: Handle failed token refresh, e.g., log out user or navigate to login
        }
      } else {
        print('Token is still valid');
      }
    } catch (e) {
      print('Error refreshing token: $e');
      // Optional: Handle errors in refreshing token, e.g., log out user or retry
    }
  }
}
