import 'package:app/themes_setup.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localisation/strings.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:themes/themes.dart';
import 'navigation/app_router.dart';
import 'navigation/route_paths.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      defaultThemeMode: ThemeMode.light,
      themes: getThemes(context),
      builder: (context, regularTheme, darkTheme, themeMode) {
        return ScreenUtilInit(
            designSize: const Size(390, 844),
            builder: (context, child) {
              return GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: MaterialApp(
                    navigatorKey: navigatorKey,
                    builder: (context, widget) => ResponsiveBreakpoints.builder(
                          child: widget!,
                          breakpoints: [
                            const Breakpoint(start: 0, end: 450, name: MOBILE),
                            const Breakpoint(
                                start: 451, end: 800, name: TABLET),
                            const Breakpoint(
                                start: 801, end: 1920, name: DESKTOP),
                            const Breakpoint(
                                start: 1921, end: double.infinity, name: '4K'),
                          ],
                        ),
                    supportedLocales: [
                      ...Strings.delegate.supportedLocales,
                      const Locale("af"),
                      const Locale("am"),
                      const Locale("ar"),
                      const Locale("az"),
                      const Locale("be"),
                      const Locale("bg"),
                      const Locale("bn"),
                      const Locale("bs"),
                      const Locale("ca"),
                      const Locale("cs"),
                      const Locale("da"),
                      const Locale("de"),
                      const Locale("el"),
                      const Locale("en"),
                      const Locale("es"),
                      const Locale("et"),
                      const Locale("fa"),
                      const Locale("fi"),
                      const Locale("fr"),
                      const Locale("gl"),
                      const Locale("ha"),
                      const Locale("he"),
                      const Locale("hi"),
                      const Locale("hr"),
                      const Locale("hu"),
                      const Locale("hy"),
                      const Locale("id"),
                      const Locale("is"),
                      const Locale("it"),
                      const Locale("ja"),
                      const Locale("ka"),
                      const Locale("kk"),
                      const Locale("km"),
                      const Locale("ko"),
                      const Locale("ku"),
                      const Locale("ky"),
                      const Locale("lt"),
                      const Locale("lv"),
                      const Locale("mk"),
                      const Locale("ml"),
                      const Locale("mn"),
                      const Locale("ms"),
                      const Locale("nb"),
                      const Locale("nl"),
                      const Locale("nn"),
                      const Locale("no"),
                      const Locale("pl"),
                      const Locale("ps"),
                      const Locale("pt"),
                      const Locale("ro"),
                      const Locale("ru"),
                      const Locale("sd"),
                      const Locale("sk"),
                      const Locale("sl"),
                      const Locale("so"),
                      const Locale("sq"),
                      const Locale("sr"),
                      const Locale("sv"),
                      const Locale("ta"),
                      const Locale("tg"),
                      const Locale("th"),
                      const Locale("tk"),
                      const Locale("tr"),
                      const Locale("tt"),
                      const Locale("uk"),
                      const Locale("ug"),
                      const Locale("ur"),
                      const Locale("uz"),
                      const Locale("vi"),
                      const Locale("zh")
                    ],
                    localizationsDelegates: const [
                      Strings.delegate,
                      CountryLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate
                    ],
                    onGenerateTitle: (context) => Strings.of(context).appName,
                    debugShowCheckedModeBanner: false,
                    initialRoute: RoutePaths.splash,
                    theme: regularTheme,
                    darkTheme: darkTheme,
                    themeMode: themeMode,
                    onGenerateRoute: AppRouter.generateRoute),
              );
            });
      },
    );
  }
}
