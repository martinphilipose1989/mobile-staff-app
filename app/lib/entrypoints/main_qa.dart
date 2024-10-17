import 'package:app/app.dart';
import 'package:app/env/env_qa.dart';
import 'package:app/flavors/flavor.dart';
import 'package:app/flavors/flavor_config.dart';
import 'package:app/flavors/flavor_values.dart';
import 'package:app/secrets/app_secrets.dart';

void main() {
  FlavorConfig.initialize(
    flavor: Flavor.qa,
    values: const FlavorValues(
        academicsUrl: EnvQa.academicsBaseUrl,
        apiBaseUrl: EnvQa.baseUrl,
        mdmBaseUrl: EnvQa.mdmBaseUrl,
        transportUrl: EnvQa.transportBaseUrl,
        authorizationEndpoint: EnvQa.authorizationEndpoint,
        tokenEndpoint: EnvQa.tokenEndpoint,
        logoutEndpoint: EnvQa.logoutEndpoint,
        discoveryUrl: EnvQa.discoveryUrl,
        secrets: AppSecrets.appSecretsQA,
        mdmToken: EnvQa.mdmToken),
  );
  startApp();
}
