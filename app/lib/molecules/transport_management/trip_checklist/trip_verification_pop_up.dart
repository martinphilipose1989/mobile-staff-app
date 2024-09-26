import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_image_widget.dart';
import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:app/utils/enum/dialog_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TripVerificationPopUp extends StatelessWidget {
  const TripVerificationPopUp(
      {super.key,
      required this.header,
      required this.name,
      required this.info,
      required this.positiveCallback,
      required this.negativeCallback,
      required this.negativeText,
      required this.imageUrl,
      required this.type});

  final String header;
  final String name;
  final String info;
  final String imageUrl;

  final String negativeText;
  final VoidCallback positiveCallback;
  final VoidCallback negativeCallback;
  final DialogType type;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      insetPadding: EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText(text: header),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonImageWidget(
            imageUrl: imageUrl,
            fallbackAssetImagePath: type == DialogType.driver
                ? AppImages.defaultDriverAvatar
                : AppImages.defaultTeacherAvatar,
            imageWidth: 125.w,
            imageHeight: 125.h,
            clipBehavior: Clip.hardEdge,
          ),
          const SizedBox(height: 16),
          CommonText(
              text: name, color: AppColors.textDark, style: AppTypography.h6),
          const SizedBox(height: 4),
          CommonText(
              text: info,
              color: AppColors.textGray,
              style: AppTypography.body2),
        ],
      ),
      actions: [
        CommonPrimaryElevatedButton(
          elevation: 0,
          title: negativeText,
          backgroundColor: AppColors.textPalerGray,
          foregroundColor: AppColors.textGray,
          icon: SvgPicture.asset(
            AppImages.callIcon,
            colorFilter:
                const ColorFilter.mode(AppColors.textGray, BlendMode.srcIn),
          ),
          onPressed: negativeCallback,
        ),
        CommonPrimaryElevatedButton(
          elevation: 0,
          title: "Yes Verify",
          icon: SvgPicture.asset(
            AppImages.checkMark,
            colorFilter:
                const ColorFilter.mode(AppColors.primaryOn, BlendMode.srcIn),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          onPressed: positiveCallback,
        )
      ],
    );
  }
}