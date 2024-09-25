import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_image_widget.dart';
import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ViewOrDropBearer extends StatelessWidget {
  const ViewOrDropBearer({
    super.key,
    this.drop = false,
    required this.onCancel,
    required this.onConfirm,
  });

  final bool drop;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

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
                CommonText(
                    text: drop ? "Drop Student" : "Add New Bearer",
                    style: AppTypography.h5),
                if (drop)
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(AppImages.closeIcon),
                  )
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: EdgeInsets.zero,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(AppImages.backArrow),
                    ),
                    CommonImageWidget(
                        imageHeight: 125.h,
                        imageWidth: 125.w,
                        imageUrl: "imageUrl",
                        clipBehavior: Clip.hardEdge),
                    RotatedBox(
                      quarterTurns: 2,
                      child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(AppImages.backArrow),
                      ),
                    )
                  ]),
            ),
            const SizedBox(height: 16),
            Visibility(
                visible: drop,
                replacement: Center(
                  child: Column(
                    children: [
                      CommonText(
                        text: "Ashok Shah",
                        style: AppTypography.h5
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      CommonText(
                        text: "Father",
                        color: AppColors.textGray,
                        style: AppTypography.subtitle2
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: "Ashok Shah",
                            style: AppTypography.h5
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          CommonText(
                            text: "Father",
                            color: AppColors.textGray,
                            style: AppTypography.subtitle2
                                .copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        iconSize: 40,
                        icon: SvgPicture.asset(
                          AppImages.call,
                          height: 40.w,
                          width: 40.w,
                        ),
                      )
                    ])),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: CommonPrimaryElevatedButton(
                    elevation: 0,
                    title: drop ? "Add Bearer" : "Cancel",
                    onPressed: onCancel,
                    backgroundColor: AppColors.textPalerGray,
                    foregroundColor: AppColors.textGray,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: CommonPrimaryElevatedButton(
                    elevation: 0,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    title: drop ? "Drop" : "Add Bearer",
                    onPressed: onConfirm,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
