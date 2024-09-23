import 'package:app/molecules/transport_management/arrival_info/arrival_info_tile.dart';
import 'package:app/molecules/transport_management/trip_list/completed_trip_list_tile.dart';
import 'package:app/molecules/transport_management/trip_list/upcoming_trip_list_tile.dart';

import 'package:app/utils/common_widgets/toggle_option_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

import 'transport_dashboard_page_viewmodel.dart';

class TransportDashboardPageView
    extends BasePageViewWidget<TransportDashboardPageViewModel> {
  // ignore: use_super_parameters
  TransportDashboardPageView(
      ProviderBase<TransportDashboardPageViewModel> model)
      : super(model);

  @override
  Widget build(BuildContext context, TransportDashboardPageViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsets.all(16.0),
          child: ToggleOptionList<String>(
              selectedValue: model.selectedTripStatus,
              options: model.tripStatusType,
              onSelect: (value) => {}),
        ),
        const UpcomingTripListTile(),
        const CompletedTripListTile(),
        const ArrivalInfoTile(
          vehicleNumber: "MH47-PK-9386",
          startTime: "7:00 AM",
          routeName: "Prabhadevi",
        )
      ],
    );
  }
}
