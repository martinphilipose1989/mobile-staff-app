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
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        padding: REdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(text: header, style: AppTypography.h5),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(AppImages.closeIcon),
                )
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: Column(
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
            ),
            const SizedBox(height: 48),
            Row(
              children: [
                Expanded(
                  child: CommonPrimaryElevatedButton(
                    elevation: 0,
                    title: "Absent",
                    icon: SvgPicture.asset(
                      AppImages.closeIcon,
                      colorFilter: const ColorFilter.mode(
                          AppColors.primaryOn, BlendMode.srcIn),
                    ),
                    backgroundColor: AppColors.failure,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    onPressed: onAbsentPresentCallback,
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: CommonPrimaryElevatedButton(
                    elevation: 0,
                    title: "Present",
                    icon: SvgPicture.asset(
                      AppImages.checkMark,
                      colorFilter: const ColorFilter.mode(
                          AppColors.primaryOn, BlendMode.srcIn),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    onPressed: onStudentPresentCallback,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
