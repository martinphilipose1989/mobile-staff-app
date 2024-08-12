import 'package:app/base/app_base_page.dart';
import 'package:app/di/states/viewmodels.dart';
import 'package:app/feature/gate_managment/gate_pass_qr_scanner/gate_pass_qr_scanner_page_view.dart';
import 'package:app/feature/gate_managment/gate_pass_qr_scanner/gate_pass_qr_scanner_viewmodel.dart';
import 'package:app/utils/common_widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class GatePassQrScannerPage extends BasePage<GatePassQrScannerViewModel> {
  const GatePassQrScannerPage({super.key});

  @override
  GatePassQrScannerPageState createState() => GatePassQrScannerPageState();
}

class GatePassQrScannerPageState extends AppBasePageState<
    GatePassQrScannerViewModel, GatePassQrScannerPage> {
  @override
  void onModelReady(GatePassQrScannerViewModel model) {
    model.listenToScannerResult();
  }

  @override
  Widget buildView(BuildContext context, GatePassQrScannerViewModel model) {
    return GatePassQrScannerPageView(provideBase());
  }

  @override
  Color scaffoldBackgroundColor() => Colors.white;

  @override
  ProviderBase<GatePassQrScannerViewModel> provideBase() {
    return gatePassQrScannerViewModelProvider;
  }

  @override
  PreferredSizeWidget? buildAppbar(GatePassQrScannerViewModel model) {
    return const CommonAppBar(
      appbarTitle: "Scan Gate-Pass",
      showBackButton: true,
      notShowNotificationAndUserBatch: true,
    );
  }
}
