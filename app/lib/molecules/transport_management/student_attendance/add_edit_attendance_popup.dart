import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_image_widget.dart';
import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddEditAttendancePopup extends StatelessWidget {
  final String header;
  final String studentName;
  final VoidCallback onStudentPresentCallback;
  final VoidCallback onAbsentPresentCallback;

  const AddEditAttendancePopup({
    super.key,
    required this.header,
    required this.onStudentPresentCallback,
    required this.onAbsentPresentCallback,
    required this.studentName,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      insetPadding: EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText(text: header),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(AppImages.closeIcon),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonImageWidget(
            imageUrl: "imageUrl",
            fallbackAssetImagePath: AppImages.defaultStudentAvatar,
            imageWidth: 125.w,
            imageHeight: 125.h,
            clipBehavior: Clip.hardEdge,
          ),
          CommonText(
              text: studentName,
              color: AppColors.textDark,
              style: AppTypography.h6),
          const SizedBox(height: 4),
          CommonText(
              text: "Regular Student",
              color: AppColors.textGray,
              style: AppTypography.body2),
        ],
      ),
      actions: [
        CommonPrimaryElevatedButton(
          elevation: 0,
          title: "Absent",
          icon: SvgPicture.asset(
            AppImages.closeIcon,
            colorFilter:
                const ColorFilter.mode(AppColors.primaryOn, BlendMode.srcIn),
          ),
          backgroundColor: AppColors.failure,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          onPressed: onAbsentPresentCallback,
        ),
        CommonPrimaryElevatedButton(
          elevation: 0,
          title: "Present",
          icon: SvgPicture.asset(
            AppImages.checkMark,
            colorFilter:
                const ColorFilter.mode(AppColors.primaryOn, BlendMode.srcIn),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          onPressed: onStudentPresentCallback,
        )
      ],
    );
  }
}
