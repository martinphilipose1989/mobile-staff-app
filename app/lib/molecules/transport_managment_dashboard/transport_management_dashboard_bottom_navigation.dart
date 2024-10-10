import 'package:app/feature/transport_management/transport_managment_dashboard/transport_dashboard_page_viewmodel.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/stream_builder/app_stream_builder.dart';
import 'package:app/utils/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TransportManagementDashboardBottomNavigation extends StatelessWidget {
  const TransportManagementDashboardBottomNavigation(
      {super.key, required this.model});

  final TransportDashboardPageViewModel model;

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder(
      stream: model.selectedIndex,
      initialData: model.selectedIndex.value,
      dataBuilder: (context, data) {
        return SafeArea(
          bottom: true,
          maintainBottomViewPadding: true,
          child: BottomNavigationBar(
            onTap: (index) {
              model.selectedIndex.value = index;
              if (index == 2) {
                UrlLauncher.launchPhone("100");
              }
            },
            backgroundColor: Colors.white,
            currentIndex: data!,
            selectedLabelStyle: AppTypography.caption.copyWith(
                color: AppColors.primary, fontWeight: FontWeight.w500),
            selectedFontSize: 14.sp,
            unselectedFontSize: 12.sp,
            unselectedLabelStyle:
                AppTypography.caption.copyWith(color: AppColors.textGray),
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppImages.transport1),
                label: "My Duties",
              ),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(AppImages.transport2),
                  label: "Raise Incident"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(AppImages.transport3), label: "SOS")
            ],
          ),
        );
      },
    );
  }
}
