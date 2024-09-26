import 'package:app/base/app_base_page.dart';
import 'package:app/di/states/viewmodels.dart';

import 'package:app/utils/common_widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

import 'bus_route_details_page_viewmodel.dart';
import 'bus_route_details_pageview.dart';

class BusRouteDetailsPage extends BasePage<BusRouteDetailsPageViewModel> {
  const BusRouteDetailsPage({super.key});

  @override
  BusChecklistPageState createState() => BusChecklistPageState();
}

class BusChecklistPageState extends AppBasePageState<
    BusRouteDetailsPageViewModel, BusRouteDetailsPage> {
  @override
  Widget buildView(BuildContext context, BusRouteDetailsPageViewModel model) {
    return BusRouteDetailsPageView(provideBase());
  }

  @override
  ProviderBase<BusRouteDetailsPageViewModel> provideBase() {
    return busRouteDetailsPageViewModelProvider;
  }

  @override
  Color scaffoldBackgroundColor() {
    return Colors.white;
  }

  @override
  void onModelReady(BusRouteDetailsPageViewModel model) {
    model.exceptionHandlerBinder.bind(context, super.stateObserver);
    //getViewModel()
    super.onModelReady(model);
  }

  @override
  PreferredSizeWidget? buildAppbar(BusRouteDetailsPageViewModel model) {
    return const CommonAppBar(appbarTitle: "PBD To MLD");
  }
}