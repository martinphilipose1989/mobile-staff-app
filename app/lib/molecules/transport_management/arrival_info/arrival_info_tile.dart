import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ArrivalInfoTile extends StatelessWidget {
  final String vehicleNumber;
  final String startTime;
  final int totalStudents;

  const ArrivalInfoTile(
      {super.key,
      required this.vehicleNumber,
      required this.startTime,
      required this.totalStudents});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CommonOutlineButton(
          icon: SvgPicture.asset(AppImages.bus),
          elevation: 0,
          borderRadius: 8,
          title: vehicleNumber,
          onPressed: () {},
          titleTextStyle: AppTypography.caption.copyWith(),
          foregroundColor: AppColors.textDark,
          borderSide: const BorderSide(color: AppColors.textPalerGray),
        ),
        const SizedBox(width: 8),
        CommonOutlineButton(
          icon: SvgPicture.asset(AppImages.clockIcon),
          elevation: 0,
          borderRadius: 8,
          title: startTime,
          onPressed: () {},
          titleTextStyle: AppTypography.caption.copyWith(),
          foregroundColor: AppColors.textDark,
          borderSide: const BorderSide(color: AppColors.textPalerGray),
        ),
        const SizedBox(width: 8),
        Expanded(
          //  flex: 2,
          child: CommonOutlineButton(
            icon: SvgPicture.asset(AppImages.userIcon),
            elevation: 0,
            borderRadius: 8,
            title: "$totalStudents Students",
            onPressed: () {},
            titleTextStyle: AppTypography.caption.copyWith(),
            foregroundColor: AppColors.textDark,
            borderSide: const BorderSide(color: AppColors.textPalerGray),
          ),
        ),
      ],
    );
  }
}
