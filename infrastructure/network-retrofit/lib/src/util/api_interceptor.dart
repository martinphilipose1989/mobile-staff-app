import 'dart:developer';

import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:services/services.dart';

class ApiInterceptor extends InterceptorsWrapper {
  final String apiKey;
  final String mdmToken;
  final SecureStorageService sharedPreferencesService =
      GetIt.I<SecureStorageService>();
  final AppAuthPort appAuthPort;

  ApiInterceptor(
    @factoryParam this.apiKey,
    this.appAuthPort,
    @factoryParam this.mdmToken,
  );

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final isMDMRequest = options.uri.path.contains("/api/");

    if (isMDMRequest) {
      options.headers
          .putIfAbsent(ServerConstants.authorization, () => "Bearer $mdmToken");
    } else {
      final token = await sharedPreferencesService
          .getFromDisk(sharedPreferencesService.accessTokenKey);
      if (token != null && token.isNotEmpty) {
        options.headers.putIfAbsent(ServerConstants.authorization, () => token);
      }
    }

    return handler.next(options);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log("message ${err.type.name}");
    super.onError(err, handler);
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
