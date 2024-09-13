import 'package:appauth/src/utils/auth_config.dart';
import 'package:data/data.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

class AppAuthAdapter implements AppAuthPort {
  final FlutterAppAuth _flutterAppAuth;
  final AppAuthConfig _config;

  AppAuthAdapter(
      {required FlutterAppAuth flutterAppAuth, required AppAuthConfig config})
      : _flutterAppAuth = flutterAppAuth,
        _config = config;

  @override
  Future<AuthorizationTokenResponse> login() async {
    try {
      final AuthorizationTokenRequest request = AuthorizationTokenRequest(
          _config.clientId, _config.appUri,
          clientSecret: _config.clientSecret,
          serviceConfiguration: AuthorizationServiceConfiguration(
              authorizationEndpoint: _config.loginUrl,
              tokenEndpoint: _config.tokenUrl,
              endSessionEndpoint: _config.logOutUrl?.isEmpty ?? false
                  ? null
                  : _config.logOutUrl),
          scopes: [
            "openid",
            "web-origins",
            "acr",
            "profile",
            "roles",
            "Ampersand_AD_Attribute",
            "email"
          ]);
      final response = await _flutterAppAuth.authorizeAndExchangeCode(request);
      return response;
    } on FlutterAppAuthUserCancelledException catch (e) {
      throw LocalError(
        errorType: ErrorType.appAuthUserCancelled,
        message: '',
        cause: Exception(e.platformErrorDetails),
      );
    } on FlutterAppAuthPlatformException catch (e) {
      throw LocalError(
        errorType: ErrorType.appAuthPlatformException,
        message: '',
        cause: Exception(e.platformErrorDetails),
      );
    }
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> refreshToken() {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }
}
