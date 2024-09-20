import 'dart:developer';

import 'package:app/di/states/viewmodels.dart';
import 'package:app/feature/gate_keeper_dashboard/dashboard_page_viewmodel.dart';
import 'package:app/feature/gate_managment/create_edit_gate_pass/create_edit_gate_pass_page.dart';
import 'package:app/feature/gate_managment/gate_pass_qr_scanner/gate_pass_qr_scanner_page.dart';

import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/stream_builder/app_stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DashboardBottomNavigation extends StatelessWidget {
  DashboardBottomNavigation({super.key, required this.model});

  final DashboardPageViewModel model;

  String selectedStatus = '';
  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<int>(
        initialData: model.selectedIndex.value,
        stream: model.selectedIndex,
        dataBuilder: (context, data) {
          return SafeArea(
            bottom: true,
            maintainBottomViewPadding: true,
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: data!,
              selectedLabelStyle:
                  AppTypography.caption.copyWith(color: AppColors.primary),
              selectedFontSize: 12.sp,
              unselectedFontSize: 12.sp,
              unselectedLabelStyle:
                  AppTypography.caption.copyWith(color: AppColors.textGray),
              onTap: (index) {
                if (index == 0) {
                  ProviderScope.containerOf(context)
                      .read(visitorListPageModelProvider)
                      .onVisitStatusSelect(selectStatus: "In");

                  model.selectedIndex.value = index;
                } else if (index == 1) {
                  model.selectedIndex.value = index;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const GatePassQrScannerPage())).then((val) {
                    log("GatePassQrScannerPage VALUE ==> $val");
                    if (val == "In") {
                      model.selectedSatus.value = "In";
                    } else {
                      model.selectedSatus.value = "Out";
                    }

                    model.selectedIndex.value = 0;
                    log("It works");
                  });
                } else if (index == 2) {
                  model.selectedIndex.value = index;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateEditGatePassPage(),
                    ),
                  ).then((val) {
                    log("CreateEditGatePassPage VALUE ==> $val");
                    model.selectedSatus.value = "In";
                    model.selectedIndex.value = 0;
                  });
                }
              },
              items: [
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(AppImages.homeBottomIcon),
                    label: "Home",
                    activeIcon:
                        SvgPicture.asset(AppImages.homeActiveBottomIcon)),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(AppImages.qrBottomIcon),
                    label: "Scan QR"),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(AppImages.gatePassBottomIcon),
                    label: "Create Gate-pass")
              ],
            ),
          );
        });
  }
}
