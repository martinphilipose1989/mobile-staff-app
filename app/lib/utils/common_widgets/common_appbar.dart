import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:app/utils/string_formatter.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:themes/themes.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String appbarTitle;
  final bool? showBackButton;
  final bool? notShowNotificationAndUserBatch;
  final VoidCallback? onTapAction;

  const CommonAppBar(
      {super.key,
      required this.appbarTitle,
      this.showBackButton = false,
      this.notShowNotificationAndUserBatch = false,
      this.onTapAction})
      : preferredSize = const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarColor: AppColors.primaryLighter),
      backgroundColor: AppColors.primaryLighter,
      centerTitle: false,
      leading: showBackButton == true
          ? IconButton(
              icon: SvgPicture.asset(AppImages.backArrow),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: SvgPicture.asset(AppImages.menuHamburgerLogo,
                  height: 24.h, width: 24.w)),
      title: CommonText(
          text: appbarTitle,
          style: AppTypography.subtitle1,
          color: AppColors.textDark),
      iconTheme: Theme.of(context).appBarTheme.iconTheme,
      actions: (notShowNotificationAndUserBatch ?? false)
          ? []
          : [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: SvgPicture.asset(AppImages.notificationLogo),
                ),
              ),
              InkWell(
                onTap: () {
                  onTapAction?.call();
                },
                child: Container(
                  height: 32.h,
                  width: 32.w,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.00),
                      border: Border.all(color: AppColors.primary),
                      color: AppColors.primary.withOpacity(0.2)),
                  child: CommonText(
                    text: GetIt.I<SharedPreferencesService>()
                                .getFromDisk(CommonVariables.userInfoKey) ==
                            null
                        ? "SS"
                        : GetIt.I<SharedPreferencesService>()
                            .getFromDisk(CommonVariables.userInfoKey)
                            .toString()
                            .getInitials(),
                    style: const TextStyle(color: AppColors.primary),
                  ),
                ),
              )
            ],
    );
  }
}
