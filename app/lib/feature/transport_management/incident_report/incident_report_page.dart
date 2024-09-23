import 'package:app/base/app_base_page.dart';
import 'package:app/di/states/viewmodels.dart';

import 'package:app/utils/common_widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

import 'incident_report_page_viewmodel.dart';
import 'incident_report_pageview.dart';

class IncidentReportPage extends BasePage<IncidentReportPageViewModel> {
  const IncidentReportPage({super.key});

  @override
  IncidentReportPageState createState() => IncidentReportPageState();
}

class IncidentReportPageState
    extends AppBasePageState<IncidentReportPageViewModel, IncidentReportPage> {
  @override
  Widget buildView(BuildContext context, IncidentReportPageViewModel model) {
    return IncidentReportPageView(provideBase());
  }

  @override
  ProviderBase<IncidentReportPageViewModel> provideBase() {
    return incidentReportPageViewModelProvider;
  }

  @override
  Color scaffoldBackgroundColor() {
    return Colors.white;
  }

  @override
  void onModelReady(IncidentReportPageViewModel model) {
    model.exceptionHandlerBinder.bind(context, super.stateObserver);
    //getViewModel()
    super.onModelReady(model);
  }

  @override
  PreferredSizeWidget? buildAppbar(IncidentReportPageViewModel model) {
    return const CommonAppBar(appbarTitle: "Incident Report");
  }
}
