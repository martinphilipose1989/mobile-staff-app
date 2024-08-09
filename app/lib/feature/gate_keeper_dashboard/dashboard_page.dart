import 'package:app/base/app_base_page.dart';
import 'package:app/di/states/viewmodels.dart';
import 'package:app/feature/gate_keeper_dashboard/dashboard_page_view.dart';
import 'package:app/feature/gate_keeper_dashboard/dashboard_page_viewmodel.dart';
import 'package:app/feature/gate_managment/visitor_list/visitor_list_page.dart';
import 'package:app/feature/splash/splash_page.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/stream_builder/app_stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class DashboardPage extends BasePage<DashboardPageViewModel> {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState
    extends AppBasePageState<DashboardPageViewModel, DashboardPage> {
  @override
  Widget buildView(BuildContext context, DashboardPageViewModel model) {
    return DashboardPageView(provideBase());
  }

  @override
  ProviderBase<DashboardPageViewModel> provideBase() {
    return dashboardPageViewModelProvider;
  }

  @override
  Color scaffoldBackgroundColor() => Colors.white;

  @override
  Widget? buildBottomNavigationBar(DashboardPageViewModel model) {
    return DashboardBottomNavigation(model: model);
  }
}

class DashboardBottomNavigation extends StatelessWidget {
  const DashboardBottomNavigation({super.key, required this.model});

  final DashboardPageViewModel model;

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<int>(
        initialData: model.selectedIndex.value,
        stream: model.selectedIndex,
        dataBuilder: (context, data) {
          return BottomNavigationBar(
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
                model.selectedIndex.value = index;
              } else if (index == 1) {
                model.selectedIndex.value = index;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SplashPage())).then((_) {
                  model.selectedIndex.value = 0;
                });
              } else if (index == 2) {
                model.selectedIndex.value = index;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VisitorListPage(),
                  ),
                ).then((_) {
                  model.selectedIndex.value = 0;
                });
              }
            },
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(AppImages.homeBottomIcon),
                  label: "Home",
                  activeIcon: SvgPicture.asset(AppImages.homeActiveBottomIcon)),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(AppImages.qrBottomIcon),
                  label: "Scan QR"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(AppImages.gatePassBottomIcon),
                  label: "Create Gate-pass")
            ],
          );
        });
  }
}
