import 'package:app/base/app_base_page.dart';
import 'package:app/di/states/viewmodels.dart';

import 'package:app/utils/common_widgets/common_appbar.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

import 'bus_checklist_page_viewmodel.dart';
import 'bus_checklist_pageview.dart';

class BusChecklistPage extends BasePage<BusChecklistPageViewModel> {
  final TripResult tripResult;
  const BusChecklistPage({super.key, required this.tripResult});

  @override
  BusChecklistPageState createState() => BusChecklistPageState();
}

class BusChecklistPageState
    extends AppBasePageState<BusChecklistPageViewModel, BusChecklistPage> {
  @override
  Widget buildView(BuildContext context, BusChecklistPageViewModel model) {
    return BusChecklistPageView(provideBase());
  }

  @override
  ProviderBase<BusChecklistPageViewModel> provideBase() {
    return busChecklistPageViewModelProvider;
  }

  @override
  Color scaffoldBackgroundColor() {
    return Colors.white;
  }

  @override
  void onModelReady(BusChecklistPageViewModel model) {
    model.exceptionHandlerBinder.bind(context, super.stateObserver);
    //getViewModel()
    model.trip = widget.tripResult;
    super.onModelReady(model);
  }

  @override
  PreferredSizeWidget? buildAppbar(BusChecklistPageViewModel model) {
    return CommonAppBar(
      appbarTitle:
          "School To ${model.trip?.routeStopMapping?.last.stop?.stopName ?? '--'}",
      showBackButton: true,
    );
  }
}
