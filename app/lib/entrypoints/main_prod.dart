import 'package:app/app.dart';
import 'package:app/flavors/flavor.dart';
import 'package:app/flavors/flavor_config.dart';
import 'package:app/flavors/flavor_values.dart';
import 'package:app/secrets/app_secrets.dart';

void main() {
  FlavorConfig.initialize(
    flavor: Flavor.prod,
    values: const FlavorValues(
      apiBaseUrl: "https://gate-management-r26sp3mibq-uc.a.run.app/",
      secrets: AppSecrets.appSecretsProd,
    ),
  );
  startApp();
}
