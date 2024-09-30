import 'package:envied/envied.dart';

part 'env_qa.g.dart';

@Envied(path: '.env.qa')
abstract class EnvQa {
  @EnviedField(varName: 'API_BASE_URL')
  static const String baseUrl = _EnvQa.baseUrl;

  @EnviedField(varName: 'MDM_BASE_URL')
  static const String mdmBaseUrl = _EnvQa.mdmBaseUrl;

  @EnviedField(varName: 'TRANSPORT_BASE_URL')
  static const String transportBaseUrl = _EnvQa.transportBaseUrl;

  @EnviedField(varName: 'KEY_CLOAK_AUTH_URL')
  static const String authorizationEndpoint = _EnvQa.authorizationEndpoint;

  @EnviedField(varName: 'KEY_CLOAK_TOKEN_URL')
  static const String tokenEndpoint = _EnvQa.tokenEndpoint;

  @EnviedField(varName: 'KEY_CLOAK_LOGOUT_URL')
  static const String logoutEndpoint = _EnvQa.logoutEndpoint;

  @EnviedField(varName: 'KEY_CLOAK_DISCOVERY_URL')
  static const String discoveryUrl = _EnvQa.discoveryUrl;

  @EnviedField(varName: 'KEY_CLOAK_REDIRECT_URI')
  static const String appRedirectUri = _EnvQa.appRedirectUri;

  @EnviedField(varName: 'KEY_CLOAK_LOGOUT_REDIRECT_URI')
  static const String logoutRedirectUri = _EnvQa.logoutRedirectUri;

  @EnviedField(varName: 'KEY_CLOAK_CLIENTID')
  static const String clientId = _EnvQa.clientId;

  @EnviedField(varName: 'KEY_CLOAK_CLIENT_SECRET')
  static const String clientSecret = _EnvQa.clientSecret;
}
