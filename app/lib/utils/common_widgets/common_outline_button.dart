import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonOutlineButton extends StatelessWidget {
  const CommonOutlineButton(
      {super.key,
      required this.title,
      this.titleTextStyle,
      this.isLoading = false,
      this.isDisabled = false,
      required this.onPressed,
      this.backgroundColor,
      this.foregroundColor,
      this.loaderColor,
      this.shadowColor,
      this.elevation = 2,
      this.height,
      this.width,
      this.disabledForegroundColor,
      this.disabledBackgroundColor});

  final VoidCallback onPressed;
  final String title;
  final TextStyle? titleTextStyle;
  final bool isDisabled;
  final bool isLoading;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? disabledForegroundColor;
  final Color? disabledBackgroundColor;
  final Color? loaderColor;
  final Color? shadowColor;
  final double elevation;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
          shadowColor: AppColors.shadowColor,
          backgroundColor: Colors.white,
          elevation: 2,
          foregroundColor: AppColors.textGray,
          fixedSize: Size(double.infinity, 40.h)),
      child: Text(
        "Cancel",
        style: AppTypography.subtitle2.copyWith(fontSize: 14.sp),
      ),
    );
  }
}
