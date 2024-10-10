import 'package:app/feature/transport_management/incident_report/incident_report_page.dart';
import 'package:app/feature/transport_management/my_duty/my_duty_page.dart';
import 'package:app/utils/stream_builder/app_stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    return AppStreamBuilder(
        stream: model.selectedIndex,
        initialData: model.selectedIndex.value,
        dataBuilder: (context, data) {
          if (model.selectedIndex.value == 0) {
            return const MyDutyPage();
          } else if (model.selectedIndex.value == 1) {
            return const IncidentReportPage();
          }
          return const SizedBox.shrink();
        });
  }
}
