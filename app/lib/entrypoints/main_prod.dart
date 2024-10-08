import 'package:app/app.dart';
import 'package:app/env/env_prod.dart';
import 'package:app/flavors/flavor.dart';
import 'package:app/flavors/flavor_config.dart';
import 'package:app/flavors/flavor_values.dart';
import 'package:app/secrets/app_secrets.dart';

void main() {
  FlavorConfig.initialize(
    flavor: Flavor.prod,
    values: const FlavorValues(
      academicsUrl: EnvProd.academicsBaseUrl,
      apiBaseUrl: EnvProd.baseUrl,
      mdmBaseUrl: EnvProd.mdmBaseUrl,
      transportUrl: EnvProd.transportBaseUrl,
      authorizationEndpoint: EnvProd.authorizationEndpoint,
      tokenEndpoint: EnvProd.tokenEndpoint,
      logoutEndpoint: EnvProd.logoutEndpoint,
      discoveryUrl: EnvProd.discoveryUrl,
      secrets: AppSecrets.appSecretsProd,
    ),
  );
  startApp();
}
