import 'package:app/base/app_base_page.dart';
import 'package:app/di/states/viewmodels.dart';

import 'package:app/utils/common_widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

import 'bus_route_list_page_viewmodel.dart';
import 'bus_route_list_page_pageview.dart';

class BusRouteListPage extends BasePage<BusRouteListPageViewModel> {
  const BusRouteListPage({super.key});

  @override
  BusChecklistPageState createState() => BusChecklistPageState();
}

class BusChecklistPageState
    extends AppBasePageState<BusRouteListPageViewModel, BusRouteListPage> {
  @override
  Widget buildView(BuildContext context, BusRouteListPageViewModel model) {
    return BusRouteListPageView(provideBase());
  }

  @override
  ProviderBase<BusRouteListPageViewModel> provideBase() {
    return busRouteListPageViewModelProvider;
  }

  @override
  Color scaffoldBackgroundColor() {
    return Colors.white;
  }

  @override
  void onModelReady(BusRouteListPageViewModel model) {
    model.exceptionHandlerBinder.bind(context, super.stateObserver);
    //getViewModel()
    model.trip = ProviderScope.containerOf(context)
        .read(busChecklistPageViewModelProvider)
        .trip;
    model.getBusStopsList();
    super.onModelReady(model);
  }

  @override
  PreferredSizeWidget? buildAppbar(BusRouteListPageViewModel model) {
    return CommonAppBar(
        showBackButton: true,
        appbarTitle:
            "School To ${model.trip?.routeStopMapping?.last.stop?.stopName ?? '--'}");
  }
}
