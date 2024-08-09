// ignore_for_file: use_super_parameters

import 'package:app/feature/gate_keeper_dashboard/dashboard_page_viewmodel.dart';
import 'package:app/feature/gate_managment/visitor_list/visitor_list_page.dart';
import 'package:app/utils/stream_builder/app_stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class DashboardPageView extends BasePageViewWidget<DashboardPageViewModel> {
  DashboardPageView(ProviderBase<DashboardPageViewModel> model) : super(model);

  @override
  Widget build(BuildContext context, DashboardPageViewModel model) {
    return AppStreamBuilder(
        stream: model.selectedIndex,
        initialData: model.selectedIndex.value,
        dataBuilder: (context, data) {
          if (model.selectedIndex.value == 0) {
            return const VisitorListPage();
          }
          return const Center(child: Text("DASHBOARD"));
        });
  }
}
