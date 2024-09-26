import 'package:app/base/app_base_page.dart';
import 'package:app/di/states/viewmodels.dart';
import 'package:app/feature/gate_management/visitor_details/visitor_details_page_view.dart';
import 'package:app/feature/gate_management/visitor_details/visitor_details_viewmodel.dart';
import 'package:app/utils/common_widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class VisitorDetailsPage extends BasePage<VisitorDetailsViewModel> {
  const VisitorDetailsPage(
      {super.key, required this.gatePassId, this.visitorType});

  final String gatePassId;
  final String? visitorType;

  @override
  VisitorDetailsPageState createState() => VisitorDetailsPageState();
}

class VisitorDetailsPageState
    extends AppBasePageState<VisitorDetailsViewModel, VisitorDetailsPage> {
  @override
  Widget buildView(BuildContext context, VisitorDetailsViewModel model) {
    return VisitorDetailsPageView(provideBase(), gatePassId: widget.gatePassId);
  }

  @override
  Color scaffoldBackgroundColor() => Colors.white;

  @override
  ProviderBase<VisitorDetailsViewModel> provideBase() {
    return visitorDetailsViewModelProvider;
  }

  @override
  PreferredSizeWidget? buildAppbar(VisitorDetailsViewModel model) {
    return const CommonAppBar(
      appbarTitle: "Gate Pass",
      showBackButton: true,
      notShowNotificationAndUserBatch: true,
    );
  }

  @override
  void onModelReady(VisitorDetailsViewModel model) {
    model.getVisitorDetails(gatePassId: widget.gatePassId);
    super.onModelReady(model);
  }
}