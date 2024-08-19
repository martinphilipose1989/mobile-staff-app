import 'package:app/navigation/route_paths.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';

import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

import 'splash_page_model.dart';

class SplashPageView extends BasePageViewWidget<SplashViewModel> {
  SplashPageView(super.model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.splashImage), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Text("STAFF MANAGMENT",
              style: AppTypography.h4.copyWith(color: Colors.white)),
          const Spacer(),
          CommonPrimaryElevatedButton(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(RoutePaths.dashboard);
              },
              title: 'Lets Get Started',
              titleTextStyle: AppTypography.subtitle2),
          SizedBox(height: 16.h)
        ],
      ),
    );
  }
}
