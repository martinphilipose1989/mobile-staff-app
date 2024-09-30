import 'package:envied/envied.dart';

part 'env_prod.g.dart';

@Envied(path: '.env.prod')
abstract class EnvProd {
  @EnviedField(varName: 'API_BASE_URL')
  static const String baseUrl = _EnvProd.baseUrl;

  @EnviedField(varName: 'MDM_BASE_URL')
  static const String mdmBaseUrl = _EnvProd.mdmBaseUrl;

  @EnviedField(varName: 'TRANSPORT_BASE_URL')
  static const String transportBaseUrl = _EnvProd.transportBaseUrl;

  @EnviedField(varName: 'KEY_CLOAK_AUTH_URL')
  static const String authorizationEndpoint = _EnvProd.authorizationEndpoint;

  @EnviedField(varName: 'KEY_CLOAK_TOKEN_URL')
  static const String tokenEndpoint = _EnvProd.tokenEndpoint;

  @EnviedField(varName: 'KEY_CLOAK_LOGOUT_URL')
  static const String logoutEndpoint = _EnvProd.logoutEndpoint;

  @EnviedField(varName: 'KEY_CLOAK_DISCOVERY_URL')
  static const String discoveryUrl = _EnvProd.discoveryUrl;

  @EnviedField(varName: 'KEY_CLOAK_REDIRECT_URI')
  static const String appRedirectUri = _EnvProd.appRedirectUri;

  @EnviedField(varName: 'KEY_CLOAK_LOGOUT_REDIRECT_URI')
  static const String logoutRedirectUri = _EnvProd.logoutRedirectUri;

  @EnviedField(varName: 'KEY_CLOAK_CLIENTID')
  static const String clientId = _EnvProd.clientId;

  @EnviedField(varName: 'KEY_CLOAK_CLIENT_SECRET')
  static const String clientSecret = _EnvProd.clientSecret;
}
