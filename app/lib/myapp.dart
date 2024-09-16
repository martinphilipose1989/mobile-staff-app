import 'dart:async';

import 'package:app/themes_setup.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localisation/strings.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:themes/themes.dart';
import 'navigation/app_router.dart';
import 'navigation/route_paths.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();

    initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();

    super.dispose();
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // Handle links
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      debugPrint('onAppLink: $uri');
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    navigatorKey.currentState?.pushNamed(RoutePaths.visitorListPage);
  }

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
                    localizationsDelegates: const [
                      Strings.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate
                    ],
                    supportedLocales: Strings.delegate.supportedLocales,
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
