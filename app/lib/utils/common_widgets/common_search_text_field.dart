import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommonSearchTextField extends StatelessWidget {
  const CommonSearchTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.prefixIcon,
    this.onChanged,
  });

  final TextEditingController controller;
  final String? hintText;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: REdgeInsets.only(left: 16, right: 16),
          child: prefixIcon ?? SvgPicture.asset(AppImages.searchIcon),
        ),
        hintStyle: AppTypography.subtitle1.copyWith(fontFamily: 'Poppins'),
        hintText: hintText ?? "Search Visitor",
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.textLightGray),
          borderRadius: BorderRadius.all(
            Radius.circular(40.r),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.textLightGray),
          borderRadius: BorderRadius.all(
            Radius.circular(40.r),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.textLightGray),
          borderRadius: BorderRadius.all(
            Radius.circular(40.r),
          ),
        ),
      ),
    );
  }
}
