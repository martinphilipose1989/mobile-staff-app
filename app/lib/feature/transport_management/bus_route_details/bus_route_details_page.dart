import 'dart:developer';

import 'package:app/base/app_base_page.dart';
import 'package:app/di/states/viewmodels.dart';
import 'package:app/feature/transport_management/bus_route_list/bus_route_list_page_viewmodel.dart';

import 'package:app/utils/common_widgets/common_appbar.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

import 'bus_route_details_page_viewmodel.dart';
import 'bus_route_details_pageview.dart';

class BusRouteDetailsPage extends BasePage<BusRouteDetailsPageViewModel> {
  final BusRouteDetailsPageParams busRouteDetailsPageParams;
  const BusRouteDetailsPage(
      {super.key, required this.busRouteDetailsPageParams});

  @override
  BusChecklistPageState createState() => BusChecklistPageState();
}

class BusChecklistPageState extends AppBasePageState<
    BusRouteDetailsPageViewModel, BusRouteDetailsPage> {
  // ignore: prefer_typing_uninitialized_variables
  late final BusRouteListPageViewModel busListProvider;
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
  void initState() {
    super.initState();
    // Access the provider safely in initState or didChangeDependencies
    busListProvider = ProviderScope.containerOf(context, listen: false)
        .read(busRouteListPageViewModelProvider);
  }

  @override
  void dispose() {
    // Use the stored provider reference here
    //  busListProvider.updateLiveLocationStatus(true);
    super.dispose();
  }

  @override
  void onModelReady(BusRouteDetailsPageViewModel model) {
    model.exceptionHandlerBinder.bind(context, super.stateObserver);

    model.trip = widget.busRouteDetailsPageParams.trip ??
        ProviderScope.containerOf(context)
            .read(busRouteListPageViewModelProvider)
            .trip;
    log("TRIP ${model.trip}");
    model.stop = widget.busRouteDetailsPageParams.stop;
    model.isLastIndex = widget.busRouteDetailsPageParams.isLastIndex;
    model.dropStarted = widget.busRouteDetailsPageParams.dropStarted;
    getViewModel().getRouteStudentList(
        routeId: int.parse(model.trip?.id ?? ""), stopId: model.stop?.id);
    super.onModelReady(model);
  }

  @override
  PreferredSizeWidget? buildAppbar(BusRouteDetailsPageViewModel model) {
    return CommonAppBar(
      appbarTitle:
          "${model.trip?.routeStopMapping?.first.stop?.stopName ?? ""} To ${model.trip?.routeStopMapping?.last.stop?.stopName ?? ""}",
      showBackButton: true,
    );
  }
}

class BusRouteDetailsPageParams {
  final StopModel stop;
  final bool isLastIndex;
  final TripResult? trip;
  final bool? dropStarted;
  BusRouteDetailsPageParams(
      {required this.stop,
      required this.isLastIndex,
      required this.trip,
      required this.dropStarted});
}
