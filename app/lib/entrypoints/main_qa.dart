import 'package:app/app.dart';
import 'package:app/flavors/flavor.dart';
import 'package:app/flavors/flavor_config.dart';
import 'package:app/flavors/flavor_values.dart';
import 'package:app/secrets/app_secrets.dart';

void main() {
  FlavorConfig.initialize(
    flavor: Flavor.qa,
    values: const FlavorValues(
      apiBaseUrl: "https://gate-management-r26sp3mibq-uc.a.run.app/",
      mdmBaseUrl: "https://ampersand-r26sp3mibq-uc.a.run.app/api/co-reasons/",
      authorizationEndpoint:
          'https://qa.vgos.org/realms/ampersand-internal-qa/protocol/openid-connect/auth',
      tokenEndpoint:
          'https://qa.vgos.org/realms/ampersand-internal-qa/protocol/openid-connect/token',
      secrets: AppSecrets.appSecretsQA,
    ),
  );
  startApp();
}
