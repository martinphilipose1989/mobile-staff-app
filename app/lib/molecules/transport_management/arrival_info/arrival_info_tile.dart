import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/common_outline_button.dart';
import 'package:flutter/material.dart';

class ArrivalInfoTile extends StatelessWidget {
  final String vehicleNumber;
  final String startTime;
  final String routeName;

  const ArrivalInfoTile(
      {super.key,
      required this.vehicleNumber,
      required this.startTime,
      required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CommonOutlineButton(
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
          elevation: 0,
          borderRadius: 8,
          title: startTime,
          onPressed: () {},
          titleTextStyle: AppTypography.caption.copyWith(),
          foregroundColor: AppColors.textDark,
          borderSide: const BorderSide(color: AppColors.textPalerGray),
        ),
        const SizedBox(width: 8),
        CommonOutlineButton(
          elevation: 0,
          borderRadius: 8,
          title: routeName,
          onPressed: () {},
          titleTextStyle: AppTypography.caption.copyWith(),
          foregroundColor: AppColors.textDark,
          borderSide: const BorderSide(color: AppColors.textPalerGray),
        ),
      ],
    );
  }
}
