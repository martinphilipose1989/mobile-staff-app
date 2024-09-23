import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_image_widget.dart';
import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TripListTileHeader extends StatelessWidget {
  const TripListTileHeader(
      {super.key, this.tripStatus = "upcoming", this.buttonTitle = "Start"});

  final String tripStatus;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CommonImageWidget(
          imageUrl: "",
          fallbackAssetImagePath: AppImages.defaultBus,
          imageHeight: 40.h,
          imageWidth: 40.w,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: "MH47-PK-9386",
                style: AppTypography.subtitle2,
                color: AppColors.textDark,
              ),
              CommonText(
                text: "Vibgyor High Malad West",
                maxLines: 1,
                overflow: TextOverflow
                    .ellipsis, // Ensures text truncates with ellipsis
                style: AppTypography.body2,
                color: AppColors.textGray,
              ),
            ],
          ),
        ),
        tripStatus == "upcoming"
            ? CommonPrimaryElevatedButton(
                title: buttonTitle,
                titleTextStyle: AppTypography.subtitle2,
                onPressed: () {},
                icon: SvgPicture.asset(AppImages.playButton),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.primaryOn,
              )
            : CommonPrimaryElevatedButton(
                title: "Complete",
                titleTextStyle: AppTypography.subtitle2,
                onPressed: () {},
                backgroundColor: AppColors.success,
                foregroundColor: AppColors.primaryOn,
              )
      ],
    );
  }
}
