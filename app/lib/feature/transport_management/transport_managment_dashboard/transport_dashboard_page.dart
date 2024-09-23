import 'package:app/base/app_base_page.dart';
import 'package:app/di/states/viewmodels.dart';
import 'package:app/feature/transport_management/transport_managment_dashboard/transport_dashboard_page_viewmodel.dart';
import 'package:app/feature/transport_management/transport_managment_dashboard/transport_dashboard_pageview.dart';
import 'package:app/utils/common_widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class TransportDashboardPage extends BasePage<TransportDashboardPageViewModel> {
  const TransportDashboardPage({super.key});

  @override
  TransportDashboardPageState createState() => TransportDashboardPageState();
}

class TransportDashboardPageState extends AppBasePageState<
    TransportDashboardPageViewModel, TransportDashboardPage> {
  @override
  ProviderBase<TransportDashboardPageViewModel> provideBase() {
    return transportDashboardPageViewModelProvider;
  }

  @override
  void onModelReady(TransportDashboardPageViewModel model) {
    model.exceptionHandlerBinder.bind(context, super.stateObserver);
    //getViewModel()
    super.onModelReady(model);
  }

  @override
  Widget buildView(
      BuildContext context, TransportDashboardPageViewModel model) {
    return TransportDashboardPageView(provideBase());
  }

  @override
  Color scaffoldBackgroundColor() {
    return Colors.white;
  }

  @override
  PreferredSizeWidget? buildAppbar(TransportDashboardPageViewModel model) {
    return const CommonAppBar(appbarTitle: "My Duty");
  }
}
