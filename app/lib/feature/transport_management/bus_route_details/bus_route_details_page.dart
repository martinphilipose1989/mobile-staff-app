import 'package:app/base/app_base_page.dart';
import 'package:app/di/states/viewmodels.dart';

import 'package:app/utils/common_widgets/common_appbar.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

import 'bus_route_details_page_viewmodel.dart';
import 'bus_route_details_pageview.dart';

class BusRouteDetailsPage extends BasePage<BusRouteDetailsPageViewModel> {
  final StopModel stop;
  const BusRouteDetailsPage({super.key, required this.stop});

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

    model.trip = ProviderScope.containerOf(context)
        .read(busRouteListPageViewModelProvider)
        .trip;
    model.stop = widget.stop;
    getViewModel().getRouteStudentList(
        routeId: int.parse(model.trip?.id ?? '1'), stopId: model.stop?.id ?? 1);
    super.onModelReady(model);
  }

  @override
  PreferredSizeWidget? buildAppbar(BusRouteDetailsPageViewModel model) {
    return CommonAppBar(
      appbarTitle: "${model.trip?.routeStopMapping?.firstWhere(
            (element) => element.stop?.orderBy == 1,
          ).stop?.stopName ?? ""} To ${model.trip?.routeStopMapping?.firstWhere(
            (element) => element.stop?.orderBy == 7,
          ).stop?.stopName ?? ""}",
      showBackButton: true,
    );
  }
}
