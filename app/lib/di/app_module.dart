import 'package:app/flavors/flavor_config.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @Named("BaseUrl")
  String get baseUrl => FlavorConfig.instance.values.apiBaseUrl;

  @Named("ApiKey")
  String get apiKey => FlavorConfig.instance.values.secrets.thirdpartyApiKey;

  @Named("MDMUrl")
  String get mdmBaseUrl => FlavorConfig.instance.values.mdmBaseUrl;

  @Named("TransportUrl")
  String get transportBaseUrl => FlavorConfig.instance.values.transportUrl;

  @Named("AcademicsUrl")
  String get academicsBaseUrl => FlavorConfig.instance.values.academicsUrl;

  @Named("AuthUrl")
  String get authUrl => FlavorConfig.instance.values.authorizationEndpoint;

  @Named("TokenUrl")
  String get tokeUrl => FlavorConfig.instance.values.tokenEndpoint;

  @Named("LogOutUrl")
  String get logOutUrl => FlavorConfig.instance.values.logoutEndpoint ?? "";

  @Named("AppUri")
  String get redirectUri => FlavorConfig.instance.values.secrets.appRedirectUri;

  @Named("ClientId")
  String get clientId => FlavorConfig.instance.values.secrets.clientId;

  @Named("ClientSecret")
  String get clientSecret => FlavorConfig.instance.values.secrets.clientSecret;

  @Named("LogOutUri")
  String get logOutRedirectUri =>
      FlavorConfig.instance.values.secrets.logoutRedirectUri;

  @Named("DiscoveryUrl")
  String get discoveryUrl => FlavorConfig.instance.values.discoveryUrl;
}
