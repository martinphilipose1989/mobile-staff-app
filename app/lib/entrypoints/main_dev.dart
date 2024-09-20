import 'package:app/app.dart';
import 'package:app/env/env_dev.dart';
import 'package:app/flavors/flavor.dart';
import 'package:app/flavors/flavor_config.dart';
import 'package:app/flavors/flavor_values.dart';
import 'package:app/secrets/app_secrets.dart';

void main() {
  FlavorConfig.initialize(
    flavor: Flavor.dev,
    values: const FlavorValues(
      apiBaseUrl: EnvDev.baseUrl,
      mdmBaseUrl: EnvDev.mdmBaseUrl,
      authorizationEndpoint: EnvDev.authorizationEndpoint,
      tokenEndpoint: EnvDev.tokenEndpoint,
      logoutEndpoint: EnvDev.logoutEndpoint,
      discoveryUrl: EnvDev.discoveryUrl,
      secrets: AppSecrets.appSecretsDev,
      logSqlStatements: true,
      showLogs: true,
      useFakeData: false,
    ),
  );
  startApp();
}
