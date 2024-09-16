import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

import '../../base/app_base_page.dart';
import '../../di/states/viewmodels.dart';
import 'splash_page_model.dart';
import 'splash_page_view.dart';

class SplashPage extends BasePage<SplashViewModel> {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends AppBasePageState<SplashViewModel, SplashPage> {
  // final AppLinks _appLinks = AppLinks();
  // late final StreamSubscription<Uri?> _linkSubscription;

  // @override
  // void initState() {
  //   super.initState();
  //   log("SPLASH PAGE INIT");
  //   _initAppLinks();
  // }

  // Future<void> _initAppLinks() async {
  //   try {
  //     // Handle initial link if the app is launched with it
  //     final Uri? initialLink = await _appLinks.getInitialLink();
  //     if (initialLink != null) {
  //       log("Initial link received: $initialLink");
  //       _handleIncomingLink(initialLink);
  //     } else {
  //       log("No initial link received");
  //     }

  //     // Listen for any incoming links when the app is running
  //     _linkSubscription = _appLinks.uriLinkStream.listen(
  //       (Uri? link) {
  //         if (link != null) {
  //           log("Link received while app is running: $link");
  //           _handleIncomingLink(link);
  //         } else {
  //           log("Received null link");
  //         }
  //       },
  //       onError: (err) {
  //         log('Error handling incoming link: $err');
  //       },
  //     );
  //   } catch (e) {
  //     log('Error initializing app links: $e');
  //   }
  // }

  // void _handleIncomingLink(Uri link) {
  //   log('Handling incoming link: $link');

  //   if (link.scheme == "gatemanagement" && link.host == "callback") {
  //     log('Navigating to /visitorListPage');
  //     Navigator.pushNamedAndRemoveUntil(
  //       context,
  //       RoutePaths.visitorListPage,
  //       (route) => false,
  //     );
  //   } else {
  //     log('Link did not match expected format: $link');
  //   }
  // }

  // @override
  // void dispose() {
  //   _linkSubscription.cancel();
  //   super.dispose();
  // }

  @override
  ProviderBase<SplashViewModel> provideBase() {
    return splashViewModelProvider;
  }

  @override
  void onModelReady(SplashViewModel model) {
    // Bind exception handler here
    model.exceptionHandlerBinder.bind(context, super.stateObserver);
  }

  @override
  Widget buildView(BuildContext context, SplashViewModel model) {
    return SplashPageView(provideBase());
  }

  @override
  bool extendBodyBehindAppBar() {
    return true;
  }
}
