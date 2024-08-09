import 'package:app/base/app_base_page.dart';
import 'package:app/di/states/viewmodels.dart';
import 'package:app/feature/gate_keeper_dashboard/dashboard_page_view.dart';
import 'package:app/feature/gate_keeper_dashboard/dashboard_page_viewmodel.dart';

import 'package:app/molecules/dashboard/dashboard_bottom_navigation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class DashboardPage extends BasePage<DashboardPageViewModel> {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState
    extends AppBasePageState<DashboardPageViewModel, DashboardPage> {
  @override
  Widget buildView(BuildContext context, DashboardPageViewModel model) {
    return DashboardPageView(provideBase());
  }

  @override
  ProviderBase<DashboardPageViewModel> provideBase() {
    return dashboardPageViewModelProvider;
  }

  @override
  Color scaffoldBackgroundColor() => Colors.white;

  @override
  Widget? buildBottomNavigationBar(DashboardPageViewModel model) {
    return DashboardBottomNavigation(model: model);
  }
}
