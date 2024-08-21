import 'package:app/feature/gate_managment/gate_pass_qr_scanner/gate_pass_qr_scanner_viewmodel.dart';
import 'package:app/model/resource.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/common_qr_scanner/qr_scanner_widget.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:app/utils/data_status_widget.dart';
import 'package:app/utils/stream_builder/app_stream_builder.dart';
import 'package:domain/domain.dart';

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

    return StreamBuilder<bool>(
        stream: model.navigateToHomeScreenStream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!) {
            // Navigate to the Home screen when the condition is met
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
            });
          }

          return Stack(
            children: [
              SizedBox(
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
                    QrScannerWidget(
                      model.controller,
                      scanWindow,
                      onDetect: (barcodes) {
                        // Additional processing can be done here
                      },
                      scannerResult: model.scannerResult,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              AppStreamBuilder<Resource<VisitorDataModel>>(
                stream: model.visitorDetails,
                initialData: Resource.none(),
                dataBuilder: (context, visitorData) {
                  return DataStatusWidget(
                      status: visitorData?.status ?? Status.none,
                      loadingWidget: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                      successWidget: () {
                        return const SizedBox.shrink();
                      });
                },
              ),
            ],
          );
        });
  }
}
