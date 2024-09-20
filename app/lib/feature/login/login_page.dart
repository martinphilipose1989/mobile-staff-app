import 'package:app/base/app_base_page.dart';
import 'package:app/di/states/viewmodels.dart';
import 'package:app/feature/login/login_pageview.dart';
import 'package:app/feature/login/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class LoginPage extends BasePage<LoginPageViewModel> {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends AppBasePageState<LoginPageViewModel, LoginPage> {
  @override
  Widget buildView(BuildContext context, LoginPageViewModel model) {
    return LoginPageView(provideBase());
  }

  @override
  ProviderBase<LoginPageViewModel> provideBase() => loginPageViewModelProvider;

  @override
  Color scaffoldBackgroundColor() {
    return Theme.of(context).colorScheme.primaryContainer;
  }
}
