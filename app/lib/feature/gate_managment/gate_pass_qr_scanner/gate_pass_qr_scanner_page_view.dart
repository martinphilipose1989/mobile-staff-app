import 'package:app/feature/gate_managment/gate_pass_qr_scanner/gate_pass_qr_scanner_viewmodel.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/common_qr_scanner/qr_scanner_widget.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class GatePassQrScannerPageView
    extends BasePageViewWidget<GatePassQrScannerViewModel> {
  // ignore: use_super_parameters
  GatePassQrScannerPageView(
    ProviderBase<GatePassQrScannerViewModel> model,
  ) : super(model);

  @override
  Widget build(
    BuildContext context,
    GatePassQrScannerViewModel model,
  ) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset.zero),
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.8,
    );

    model.isUpdateOutGoingTime.listen((data) {
      if (data) {
        Navigator.pop(context);
      }
    });
    
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          CommonText(
            text: "Scan QR Code",
            style: AppTypography.subtitle1.copyWith(
              color: AppColors.textDark,
              fontSize: 16.sp,
              height: 1.1,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          CommonText(
            text: "Please QR Inside The Frame To Scan",
            style: AppTypography.subtitle1.copyWith(
              color: AppColors.textGray,
              fontSize: 16.sp,
              height: 1.1,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          StreamBuilder<bool>(
              stream: model.isLoading.stream,
              builder: (context, snapshot) {
                bool isLoading = snapshot.data ?? false;

                if (isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return QrScannerWidget(
                  model.controller,
                  scanWindow,
                  onDetect: (barcodes) {
                    // Additional processing can be done here
                  },
                  scannerResult: model.scannerResult,
                );
              }),
          const Spacer(),
        ],
      ),
    );
  }
}
