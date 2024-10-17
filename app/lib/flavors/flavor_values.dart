import 'package:app/secrets/app_secrets.dart';

class FlavorValues {
  final String apiBaseUrl;
  final AppSecrets secrets;
  final bool useFakeData;
  final bool showLogs;
  final bool _logSqlStatements;
  final String mdmBaseUrl;
  final String authorizationEndpoint;
  final String tokenEndpoint;
  final String? logoutEndpoint;
  final String discoveryUrl;
  final String transportUrl;
  final String academicsUrl;
  final String mdmToken;

  const FlavorValues({
    required this.transportUrl,
    required this.apiBaseUrl,
    required this.secrets,
    required this.mdmBaseUrl,
    required this.authorizationEndpoint,
    required this.tokenEndpoint,
    required this.academicsUrl,
    required this.discoveryUrl,
    required this.mdmToken,
    this.logoutEndpoint,
    logSqlStatements = false,
    this.showLogs = false,
    this.useFakeData = false,
  }) : _logSqlStatements = showLogs && logSqlStatements;

  bool get logSqlStatements => _logSqlStatements;
}
