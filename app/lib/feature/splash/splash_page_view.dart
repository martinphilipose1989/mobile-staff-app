// ignore_for_file: use_key_in_widget_constructors

import 'dart:developer';
import 'package:app/myapp.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';

import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

import 'splash_page_model.dart';

class SplashPageView extends BasePageViewWidget<SplashViewModel> {
  SplashPageView(super.model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.splashImage), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Text("STAFF MANAGMENT",
              style: AppTypography.h4.copyWith(color: Colors.white)),
          const Spacer(),
          CommonPrimaryElevatedButton(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              onPressed: () async {
                // final SharedPreferencesService sharedPreferencesService =
                //     GetIt.I<SharedPreferencesService>();

                // final value = sharedPreferencesService
                //     .getFromDisk(CommonVariables.tokenKey);

                // if (value != null) {
                //   Navigator.of(context)
                //       .pushReplacementNamed(RoutePaths.dashboard);
                // } else {
                //  Navigator.of(context).pushReplacementNamed(RoutePaths.webLogin);
                // }
                await authenticateWithKeycloak();
              },
              title: 'Lets Get Started',
              titleTextStyle: AppTypography.subtitle2),
          SizedBox(height: 16.h)
        ],
      ),
    );
  }

  final FlutterAppAuth appAuth = const FlutterAppAuth();

  Future<void> authenticateWithKeycloak() async {
    try {
      String clientId = "hubbleorion-gate-management-dev";
      const String appredirectUri = "gatemanagement://callback";

      String clientSecret = "lLAdLnD7bC4jowSaXJQW5RpJHFrGWAyS";
      String realm = "ampersand-internal-qa";
      String authorizationEndpoint =
          'https://qa.vgos.org/realms/$realm/protocol/openid-connect/auth';
      String tokenEndpoint =
          'https://qa.vgos.org/realms/$realm/protocol/openid-connect/token';
      //final result1      = await  appAuth.token(TokenRequest(clientId, appredirectUri));
      appAuth.endSession(
        EndSessionRequest(
          idTokenHint: "",
          postLogoutRedirectUrl: appredirectUri,
          serviceConfiguration: AuthorizationServiceConfiguration(
            authorizationEndpoint: authorizationEndpoint,
            tokenEndpoint: tokenEndpoint,
          ),
        ),
      );
      final result = await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(clientId, appredirectUri,
            serviceConfiguration: AuthorizationServiceConfiguration(
                authorizationEndpoint: authorizationEndpoint,
                tokenEndpoint: tokenEndpoint),
            scopes: [
              "openid",
              "web-origins",
              "acr",
              "profile",
              "roles",
              "Ampersand_AD_Attribute",
              "email"
            ],
            clientSecret: clientSecret),
      );

      log('Access token: ${result.accessToken}');
      result.idToken;
      result.refreshToken;

      log('ID token: ${result.idToken}');
      if (result.accessToken != null) {
        ScaffoldMessenger.of(navigatorKey.currentContext!)
            .showSnackBar(SnackBar(content: Text("${result.accessToken}")));
      }
    } catch (e) {
      log("ERROR $e");
    }
  }
}
